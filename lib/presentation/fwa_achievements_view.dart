import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaAchievementsView extends StatefulWidget {
  const FwaAchievementsView({super.key});

  @override
  State<FwaAchievementsView> createState() => _FwaAchievementsViewState();
}

class _FwaAchievementsViewState extends State<FwaAchievementsView> {
  String selectedCategory = "all";
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Achievements", "value": "all"},
    {"label": "Fitness", "value": "fitness"},
    {"label": "Nutrition", "value": "nutrition"},
    {"label": "Sleep", "value": "sleep"},
    {"label": "Challenges", "value": "challenges"},
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "id": "1",
      "title": "First Steps",
      "description": "Complete your first 1,000 steps in a day",
      "category": "fitness",
      "points": 50,
      "unlockedDate": "2024-12-15",
      "isUnlocked": true,
      "icon": Icons.directions_walk,
      "color": primaryColor,
      "rarity": "Common",
    },
    {
      "id": "2", 
      "title": "Step Master",
      "description": "Achieve 10,000 steps for 7 consecutive days",
      "category": "fitness",
      "points": 200,
      "unlockedDate": "2024-12-20",
      "isUnlocked": true,
      "icon": Icons.emoji_events,
      "color": warningColor,
      "rarity": "Rare",
    },
    {
      "id": "3",
      "title": "Calorie Crusher",
      "description": "Burn 500+ calories in a single workout session",
      "category": "fitness", 
      "points": 150,
      "unlockedDate": "2024-12-18",
      "isUnlocked": true,
      "icon": Icons.local_fire_department,
      "color": dangerColor,
      "rarity": "Uncommon",
    },
    {
      "id": "4",
      "title": "Marathon Walker",
      "description": "Walk a total distance of 42km in one week",
      "category": "fitness",
      "points": 300,
      "unlockedDate": null,
      "isUnlocked": false,
      "icon": Icons.directions_run,
      "color": successColor,
      "rarity": "Epic",
    },
    {
      "id": "5",
      "title": "Hydration Hero",
      "description": "Drink 8 glasses of water daily for 30 days",
      "category": "nutrition",
      "points": 250,
      "unlockedDate": "2024-12-22",
      "isUnlocked": true,
      "icon": Icons.water_drop,
      "color": infoColor,
      "rarity": "Rare",
    },
    {
      "id": "6",
      "title": "Healthy Eater",
      "description": "Log healthy meals for 14 consecutive days",
      "category": "nutrition",
      "points": 180,
      "unlockedDate": null,
      "isUnlocked": false,
      "icon": Icons.restaurant,
      "color": successColor,
      "rarity": "Uncommon",
    },
    {
      "id": "7",
      "title": "Sleep Champion",
      "description": "Get 8+ hours of sleep for 7 nights in a row",
      "category": "sleep",
      "points": 120,
      "unlockedDate": null,
      "isUnlocked": false,
      "icon": Icons.bedtime,
      "color": primaryColor,
      "rarity": "Common",
    },
    {
      "id": "8",
      "title": "Early Bird",
      "description": "Complete morning workouts for 10 days",
      "category": "challenges",
      "points": 100,
      "unlockedDate": "2024-12-16",
      "isUnlocked": true,
      "icon": Icons.wb_sunny,
      "color": warningColor,
      "rarity": "Common",
    },
  ];

  int get totalPoints => achievements
      .where((a) => a["isUnlocked"] == true)
      .fold(0, (sum, a) => sum + (a["points"] as int));

  int get totalUnlocked => achievements
      .where((a) => a["isUnlocked"] == true)
      .length;

  List<Map<String, dynamic>> get filteredAchievements {
    if (selectedCategory == "all") return achievements;
    return achievements.where((a) => a["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Achievements"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Achievements shared successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Achievement Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              "Achievement Progress",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Keep going to unlock more achievements!",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Unlocked",
                          "$totalUnlocked/${achievements.length}",
                          Icons.lock_open,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Total Points",
                          "$totalPoints",
                          Icons.stars,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Category Filter
            Container(
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
                    "Filter by Category",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Select Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Achievements List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Your Achievements",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: filteredAchievements.map((achievement) {
                      final isUnlocked = achievement["isUnlocked"] as bool;
                      final color = achievement["color"] as Color;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isUnlocked 
                              ? color.withAlpha(10)
                              : disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isUnlocked ? color : disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isUnlocked ? color : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                achievement["icon"] as IconData,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${achievement["title"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isUnlocked ? primaryColor : disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getRarityColor(achievement["rarity"]),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${achievement["rarity"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${achievement["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isUnlocked ? disabledBoldColor : disabledColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.stars,
                                        size: 14,
                                        color: isUnlocked ? warningColor : disabledColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${achievement["points"]} points",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: isUnlocked ? warningColor : disabledColor,
                                        ),
                                      ),
                                      if (isUnlocked && achievement["unlockedDate"] != null) ...[
                                        Spacer(),
                                        Text(
                                          "Unlocked ${achievement["unlockedDate"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (isUnlocked)
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 20,
                              )
                            else
                              Icon(
                                Icons.lock,
                                color: disabledColor,
                                size: 20,
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Progress to Next Achievement
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Almost There!",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: warningColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.directions_run,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                "Marathon Walker",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "32.5km / 42km completed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Container(
                                height: 6,
                                margin: EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: 0.77,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "77%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Color _getRarityColor(String rarity) {
    switch (rarity.toLowerCase()) {
      case "common":
        return disabledBoldColor;
      case "uncommon":
        return successColor;
      case "rare":
        return infoColor;
      case "epic":
        return warningColor;
      case "legendary":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
