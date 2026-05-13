import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaCharacterSelectView extends StatefulWidget {
  const GeaCharacterSelectView({super.key});

  @override
  State<GeaCharacterSelectView> createState() => _GeaCharacterSelectViewState();
}

class _GeaCharacterSelectViewState extends State<GeaCharacterSelectView> {
  int selectedCharacterIndex = 0;
  
  List<Map<String, dynamic>> characters = [
    {
      "id": 1,
      "name": "Warrior",
      "class": "Tank",
      "level": 25,
      "health": 950,
      "attack": 85,
      "defense": 120,
      "speed": 60,
      "unlocked": true,
      "image": "https://picsum.photos/300/400?random=1&keyword=warrior",
      "description": "A strong melee fighter with high defense capabilities",
      "abilities": ["Shield Block", "Power Strike", "Battle Cry"],
      "weapon": "Iron Sword",
      "rarity": "Common",
    },
    {
      "id": 2,
      "name": "Mage",
      "class": "Caster",
      "level": 28,
      "health": 650,
      "attack": 145,
      "defense": 45,
      "speed": 80,
      "unlocked": true,
      "image": "https://picsum.photos/300/400?random=2&keyword=wizard",
      "description": "A magical spellcaster with devastating area attacks",
      "abilities": ["Fireball", "Ice Storm", "Lightning Bolt"],
      "weapon": "Mystic Staff",
      "rarity": "Rare",
    },
    {
      "id": 3,
      "name": "Archer",
      "class": "Ranged",
      "level": 22,
      "health": 720,
      "attack": 110,
      "defense": 65,
      "speed": 105,
      "unlocked": true,
      "image": "https://picsum.photos/300/400?random=3&keyword=archer",
      "description": "A swift ranged fighter with precise targeting",
      "abilities": ["Multi Shot", "Poison Arrow", "Eagle Eye"],
      "weapon": "Elven Bow",
      "rarity": "Common",
    },
    {
      "id": 4,
      "name": "Assassin",
      "class": "Stealth",
      "level": 30,
      "health": 580,
      "attack": 165,
      "defense": 35,
      "speed": 140,
      "unlocked": false,
      "image": "https://picsum.photos/300/400?random=4&keyword=ninja",
      "description": "A deadly stealth fighter with critical strike abilities",
      "abilities": ["Stealth", "Backstab", "Shadow Clone"],
      "weapon": "Twin Daggers",
      "rarity": "Epic",
    },
    {
      "id": 5,
      "name": "Paladin",
      "class": "Support",
      "level": 26,
      "health": 850,
      "attack": 95,
      "defense": 100,
      "speed": 70,
      "unlocked": false,
      "image": "https://picsum.photos/300/400?random=5&keyword=paladin",
      "description": "A holy warrior with healing and support abilities",
      "abilities": ["Heal", "Divine Shield", "Blessing"],
      "weapon": "Holy Mace",
      "rarity": "Rare",
    },
  ];

  Color getRarityColor(String rarity) {
    switch (rarity) {
      case "Common": return disabledBoldColor;
      case "Rare": return infoColor;
      case "Epic": return warningColor;
      case "Legendary": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedCharacter = characters[selectedCharacterIndex];
    final isUnlocked = selectedCharacter["unlocked"] as bool;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Character Selection"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              //navigateTo('CharacterCustomizationView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Character Selector
            Container(
              height: 100,
              child: QHorizontalScroll(
                children: List.generate(characters.length, (index) {
                  final character = characters[index];
                  final isSelected = index == selectedCharacterIndex;
                  final isCharUnlocked = character["unlocked"] as bool;
                  
                  return GestureDetector(
                    onTap: () {
                      selectedCharacterIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      width: 80,
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: isSelected ? Border.all(color: primaryColor, width: 3) : null,
                        boxShadow: [shadowSm],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${character["image"]}",
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              colorBlendMode: isCharUnlocked ? null : BlendMode.saturation,
                              color: isCharUnlocked ? null : Colors.grey,
                            ),
                          ),
                          if (!isCharUnlocked)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                color: Colors.black.withAlpha(150),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(radiusSm),
                                  bottomRight: Radius.circular(radiusSm),
                                ),
                              ),
                              child: Text(
                                "${character["name"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Character Display
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Character Image
                  Container(
                    width: 200,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${selectedCharacter["image"]}",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            colorBlendMode: isUnlocked ? null : BlendMode.saturation,
                            color: isUnlocked ? null : Colors.grey,
                          ),
                        ),
                        if (!isUnlocked)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              color: Colors.black.withAlpha(150),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Locked",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        Positioned(
                          top: spXs,
                          right: spXs,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: getRarityColor("${selectedCharacter["rarity"]}"),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${selectedCharacter["rarity"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  // Character Info
                  Text(
                    "${selectedCharacter["name"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${selectedCharacter["class"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Lv. ${selectedCharacter["level"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${selectedCharacter["description"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Character Stats",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  _buildStatBar("Health", selectedCharacter["health"] as int, 1000, dangerColor),
                  SizedBox(height: spXs),
                  _buildStatBar("Attack", selectedCharacter["attack"] as int, 200, warningColor),
                  SizedBox(height: spXs),
                  _buildStatBar("Defense", selectedCharacter["defense"] as int, 150, infoColor),
                  SizedBox(height: spXs),
                  _buildStatBar("Speed", selectedCharacter["speed"] as int, 150, successColor),
                ],
              ),
            ),

            // Equipment & Abilities
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Equipment",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.sports_esports,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${selectedCharacter["weapon"]}",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rarity",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: getRarityColor("${selectedCharacter["rarity"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${selectedCharacter["rarity"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Abilities
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Special Abilities",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...(selectedCharacter["abilities"] as List<String>).map((ability) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.flash_on,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            ability,
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: isUnlocked ? "Select Character" : "Unlock Character",
                    onPressed: () {
                      if (isUnlocked) {
                        //navigateTo('GameplayView', arguments: {'character': selectedCharacter})
                      } else {
                        //navigateTo('UnlockCharacterView', arguments: {'character': selectedCharacter})
                      }
                    },
                  ),
                ),
                if (isUnlocked) ...[
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.upgrade,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('CharacterUpgradeView', arguments: {'character': selectedCharacter})
                    },
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBar(String label, int value, int maxValue, Color color) {
    final percentage = value / maxValue;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "$value",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 2),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: disabledColor,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }
}
