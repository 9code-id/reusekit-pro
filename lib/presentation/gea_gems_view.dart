import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaGemsView extends StatefulWidget {
  const GeaGemsView({super.key});

  @override
  State<GeaGemsView> createState() => _GeaGemsViewState();
}

class _GeaGemsViewState extends State<GeaGemsView> {
  String selectedType = "All";
  String searchQuery = "";

  int currentGems = 2850;
  
  List<Map<String, dynamic>> gemPacks = [
    {
      "id": 1,
      "name": "Starter Pack",
      "gems": 100,
      "bonus": 0,
      "price": 0.99,
      "currency": "USD",
      "popular": false,
      "discount": 0,
      "icon": Icons.diamond,
      "color": Color(0xFF4CAF50),
      "description": "Perfect for beginners to get started",
    },
    {
      "id": 2,
      "name": "Basic Bundle",
      "gems": 500,
      "bonus": 50,
      "price": 4.99,
      "currency": "USD",
      "popular": false,
      "discount": 0,
      "icon": Icons.diamond,
      "color": Color(0xFF2196F3),
      "description": "Great value for casual players",
    },
    {
      "id": 3,
      "name": "Popular Choice",
      "gems": 1200,
      "bonus": 200,
      "price": 9.99,
      "currency": "USD",
      "popular": true,
      "discount": 20,
      "icon": Icons.diamond,
      "color": Color(0xFF9C27B0),
      "description": "Most chosen by players worldwide",
    },
    {
      "id": 4,
      "name": "Power Pack",
      "gems": 2500,
      "bonus": 500,
      "price": 19.99,
      "currency": "USD",
      "popular": false,
      "discount": 25,
      "icon": Icons.diamond,
      "color": Color(0xFFFF9800),
      "description": "Serious gamers' preferred choice",
    },
    {
      "id": 5,
      "name": "Ultimate Bundle",
      "gems": 6000,
      "bonus": 1500,
      "price": 49.99,
      "currency": "USD",
      "popular": false,
      "discount": 30,
      "icon": Icons.diamond,
      "color": Color(0xFFFFD700),
      "description": "Maximum value with huge bonus",
    },
    {
      "id": 6,
      "name": "VIP Elite",
      "gems": 12000,
      "bonus": 4000,
      "price": 99.99,
      "currency": "USD",
      "popular": false,
      "discount": 35,
      "icon": Icons.diamond,
      "color": Color(0xFFE91E63),
      "description": "For the ultimate gaming experience",
    },
  ];

  List<Map<String, dynamic>> gemShop = [
    {
      "id": 1,
      "name": "Health Potion",
      "category": "Consumables",
      "price": 50,
      "icon": Icons.favorite,
      "color": Color(0xFFF44336),
      "description": "Restore 100 HP instantly",
      "stock": 10,
    },
    {
      "id": 2,
      "name": "Mana Elixir",
      "category": "Consumables",
      "price": 75,
      "icon": Icons.auto_awesome,
      "color": Color(0xFF3F51B5),
      "description": "Restore 50 MP instantly",
      "stock": 8,
    },
    {
      "id": 3,
      "name": "XP Booster",
      "category": "Boosters",
      "price": 200,
      "icon": Icons.trending_up,
      "color": Color(0xFF4CAF50),
      "description": "Double XP for 1 hour",
      "stock": 5,
    },
    {
      "id": 4,
      "name": "Premium Chest",
      "category": "Loot Boxes",
      "price": 300,
      "icon": Icons.inventory,
      "color": Color(0xFFFF9800),
      "description": "Contains rare items and weapons",
      "stock": 3,
    },
    {
      "id": 5,
      "name": "Legendary Ticket",
      "category": "Tickets",
      "price": 500,
      "icon": Icons.confirmation_number,
      "color": Color(0xFF9C27B0),
      "description": "Access to legendary dungeons",
      "stock": 2,
    },
    {
      "id": 6,
      "name": "Character Slot",
      "category": "Upgrades",
      "price": 1000,
      "icon": Icons.person_add,
      "color": Color(0xFF607D8B),
      "description": "Add an extra character slot",
      "stock": 1,
    },
  ];

  List<Map<String, dynamic>> get filteredShopItems {
    return gemShop.where((item) {
      final matchesType = selectedType == "All" || item["category"] == selectedType;
      final matchesSearch = searchQuery.isEmpty ||
          (item["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesType && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gems & Premium Store"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            margin: EdgeInsets.only(right: spSm),
            decoration: BoxDecoration(
              color: Color(0xFFFFD700).withAlpha(30),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: Color(0xFFFFD700)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.diamond,
                  color: Color(0xFFFFD700),
                  size: 20,
                ),
                SizedBox(width: 4),
                Text(
                  "$currentGems",
                  style: TextStyle(
                    color: Color(0xFFFFD700),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Current Balance Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFD700),
                    Color(0xFFFFA000),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.diamond,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Current Balance",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "$currentGems Gems",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Purchase Gems Section
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
                children: [
                  Text(
                    "Purchase Gems",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    minItemWidth: 150,
                    children: gemPacks.map((pack) {
                      final totalGems = (pack["gems"] as int) + (pack["bonus"] as int);
                      final hasDiscount = (pack["discount"] as int) > 0;
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: pack["popular"] == true
                              ? Border.all(color: Color(0xFFFFD700), width: 2)
                              : Border.all(color: disabledColor),
                        ),
                        child: Column(
                          children: [
                            // Header
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (pack["color"] as Color).withAlpha(30),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusSm),
                                  topRight: Radius.circular(radiusSm),
                                ),
                              ),
                              child: Column(
                                children: [
                                  if (pack["popular"] == true)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFD700),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "POPULAR",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${pack["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            
                            // Content
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                spacing: spXs,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.diamond,
                                        color: pack["color"] as Color,
                                        size: 20,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${pack["gems"]}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: pack["color"] as Color,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  if ((pack["bonus"] as int) > 0)
                                    Text(
                                      "+${pack["bonus"]} Bonus",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  
                                  if (hasDiscount)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${pack["discount"]}% OFF",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  
                                  Text(
                                    "\$${pack["price"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  
                                  QButton(
                                    label: "Purchase",
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('PurchaseGemPackView', arguments: pack)
                                    },
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

            // Gem Shop Section
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
                    "Gem Shop",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Text(
                    "Spend your gems on premium items and upgrades",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
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
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "Consumables", "value": "Consumables"},
                            {"label": "Boosters", "value": "Boosters"},
                            {"label": "Loot Boxes", "value": "Loot Boxes"},
                            {"label": "Tickets", "value": "Tickets"},
                            {"label": "Upgrades", "value": "Upgrades"},
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

                  // Shop Items
                  ...filteredShopItems.map((item) {
                    final canAfford = currentGems >= (item["price"] as int);
                    final inStock = (item["stock"] as int) > 0;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: canAfford && inStock 
                            ? Colors.white 
                            : disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: canAfford && inStock 
                              ? disabledColor 
                              : disabledBoldColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (item["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              item["icon"] as IconData,
                              color: item["color"] as Color,
                              size: 24,
                            ),
                          ),
                          
                          SizedBox(width: spSm),
                          
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 2,
                              children: [
                                Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: canAfford && inStock 
                                        ? primaryColor 
                                        : disabledBoldColor,
                                  ),
                                ),
                                
                                Text(
                                  "${item["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                
                                Row(
                                  children: [
                                    Text(
                                      "Stock: ${item["stock"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: inStock ? successColor : dangerColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.diamond,
                                      size: 14,
                                      color: Color(0xFFFFD700),
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${item["price"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: canAfford 
                                            ? Color(0xFFFFD700) 
                                            : dangerColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          QButton(
                            label: "Buy",
                            size: bs.sm,
                            onPressed: canAfford && inStock ? () {
                              //navigateTo('PurchaseItemView', arguments: item)
                            } : null,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
