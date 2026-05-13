import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaInventoryView extends StatefulWidget {
  const GeaInventoryView({super.key});

  @override
  State<GeaInventoryView> createState() => _GeaInventoryViewState();
}

class _GeaInventoryViewState extends State<GeaInventoryView> {
  String selectedCategory = "All";
  String searchQuery = "";
  Map<String, dynamic>? selectedItem;
  
  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": 1,
      "name": "Iron Sword",
      "type": "Weapon",
      "rarity": "Common",
      "level": 15,
      "attack": 85,
      "durability": 95,
      "maxDurability": 100,
      "quantity": 1,
      "equipped": true,
      "image": "https://picsum.photos/100/100?random=1&keyword=sword",
      "description": "A sturdy iron sword with decent attack power",
      "value": 250,
    },
    {
      "id": 2,
      "name": "Health Potion",
      "type": "Consumable",
      "rarity": "Common",
      "level": 1,
      "healAmount": 150,
      "quantity": 25,
      "equipped": false,
      "image": "https://picsum.photos/100/100?random=2&keyword=potion",
      "description": "Restores 150 HP when consumed",
      "value": 50,
    },
    {
      "id": 3,
      "name": "Dragon Scale Armor",
      "type": "Armor",
      "rarity": "Epic",
      "level": 30,
      "defense": 120,
      "durability": 88,
      "maxDurability": 100,
      "quantity": 1,
      "equipped": true,
      "image": "https://picsum.photos/100/100?random=3&keyword=armor",
      "description": "Legendary armor crafted from dragon scales",
      "value": 1500,
    },
    {
      "id": 4,
      "name": "Mana Crystal",
      "type": "Material",
      "rarity": "Rare",
      "level": 1,
      "quantity": 8,
      "equipped": false,
      "image": "https://picsum.photos/100/100?random=4&keyword=crystal",
      "description": "Magical crystal used for enchanting equipment",
      "value": 200,
    },
    {
      "id": 5,
      "name": "Elven Bow",
      "type": "Weapon",
      "rarity": "Rare",
      "level": 22,
      "attack": 110,
      "durability": 92,
      "maxDurability": 100,
      "quantity": 1,
      "equipped": false,
      "image": "https://picsum.photos/100/100?random=5&keyword=bow",
      "description": "An elegant bow crafted by elven artisans",
      "value": 800,
    },
    {
      "id": 6,
      "name": "Speed Boots",
      "type": "Accessory",
      "rarity": "Rare",
      "level": 18,
      "speed": 25,
      "durability": 78,
      "maxDurability": 100,
      "quantity": 1,
      "equipped": true,
      "image": "https://picsum.photos/100/100?random=6&keyword=boots",
      "description": "Lightweight boots that increase movement speed",
      "value": 600,
    },
    {
      "id": 7,
      "name": "Ancient Scroll",
      "type": "Consumable",
      "rarity": "Epic",
      "level": 1,
      "quantity": 3,
      "equipped": false,
      "image": "https://picsum.photos/100/100?random=7&keyword=scroll",
      "description": "A scroll containing powerful magic spells",
      "value": 1200,
    },
    {
      "id": 8,
      "name": "Gold Coin",
      "type": "Currency",
      "rarity": "Common",
      "level": 1,
      "quantity": 15420,
      "equipped": false,
      "image": "https://picsum.photos/100/100?random=8&keyword=coin",
      "description": "Standard currency used throughout the realm",
      "value": 1,
    },
  ];

  List<String> categories = ["All", "Weapon", "Armor", "Accessory", "Consumable", "Material", "Currency"];

  List<Map<String, dynamic>> get filteredItems {
    return inventoryItems.where((item) {
      final matchesCategory = selectedCategory == "All" || item["type"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          (item["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["type"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

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
    final totalItems = inventoryItems.length;
    final totalValue = inventoryItems.fold(0.0, (sum, item) => sum + ((item["value"] as int) * (item["quantity"] as int)).toDouble());
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory"),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              //navigateTo('InventorySortView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Inventory Stats
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
                          "$totalItems",
                          style: TextStyle(
                            fontSize: fsH5,
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
                          "Total Value",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(totalValue / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: fsH5,
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
                    label: "Search items...",
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
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Category Pills
            Container(
              height: 40,
              child: QHorizontalScroll(
                children: categories.map((category) {
                  final isSelected = category == selectedCategory;
                  return GestureDetector(
                    onTap: () {
                      selectedCategory = category;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spXs),
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                        boxShadow: [shadowXs],
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : disabledBoldColor,
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Inventory Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredItems.map((item) {
                final isEquipped = item["equipped"] as bool;
                final rarity = item["rarity"] as String;
                final quantity = item["quantity"] as int;
                
                return GestureDetector(
                  onTap: () {
                    selectedItem = item;
                    _showItemDetailsModal(context, item);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: isEquipped ? Border.all(color: successColor, width: 2) : null,
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Item Image
                        Stack(
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusMd),
                                  topRight: Radius.circular(radiusMd),
                                ),
                                border: Border.all(
                                  color: getRarityColor(rarity),
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusMd),
                                  topRight: Radius.circular(radiusMd),
                                ),
                                child: Image.network(
                                  "${item["image"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (isEquipped)
                              Positioned(
                                top: spXs,
                                left: spXs,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "EQUIPPED",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                  color: getRarityColor(rarity),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  rarity,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            if (quantity > 1)
                              Positioned(
                                bottom: spXs,
                                right: spXs,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "x$quantity",
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

                        // Item Info
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "${item["type"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (item["level"] != null) ...[
                                    SizedBox(width: spXs),
                                    Text(
                                      "Lv.${item["level"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(height: spXs),
                              
                              // Item Stats
                              if (item["attack"] != null)
                                _buildStatRow(Icons.sports_esports, "ATK", "${item["attack"]}", warningColor),
                              if (item["defense"] != null)
                                _buildStatRow(Icons.shield, "DEF", "${item["defense"]}", infoColor),
                              if (item["speed"] != null)
                                _buildStatRow(Icons.speed, "SPD", "${item["speed"]}", successColor),
                              if (item["healAmount"] != null)
                                _buildStatRow(Icons.favorite, "HEAL", "${item["healAmount"]}", dangerColor),
                              
                              // Durability Bar
                              if (item["durability"] != null) ...[
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.build,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 2),
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: (item["durability"] as int) / (item["maxDurability"] as int),
                                        backgroundColor: disabledColor,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          (item["durability"] as int) > 50 ? successColor : dangerColor
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${item["durability"]}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              
                              SizedBox(height: spXs),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${((item["value"] as int) * quantity).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                  if (!isEquipped && item["type"] != "Currency" && item["type"] != "Material")
                                    QButton(
                                      label: "Equip",
                                      size: bs.sm,
                                      onPressed: () {
                                        item["equipped"] = true;
                                        setState(() {});
                                        ss("${item["name"]} equipped!");
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
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 12,
          color: color,
        ),
        SizedBox(width: 2),
        Text(
          "$label: $value",
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showItemDetailsModal(BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusLg),
              topRight: Radius.circular(radiusLg),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: getRarityColor("${item["rarity"]}"),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${item["image"]}",
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
                          "${item["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${item["type"]} • ${item["rarity"]}",
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
              SizedBox(height: spSm),
              Text(
                "${item["description"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: (item["equipped"] as bool) ? "Unequip" : "Equip",
                      onPressed: () {
                        item["equipped"] = !(item["equipped"] as bool);
                        setState(() {});
                        Navigator.pop(context);
                        ss("${item["name"]} ${(item["equipped"] as bool) ? 'equipped' : 'unequipped'}!");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.delete,
                    size: bs.sm,
                    onPressed: () async {
                      Navigator.pop(context);
                      bool isConfirmed = await confirm("Are you sure you want to discard this item?");
                      if (isConfirmed) {
                        inventoryItems.removeWhere((i) => i["id"] == item["id"]);
                        setState(() {});
                        ss("${item["name"]} discarded!");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
