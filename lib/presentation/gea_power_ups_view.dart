import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaPowerUpsView extends StatefulWidget {
  const GeaPowerUpsView({super.key});

  @override
  State<GeaPowerUpsView> createState() => _GeaPowerUpsViewState();
}

class _GeaPowerUpsViewState extends State<GeaPowerUpsView> {
  String selectedType = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> powerUps = [
    {
      "id": 1,
      "name": "Double Damage",
      "type": "Temporary",
      "duration": 30,
      "effect": "Doubles all damage dealt",
      "quantity": 5,
      "maxStack": 10,
      "cost": 150,
      "cooldown": 0,
      "rarity": "Epic",
      "icon": Icons.flash_on,
      "description": "Temporarily doubles your damage output for devastating attacks",
      "activated": false,
    },
    {
      "id": 2,
      "name": "Invincibility",
      "type": "Temporary",
      "duration": 15,
      "effect": "Immune to all damage",
      "quantity": 2,
      "maxStack": 5,
      "cost": 300,
      "cooldown": 0,
      "rarity": "Legendary",
      "icon": Icons.shield,
      "description": "Become completely invulnerable to all forms of damage",
      "activated": false,
    },
    {
      "id": 3,
      "name": "Speed Rush",
      "type": "Temporary",
      "duration": 45,
      "effect": "Increases speed by 50%",
      "quantity": 8,
      "maxStack": 15,
      "cost": 100,
      "cooldown": 0,
      "rarity": "Rare",
      "icon": Icons.speed,
      "description": "Move and attack at lightning speed",
      "activated": false,
    },
    {
      "id": 4,
      "name": "Health Potion",
      "type": "Instant",
      "duration": 0,
      "effect": "Restores 100 HP instantly",
      "quantity": 12,
      "maxStack": 20,
      "cost": 50,
      "cooldown": 0,
      "rarity": "Common",
      "icon": Icons.favorite,
      "description": "Instantly restores a significant amount of health",
      "activated": false,
    },
    {
      "id": 5,
      "name": "Mana Surge",
      "type": "Instant",
      "duration": 0,
      "effect": "Restores 50 MP instantly",
      "quantity": 7,
      "maxStack": 15,
      "cost": 75,
      "cooldown": 0,
      "rarity": "Common",
      "icon": Icons.auto_awesome,
      "description": "Quickly replenish your magical energy",
      "activated": false,
    },
    {
      "id": 6,
      "name": "Lucky Charm",
      "type": "Temporary",
      "duration": 60,
      "effect": "Increases drop rate by 25%",
      "quantity": 3,
      "maxStack": 8,
      "cost": 200,
      "cooldown": 0,
      "rarity": "Epic",
      "icon": Icons.star,
      "description": "Improves your luck in finding rare items",
      "activated": false,
    },
    {
      "id": 7,
      "name": "Freeze Time",
      "type": "Active",
      "duration": 10,
      "effect": "Slows enemies by 75%",
      "quantity": 1,
      "maxStack": 3,
      "cost": 500,
      "cooldown": 120,
      "rarity": "Legendary",
      "icon": Icons.access_time,
      "description": "Slow down time for tactical advantage",
      "activated": false,
    },
  ];

  List<Map<String, dynamic>> get filteredPowerUps {
    return powerUps.where((powerUp) {
      final matchesType = selectedType == "All" || powerUp["type"] == selectedType;
      final matchesSearch = searchQuery.isEmpty ||
          (powerUp["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (powerUp["effect"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesType && matchesSearch;
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

  Color _getTypeColor(String type) {
    switch (type) {
      case "Temporary":
        return warningColor;
      case "Instant":
        return successColor;
      case "Active":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatDuration(int duration) {
    if (duration == 0) return "Instant";
    if (duration < 60) return "${duration}s";
    return "${(duration / 60).floor()}m ${duration % 60}s";
  }

  @override
  Widget build(BuildContext context) {
    final totalPowerUps = powerUps.fold(0, (sum, p) => sum + (p["quantity"] as int));
    final activePowerUps = powerUps.where((p) => p["activated"] == true).length;
    final uniquePowerUps = powerUps.where((p) => (p["quantity"] as int) > 0).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Power-Ups Collection"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              //navigateTo('PowerUpStoreView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Overview
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
                          "Total Items",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$totalPowerUps",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Types Owned",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$uniquePowerUps/${powerUps.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$activePowerUps",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search and Filter
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search power-ups...",
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
                    label: "Type",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Temporary", "value": "Temporary"},
                      {"label": "Instant", "value": "Instant"},
                      {"label": "Active", "value": "Active"},
                    ],
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Power-Ups Grid
            ResponsiveGridView(
              padding: EdgeInsets.symmetric(vertical: spSm),
              minItemWidth: 200,
              children: filteredPowerUps.map((powerUp) {
                final hasItems = (powerUp["quantity"] as int) > 0;
                final isActive = powerUp["activated"] == true;
                
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: isActive
                        ? Border.all(color: warningColor, width: 2)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getTypeColor(powerUp["type"] as String).withAlpha(30),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: _getTypeColor(powerUp["type"] as String),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                powerUp["icon"] as IconData,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${powerUp["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${powerUp["type"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getTypeColor(powerUp["type"] as String),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getRarityColor(powerUp["rarity"] as String),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${powerUp["rarity"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Content
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "${powerUp["effect"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              "${powerUp["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),

                            // Stats Row
                            Row(
                              children: [
                                if ((powerUp["duration"] as int) > 0) ...[
                                  Icon(
                                    Icons.timer,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    _formatDuration(powerUp["duration"] as int),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                ],
                                if ((powerUp["cooldown"] as int) > 0) ...[
                                  Icon(
                                    Icons.refresh,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${powerUp["cooldown"]}s CD",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),

                            // Quantity
                            Row(
                              children: [
                                Text(
                                  "Quantity: ${powerUp["quantity"]}/${powerUp["maxStack"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: hasItems ? successColor : dangerColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: (powerUp["quantity"] as int) / (powerUp["maxStack"] as int),
                                    backgroundColor: disabledColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      hasItems ? successColor : dangerColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Price
                            Row(
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  size: 16,
                                  color: warningColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${powerUp["cost"]} Gold",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: hasItems ? "Use" : "Buy",
                                    size: bs.sm,
                                    onPressed: hasItems ? () {
                                      //navigateTo('UsePowerUpView', arguments: powerUp)
                                    } : () {
                                      //navigateTo('BuyPowerUpView', arguments: powerUp)
                                    },
                                  ),
                                ),
                                if (hasItems) ...[
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.info,
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('PowerUpDetailView', arguments: powerUp)
                                    },
                                  ),
                                ],
                              ],
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
}
