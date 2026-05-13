import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaStickersView extends StatefulWidget {
  const GeaStickersView({super.key});

  @override
  State<GeaStickersView> createState() => _GeaStickersViewState();
}

class _GeaStickersViewState extends State<GeaStickersView> {
  int currentTab = 0;
  String selectedCategory = "All";
  String selectedRarity = "All";
  
  List<String> categories = ["All", "Funny", "Reaction", "Team", "Achievement", "Holiday"];
  List<String> rarities = ["All", "Common", "Uncommon", "Rare", "Epic", "Legendary"];
  
  List<Map<String, dynamic>> stickers = [
    {
      "id": 1,
      "name": "GG EZ",
      "category": "Reaction",
      "rarity": "Common",
      "price": 50,
      "owned": true,
      "favorited": true,
      "image": "https://picsum.photos/150/150?random=1&keyword=sticker",
      "description": "Classic victory celebration",
      "timesUsed": 67,
      "unlockDate": "2024-06-15",
      "animated": false
    },
    {
      "id": 2,
      "name": "Fire Emoji",
      "category": "Reaction",
      "rarity": "Uncommon",
      "price": 100,
      "owned": true,
      "favorited": false,
      "image": "https://picsum.photos/150/150?random=2&keyword=fire",
      "description": "Show your appreciation for hot plays",
      "timesUsed": 23,
      "unlockDate": "2024-07-10",
      "animated": true
    },
    {
      "id": 3,
      "name": "Ace Badge",
      "category": "Achievement",
      "rarity": "Epic",
      "price": 500,
      "owned": false,
      "favorited": false,
      "image": "https://picsum.photos/150/150?random=3&keyword=badge",
      "description": "Celebrate those perfect rounds",
      "timesUsed": 0,
      "unlockDate": null,
      "animated": true
    },
    {
      "id": 4,
      "name": "Team Unity",
      "category": "Team",
      "rarity": "Rare",
      "price": 250,
      "owned": true,
      "favorited": true,
      "image": "https://picsum.photos/150/150?random=4&keyword=team",
      "description": "Show your team spirit",
      "timesUsed": 15,
      "unlockDate": "2024-08-01",
      "animated": false
    },
    {
      "id": 5,
      "name": "Christmas Tree",
      "category": "Holiday",
      "rarity": "Legendary",
      "price": 750,
      "owned": false,
      "favorited": false,
      "image": "https://picsum.photos/150/150?random=5&keyword=christmas",
      "description": "Festive holiday spirit",
      "timesUsed": 0,
      "unlockDate": null,
      "animated": true
    },
    {
      "id": 6,
      "name": "LOL Face",
      "category": "Funny",
      "rarity": "Common",
      "price": 75,
      "owned": true,
      "favorited": false,
      "image": "https://picsum.photos/150/150?random=6&keyword=funny",
      "description": "Express your amusement",
      "timesUsed": 89,
      "unlockDate": "2024-05-20",
      "animated": false
    }
  ];

  List<Map<String, dynamic>> recentlyUsed = [];
  List<Map<String, dynamic>> equippedStickers = [];

  @override
  void initState() {
    super.initState();
    recentlyUsed = stickers.where((sticker) => 
      (sticker["owned"] as bool) && (sticker["timesUsed"] as int) > 0
    ).toList()..sort((a, b) => (b["timesUsed"] as int).compareTo(a["timesUsed"] as int));
    
    equippedStickers = stickers.where((sticker) => 
      (sticker["owned"] as bool) && (sticker["favorited"] as bool)
    ).toList();
  }

  List<Map<String, dynamic>> get filteredStickers {
    return stickers.where((sticker) {
      bool categoryMatch = selectedCategory == "All" || sticker["category"] == selectedCategory;
      bool rarityMatch = selectedRarity == "All" || sticker["rarity"] == selectedRarity;
      return categoryMatch && rarityMatch;
    }).toList();
  }

  List<Map<String, dynamic>> get ownedStickers {
    return stickers.where((sticker) => sticker["owned"] as bool).toList();
  }

  Color getRarityColor(String rarity) {
    switch (rarity) {
      case "Common":
        return Colors.grey[600]!;
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
      title: "Stickers",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Shop", icon: Icon(Icons.store)),
        Tab(text: "Collection", icon: Icon(Icons.collections)),
        Tab(text: "Quick Access", icon: Icon(Icons.flash_on)),
      ],
      tabChildren: [
        _buildShopTab(),
        _buildCollectionTab(),
        _buildQuickAccessTab(),
      ],
    );
  }

  Widget _buildShopTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Daily Featured
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
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.white, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Daily Featured",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Special stickers for today only",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "50% OFF",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/80/80?random=10&keyword=featured"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Filters
          QCategoryPicker(
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
          
          // Stickers Grid
          ResponsiveGridView(
            minItemWidth: 200,
            children: filteredStickers.map((sticker) {
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
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                image: DecorationImage(
                                  image: NetworkImage("${sticker["image"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        // Rarity Badge
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: getRarityColor("${sticker["rarity"]}"),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${sticker["rarity"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                        // Animated Badge
                        if (sticker["animated"] as bool)
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: infoColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "ANIMATED",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        
                        // Owned Badge
                        if (sticker["owned"] as bool)
                          Positioned(
                            bottom: spSm,
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
                      ],
                    ),
                    
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${sticker["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${sticker["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          
                          Text(
                            "${sticker["description"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${sticker["price"]} VP",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: getRarityColor("${sticker["rarity"]}"),
                                  ),
                                ),
                              ),
                              if (sticker["owned"] as bool)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      sticker["favorited"] = !(sticker["favorited"] as bool);
                                      if (sticker["favorited"] as bool) {
                                        if (!equippedStickers.contains(sticker)) {
                                          equippedStickers.add(sticker);
                                        }
                                      } else {
                                        equippedStickers.remove(sticker);
                                      }
                                    });
                                  },
                                  child: Icon(
                                    (sticker["favorited"] as bool) 
                                      ? Icons.star 
                                      : Icons.star_border,
                                    color: (sticker["favorited"] as bool) 
                                      ? warningColor 
                                      : disabledBoldColor,
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Action Button
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: (sticker["owned"] as bool) ? "Owned" : "Purchase",
                              size: bs.sm,
                              onPressed: (sticker["owned"] as bool) 
                                ? null 
                                : () => _showPurchaseDialog(sticker),
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
          // Collection Stats
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
                        "${ownedStickers.length}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Owned",
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
                        "${equippedStickers.length}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Favorites",
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
                        "${ownedStickers.fold(0, (sum, sticker) => sum + (sticker["timesUsed"] as int))}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Uses",
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
          
          // Recently Used
          if (recentlyUsed.isNotEmpty) ...[
            Text(
              "Recently Used",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: recentlyUsed.take(5).map<Widget>((sticker) {
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${sticker["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          children: [
                            Text(
                              "${sticker["name"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${sticker["timesUsed"]} uses",
                              style: TextStyle(
                                fontSize: 9,
                                color: disabledBoldColor,
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
            
            SizedBox(height: spMd),
          ],
          
          // Collection by Category
          Text(
            "Your Collection",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          if (ownedStickers.isEmpty)
            Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Icon(
                    Icons.collections_bookmark_outlined,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No Stickers Yet",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Visit the shop to purchase stickers",
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
              children: ownedStickers.map((sticker) {
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
                          Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${sticker["image"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: getRarityColor("${sticker["rarity"]}"),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${sticker["rarity"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          
                          if (sticker["animated"] as bool)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: infoColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "GIF",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
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
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${sticker["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      sticker["favorited"] = !(sticker["favorited"] as bool);
                                      if (sticker["favorited"] as bool) {
                                        if (!equippedStickers.contains(sticker)) {
                                          equippedStickers.add(sticker);
                                        }
                                      } else {
                                        equippedStickers.remove(sticker);
                                      }
                                    });
                                  },
                                  child: Icon(
                                    (sticker["favorited"] as bool) 
                                      ? Icons.star 
                                      : Icons.star_border,
                                    color: (sticker["favorited"] as bool) 
                                      ? warningColor 
                                      : disabledBoldColor,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${sticker["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Text(
                                  "Used ${sticker["timesUsed"]} times",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${sticker["unlockDate"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
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
    );
  }

  Widget _buildQuickAccessTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Access Setup",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Add your favorite stickers for quick access during gameplay",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Quick Access Grid (3x3)
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Quick Access Panel",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: spSm,
                    mainAxisSpacing: spSm,
                    childAspectRatio: 1,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    final hasSticker = index < equippedStickers.length;
                    final sticker = hasSticker ? equippedStickers[index] : null;
                    
                    return GestureDetector(
                      onTap: () => _showQuickAccessSelector(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: hasSticker ? Colors.grey[100] : Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: hasSticker ? primaryColor : disabledOutlineBorderColor,
                            width: hasSticker ? 2 : 1,
                          ),
                        ),
                        child: hasSticker
                          ? Stack(
                              children: [
                                Center(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      image: DecorationImage(
                                        image: NetworkImage("${sticker!["image"]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: spXs,
                                  left: spXs,
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                if (sticker["animated"] as bool)
                                  Positioned(
                                    bottom: spXs,
                                    right: spXs,
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: infoColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 8,
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: disabledBoldColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Equipped Stickers List
          Text(
            "Equipped Stickers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          if (equippedStickers.isEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.star_border,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No stickers equipped",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Star your favorite stickers to add them here",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: equippedStickers.length,
              itemBuilder: (context, index) {
                final sticker = equippedStickers[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusXs),
                              image: DecorationImage(
                                image: NetworkImage("${sticker["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
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
                                  "${sticker["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                if (sticker["animated"] as bool)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: infoColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "ANIMATED",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${sticker["category"]} • Used ${sticker["timesUsed"]} times",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: getRarityColor("${sticker["rarity"]}"),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${sticker["rarity"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      IconButton(
                        icon: Icon(Icons.remove_circle, color: dangerColor),
                        onPressed: () {
                          setState(() {
                            sticker["favorited"] = false;
                            equippedStickers.removeAt(index);
                          });
                        },
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

  void _showPurchaseDialog(Map<String, dynamic> sticker) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Purchase Sticker"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusXs),
                    image: DecorationImage(
                      image: NetworkImage("${sticker["image"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "${sticker["name"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spSm),
            Text(
              "Price: ${sticker["price"]} VP",
              style: TextStyle(
                fontSize: 16,
                color: getRarityColor("${sticker["rarity"]}"),
                fontWeight: FontWeight.bold,
              ),
            ),
            if (sticker["animated"] as bool)
              Container(
                margin: EdgeInsets.only(top: spSm),
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Animated Sticker",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
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
              ss("Sticker purchased successfully!");
            },
          ),
        ],
      ),
    );
  }

  void _showQuickAccessSelector(int slotIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
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
                    "Select Sticker for Slot ${slotIndex + 1}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(spMd),
                itemCount: ownedStickers.length,
                itemBuilder: (context, index) {
                  final sticker = ownedStickers[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusXs),
                              image: DecorationImage(
                                image: NetworkImage("${sticker["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text("${sticker["name"]}"),
                      subtitle: Text("${sticker["category"]} • ${sticker["rarity"]}"),
                      trailing: sticker["animated"] as bool
                        ? Icon(Icons.play_arrow, color: infoColor)
                        : null,
                      onTap: () {
                        setState(() {
                          // Remove from current position if already equipped
                          equippedStickers.remove(sticker);
                          
                          // Add to specific position
                          if (slotIndex < equippedStickers.length) {
                            equippedStickers[slotIndex] = sticker;
                          } else {
                            equippedStickers.add(sticker);
                          }
                          
                          sticker["favorited"] = true;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
