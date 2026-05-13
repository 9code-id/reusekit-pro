import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaBadgesView extends StatefulWidget {
  const ElaBadgesView({super.key});

  @override
  State<ElaBadgesView> createState() => _ElaBadgesViewState();
}

class _ElaBadgesViewState extends State<ElaBadgesView> {
  String selectedCategory = "All";
  List<Map<String, dynamic>> badges = [
    {
      "id": 1,
      "name": "First Steps",
      "description": "Complete your first lesson",
      "icon": Icons.star,
      "category": "Achievement",
      "earned": true,
      "earnedDate": "2024-01-15",
      "progress": 100,
      "color": Colors.amber,
      "rarity": "Common",
    },
    {
      "id": 2,
      "name": "Speed Reader",
      "description": "Read 50 articles in a week",
      "icon": Icons.flash_on,
      "category": "Reading",
      "earned": true,
      "earnedDate": "2024-01-20",
      "progress": 100,
      "color": Colors.orange,
      "rarity": "Rare",
    },
    {
      "id": 3,
      "name": "Quiz Master",
      "description": "Score 100% on 10 quizzes",
      "icon": Icons.quiz,
      "category": "Assessment",
      "earned": false,
      "progress": 70,
      "color": Colors.blue,
      "rarity": "Epic",
    },
    {
      "id": 4,
      "name": "Streak Keeper",
      "description": "Maintain a 30-day learning streak",
      "icon": Icons.local_fire_department,
      "category": "Consistency",
      "earned": false,
      "progress": 85,
      "color": Colors.red,
      "rarity": "Legendary",
    },
    {
      "id": 5,
      "name": "Course Conqueror",
      "description": "Complete 5 full courses",
      "icon": Icons.emoji_events,
      "category": "Achievement",
      "earned": true,
      "earnedDate": "2024-02-01",
      "progress": 100,
      "color": Colors.purple,
      "rarity": "Epic",
    },
    {
      "id": 6,
      "name": "Night Owl",
      "description": "Study for 10 hours after 10 PM",
      "icon": Icons.nightlight,
      "category": "Dedication",
      "earned": false,
      "progress": 40,
      "color": Colors.indigo,
      "rarity": "Rare",
    },
  ];

  List<String> categories = ["All", "Achievement", "Reading", "Assessment", "Consistency", "Dedication"];

  List<Map<String, dynamic>> get filteredBadges {
    if (selectedCategory == "All") {
      return badges;
    }
    return badges.where((badge) => badge["category"] == selectedCategory).toList();
  }

  Color getRarityColor(String rarity) {
    switch (rarity) {
      case "Common":
        return Colors.grey;
      case "Rare":
        return Colors.blue;
      case "Epic":
        return Colors.purple;
      case "Legendary":
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Badges"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.emoji_events,
                  color: primaryColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${badges.where((b) => b["earned"] == true).length}/${badges.length}",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.military_tech,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Badge Progress",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${badges.where((b) => b["earned"] == true).length} earned, ${badges.where((b) => b["earned"] == false).length} remaining",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Category Filter
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
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
            SizedBox(height: spLg),

            // Badges Grid
            Text(
              "Badges",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredBadges.map((badge) {
                bool isEarned = badge["earned"] as bool;
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isEarned ? Colors.white : Colors.grey.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isEarned ? getRarityColor(badge["rarity"]) : disabledOutlineBorderColor,
                      width: 2,
                    ),
                    boxShadow: isEarned ? [shadowSm] : [],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isEarned ? (badge["color"] as Color).withAlpha(20) : disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              badge["icon"] as IconData,
                              color: isEarned ? badge["color"] as Color : disabledBoldColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${badge["rarity"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: getRarityColor(badge["rarity"]),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (isEarned) ...[
                                      SizedBox(width: spXs),
                                      Icon(
                                        Icons.verified,
                                        color: successColor,
                                        size: 14,
                                      ),
                                    ],
                                  ],
                                ),
                                Text(
                                  "${badge["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isEarned ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),

                      // Description
                      Text(
                        "${badge["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: isEarned ? disabledBoldColor : disabledColor,
                        ),
                      ),
                      SizedBox(height: spSm),

                      // Progress or Earned Date
                      if (isEarned) ...[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Earned ${badge["earnedDate"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ] else ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Progress",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${badge["progress"]}%",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            LinearProgressIndicator(
                              value: (badge["progress"] as int) / 100,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                            ),
                          ],
                        ),
                      ],
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