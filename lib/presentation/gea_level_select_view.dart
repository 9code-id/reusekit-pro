import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaLevelSelectView extends StatefulWidget {
  const GeaLevelSelectView({super.key});

  @override
  State<GeaLevelSelectView> createState() => _GeaLevelSelectViewState();
}

class _GeaLevelSelectViewState extends State<GeaLevelSelectView> {
  String selectedWorld = "Forest";
  int selectedLevel = 1;
  
  List<Map<String, dynamic>> worlds = [
    {
      "name": "Forest",
      "levels": 15,
      "completed": 12,
      "unlocked": true,
      "image": "https://picsum.photos/300/200?random=1&keyword=forest",
      "difficulty": "Easy",
      "theme": "Nature & Wildlife",
    },
    {
      "name": "Desert",
      "levels": 18,
      "completed": 8,
      "unlocked": true,
      "image": "https://picsum.photos/300/200?random=2&keyword=desert",
      "difficulty": "Medium",
      "theme": "Sand & Heat",
    },
    {
      "name": "Mountain",
      "levels": 20,
      "completed": 3,
      "unlocked": true,
      "image": "https://picsum.photos/300/200?random=3&keyword=mountain",
      "difficulty": "Hard",
      "theme": "Heights & Snow",
    },
    {
      "name": "Ocean",
      "levels": 25,
      "completed": 0,
      "unlocked": false,
      "image": "https://picsum.photos/300/200?random=4&keyword=ocean",
      "difficulty": "Expert",
      "theme": "Deep Waters",
    },
  ];

  List<Map<String, dynamic>> getLevelsForWorld(String worldName) {
    final world = worlds.firstWhere((w) => w["name"] == worldName);
    final totalLevels = world["levels"] as int;
    final completed = world["completed"] as int;
    
    return List.generate(totalLevels, (index) {
      final levelNumber = index + 1;
      return {
        "level": levelNumber,
        "completed": levelNumber <= completed,
        "unlocked": levelNumber <= completed + 1,
        "stars": levelNumber <= completed ? (levelNumber % 3) + 1 : 0,
        "bestTime": levelNumber <= completed ? "0${(levelNumber % 5) + 1}:${(levelNumber * 7) % 60}${(levelNumber * 3) % 10}" : null,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedWorldData = worlds.firstWhere((w) => w["name"] == selectedWorld);
    final levels = getLevelsForWorld(selectedWorld);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Level"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              //navigateTo('GameInfoView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // World Selection
            Container(
              height: 120,
              child: QHorizontalScroll(
                children: worlds.map((world) {
                  final isSelected = world["name"] == selectedWorld;
                  final isUnlocked = world["unlocked"] as bool;
                  
                  return GestureDetector(
                    onTap: isUnlocked ? () {
                      selectedWorld = world["name"];
                      setState(() {});
                    } : null,
                    child: Container(
                      width: 150,
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: isSelected ? Border.all(color: primaryColor, width: 3) : null,
                        boxShadow: [shadowSm],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusMd),
                            child: Image.network(
                              "${world["image"]}",
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              colorBlendMode: isUnlocked ? null : BlendMode.saturation,
                              color: isUnlocked ? null : Colors.grey,
                            ),
                          ),
                          if (!isUnlocked)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusMd),
                                color: Colors.black.withAlpha(150),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(radiusMd),
                                  bottomRight: Radius.circular(radiusMd),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${world["name"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "${world["completed"]}/${world["levels"]} levels",
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(200),
                                      fontSize: 12,
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
                }).toList(),
              ),
            ),

            // World Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedWorldData["name"]} World",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${selectedWorldData["theme"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.stars,
                              size: 16,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Difficulty: ${selectedWorldData["difficulty"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "${selectedWorldData["completed"]}",
                        style: TextStyle(
                          fontSize: 24,
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
                ],
              ),
            ),

            // Progress Bar
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Progress",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${(((selectedWorldData["completed"] as int) / (selectedWorldData["levels"] as int)) * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: (selectedWorldData["completed"] as int) / (selectedWorldData["levels"] as int),
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(successColor),
                  ),
                ],
              ),
            ),

            // Level Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 80,
              children: levels.map((level) {
                final isCompleted = level["completed"] as bool;
                final isUnlocked = level["unlocked"] as bool;
                final stars = level["stars"] as int;
                
                return GestureDetector(
                  onTap: isUnlocked ? () {
                    selectedLevel = level["level"];
                    //navigateTo('GameplayView', arguments: {'world': selectedWorld, 'level': selectedLevel})
                  } : null,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: isCompleted ? successColor.withAlpha(50) : 
                             isUnlocked ? Colors.white : disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isCompleted ? successColor : 
                               isUnlocked ? primaryColor : disabledBoldColor,
                        width: 2,
                      ),
                      boxShadow: isUnlocked ? [shadowXs] : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!isUnlocked)
                          Icon(
                            Icons.lock,
                            color: disabledBoldColor,
                            size: 20,
                          )
                        else ...[
                          Text(
                            "${level["level"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isCompleted ? successColor : primaryColor,
                            ),
                          ),
                          if (isCompleted) ...[
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (index) {
                                return Icon(
                                  Icons.star,
                                  size: 12,
                                  color: index < stars ? warningColor : disabledColor,
                                );
                              }),
                            ),
                          ],
                        ],
                      ],
                    ),
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
