import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaAchievementsView extends StatefulWidget {
  const ElaAchievementsView({super.key});

  @override
  State<ElaAchievementsView> createState() => _ElaAchievementsViewState();
}

class _ElaAchievementsViewState extends State<ElaAchievementsView> {
  String selectedCategory = "All";
  String selectedTimeframe = "All Time";
  
  List<Map<String, dynamic>> achievements = [
    {
      "id": 1,
      "title": "Perfect Score",
      "description": "Achieved 100% on a poetry analysis assignment",
      "category": "Academic",
      "points": 50,
      "earned_date": "2024-12-15",
      "rarity": "Common",
      "icon": Icons.star,
      "color": "#FFD700",
      "requirements": "Score 100% on any assignment",
      "progress": 1.0,
      "unlocked": true
    },
    {
      "id": 2,
      "title": "Speed Reader",
      "description": "Completed 5 reading assignments in one week",
      "category": "Reading",
      "points": 75,
      "earned_date": "2024-12-10",
      "rarity": "Uncommon",
      "icon": Icons.speed,
      "color": "#4CAF50",
      "requirements": "Complete 5 reading assignments in 7 days",
      "progress": 1.0,
      "unlocked": true
    },
    {
      "id": 3,
      "title": "Grammar Guru",
      "description": "Achieve 95%+ on 10 consecutive grammar exercises",
      "category": "Grammar",
      "points": 100,
      "earned_date": "2024-11-28",
      "rarity": "Rare",
      "icon": Icons.school,
      "color": "#2196F3",
      "requirements": "Score 95%+ on 10 consecutive grammar exercises",
      "progress": 1.0,
      "unlocked": true
    },
    {
      "id": 4,
      "title": "Creative Genius",
      "description": "Write a short story with 95%+ creativity score",
      "category": "Creative Writing",
      "points": 125,
      "earned_date": "2024-11-15",
      "rarity": "Epic",
      "icon": Icons.brush,
      "color": "#9C27B0",
      "requirements": "Score 95%+ on creativity in short story assignment",
      "progress": 1.0,
      "unlocked": true
    },
    {
      "id": 5,
      "title": "Vocabulary Master",
      "description": "Learn 100 new vocabulary words",
      "category": "Vocabulary",
      "points": 80,
      "earned_date": "",
      "rarity": "Uncommon",
      "icon": Icons.book,
      "color": "#FF5722",
      "requirements": "Learn 100 new vocabulary words",
      "progress": 0.73,
      "unlocked": false
    },
    {
      "id": 6,
      "title": "Essay Expert",
      "description": "Write 5 essays with A- grade or higher",
      "category": "Writing",
      "points": 90,
      "earned_date": "",
      "rarity": "Rare",
      "icon": Icons.edit,
      "color": "#607D8B",
      "requirements": "Receive A- or higher on 5 essay assignments",
      "progress": 0.6,
      "unlocked": false
    },
    {
      "id": 7,
      "title": "Attendance Ace",
      "description": "Perfect attendance for one month",
      "category": "Participation",
      "points": 60,
      "earned_date": "2024-10-31",
      "rarity": "Common",
      "icon": Icons.event_available,
      "color": "#8BC34A",
      "requirements": "100% attendance for 30 consecutive days",
      "progress": 1.0,
      "unlocked": true
    },
    {
      "id": 8,
      "title": "Discussion Leader",
      "description": "Lead class discussions 10 times",
      "category": "Participation",
      "points": 70,
      "earned_date": "",
      "rarity": "Uncommon",
      "icon": Icons.forum,
      "color": "#FF9800",
      "requirements": "Actively lead 10 class discussions",
      "progress": 0.4,
      "unlocked": false
    }
  ];

  List<Map<String, dynamic>> get filteredAchievements {
    List<Map<String, dynamic>> filtered = achievements;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((achievement) => 
        achievement["category"] == selectedCategory).toList();
    }
    
    return filtered;
  }

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case "Common":
        return Color(0xFF8BC34A);
      case "Uncommon":
        return Color(0xFF2196F3);
      case "Rare":
        return Color(0xFF9C27B0);
      case "Epic":
        return Color(0xFFFF9800);
      case "Legendary":
        return Color(0xFFFF5722);
      default:
        return disabledBoldColor;
    }
  }

  void _viewAchievementDetail(Map<String, dynamic> achievement) {
    // navigateTo(AchievementDetailView(achievement: achievement))
  }

  void _shareAchievement(Map<String, dynamic> achievement) {
    if (achievement["unlocked"]) {
      ss("Achievement shared: ${achievement["title"]}");
    } else {
      se("Can only share unlocked achievements");
    }
  }

  int get totalEarned => achievements.where((a) => a["unlocked"] == true).length;
  int get totalPoints => achievements.where((a) => a["unlocked"] == true).fold(0, (sum, a) => sum + (a["points"] as int));
  double get completionRate => (totalEarned / achievements.length) * 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Achievements"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // Show achievement info
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Achievement overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
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
                    Icons.emoji_events,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Achievement Progress",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "$totalEarned",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Unlocked",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "$totalPoints",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Points",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${completionRate.toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Complete",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
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
            
            SizedBox(height: spLg),
            
            // Rarity breakdown
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Achievement Rarity Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildRarityItem(
                          "Common",
                          achievements.where((a) => a["rarity"] == "Common" && a["unlocked"]).length,
                          _getRarityColor("Common"),
                        ),
                      ),
                      Expanded(
                        child: _buildRarityItem(
                          "Uncommon",
                          achievements.where((a) => a["rarity"] == "Uncommon" && a["unlocked"]).length,
                          _getRarityColor("Uncommon"),
                        ),
                      ),
                      Expanded(
                        child: _buildRarityItem(
                          "Rare",
                          achievements.where((a) => a["rarity"] == "Rare" && a["unlocked"]).length,
                          _getRarityColor("Rare"),
                        ),
                      ),
                      Expanded(
                        child: _buildRarityItem(
                          "Epic",
                          achievements.where((a) => a["rarity"] == "Epic" && a["unlocked"]).length,
                          _getRarityColor("Epic"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Filter options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Category",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Academic", "value": "Academic"},
                      {"label": "Reading", "value": "Reading"},
                      {"label": "Writing", "value": "Writing"},
                      {"label": "Grammar", "value": "Grammar"},
                      {"label": "Creative Writing", "value": "Creative Writing"},
                      {"label": "Vocabulary", "value": "Vocabulary"},
                      {"label": "Participation", "value": "Participation"},
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
            
            SizedBox(height: spLg),
            
            // Achievements list
            Text(
              "Achievements (${filteredAchievements.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...filteredAchievements.map((achievement) {
              final isUnlocked = achievement["unlocked"] as bool;
              final progress = achievement["progress"] as double;
              final achievementColor = Color(int.parse(achievement["color"].substring(1), radix: 16) + 0xFF000000);
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: isUnlocked ? achievementColor : disabledColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: isUnlocked ? achievementColor.withAlpha(20) : disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  achievement["icon"],
                                  color: isUnlocked ? achievementColor : disabledColor,
                                  size: 28,
                                ),
                              ),
                              if (!isUnlocked)
                                Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: disabledBoldColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                      size: 12,
                                    ),
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${achievement["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: isUnlocked ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getRarityColor(achievement["rarity"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${achievement["rarity"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: _getRarityColor(achievement["rarity"]),
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
                                  color: isUnlocked ? disabledBoldColor : disabledColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: isUnlocked ? achievementColor : disabledColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${achievement["points"]} points",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isUnlocked ? achievementColor : disabledColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${achievement["category"]}",
                                    style: TextStyle(
                                      fontSize: 11,
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
                    
                    SizedBox(height: spMd),
                    
                    // Progress bar (for locked achievements)
                    if (!isUnlocked) ...[
                      Text(
                        "Requirements: ${achievement["requirements"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Progress: ${(progress * 100).toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${(progress * 100).toStringAsFixed(0)}% complete",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            width: double.infinity,
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress.clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: achievementColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                    ],
                    
                    // Achievement date
                    if (isUnlocked) ...[
                      Row(
                        children: [
                          Text(
                            "Unlocked: ${DateTime.parse(achievement["earned_date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            icon: Icons.share,
                            size: bs.sm,
                            onPressed: () => _shareAchievement(achievement),
                          ),
                        ],
                      ),
                    ],
                    
                    if (!isUnlocked) ...[
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "View Requirements",
                          size: bs.sm,
                          onPressed: () => _viewAchievementDetail(achievement),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
            
            if (filteredAchievements.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.emoji_events,
                      color: disabledColor,
                      size: 60,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No achievements found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Complete assignments and participate in class to unlock achievements",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
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

  Widget _buildRarityItem(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          "$count",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
