import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaSkinsView extends StatefulWidget {
  const GeaSkinsView({super.key});

  @override
  State<GeaSkinsView> createState() => _GeaSkinsViewState();
}

class _GeaSkinsViewState extends State<GeaSkinsView> {
  String selectedGame = "Valorant";
  String selectedWeapon = "All";
  String selectedRarity = "All";
  
  List<String> games = ["Valorant", "CS2", "Fortnite", "Apex Legends"];
  List<String> weapons = ["All", "Rifle", "Pistol", "SMG", "Sniper", "Shotgun", "Knife"];
  List<String> rarities = ["All", "Select", "Deluxe", "Premium", "Ultra", "Exclusive"];
  
  List<Map<String, dynamic>> skins = [
    {
      "id": 1,
      "name": "Dragon Lore AWP",
      "weapon": "Sniper",
      "game": "CS2",
      "rarity": "Ultra",
      "price": 2499,
      "owned": false,
      "equipped": false,
      "image": "https://picsum.photos/300/200?random=1&keyword=weapon",
      "collection": "The Cobblestone Collection",
      "float": 0.15,
      "condition": "Field-Tested",
      "statTrak": false,
      "inspectImages": [
        "https://picsum.photos/400/300?random=11&keyword=weapon",
        "https://picsum.photos/400/300?random=12&keyword=weapon",
        "https://picsum.photos/400/300?random=13&keyword=weapon"
      ]
    },
    {
      "id": 2,
      "name": "Phantom Vandal",
      "weapon": "Rifle",
      "game": "Valorant",
      "rarity": "Premium",
      "price": 1775,
      "owned": true,
      "equipped": true,
      "image": "https://picsum.photos/300/200?random=2&keyword=rifle",
      "collection": "Prime Collection",
      "float": 0.03,
      "condition": "Factory New",
      "statTrak": true,
      "inspectImages": [
        "https://picsum.photos/400/300?random=21&keyword=rifle",
        "https://picsum.photos/400/300?random=22&keyword=rifle"
      ]
    },
    {
      "id": 3,
      "name": "Neon Sheriff",
      "weapon": "Pistol",
      "game": "Valorant",
      "rarity": "Deluxe",
      "price": 875,
      "owned": false,
      "equipped": false,
      "image": "https://picsum.photos/300/200?random=3&keyword=pistol",
      "collection": "Ion Collection",
      "float": 0.08,
      "condition": "Minimal Wear",
      "statTrak": false,
      "inspectImages": [
        "https://picsum.photos/400/300?random=31&keyword=pistol"
      ]
    },
    {
      "id": 4,
      "name": "Butterfly Knife Fade",
      "weapon": "Knife",
      "game": "CS2",
      "rarity": "Exclusive",
      "price": 3500,
      "owned": false,
      "equipped": false,
      "image": "https://picsum.photos/300/200?random=4&keyword=knife",
      "collection": "Rare Special Items",
      "float": 0.01,
      "condition": "Factory New",
      "statTrak": true,
      "inspectImages": [
        "https://picsum.photos/400/300?random=41&keyword=knife",
        "https://picsum.photos/400/300?random=42&keyword=knife",
        "https://picsum.photos/400/300?random=43&keyword=knife",
        "https://picsum.photos/400/300?random=44&keyword=knife"
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredSkins {
    return skins.where((skin) {
      bool gameMatch = skin["game"] == selectedGame;
      bool weaponMatch = selectedWeapon == "All" || skin["weapon"] == selectedWeapon;
      bool rarityMatch = selectedRarity == "All" || skin["rarity"] == selectedRarity;
      return gameMatch && weaponMatch && rarityMatch;
    }).toList();
  }

  Color getRarityColor(String rarity) {
    switch (rarity) {
      case "Select":
        return Colors.grey[600]!;
      case "Deluxe":
        return successColor;
      case "Premium":
        return infoColor;
      case "Ultra":
        return warningColor;
      case "Exclusive":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weapon Skins"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.tune),
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
            
            // Filters Row
            Row(
              children: [
                Expanded(
                  child: QCategoryPicker(
                    items: weapons.map((weapon) => {
                      "label": weapon,
                      "value": weapon,
                    }).toList(),
                    value: selectedWeapon,
                    onChanged: (index, label, value, item) {
                      selectedWeapon = value;
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
            
            // Featured Skin
            if (filteredSkins.isNotEmpty)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${filteredSkins[0]["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusMd),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(204),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: getRarityColor("${filteredSkins[0]["rarity"]}"),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${filteredSkins[0]["rarity"]}".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${filteredSkins[0]["name"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${filteredSkins[0]["weapon"]} • ${filteredSkins[0]["condition"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "${filteredSkins[0]["price"]} VP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          if (filteredSkins[0]["statTrak"] as bool)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "StatTrak™",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            
            SizedBox(height: spMd),
            
            // Skins Grid
            Text(
              "Available Skins",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            ResponsiveGridView(
              minItemWidth: 200,
              children: filteredSkins.map((skin) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: (skin["equipped"] as bool)
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
                              "${skin["image"]}",
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          // Rarity Gradient
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusMd),
                                  topRight: Radius.circular(radiusMd),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    getRarityColor("${skin["rarity"]}").withAlpha(51),
                                    Colors.transparent,
                                  ],
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
                                color: getRarityColor("${skin["rarity"]}"),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${skin["rarity"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          
                          // StatTrak Badge
                          if (skin["statTrak"] as bool)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "StatTrak™",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          
                          // Equipped Badge
                          if (skin["equipped"] as bool)
                            Positioned(
                              bottom: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "EQUIPPED",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          
                          // Owned Overlay
                          if (skin["owned"] as bool && !(skin["equipped"] as bool))
                            Positioned(
                              bottom: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
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
                              "${skin["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${skin["weapon"]} • ${skin["condition"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            
                            // Float Value
                            Row(
                              children: [
                                Text(
                                  "Float: ",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${skin["float"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${skin["collection"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${skin["price"]} VP",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: getRarityColor("${skin["rarity"]}"),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _showSkinDetails(skin),
                                  child: Icon(
                                    Icons.zoom_in,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: (skin["owned"] as bool)
                                      ? (skin["equipped"] as bool)
                                        ? "Equipped"
                                        : "Equip"
                                      : "Buy",
                                    size: bs.sm,
                                    onPressed: (skin["owned"] as bool)
                                      ? (skin["equipped"] as bool)
                                        ? null
                                        : () {
                                            // Equip skin logic
                                            ss("Skin equipped!");
                                          }
                                      : () {
                                          _showPurchaseDialog(skin);
                                        },
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
      ),
    );
  }

  void _showSkinDetails(Map<String, dynamic> skin) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
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
                    "Skin Details",
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
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Image
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        image: DecorationImage(
                          image: NetworkImage("${skin["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Skin Info
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: getRarityColor("${skin["rarity"]}"),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${skin["rarity"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        if (skin["statTrak"] as bool)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "StatTrak™",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "${skin["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${skin["weapon"]} • ${skin["game"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Details Grid
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Condition",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${skin["condition"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
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
                                      "Float Value",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${skin["float"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
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
                                      "Collection",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${skin["collection"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
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
                                      "Price",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${skin["price"]} VP",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: getRarityColor("${skin["rarity"]}"),
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
                    
                    // Inspect Images
                    Text(
                      "Inspect Images",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    QHorizontalScroll(
                      children: (skin["inspectImages"] as List).map<Widget>((imageUrl) {
                        return Container(
                          width: 200,
                          height: 150,
                          margin: EdgeInsets.only(right: spSm),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusMd),
                            image: DecorationImage(
                              image: NetworkImage("$imageUrl"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Action Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: (skin["owned"] as bool)
                          ? (skin["equipped"] as bool)
                            ? "Equipped"
                            : "Equip Skin"
                          : "Purchase Skin",
                        size: bs.md,
                        onPressed: (skin["owned"] as bool)
                          ? (skin["equipped"] as bool)
                            ? null
                            : () {
                                Navigator.of(context).pop();
                                ss("Skin equipped!");
                              }
                          : () {
                              Navigator.of(context).pop();
                              _showPurchaseDialog(skin);
                            },
                      ),
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

  void _showPurchaseDialog(Map<String, dynamic> skin) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Purchase Skin"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              "${skin["image"]}",
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: spMd),
            Text(
              "${skin["name"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spSm),
            Text(
              "Price: ${skin["price"]} VP",
              style: TextStyle(
                fontSize: 16,
                color: getRarityColor("${skin["rarity"]}"),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Confirm your purchase of this ${skin["rarity"]} skin?",
              style: TextStyle(
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
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
              ss("Skin purchased successfully!");
            },
          ),
        ],
      ),
    );
  }
}
