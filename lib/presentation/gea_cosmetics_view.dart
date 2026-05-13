import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaCosmeticsView extends StatefulWidget {
  const GeaCosmeticsView({super.key});

  @override
  State<GeaCosmeticsView> createState() => _GeaCosmeticsViewState();
}

class _GeaCosmeticsViewState extends State<GeaCosmeticsView> {
  int currentTab = 0;
  String selectedCategory = "All";
  String selectedRarity = "All";
  
  List<String> categories = ["All", "Weapons", "Characters", "Emotes", "Sprays", "Player Cards"];
  List<String> rarities = ["All", "Common", "Uncommon", "Rare", "Epic", "Legendary"];
  
  List<Map<String, dynamic>> cosmetics = [
    {
      "id": 1,
      "name": "Dragon Skin AK-47",
      "category": "Weapons",
      "rarity": "Legendary",
      "price": 2499,
      "currency": "VP",
      "game": "Valorant",
      "image": "https://picsum.photos/200/200?random=1&keyword=weapon",
      "owned": false,
      "limited": true,
      "discount": 0
    },
    {
      "id": 2,
      "name": "Neon Agent Skin",
      "category": "Characters",
      "rarity": "Epic",
      "price": 1875,
      "currency": "VP",
      "game": "Valorant",
      "image": "https://picsum.photos/200/200?random=2&keyword=character",
      "owned": true,
      "limited": false,
      "discount": 25
    },
    {
      "id": 3,
      "name": "Victory Dance",
      "category": "Emotes",
      "rarity": "Rare",
      "price": 350,
      "currency": "VP",
      "game": "Valorant",
      "image": "https://picsum.photos/200/200?random=3&keyword=dance",
      "owned": false,
      "limited": false,
      "discount": 0
    },
    {
      "id": 4,
      "name": "Fire Logo Spray",
      "category": "Sprays",
      "rarity": "Common",
      "price": 75,
      "currency": "VP",
      "game": "Valorant",
      "image": "https://picsum.photos/200/200?random=4&keyword=spray",
      "owned": false,
      "limited": false,
      "discount": 50
    },
    {
      "id": 5,
      "name": "Champion Player Card",
      "category": "Player Cards",
      "rarity": "Epic",
      "price": 500,
      "currency": "VP",
      "game": "CS2",
      "image": "https://picsum.photos/200/200?random=5&keyword=card",
      "owned": false,
      "limited": true,
      "discount": 0
    }
  ];

  List<Map<String, dynamic>> inventory = [
    {
      "id": 2,
      "name": "Neon Agent Skin",
      "category": "Characters",
      "rarity": "Epic",
      "purchaseDate": "2024-07-15",
      "image": "https://picsum.photos/200/200?random=2&keyword=character",
    },
    {
      "id": 6,
      "name": "Classic Knife",
      "category": "Weapons",
      "rarity": "Uncommon",
      "purchaseDate": "2024-06-20",
      "image": "https://picsum.photos/200/200?random=6&keyword=knife",
    }
  ];

  List<Map<String, dynamic>> get filteredCosmetics {
    return cosmetics.where((item) {
      bool categoryMatch = selectedCategory == "All" || item["category"] == selectedCategory;
      bool rarityMatch = selectedRarity == "All" || item["rarity"] == selectedRarity;
      return categoryMatch && rarityMatch;
    }).toList();
  }

  Color getRarityColor(String rarity) {
    switch (rarity) {
      case "Common":
        return Colors.grey;
      case "Uncommon":
        return successColor;
      case "Rare":
        return infoColor;
      case "Epic":
        return warningColor;
      case "Legendary":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Cosmetics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Shop", icon: Icon(Icons.store)),
        Tab(text: "Inventory", icon: Icon(Icons.inventory)),
        Tab(text: "Collection", icon: Icon(Icons.collections)),
      ],
      tabChildren: [
        _buildShopTab(),
        _buildInventoryTab(),
        _buildCollectionTab(),
      ],
    );
  }

  Widget _buildShopTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Daily Deals
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Daily Deals",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Up to 50% off selected items",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.white, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "Resets in 12:34:56",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.local_fire_department,
                  color: Colors.white,
                  size: 48,
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Filters
          Row(
            children: [
              Expanded(
                child: QCategoryPicker(
                  items: categories.map((category) => {
                    "label": category,
                    "value": category,
                  }).toList(),
                  value: selectedCategory,
                  onChanged: (index, label, value, item) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          QCategoryPicker(
            items: rarities.map((rarity) => {
              "label": rarity,
              "value": rarity,
            }).toList(),
            value: selectedRarity,
            onChanged: (index, label, value, item) {
              selectedRarity = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          // Items Grid
          ResponsiveGridView(
            minItemWidth: 200,
            children: filteredCosmetics.map((item) {
              return Container(
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
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                          child: Image.network(
                            "${item["image"]}",
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        
                        // Rarity Badge
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: getRarityColor("${item["rarity"]}"),
                              borderRadius: BorderRadius.circular(radiusSm),
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
                        
                        // Limited Badge
                        if (item["limited"] as bool)
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "LIMITED",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        
                        // Discount Badge
                        if ((item["discount"] as int) > 0)
                          Positioned(
                            bottom: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "-${item["discount"]}%",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        
                        // Owned Overlay
                        if (item["owned"] as bool)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(128),
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
                                      Icons.check_circle,
                                      color: successColor,
                                      size: 32,
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "OWNED",
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
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${item["category"]} • ${item["game"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              if ((item["discount"] as int) > 0)
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "${item["price"]} ${item["currency"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${((item["price"] as int) * (100 - (item["discount"] as int)) / 100).round()} ${item["currency"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Expanded(
                                  child: Text(
                                    "${item["price"]} ${item["currency"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Action Button
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: (item["owned"] as bool) ? "Owned" : "Purchase",
                              size: bs.sm,
                              onPressed: (item["owned"] as bool) ? null : () {
                                _showPurchaseDialog(item);
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
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Inventory Stats
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${inventory.length}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Items",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "5",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Equipped",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "2",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Rare+",
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
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "Your Items",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          if (inventory.isEmpty)
            Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No Items Yet",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Visit the shop to purchase cosmetics",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ResponsiveGridView(
              minItemWidth: 200,
              children: inventory.map((item) {
                return Container(
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
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${item["image"]}",
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: getRarityColor("${item["rarity"]}"),
                                borderRadius: BorderRadius.circular(radiusSm),
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
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${item["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Purchased: ${item["purchaseDate"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Equip",
                                size: bs.sm,
                                onPressed: () {},
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
    );
  }

  Widget _buildCollectionTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Collection Progress
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Collection Progress",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Weapons",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: 0.3,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "12/40 (30%)",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Characters",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: 0.6,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(successColor),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "18/30 (60%)",
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
                
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Emotes",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: 0.8,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "16/20 (80%)",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sprays",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: 0.4,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "8/20 (40%)",
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
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Achievements
          Text(
            "Collection Achievements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              List<Map<String, dynamic>> achievements = [
                {
                  "title": "Weapon Master",
                  "description": "Collect 25 weapon skins",
                  "progress": 12,
                  "target": 25,
                  "completed": false,
                  "reward": "Exclusive Title"
                },
                {
                  "title": "Character Collector",
                  "description": "Unlock all character skins",
                  "progress": 18,
                  "target": 30,
                  "completed": false,
                  "reward": "Rare Emote"
                },
                {
                  "title": "First Purchase",
                  "description": "Make your first cosmetic purchase",
                  "progress": 1,
                  "target": 1,
                  "completed": true,
                  "reward": "Starter Pack"
                }
              ];
              
              final achievement = achievements[index];
              double progress = (achievement["progress"] as int) / (achievement["target"] as int);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: (achievement["completed"] as bool) 
                    ? Border.all(color: successColor, width: 2)
                    : null,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (achievement["completed"] as bool) 
                          ? successColor 
                          : primaryColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        (achievement["completed"] as bool)
                          ? Icons.check_circle
                          : Icons.emoji_events,
                        color: (achievement["completed"] as bool)
                          ? Colors.white
                          : primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${achievement["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${achievement["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: disabledColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    (achievement["completed"] as bool) 
                                      ? successColor 
                                      : primaryColor
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${achievement["progress"]}/${achievement["target"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: (achievement["completed"] as bool)
                                    ? successColor
                                    : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Reward: ${achievement["reward"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
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
        ],
      ),
    );
  }

  void _showPurchaseDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Purchase Item"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              "${item["image"]}",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: spMd),
            Text(
              "${item["name"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spSm),
            Text(
              "Price: ${item["price"]} ${item["currency"]}",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
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
            label: "Purchase",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              ss("Item purchased successfully!");
            },
          ),
        ],
      ),
    );
  }
}
