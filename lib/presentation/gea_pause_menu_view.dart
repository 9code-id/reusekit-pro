import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaPauseMenuView extends StatefulWidget {
  const GeaPauseMenuView({super.key});

  @override
  State<GeaPauseMenuView> createState() => _GeaPauseMenuViewState();
}

class _GeaPauseMenuViewState extends State<GeaPauseMenuView> {
  String selectedTab = "Main";
  
  // Game session data
  String currentGame = "Cyberpunk 2077";
  String sessionTime = "02:34:15";
  String currentLevel = "Night City - Downtown";
  String currentObjective = "Meet with Jackie at the bar";
  int currentScore = 15650;
  int currentLevel_num = 12;
  double gameProgress = 0.68;
  
  // Quick save slots
  List<Map<String, dynamic>> saveSlots = [
    {
      "slot": 1,
      "name": "Auto Save",
      "location": "Night City - Downtown",
      "timestamp": "2 minutes ago",
      "level": 12,
      "progress": 68,
      "image": "https://picsum.photos/120/80?random=1&keyword=cyberpunk",
    },
    {
      "slot": 2,
      "name": "Main Quest Save",
      "location": "Arasaka Tower",
      "timestamp": "15 minutes ago",
      "level": 12,
      "progress": 65,
      "image": "https://picsum.photos/120/80?random=2&keyword=tower",
    },
    {
      "slot": 3,
      "name": "Before Boss Fight",
      "location": "Underground Facility",
      "timestamp": "1 hour ago",
      "level": 11,
      "progress": 60,
      "image": "https://picsum.photos/120/80?random=3&keyword=underground",
    },
  ];
  
  // Quick access items
  List<Map<String, dynamic>> inventory = [
    {
      "name": "Health Kit",
      "quantity": 5,
      "icon": Icons.local_hospital,
      "rarity": "Common",
    },
    {
      "name": "Energy Drink",
      "quantity": 3,
      "icon": Icons.battery_charging_full,
      "rarity": "Common",
    },
    {
      "name": "Assault Rifle",
      "quantity": 1,
      "icon": Icons.gps_fixed,
      "rarity": "Rare",
    },
    {
      "name": "Cybernetic Implant",
      "quantity": 2,
      "icon": Icons.memory,
      "rarity": "Epic",
    },
  ];
  
  // Settings quick toggles
  bool soundEnabled = true;
  bool musicEnabled = true;
  bool vibrationEnabled = true;
  bool autoSaveEnabled = true;
  double masterVolume = 0.8;
  double musicVolume = 0.6;
  double effectsVolume = 0.9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(200),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowLg],
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusLg),
                    topRight: Radius.circular(radiusLg),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.pause_circle,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Game Paused",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$currentGame - $currentLevel",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "$sessionTime",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Current Game Status
              Container(
                padding: EdgeInsets.all(spMd),
                color: disabledColor,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Level $currentLevel_num",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Score: ${currentScore.toString()}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Progress",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(gameProgress * 100).toStringAsFixed(0)}%",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Current Objective",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "$currentObjective",
                            style: TextStyle(
                              fontSize: 10,
                              color: warningColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Tab Navigation
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = "Main";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTab == "Main" ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Main Menu",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selectedTab == "Main" ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = "Save";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTab == "Save" ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Save & Load",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selectedTab == "Save" ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = "Inventory";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTab == "Inventory" ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Inventory",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selectedTab == "Inventory" ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = "Settings";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTab == "Settings" ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Settings",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selectedTab == "Settings" ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content Area
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: _buildTabContent(),
                ),
              ),
              
              // Bottom Actions
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: disabledColor),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Resume Game",
                        icon: Icons.play_arrow,
                        size: bs.md,
                        onPressed: () {
                          ss("Game resumed");
                          //navigateTo('');
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.exit_to_app,
                      size: bs.md,
                      onPressed: () {
                        sw("Exiting to main menu");
                        //navigateTo('');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "Main":
        return _buildMainMenu();
      case "Save":
        return _buildSaveLoadMenu();
      case "Inventory":
        return _buildInventoryMenu();
      case "Settings":
        return _buildSettingsMenu();
      default:
        return _buildMainMenu();
    }
  }

  Widget _buildMainMenu() {
    return Column(
      spacing: spMd,
      children: [
        // Quick Actions
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: spSm,
            mainAxisSpacing: spSm,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            List<Map<String, dynamic>> quickActions = [
              {"title": "Quick Save", "icon": Icons.save, "color": successColor},
              {"title": "Load Game", "icon": Icons.folder_open, "color": infoColor},
              {"title": "Game Settings", "icon": Icons.settings, "color": primaryColor},
              {"title": "Controls", "icon": Icons.gamepad, "color": warningColor},
              {"title": "Statistics", "icon": Icons.bar_chart, "color": successColor},
              {"title": "Help", "icon": Icons.help, "color": disabledBoldColor},
            ];
            
            final action = quickActions[index];
            
            return GestureDetector(
              onTap: () {
                si("${action["title"]}");
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (action["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: (action["color"] as Color).withAlpha(100),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      action["icon"] as IconData,
                      color: action["color"] as Color,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${action["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: action["color"] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        
        // Game Options
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: disabledColor,
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Game Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Restart Level",
                      icon: Icons.refresh,
                      size: bs.sm,
                      onPressed: () {
                        sw("Level restarted");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Skip Cutscene",
                      icon: Icons.fast_forward,
                      size: bs.sm,
                      onPressed: () {
                        si("Cutscene skipped");
                      },
                    ),
                  ),
                ],
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Change Difficulty",
                      icon: Icons.tune,
                      size: bs.sm,
                      onPressed: () {
                        si("Difficulty settings");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "View Map",
                      icon: Icons.map,
                      size: bs.sm,
                      onPressed: () {
                        si("Game map");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaveLoadMenu() {
    return Column(
      spacing: spMd,
      children: [
        // Quick Save Section
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: successColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: successColor.withAlpha(100)),
          ),
          child: Row(
            children: [
              Icon(Icons.save, color: successColor),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Save",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Save your current progress instantly",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Save Now",
                size: bs.sm,
                onPressed: () {
                  ss("Game saved successfully");
                },
              ),
            ],
          ),
        ),
        
        // Save Slots
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Save Slots",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ...saveSlots.map((save) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${save["image"]}",
                        width: 80,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spMd),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Slot ${save["slot"]} - ${save["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Lv.${save["level"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${save["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${save["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${save["progress"]}% Complete",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(width: spSm),
                    
                    Column(
                      spacing: spXs,
                      children: [
                        QButton(
                          icon: Icons.play_arrow,
                          size: bs.sm,
                          onPressed: () {
                            ss("Loading save slot ${save["slot"]}");
                          },
                        ),
                        QButton(
                          icon: Icons.delete,
                          size: bs.sm,
                          onPressed: () {
                            sw("Save slot ${save["slot"]} deleted");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ],
    );
  }

  Widget _buildInventoryMenu() {
    return Column(
      spacing: spMd,
      children: [
        // Inventory Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Row(
            children: [
              Icon(Icons.inventory, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Quick Inventory Access",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        
        // Inventory Grid
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: spSm,
            mainAxisSpacing: spSm,
          ),
          itemCount: inventory.length,
          itemBuilder: (context, index) {
            final item = inventory[index];
            Color rarityColor = primaryColor;
            
            switch (item["rarity"]) {
              case "Common":
                rarityColor = disabledBoldColor;
                break;
              case "Rare":
                rarityColor = infoColor;
                break;
              case "Epic":
                rarityColor = warningColor;
                break;
              case "Legendary":
                rarityColor = dangerColor;
                break;
            }
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: rarityColor.withAlpha(100)),
              ),
              child: Column(
                children: [
                  Icon(
                    item["icon"] as IconData,
                    color: rarityColor,
                    size: 32,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${item["name"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "x${item["quantity"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: rarityColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${item["rarity"]}",
                          style: TextStyle(
                            fontSize: 8,
                            color: rarityColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Use",
                      size: bs.sm,
                      onPressed: () {
                        si("Used ${item["name"]}");
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSettingsMenu() {
    return Column(
      spacing: spMd,
      children: [
        // Audio Settings
        Container(
          padding: EdgeInsets.all(spMd),
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
                "Audio Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Row(
                children: [
                  Text("Master Volume"),
                  Spacer(),
                  Text("${(masterVolume * 100).toInt()}%"),
                ],
              ),
              Slider(
                value: masterVolume,
                onChanged: (value) {
                  setState(() {
                    masterVolume = value;
                  });
                },
              ),
              
              Row(
                children: [
                  Text("Music Volume"),
                  Spacer(),
                  Text("${(musicVolume * 100).toInt()}%"),
                ],
              ),
              Slider(
                value: musicVolume,
                onChanged: (value) {
                  setState(() {
                    musicVolume = value;
                  });
                },
              ),
              
              Row(
                children: [
                  Text("Effects Volume"),
                  Spacer(),
                  Text("${(effectsVolume * 100).toInt()}%"),
                ],
              ),
              Slider(
                value: effectsVolume,
                onChanged: (value) {
                  setState(() {
                    effectsVolume = value;
                  });
                },
              ),
            ],
          ),
        ),
        
        // Game Settings Toggles
        Container(
          padding: EdgeInsets.all(spMd),
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
                "Game Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "Sound Effects",
                    "value": "sound",
                    "checked": soundEnabled,
                  }
                ],
                value: [
                  if (soundEnabled)
                    {"label": "Sound Effects", "value": "sound", "checked": true}
                ],
                onChanged: (values, ids) {
                  setState(() {
                    soundEnabled = values.isNotEmpty;
                  });
                },
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "Background Music",
                    "value": "music",
                    "checked": musicEnabled,
                  }
                ],
                value: [
                  if (musicEnabled)
                    {"label": "Background Music", "value": "music", "checked": true}
                ],
                onChanged: (values, ids) {
                  setState(() {
                    musicEnabled = values.isNotEmpty;
                  });
                },
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "Vibration Feedback",
                    "value": "vibration",
                    "checked": vibrationEnabled,
                  }
                ],
                value: [
                  if (vibrationEnabled)
                    {"label": "Vibration Feedback", "value": "vibration", "checked": true}
                ],
                onChanged: (values, ids) {
                  setState(() {
                    vibrationEnabled = values.isNotEmpty;
                  });
                },
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "Auto Save",
                    "value": "autosave",
                    "checked": autoSaveEnabled,
                  }
                ],
                value: [
                  if (autoSaveEnabled)
                    {"label": "Auto Save", "value": "autosave", "checked": true}
                ],
                onChanged: (values, ids) {
                  setState(() {
                    autoSaveEnabled = values.isNotEmpty;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
