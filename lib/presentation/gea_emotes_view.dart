import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaEmotesView extends StatefulWidget {
  const GeaEmotesView({super.key});

  @override
  State<GeaEmotesView> createState() => _GeaEmotesViewState();
}

class _GeaEmotesViewState extends State<GeaEmotesView> {
  String selectedCategory = "All";
  String searchQuery = "";
  List<String> ownedEmotes = ["😀", "😎", "🤔", "😊", "👍", "❤️", "🔥", "⭐"];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Happy", "value": "Happy"},
    {"label": "Sad", "value": "Sad"},
    {"label": "Angry", "value": "Angry"},
    {"label": "Funny", "value": "Funny"},
    {"label": "Cool", "value": "Cool"},
    {"label": "Love", "value": "Love"},
    {"label": "Gaming", "value": "Gaming"},
    {"label": "Animals", "value": "Animals"},
    {"label": "Premium", "value": "Premium"},
  ];

  List<Map<String, dynamic>> emotes = [
    {
      "id": "1",
      "emoji": "😀",
      "name": "Grinning Face",
      "category": "Happy",
      "rarity": "Common",
      "price": 0,
      "owned": true,
      "animated": false,
      "description": "Express your happiness with this cheerful grin!",
      "unlockLevel": 1,
    },
    {
      "id": "2",
      "emoji": "😎",
      "name": "Cool Sunglasses",
      "category": "Cool",
      "rarity": "Rare",
      "price": 150,
      "owned": true,
      "animated": false,
      "description": "Stay cool with these stylish sunglasses",
      "unlockLevel": 5,
    },
    {
      "id": "3",
      "emoji": "🤔",
      "name": "Thinking Face",
      "category": "Funny",
      "rarity": "Common",
      "price": 50,
      "owned": true,
      "animated": false,
      "description": "Show everyone you're deep in thought",
      "unlockLevel": 1,
    },
    {
      "id": "4",
      "emoji": "😊",
      "name": "Smiling Face",
      "category": "Happy",
      "rarity": "Common",
      "price": 0,
      "owned": true,
      "animated": false,
      "description": "A warm and friendly smile",
      "unlockLevel": 1,
    },
    {
      "id": "5",
      "emoji": "😢",
      "name": "Crying Face",
      "category": "Sad",
      "rarity": "Common",
      "price": 75,
      "owned": false,
      "animated": false,
      "description": "Express your sadness or disappointment",
      "unlockLevel": 3,
    },
    {
      "id": "6",
      "emoji": "👍",
      "name": "Thumbs Up",
      "category": "Cool",
      "rarity": "Common",
      "price": 25,
      "owned": true,
      "animated": false,
      "description": "Give a thumbs up to show approval",
      "unlockLevel": 1,
    },
    {
      "id": "7",
      "emoji": "❤️",
      "name": "Red Heart",
      "category": "Love",
      "rarity": "Rare",
      "price": 200,
      "owned": true,
      "animated": true,
      "description": "Show your love with a beating heart",
      "unlockLevel": 10,
    },
    {
      "id": "8",
      "emoji": "🔥",
      "name": "Fire",
      "category": "Gaming",
      "rarity": "Epic",
      "price": 500,
      "owned": true,
      "animated": true,
      "description": "You're on fire! Show your hot streak",
      "unlockLevel": 15,
    },
    {
      "id": "9",
      "emoji": "⭐",
      "name": "Star",
      "category": "Gaming",
      "rarity": "Rare",
      "price": 300,
      "owned": true,
      "animated": true,
      "description": "Shine bright like a star",
      "unlockLevel": 8,
    },
    {
      "id": "10",
      "emoji": "😡",
      "name": "Angry Face",
      "category": "Angry",
      "rarity": "Common",
      "price": 100,
      "owned": false,
      "animated": false,
      "description": "Show your frustration and anger",
      "unlockLevel": 5,
    },
    {
      "id": "11",
      "emoji": "🎮",
      "name": "Gaming Controller",
      "category": "Gaming",
      "rarity": "Epic",
      "price": 750,
      "owned": false,
      "animated": true,
      "description": "Perfect for gaming celebrations",
      "unlockLevel": 20,
    },
    {
      "id": "12",
      "emoji": "🦄",
      "name": "Unicorn",
      "category": "Animals",
      "rarity": "Legendary",
      "price": 1000,
      "owned": false,
      "animated": true,
      "description": "Rare and magical unicorn emote",
      "unlockLevel": 25,
    },
    {
      "id": "13",
      "emoji": "👑",
      "name": "Crown",
      "category": "Premium",
      "rarity": "Legendary",
      "price": 1500,
      "owned": false,
      "animated": true,
      "description": "Show your royal status",
      "unlockLevel": 30,
    },
    {
      "id": "14",
      "emoji": "💎",
      "name": "Diamond",
      "category": "Premium",
      "rarity": "Legendary",
      "price": 2000,
      "owned": false,
      "animated": true,
      "description": "The most precious emote",
      "unlockLevel": 50,
    },
  ];

  List<Map<String, dynamic>> get filteredEmotes {
    return emotes.where((emote) {
      final matchesCategory = selectedCategory == "All" || emote["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty || 
          (emote["name"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case "Common":
        return Colors.grey;
      case "Rare":
        return Colors.blue;
      case "Epic":
        return Colors.purple;
      case "Legendary":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _purchaseEmote(Map<String, dynamic> emote) async {
    final confirmed = await confirm("Purchase ${emote["name"]} for ${emote["price"]} coins?");
    if (confirmed) {
      setState(() {
        emote["owned"] = true;
        ownedEmotes.add(emote["emoji"]);
      });
      ss("Successfully purchased ${emote["name"]}!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emotes Collection"),
        actions: [
          QButton(
            icon: Icons.shopping_cart,
            size: bs.sm,
            onPressed: () {
              si("View emote shop");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search emotes",
                        value: searchQuery,
                        hint: "Type emote name...",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                
                // Category Filter
                QDropdownField(
                  label: "Category",
                  items: categoryItems,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
                
                // Stats Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${ownedEmotes.length}",
                              style: TextStyle(
                                fontSize: 18,
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
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${emotes.length}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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
                          color: warningColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${((ownedEmotes.length / emotes.length) * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Complete",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Emotes Grid
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: ResponsiveGridView(
                minItemWidth: 200,
                children: List.generate(filteredEmotes.length, (index) {
                  final emote = filteredEmotes[index];
                  final isOwned = emote["owned"] as bool;
                  final rarityColor = _getRarityColor(emote["rarity"]);
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isOwned ? Colors.white : Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isOwned ? rarityColor : disabledOutlineBorderColor,
                        width: isOwned ? 2 : 1,
                      ),
                      boxShadow: isOwned ? [shadowSm] : [],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        // Emote Header
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: rarityColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${emote["rarity"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Spacer(),
                            if (emote["animated"] as bool) ...[
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "ANIMATED",
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                            if (isOwned) ...[
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 16,
                              ),
                            ],
                          ],
                        ),
                        
                        // Emote Display
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: isOwned 
                                ? rarityColor.withAlpha(25)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Center(
                            child: Text(
                              "${emote["emoji"]}",
                              style: TextStyle(
                                fontSize: isOwned ? 40 : 30,
                              ),
                            ),
                          ),
                        ),
                        
                        // Emote Info
                        Column(
                          children: [
                            Text(
                              "${emote["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isOwned ? Colors.black : disabledBoldColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${emote["description"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        
                        // Level Requirement
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock,
                              color: disabledBoldColor,
                              size: 12,
                            ),
                            SizedBox(width: 2),
                            Text(
                              "Level ${emote["unlockLevel"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        
                        // Action Button
                        if (isOwned) ...[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "OWNED",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ] else if ((emote["price"] as int) == 0) ...[
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Free",
                              size: bs.sm,
                              onPressed: () {
                                setState(() {
                                  emote["owned"] = true;
                                  ownedEmotes.add(emote["emoji"]);
                                });
                                ss("Unlocked ${emote["name"]}!");
                              },
                            ),
                          ),
                        ] else ...[
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "${emote["price"]} coins",
                              size: bs.sm,
                              onPressed: () => _purchaseEmote(emote),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
      
      // Quick Access Bar
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Quick Access",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Tap to use",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spXs),
            Container(
              height: 50,
              child: QHorizontalScroll(
                children: List.generate(ownedEmotes.length, (index) {
                  final emoji = ownedEmotes[index];
                  return GestureDetector(
                    onTap: () {
                      ss("Used $emoji emote!");
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      margin: EdgeInsets.only(right: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          emoji,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
