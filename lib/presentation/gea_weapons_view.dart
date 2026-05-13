import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaWeaponsView extends StatefulWidget {
  const GeaWeaponsView({super.key});

  @override
  State<GeaWeaponsView> createState() => _GeaWeaponsViewState();
}

class _GeaWeaponsViewState extends State<GeaWeaponsView> {
  String selectedCategory = "All";
  String searchQuery = "";
  String selectedRarity = "All";

  List<Map<String, dynamic>> weapons = [
    {
      "id": 1,
      "name": "Dragon Slayer",
      "type": "Sword",
      "rarity": "Legendary",
      "damage": 150,
      "durability": 95,
      "level": 25,
      "owned": true,
      "equipped": true,
      "image": "https://picsum.photos/120/120?random=1&keyword=sword",
      "description": "A legendary sword forged from dragon scales",
      "price": 5000,
      "skills": ["Fire Damage", "Critical Strike", "Dragon Slayer"],
    },
    {
      "id": 2,
      "name": "Shadow Bow",
      "type": "Bow",
      "rarity": "Epic",
      "damage": 120,
      "durability": 80,
      "level": 20,
      "owned": true,
      "equipped": false,
      "image": "https://picsum.photos/120/120?random=2&keyword=bow",
      "description": "A bow that shoots arrows from the shadows",
      "price": 3500,
      "skills": ["Shadow Shot", "Silent Strike", "Poison Arrow"],
    },
    {
      "id": 3,
      "name": "Thunder Staff",
      "type": "Staff",
      "rarity": "Epic",
      "damage": 140,
      "durability": 70,
      "level": 22,
      "owned": true,
      "equipped": false,
      "image": "https://picsum.photos/120/120?random=3&keyword=staff",
      "description": "Channel the power of thunder and lightning",
      "price": 4200,
      "skills": ["Lightning Bolt", "Chain Lightning", "Thunder Storm"],
    },
    {
      "id": 4,
      "name": "Crystal Dagger",
      "type": "Dagger",
      "rarity": "Rare",
      "damage": 90,
      "durability": 85,
      "level": 15,
      "owned": false,
      "equipped": false,
      "image": "https://picsum.photos/120/120?random=4&keyword=dagger",
      "description": "A dagger made from pure crystal",
      "price": 2800,
      "skills": ["Crystal Shards", "Quick Strike", "Stealth"],
    },
    {
      "id": 5,
      "name": "Iron Shield",
      "type": "Shield",
      "rarity": "Common",
      "damage": 0,
      "durability": 100,
      "level": 10,
      "owned": true,
      "equipped": false,
      "image": "https://picsum.photos/120/120?random=5&keyword=shield",
      "description": "A sturdy iron shield for defense",
      "price": 1200,
      "skills": ["Block", "Shield Bash", "Fortify"],
    },
    {
      "id": 6,
      "name": "Flame Axe",
      "type": "Axe",
      "rarity": "Rare",
      "damage": 130,
      "durability": 75,
      "level": 18,
      "owned": false,
      "equipped": false,
      "image": "https://picsum.photos/120/120?random=6&keyword=axe",
      "description": "An axe that burns with eternal flames",
      "price": 3200,
      "skills": ["Fire Strike", "Burning Wound", "Flame Slash"],
    },
  ];

  List<Map<String, dynamic>> get filteredWeapons {
    return weapons.where((weapon) {
      final matchesCategory = selectedCategory == "All" || weapon["type"] == selectedCategory;
      final matchesRarity = selectedRarity == "All" || weapon["rarity"] == selectedRarity;
      final matchesSearch = searchQuery.isEmpty ||
          (weapon["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (weapon["type"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesRarity && matchesSearch;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weapons Arsenal"),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              //navigateTo('WeaponsSortView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Summary
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
                          "Total Weapons",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${weapons.length}",
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
                          "Owned",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${weapons.where((w) => w["owned"] == true).length}",
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
                          "Equipped",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${weapons.where((w) => w["equipped"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
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
                    label: "Search weapons...",
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
                      {"label": "Sword", "value": "Sword"},
                      {"label": "Bow", "value": "Bow"},
                      {"label": "Staff", "value": "Staff"},
                      {"label": "Dagger", "value": "Dagger"},
                      {"label": "Shield", "value": "Shield"},
                      {"label": "Axe", "value": "Axe"},
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

            // Rarity Filter
            QDropdownField(
              label: "Rarity Filter",
              items: [
                {"label": "All Rarities", "value": "All"},
                {"label": "Legendary", "value": "Legendary"},
                {"label": "Epic", "value": "Epic"},
                {"label": "Rare", "value": "Rare"},
                {"label": "Common", "value": "Common"},
              ],
              value: selectedRarity,
              onChanged: (value, label) {
                selectedRarity = value;
                setState(() {});
              },
            ),

            // Weapons Grid
            ResponsiveGridView(
              padding: EdgeInsets.symmetric(vertical: spSm),
              minItemWidth: 200,
              children: filteredWeapons.map((weapon) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: weapon["equipped"] == true
                        ? Border.all(color: successColor, width: 2)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Weapon Image
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${weapon["image"]}",
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
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
                                color: _getRarityColor(weapon["rarity"] as String),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${weapon["rarity"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          if (weapon["equipped"] == true)
                            Positioned(
                              top: spXs,
                              left: spXs,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: successColor,
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

                      // Weapon Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${weapon["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            Text(
                              "${weapon["type"]} • Level ${weapon["level"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),

                            // Stats
                            Row(
                              children: [
                                Icon(
                                  Icons.flash_on,
                                  size: 16,
                                  color: dangerColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${weapon["damage"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: dangerColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.shield,
                                  size: 16,
                                  color: infoColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${weapon["durability"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
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
                                  "${weapon["price"]} Gold",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),

                            // Action Button
                            Container(
                              width: double.infinity,
                              child: weapon["owned"] == true
                                  ? QButton(
                                      label: weapon["equipped"] == true ? "Equipped" : "Equip",
                                      size: bs.sm,
                                      onPressed: weapon["equipped"] == true ? null : () {
                                        //navigateTo('EquipWeaponView', arguments: weapon)
                                      },
                                    )
                                  : QButton(
                                      label: "Purchase",
                                      size: bs.sm,
                                      onPressed: () {
                                        //navigateTo('PurchaseWeaponView', arguments: weapon)
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
}
