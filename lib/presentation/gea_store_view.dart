import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaStoreView extends StatefulWidget {
  const GeaStoreView({super.key});

  @override
  State<GeaStoreView> createState() => _GeaStoreViewState();
}

class _GeaStoreViewState extends State<GeaStoreView> {
  String selectedCategory = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> storeItems = [
    {
      "id": 1,
      "name": "Dragon Sword",
      "description": "Legendary weapon with fire damage",
      "price": 15.99,
      "currency": "USD",
      "category": "Weapons",
      "rarity": "Legendary",
      "image": "https://picsum.photos/200/200?random=1&keyword=sword",
      "discount": 20,
      "originalPrice": 19.99,
      "stock": 50,
      "popular": true,
    },
    {
      "id": 2,
      "name": "Mystic Armor Set",
      "description": "Complete armor set with magic resistance",
      "price": 25.99,
      "currency": "USD", 
      "category": "Armor",
      "rarity": "Epic",
      "image": "https://picsum.photos/200/200?random=2&keyword=armor",
      "discount": 0,
      "originalPrice": 25.99,
      "stock": 30,
      "popular": false,
    },
    {
      "id": 3,
      "name": "Speed Boost Potion",
      "description": "Increases movement speed for 10 minutes",
      "price": 2.99,
      "currency": "USD",
      "category": "Consumables",
      "rarity": "Common",
      "image": "https://picsum.photos/200/200?random=3&keyword=potion",
      "discount": 0,
      "originalPrice": 2.99,
      "stock": 100,
      "popular": true,
    },
    {
      "id": 4,
      "name": "Phoenix Wings",
      "description": "Rare cosmetic wings with fire effect",
      "price": 12.99,
      "currency": "USD",
      "category": "Cosmetics",
      "rarity": "Rare",
      "image": "https://picsum.photos/200/200?random=4&keyword=wings",
      "discount": 15,
      "originalPrice": 15.29,
      "stock": 25,
      "popular": true,
    },
    {
      "id": 5,
      "name": "Champion's Bundle",
      "description": "Complete starter pack for new players",
      "price": 49.99,
      "currency": "USD",
      "category": "Bundles",
      "rarity": "Bundle",
      "image": "https://picsum.photos/200/200?random=5&keyword=bundle",
      "discount": 30,
      "originalPrice": 71.40,
      "stock": 15,
      "popular": true,
    },
    {
      "id": 6,
      "name": "Experience Booster",
      "description": "Double XP gain for 24 hours",
      "price": 4.99,
      "currency": "USD",
      "category": "Boosters",
      "rarity": "Common",
      "image": "https://picsum.photos/200/200?random=6&keyword=boost",
      "discount": 0,
      "originalPrice": 4.99,
      "stock": 200,
      "popular": false,
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return storeItems.where((item) {
      final matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          (item["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case "Legendary":
        return warningColor;
      case "Epic":
        return infoColor;
      case "Rare":
        return successColor;
      case "Bundle":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Store"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              //navigateTo('CartView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Featured Banner
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Icon(
                      Icons.stars,
                      size: 100,
                      color: Colors.white.withAlpha(50),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Weekly Sale",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Up to 30% off on selected items",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
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
                      {"label": "Weapons", "value": "Weapons"},
                      {"label": "Armor", "value": "Armor"},
                      {"label": "Consumables", "value": "Consumables"},
                      {"label": "Cosmetics", "value": "Cosmetics"},
                      {"label": "Bundles", "value": "Bundles"},
                      {"label": "Boosters", "value": "Boosters"},
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

            // Popular Items Section
            if (storeItems.where((item) => item["popular"] == true).isNotEmpty) ...[
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Popular Items",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              QHorizontalScroll(
                children: storeItems
                    .where((item) => item["popular"] == true)
                    .map((item) => Container(
                          width: 180,
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    child: Image.network(
                                      "${item["image"]}",
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  if ((item["discount"] as int) > 0)
                                    Positioned(
                                      top: spXs,
                                      right: spXs,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: dangerColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "-${item["discount"]}%",
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
                              SizedBox(height: spXs),
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
                                  if ((item["discount"] as int) > 0) ...[
                                    Text(
                                      "\$${(item["originalPrice"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                  ],
                                  Text(
                                    "\$${(item["price"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],

            // All Items Grid
            Row(
              children: [
                Text(
                  "All Items",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredItems.length} items",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredItems.map((item) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${item["image"]}",
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if ((item["discount"] as int) > 0)
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "-${item["discount"]}%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            top: spXs,
                            left: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getRarityColor(item["rarity"]),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["rarity"]}",
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
                      SizedBox(height: spSm),
                      Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${item["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if ((item["discount"] as int) > 0) ...[
                                Text(
                                  "\$${(item["originalPrice"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(height: 2),
                              ],
                              Text(
                                "\$${(item["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "Stock: ${item["stock"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Buy Now",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('PurchaseView', arguments: item)
                          },
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
