import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaCharactersView extends StatefulWidget {
  const GeaCharactersView({super.key});

  @override
  State<GeaCharactersView> createState() => _GeaCharactersViewState();
}

class _GeaCharactersViewState extends State<GeaCharactersView> {
  String selectedGame = "Valorant";
  String selectedRole = "All";
  int selectedCharacter = 0;
  
  List<String> games = ["Valorant", "Overwatch", "Apex Legends", "League of Legends"];
  List<String> roles = ["All", "Duelist", "Controller", "Initiator", "Sentinel"];
  
  List<Map<String, dynamic>> characters = [
    {
      "id": 1,
      "name": "Jett",
      "role": "Duelist",
      "game": "Valorant",
      "description": "Representing her home country of South Korea, Jett's agile and evasive fighting style lets her take risks no one else can.",
      "image": "https://picsum.photos/300/400?random=1&keyword=character",
      "abilities": [
        {
          "name": "Cloudburst",
          "type": "Basic",
          "description": "Instantly throw a projectile that expands into a brief vision-blocking cloud on impact with a surface.",
          "icon": "https://picsum.photos/64/64?random=11&keyword=ability"
        },
        {
          "name": "Updraft",
          "type": "Basic",
          "description": "Instantly propel Jett high into the air.",
          "icon": "https://picsum.photos/64/64?random=12&keyword=ability"
        },
        {
          "name": "Tailwind",
          "type": "Signature",
          "description": "Instantly dash a short distance in the direction you're moving.",
          "icon": "https://picsum.photos/64/64?random=13&keyword=ability"
        },
        {
          "name": "Blade Storm",
          "type": "Ultimate",
          "description": "Equip throwing knives that deal moderate damage and kill on headshots.",
          "icon": "https://picsum.photos/64/64?random=14&keyword=ability"
        }
      ],
      "stats": {
        "difficulty": 3,
        "mobility": 5,
        "damage": 4,
        "utility": 2
      },
      "skins": [
        {
          "name": "Default",
          "price": 0,
          "owned": true,
          "equipped": true,
          "image": "https://picsum.photos/200/300?random=101&keyword=skin"
        },
        {
          "name": "Neon Jett",
          "price": 1875,
          "owned": false,
          "equipped": false,
          "image": "https://picsum.photos/200/300?random=102&keyword=skin"
        }
      ],
      "owned": true,
      "unlocked": true
    },
    {
      "id": 2,
      "name": "Sage",
      "role": "Sentinel",
      "game": "Valorant",
      "description": "The stronghold of China, Sage creates safety for herself and her team wherever she goes.",
      "image": "https://picsum.photos/300/400?random=2&keyword=character",
      "abilities": [
        {
          "name": "Barrier Orb",
          "type": "Basic",
          "description": "Conjure a large solid wall that can be rotated before casting.",
          "icon": "https://picsum.photos/64/64?random=21&keyword=ability"
        },
        {
          "name": "Slow Orb",
          "type": "Basic", 
          "description": "Cast an orb that breaks into a slowing field upon impact with the ground.",
          "icon": "https://picsum.photos/64/64?random=22&keyword=ability"
        },
        {
          "name": "Healing Orb",
          "type": "Signature",
          "description": "Heal an ally or yourself to full health over a few seconds.",
          "icon": "https://picsum.photos/64/64?random=23&keyword=ability"
        },
        {
          "name": "Resurrection",
          "type": "Ultimate",
          "description": "Target a friendly corpse and revive them with full health after a short channel.",
          "icon": "https://picsum.photos/64/64?random=24&keyword=ability"
        }
      ],
      "stats": {
        "difficulty": 2,
        "mobility": 2,
        "damage": 2,
        "utility": 5
      },
      "skins": [
        {
          "name": "Default",
          "price": 0,
          "owned": true,
          "equipped": true,
          "image": "https://picsum.photos/200/300?random=201&keyword=skin"
        }
      ],
      "owned": true,
      "unlocked": true
    },
    {
      "id": 3,
      "name": "Phoenix",
      "role": "Duelist",
      "game": "Valorant",
      "description": "Hailing from the U.K., Phoenix's star power shines through in his fighting style, igniting the battlefield with flash and flare.",
      "image": "https://picsum.photos/300/400?random=3&keyword=character",
      "abilities": [
        {
          "name": "Blaze",
          "type": "Basic",
          "description": "Cast a flame wall that blocks vision and damages players passing through it.",
          "icon": "https://picsum.photos/64/64?random=31&keyword=ability"
        },
        {
          "name": "Curveball",
          "type": "Basic",
          "description": "Cast a flashing orb that takes a curving path and blinds all players who see it.",
          "icon": "https://picsum.photos/64/64?random=32&keyword=ability"
        },
        {
          "name": "Hot Hands",
          "type": "Signature",
          "description": "Throw a fireball that explodes after a delay or upon hitting the ground.",
          "icon": "https://picsum.photos/64/64?random=33&keyword=ability"
        },
        {
          "name": "Run it Back",
          "type": "Ultimate",
          "description": "Mark your current location and be reborn there with full health if you die during the ability.",
          "icon": "https://picsum.photos/64/64?random=34&keyword=ability"
        }
      ],
      "stats": {
        "difficulty": 2,
        "mobility": 3,
        "damage": 4,
        "utility": 3
      },
      "skins": [
        {
          "name": "Default",
          "price": 0,
          "owned": true,
          "equipped": true,
          "image": "https://picsum.photos/200/300?random=301&keyword=skin"
        }
      ],
      "owned": false,
      "unlocked": false
    }
  ];

  List<Map<String, dynamic>> get filteredCharacters {
    return characters.where((character) {
      bool gameMatch = character["game"] == selectedGame;
      bool roleMatch = selectedRole == "All" || character["role"] == selectedRole;
      return gameMatch && roleMatch;
    }).toList();
  }

  Color getRoleColor(String role) {
    switch (role) {
      case "Duelist":
        return dangerColor;
      case "Controller":
        return infoColor;
      case "Initiator":
        return warningColor;
      case "Sentinel":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Characters"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Game Selector
            QCategoryPicker(
              items: games.map((game) => {
                "label": game,
                "value": game,
              }).toList(),
              value: selectedGame,
              onChanged: (index, label, value, item) {
                selectedGame = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Role Filter
            QCategoryPicker(
              items: roles.map((role) => {
                "label": role,
                "value": role,
              }).toList(),
              value: selectedRole,
              onChanged: (index, label, value, item) {
                selectedRole = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Characters Grid
            ResponsiveGridView(
              minItemWidth: 200,
              children: filteredCharacters.map((character) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: (character["owned"] as bool)
                      ? Border.all(color: primaryColor, width: 2)
                      : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${character["image"]}",
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          // Role Badge
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: getRoleColor("${character["role"]}"),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${character["role"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          
                          // Owned Badge
                          if (character["owned"] as bool)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          
                          // Locked Overlay
                          if (!(character["unlocked"] as bool))
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(153),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusMd),
                                    topRight: Radius.circular(radiusMd),
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "LOCKED",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${character["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${character["game"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            
                            // Stats Preview
                            Row(
                              children: [
                                _buildStatPreview("DMG", (character["stats"] as Map)["damage"] as int),
                                SizedBox(width: spSm),
                                _buildStatPreview("MOB", (character["stats"] as Map)["mobility"] as int),
                                SizedBox(width: spSm),
                                _buildStatPreview("UTL", (character["stats"] as Map)["utility"] as int),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            Text(
                              "${character["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Action Button
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: (character["unlocked"] as bool)
                                  ? "View Details"
                                  : "Unlock",
                                size: bs.sm,
                                onPressed: () {
                                  if (character["unlocked"] as bool) {
                                    _showCharacterDetails(character);
                                  } else {
                                    _showUnlockDialog(character);
                                  }
                                },
                              ),
                            ),
                          ],
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
    );
  }

  Widget _buildStatPreview(String label, int value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2),
        Row(
          children: List.generate(5, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.only(right: 1),
              decoration: BoxDecoration(
                color: index < value ? primaryColor : disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            );
          }),
        ),
      ],
    );
  }

  void _showCharacterDetails(Map<String, dynamic> character) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "${character["name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: getRoleColor("${character["role"]}"),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${character["role"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Character Image
                    Center(
                      child: Container(
                        width: 200,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusMd),
                          image: DecorationImage(
                            image: NetworkImage("${character["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Description
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${character["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Stats
                    Text(
                      "Character Stats",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          _buildStatRow("Difficulty", (character["stats"] as Map)["difficulty"] as int),
                          SizedBox(height: spSm),
                          _buildStatRow("Mobility", (character["stats"] as Map)["mobility"] as int),
                          SizedBox(height: spSm),
                          _buildStatRow("Damage", (character["stats"] as Map)["damage"] as int),
                          SizedBox(height: spSm),
                          _buildStatRow("Utility", (character["stats"] as Map)["utility"] as int),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Abilities
                    Text(
                      "Abilities",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (character["abilities"] as List).length,
                      itemBuilder: (context, index) {
                        final ability = (character["abilities"] as List)[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: disabledOutlineBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${ability["icon"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${ability["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                          decoration: BoxDecoration(
                                            color: _getAbilityTypeColor("${ability["type"]}"),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${ability["type"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${ability["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Character Skins
                    Text(
                      "Available Skins",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    QHorizontalScroll(
                      children: (character["skins"] as List).map<Widget>((skin) {
                        return Container(
                          width: 150,
                          margin: EdgeInsets.only(right: spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: (skin["equipped"] as bool) 
                                ? primaryColor 
                                : disabledOutlineBorderColor,
                              width: (skin["equipped"] as bool) ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(radiusMd),
                                      topRight: Radius.circular(radiusMd),
                                    ),
                                    child: Image.network(
                                      "${skin["image"]}",
                                      width: double.infinity,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  if (skin["equipped"] as bool)
                                    Positioned(
                                      top: spSm,
                                      right: spSm,
                                      child: Container(
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(spSm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${skin["name"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    if ((skin["price"] as int) > 0)
                                      Text(
                                        "${skin["price"]} VP",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    else
                                      Text(
                                        "Free",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                  ],
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: List.generate(5, (index) {
              return Container(
                width: 16,
                height: 16,
                margin: EdgeInsets.only(right: spXs),
                decoration: BoxDecoration(
                  color: index < value ? primaryColor : disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              );
            }),
          ),
        ),
        Text(
          "$value/5",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _getAbilityTypeColor(String type) {
    switch (type) {
      case "Basic":
        return infoColor;
      case "Signature":
        return warningColor;
      case "Ultimate":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showUnlockDialog(Map<String, dynamic> character) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Unlock Character"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              "${character["image"]}",
              height: 120,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: spMd),
            Text(
              "${character["name"]}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spSm),
            Text(
              "Unlock ${character["name"]} to play as this ${character["role"]} character.",
              style: TextStyle(
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spSm),
            Text(
              "Cost: 11,000 XP or 1,000 VP",
              style: TextStyle(
                fontSize: 16,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Unlock",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              ss("Character unlocked successfully!");
            },
          ),
        ],
      ),
    );
  }
}
