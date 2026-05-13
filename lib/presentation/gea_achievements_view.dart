import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaAchievementsView extends StatefulWidget {
  const GeaAchievementsView({super.key});

  @override
  State<GeaAchievementsView> createState() => _GeaAchievementsViewState();
}

class _GeaAchievementsViewState extends State<GeaAchievementsView> {
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> achievements = [
    {
      "id": 1,
      "title": "First Steps",
      "description": "Complete your first level",
      "category": "Beginner",
      "progress": 1,
      "target": 1,
      "completed": true,
      "points": 10,
      "rarity": "Common",
      "icon": Icons.directions_walk,
      "completedDate": "2024-01-15",
      "reward": "50 Gold Coins",
    },
    {
      "id": 2,
      "title": "Speed Runner",
      "description": "Complete a level in under 2 minutes",
      "category": "Challenge",
      "progress": 3,
      "target": 5,
      "completed": false,
      "points": 25,
      "rarity": "Rare",
      "icon": Icons.speed,
      "completedDate": null,
      "reward": "Speed Boots",
    },
    {
      "id": 3,
      "title": "Treasure Hunter",
      "description": "Collect 100 treasures",
      "category": "Collection",
      "progress": 78,
      "target": 100,
      "completed": false,
      "points": 20,
      "rarity": "Common",
      "icon": Icons.diamond,
      "completedDate": null,
      "reward": "Treasure Map",
    },
    {
      "id": 4,
      "title": "Master Warrior",
      "description": "Defeat 1000 enemies",
      "category": "Combat",
      "progress": 1000,
      "target": 1000,
      "completed": true,
      "points": 50,
      "rarity": "Epic",
      "icon": Icons.sports_esports,
      "completedDate": "2024-02-20",
      "reward": "Legendary Sword",
    },
    {
      "id": 5,
      "title": "Perfect Score",
      "description": "Complete 10 levels with 3 stars",
      "category": "Challenge",
      "progress": 7,
      "target": 10,
      "completed": false,
      "points": 35,
      "rarity": "Rare",
      "icon": Icons.star,
      "completedDate": null,
      "reward": "Star Crown",
    },
    {
      "id": 6,
      "title": "Coin Collector",
      "description": "Collect 10,000 coins",
      "category": "Collection",
      "progress": 15420,
      "target": 10000,
      "completed": true,
      "points": 30,
      "rarity": "Rare",
      "icon": Icons.monetization_on,
      "completedDate": "2024-01-28",
      "reward": "Golden Pouch",
    },
    {
      "id": 7,
      "title": "Explorer",
      "description": "Discover all hidden areas in Forest World",
      "category": "Exploration",
      "progress": 12,
      "target": 15,
      "completed": false,
      "points": 40,
      "rarity": "Epic",
      "icon": Icons.explore,
      "completedDate": null,
      "reward": "Explorer's Badge",
    },
    {
      "id": 8,
      "title": "Legendary Hero",
      "description": "Complete all achievements",
      "category": "Ultimate",
      "progress": 3,
      "target": 20,
      "completed": false,
      "points": 100,
      "rarity": "Legendary",
      "icon": Icons.emoji_events,
      "completedDate": null,
      "reward": "Hero's Crown",
    },
  ];

  List<String> categories = ["All", "Beginner", "Challenge", "Collection", "Combat", "Exploration", "Ultimate"];

  List<Map<String, dynamic>> get filteredAchievements {
    if (selectedCategory == "All") {
      return achievements;
    }
    return achievements.where((achievement) => achievement["category"] == selectedCategory).toList();
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
    final completedCount = achievements.where((a) => a["completed"] as bool).length;
    final totalPoints = achievements.where((a) => a["completed"] as bool).fold(0, (sum, a) => sum + (a["points"] as int));
    final completionPercentage = (completedCount / achievements.length * 100).toInt();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Achievements"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              //navigateTo('AchievementGuideView')
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Achievement Progress",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "$completedCount of ${achievements.length} completed ($completionPercentage%)",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.emoji_events,
                            color: warningColor,
                            size: 30,
                          ),
                          Text(
                            "$totalPoints pts",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: completedCount / achievements.length,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(successColor),
                  ),
                ],
              ),
            ),

            // Stats Cards
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
                      children: [
                        Text(
                          "$completedCount",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Completed",
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${achievements.length - completedCount}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "In Progress",
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$totalPoints",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Points",
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

            // Category Filter
            Container(
              height: 40,
              child: QHorizontalScroll(
                children: categories.map((category) {
                  final isSelected = category == selectedCategory;
                  final categoryCount = category == "All" ? achievements.length : 
                      achievements.where((a) => a["category"] == category).length;
                  
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                          SizedBox(width: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white.withAlpha(50) : disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$categoryCount",
                              style: TextStyle(
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Achievements List
            ...filteredAchievements.map((achievement) {
              final isCompleted = achievement["completed"] as bool;
              final progress = achievement["progress"] as int;
              final target = achievement["target"] as int;
              final progressPercentage = progress / target;
              final rarity = achievement["rarity"] as String;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: isCompleted ? successColor.withAlpha(20) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: isCompleted ? Border.all(color: successColor, width: 2) : null,
                  boxShadow: [shadowSm],
                ),
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Row(
                    children: [
                      // Achievement Icon
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: getRarityColor(rarity).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: getRarityColor(rarity),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          achievement["icon"] as IconData,
                          color: getRarityColor(rarity),
                          size: 30,
                        ),
                      ),
                      SizedBox(width: spSm),
                      
                      // Achievement Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${achievement["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isCompleted ? successColor : primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
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
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${achievement["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            
                            // Progress Bar
                            if (!isCompleted) ...[
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: progressPercentage > 1 ? 1 : progressPercentage,
                                      backgroundColor: disabledColor,
                                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "$progress/$target",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ] else ...[
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: successColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Completed on ${achievement["completedDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.emoji_events,
                                  color: warningColor,
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${achievement["points"]} points",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.card_giftcard,
                                  color: infoColor,
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${achievement["reward"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
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
