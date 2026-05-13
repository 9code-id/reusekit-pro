import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaUpgradesView extends StatefulWidget {
  const GeaUpgradesView({super.key});

  @override
  State<GeaUpgradesView> createState() => _GeaUpgradesViewState();
}

class _GeaUpgradesViewState extends State<GeaUpgradesView> {
  String selectedCategory = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> upgrades = [
    {
      "id": 1,
      "name": "Damage Amplifier",
      "category": "Attack",
      "type": "Passive",
      "level": 5,
      "maxLevel": 10,
      "effect": "Increases weapon damage by 15%",
      "cost": 500,
      "nextCost": 750,
      "owned": true,
      "icon": Icons.flash_on,
      "rarity": "Epic",
      "description": "Enhances all weapon damage output significantly",
    },
    {
      "id": 2,
      "name": "Health Regeneration",
      "category": "Defense",
      "type": "Passive",
      "level": 3,
      "maxLevel": 8,
      "effect": "Regenerates 5 HP per second",
      "cost": 300,
      "nextCost": 450,
      "owned": true,
      "icon": Icons.favorite,
      "rarity": "Rare",
      "description": "Slowly restores health over time during combat",
    },
    {
      "id": 3,
      "name": "Speed Boost",
      "category": "Movement",
      "type": "Active",
      "level": 2,
      "maxLevel": 6,
      "effect": "Increases movement speed by 25% for 10 seconds",
      "cost": 400,
      "nextCost": 600,
      "owned": true,
      "icon": Icons.speed,
      "rarity": "Rare",
      "description": "Temporarily enhances movement and attack speed",
    },
    {
      "id": 4,
      "name": "Critical Strike",
      "category": "Attack",
      "type": "Passive",
      "level": 0,
      "maxLevel": 12,
      "effect": "15% chance to deal double damage",
      "cost": 800,
      "nextCost": 800,
      "owned": false,
      "icon": Icons.star,
      "rarity": "Legendary",
      "description": "Chance to deliver devastating critical hits",
    },
    {
      "id": 5,
      "name": "Shield Barrier",
      "category": "Defense",
      "type": "Active",
      "level": 1,
      "maxLevel": 5,
      "effect": "Absorbs next 100 damage",
      "cost": 350,
      "nextCost": 525,
      "owned": true,
      "icon": Icons.shield,
      "rarity": "Common",
      "description": "Creates a temporary protective barrier",
    },
    {
      "id": 6,
      "name": "Mana Efficiency",
      "category": "Magic",
      "type": "Passive",
      "level": 4,
      "maxLevel": 10,
      "effect": "Reduces mana cost by 20%",
      "cost": 450,
      "nextCost": 675,
      "owned": true,
      "icon": Icons.auto_awesome,
      "rarity": "Epic",
      "description": "Optimizes magical energy consumption",
    },
  ];

  List<Map<String, dynamic>> get filteredUpgrades {
    return upgrades.where((upgrade) {
      final matchesCategory = selectedCategory == "All" || upgrade["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          (upgrade["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (upgrade["effect"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case "Legendary":
        return Color(0xFFFFD700);
      case "Epic":
        return Color(0xFF9C27B0);
      case "Rare":
        return Color(0xFF2196F3);
      case "Common":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Attack":
        return dangerColor;
      case "Defense":
        return infoColor;
      case "Movement":
        return successColor;
      case "Magic":
        return Color(0xFF9C27B0);
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalUpgrades = upgrades.length;
    final ownedUpgrades = upgrades.where((u) => u["owned"] == true).length;
    final maxedUpgrades = upgrades.where((u) => u["level"] == u["maxLevel"]).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Character Upgrades"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              //navigateTo('UpgradeInfoView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Progress Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Owned Upgrades",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$ownedUpgrades/$totalUpgrades",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                          "Maxed Out",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$maxedUpgrades",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                          "Total Power",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${upgrades.where((u) => u["owned"] == true).fold(0, (sum, u) => sum + (u["level"] as int))}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Search and Filter
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search upgrades...",
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
                    label: "Category",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Attack", "value": "Attack"},
                      {"label": "Defense", "value": "Defense"},
                      {"label": "Movement", "value": "Movement"},
                      {"label": "Magic", "value": "Magic"},
                    ],
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Upgrades List
            ...filteredUpgrades.map((upgrade) {
              final isMaxLevel = (upgrade["level"] as int) >= (upgrade["maxLevel"] as int);
              final canUpgrade = upgrade["owned"] == true && !isMaxLevel;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: upgrade["owned"] == true
                      ? Border.all(color: _getCategoryColor(upgrade["category"] as String), width: 1)
                      : null,
                ),
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _getCategoryColor(upgrade["category"] as String).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          upgrade["icon"] as IconData,
                          color: _getCategoryColor(upgrade["category"] as String),
                          size: 30,
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${upgrade["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
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
                                    color: _getRarityColor(upgrade["rarity"] as String),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${upgrade["rarity"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            Text(
                              "${upgrade["category"]} • ${upgrade["type"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            
                            Text(
                              "${upgrade["effect"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                              ),
                            ),

                            // Level Progress
                            Row(
                              children: [
                                Text(
                                  "Level ${upgrade["level"]}/${upgrade["maxLevel"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: (upgrade["level"] as int) / (upgrade["maxLevel"] as int),
                                    backgroundColor: disabledColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _getCategoryColor(upgrade["category"] as String),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Cost and Action
                            Row(
                              children: [
                                if (!upgrade["owned"])
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.monetization_on,
                                        size: 16,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${upgrade["cost"]} Gold",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: warningColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (canUpgrade)
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.upgrade,
                                        size: 16,
                                        color: infoColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${upgrade["nextCost"]} Gold",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (isMaxLevel)
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        size: 16,
                                        color: successColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Maxed",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                Spacer(),
                                if (!upgrade["owned"])
                                  QButton(
                                    label: "Purchase",
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('PurchaseUpgradeView', arguments: upgrade)
                                    },
                                  ),
                                if (canUpgrade)
                                  QButton(
                                    label: "Upgrade",
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('UpgradeDetailView', arguments: upgrade)
                                    },
                                  ),
                                if (upgrade["owned"] == true && !canUpgrade && !isMaxLevel)
                                  QButton(
                                    label: "Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('UpgradeDetailView', arguments: upgrade)
                                    },
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
            }),
          ],
        ),
      ),
    );
  }
}
