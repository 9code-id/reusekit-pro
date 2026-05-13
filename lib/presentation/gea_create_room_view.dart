import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaCreateRoomView extends StatefulWidget {
  const GeaCreateRoomView({super.key});

  @override
  State<GeaCreateRoomView> createState() => _GeaCreateRoomViewState();
}

class _GeaCreateRoomViewState extends State<GeaCreateRoomView> {
  final formKey = GlobalKey<FormState>();
  
  String roomName = "";
  String selectedMode = "Battle Royale";
  String selectedMap = "Apocalypse Zone";
  String selectedRegion = "US East";
  String selectedDifficulty = "Medium";
  String maxPlayers = "10";
  String levelRestriction = "Any";
  String password = "";
  bool isPrivate = false;
  bool allowSpectators = true;
  bool autoStart = false;
  String description = "";

  List<Map<String, dynamic>> gameModes = [
    {"label": "Battle Royale", "value": "Battle Royale", "icon": Icons.military_tech},
    {"label": "Team Deathmatch", "value": "Team Deathmatch", "icon": Icons.group},
    {"label": "Capture Flag", "value": "Capture Flag", "icon": Icons.flag},
    {"label": "Free for All", "value": "Free for All", "icon": Icons.person},
    {"label": "Elimination", "value": "Elimination", "icon": Icons.whatshot},
    {"label": "King of Hill", "value": "King of Hill", "icon": Icons.landscape},
  ];

  List<Map<String, dynamic>> availableMaps = [
    {"label": "Apocalypse Zone", "value": "Apocalypse Zone", "mode": "Battle Royale"},
    {"label": "Desert Storm", "value": "Desert Storm", "mode": "Battle Royale"},
    {"label": "Urban Warfare", "value": "Urban Warfare", "mode": "Team Deathmatch"},
    {"label": "Training Ground", "value": "Training Ground", "mode": "Team Deathmatch"},
    {"label": "Desert Fortress", "value": "Desert Fortress", "mode": "Capture Flag"},
    {"label": "Industrial Complex", "value": "Industrial Complex", "mode": "Capture Flag"},
    {"label": "City Center", "value": "City Center", "mode": "Free for All"},
    {"label": "Arena Showdown", "value": "Arena Showdown", "mode": "Free for All"},
    {"label": "Championship Arena", "value": "Championship Arena", "mode": "Elimination"},
    {"label": "Colosseum", "value": "Colosseum", "mode": "Elimination"},
  ];

  List<Map<String, dynamic>> get filteredMaps {
    return availableMaps.where((map) => map["mode"] == selectedMode).toList();
  }

  void createRoom() {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate room creation
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Room created successfully!");
        back();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Room"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              //navigateTo('CreateRoomHelpView')
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Room Basic Info
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
                          Icons.room,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Room Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Room Name",
                      value: roomName,
                      hint: "Enter a unique room name",
                      validator: Validator.required,
                      onChanged: (value) {
                        roomName = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Description (Optional)",
                      value: description,
                      hint: "Describe your room rules or requirements",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Game Configuration
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
                          Icons.videogame_asset,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Game Configuration",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Game Mode",
                      items: gameModes,
                      value: selectedMode,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedMode = value;
                        // Reset map selection when mode changes
                        if (filteredMaps.isNotEmpty) {
                          selectedMap = filteredMaps.first["value"];
                        }
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Map",
                      items: filteredMaps,
                      value: selectedMap,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedMap = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Difficulty",
                            items: [
                              {"label": "Easy", "value": "Easy"},
                              {"label": "Medium", "value": "Medium"},
                              {"label": "Hard", "value": "Hard"},
                              {"label": "Expert", "value": "Expert"},
                            ],
                            value: selectedDifficulty,
                            onChanged: (value, label) {
                              selectedDifficulty = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Max Players",
                            items: [
                              {"label": "4", "value": "4"},
                              {"label": "6", "value": "6"},
                              {"label": "8", "value": "8"},
                              {"label": "10", "value": "10"},
                              {"label": "12", "value": "12"},
                              {"label": "16", "value": "16"},
                              {"label": "20", "value": "20"},
                              {"label": "25", "value": "25"},
                              {"label": "50", "value": "50"},
                              {"label": "100", "value": "100"},
                            ],
                            value: maxPlayers,
                            onChanged: (value, label) {
                              maxPlayers = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Server & Access Settings
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
                          Icons.settings,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Server & Access Settings",
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
                          child: QDropdownField(
                            label: "Region",
                            items: [
                              {"label": "US East", "value": "US East"},
                              {"label": "US West", "value": "US West"},
                              {"label": "Europe", "value": "Europe"},
                              {"label": "Asia", "value": "Asia"},
                              {"label": "Australia", "value": "Australia"},
                            ],
                            value: selectedRegion,
                            onChanged: (value, label) {
                              selectedRegion = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Level Restriction",
                            items: [
                              {"label": "Any", "value": "Any"},
                              {"label": "1-10", "value": "1-10"},
                              {"label": "11-20", "value": "11-20"},
                              {"label": "21-30", "value": "21-30"},
                              {"label": "31-40", "value": "31-40"},
                              {"label": "41-50", "value": "41-50"},
                              {"label": "50+", "value": "50+"},
                            ],
                            value: levelRestriction,
                            onChanged: (value, label) {
                              levelRestriction = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    if (isPrivate)
                      QTextField(
                        label: "Room Password",
                        value: password,
                        hint: "Enter password for private room",
                        validator: isPrivate ? Validator.required : null,
                        onChanged: (value) {
                          password = value;
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),

              // Room Options
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
                          Icons.tune,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Room Options",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Private Room",
                          "value": "private",
                          "checked": isPrivate,
                        }
                      ],
                      value: [
                        if (isPrivate)
                          {
                            "label": "Private Room",
                            "value": "private",
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          isPrivate = values.isNotEmpty;
                          if (!isPrivate) {
                            password = "";
                          }
                        });
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Allow Spectators",
                          "value": "spectators",
                          "checked": allowSpectators,
                        }
                      ],
                      value: [
                        if (allowSpectators)
                          {
                            "label": "Allow Spectators",
                            "value": "spectators",
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          allowSpectators = values.isNotEmpty;
                        });
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Auto-start when full",
                          "value": "autostart",
                          "checked": autoStart,
                        }
                      ],
                      value: [
                        if (autoStart)
                          {
                            "label": "Auto-start when full",
                            "value": "autostart",
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          autoStart = values.isNotEmpty;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Room Preview
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.preview,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Room Preview",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  roomName.isEmpty ? "My Awesome Room" : roomName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              if (isPrivate)
                                Icon(
                                  Icons.lock,
                                  size: 16,
                                  color: warningColor,
                                ),
                            ],
                          ),
                          Text(
                            "$selectedMode • $selectedMap",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 16,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "1/$maxPlayers players",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: selectedDifficulty == "Easy" 
                                      ? successColor 
                                      : selectedDifficulty == "Medium" 
                                          ? warningColor 
                                          : dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  selectedDifficulty,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (description.isNotEmpty)
                            Text(
                              description,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Create Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Room",
                  size: bs.md,
                  onPressed: createRoom,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
