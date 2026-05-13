import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExercise3View extends StatefulWidget {
  @override
  State<GrlExercise3View> createState() => _GrlExercise3ViewState();
}

class _GrlExercise3ViewState extends State<GrlExercise3View> {
  int selectedTab = 0;
  List<String> tabLabels = ["Progress", "Achievements", "Statistics"];

  Map<String, dynamic> userProgress = {
    "totalWorkouts": 87,
    "totalCalories": 12450,
    "totalMinutes": 1680,
    "currentStreak": 12,
    "longestStreak": 28,
    "averageWorkoutsPerWeek": 4.2,
    "favoriteExercise": "Push-ups",
    "strengthGain": 15.5,
    "enduranceImprovement": 22.3
  };

  List<Map<String, dynamic>> weeklyProgress = [
    {"week": "Week 1", "workouts": 3, "calories": 450, "duration": 90},
    {"week": "Week 2", "workouts": 4, "calories": 580, "duration": 120},
    {"week": "Week 3", "workouts": 5, "calories": 675, "duration": 150},
    {"week": "Week 4", "workouts": 4, "calories": 520, "duration": 105},
    {"week": "Week 5", "workouts": 6, "calories": 780, "duration": 180},
    {"week": "Week 6", "workouts": 5, "calories": 650, "duration": 155},
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "First Workout",
      "description": "Complete your first workout session",
      "icon": Icons.flag,
      "unlocked": true,
      "unlockedAt": "2025-01-15",
      "rarity": "common"
    },
    {
      "title": "7-Day Streak",
      "description": "Exercise for 7 consecutive days",
      "icon": Icons.local_fire_department,
      "unlocked": true,
      "unlockedAt": "2025-02-22",
      "rarity": "rare"
    },
    {
      "title": "Calorie Crusher",
      "description": "Burn 1000 calories in a single week",
      "icon": Icons.whatshot,
      "unlocked": true,
      "unlockedAt": "2025-03-10",
      "rarity": "epic"
    },
    {
      "title": "Strength Champion",
      "description": "Complete 50 strength training exercises",
      "icon": Icons.fitness_center,
      "unlocked": true,
      "unlockedAt": "2025-04-05",
      "rarity": "legendary"
    },
    {
      "title": "Cardio Master",
      "description": "Complete 100 cardio exercises",
      "icon": Icons.favorite,
      "unlocked": false,
      "progress": 78,
      "target": 100,
      "rarity": "epic"
    },
    {
      "title": "Marathon Runner",
      "description": "Exercise for 1000 minutes total",
      "icon": Icons.directions_run,
      "unlocked": true,
      "unlockedAt": "2025-05-20",
      "rarity": "legendary"
    },
    {
      "title": "Perfect Month",
      "description": "Exercise every day for 30 days",
      "icon": Icons.calendar_month,
      "unlocked": false,
      "progress": 12,
      "target": 30,
      "rarity": "legendary"
    },
    {
      "title": "Heavy Lifter",
      "description": "Complete 25 advanced strength exercises",
      "icon": Icons.trending_up,
      "unlocked": false,
      "progress": 8,
      "target": 25,
      "rarity": "rare"
    }
  ];

  List<Map<String, dynamic>> exerciseStats = [
    {
      "name": "Push-ups",
      "totalReps": 1250,
      "bestSession": 45,
      "averageReps": 28,
      "improvement": 15.2,
      "category": "Strength"
    },
    {
      "name": "Squats",
      "totalReps": 980,
      "bestSession": 35,
      "averageReps": 22,
      "improvement": 12.8,
      "category": "Strength"
    },
    {
      "name": "Jumping Jacks",
      "totalReps": 2340,
      "bestSession": 120,
      "averageReps": 85,
      "improvement": 18.5,
      "category": "Cardio"
    },
    {
      "name": "Plank",
      "totalTime": 1680, // seconds
      "bestSession": 90,
      "averageTime": 45,
      "improvement": 25.3,
      "category": "Core"
    },
    {
      "name": "Burpees",
      "totalReps": 445,
      "bestSession": 25,
      "averageReps": 12,
      "improvement": 8.7,
      "category": "HIIT"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness Progress"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareProgress(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Navigation
          _buildTabNavigation(),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildTabContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabNavigation() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: disabledColor,
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: List.generate(tabLabels.length, (index) {
          final isSelected = selectedTab == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = index;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  tabLabels[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : disabledBoldColor,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildProgressTab();
      case 1:
        return _buildAchievementsTab();
      case 2:
        return _buildStatisticsTab();
      default:
        return _buildProgressTab();
    }
  }

  Widget _buildProgressTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Overall Progress Summary
        _buildProgressSummary(),
        
        SizedBox(height: spMd),

        // Weekly Progress Chart
        _buildWeeklyProgress(),
        
        SizedBox(height: spMd),

        // Current Goals
        _buildCurrentGoals(),
      ],
    );
  }

  Widget _buildProgressSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: Colors.white, size: 24),
              SizedBox(width: spSm),
              Text(
                "Your Progress",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 120,
            children: [
              _buildSummaryCard(
                "Workouts",
                "${userProgress["totalWorkouts"]}",
                Icons.fitness_center,
                "Total sessions",
              ),
              _buildSummaryCard(
                "Calories",
                "${((userProgress["totalCalories"] as int) / 1000).toStringAsFixed(1)}K",
                Icons.local_fire_department,
                "Total burned",
              ),
              _buildSummaryCard(
                "Minutes",
                "${((userProgress["totalMinutes"] as int) / 60).toStringAsFixed(0)}h",
                Icons.timer,
                "Total time",
              ),
              _buildSummaryCard(
                "Streak",
                "${userProgress["currentStreak"]}",
                Icons.whatshot,
                "Days active",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withAlpha(180),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyProgress() {
    double maxWorkouts = weeklyProgress.map((e) => e["workouts"] as int).reduce((a, b) => a > b ? a : b).toDouble();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Weekly Progress",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Container(
                height: 120,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(weeklyProgress.length, (index) {
                    final week = weeklyProgress[index];
                    final workouts = (week["workouts"] as int).toDouble();
                    final height = (workouts / maxWorkouts) * 100;
                    
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: height,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(
                                  (120 + (workouts / maxWorkouts * 135)).toInt()
                                ),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(radiusXs),
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "W${index + 1}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Text(
                    "Average: ${((userProgress["averageWorkoutsPerWeek"] as double)).toStringAsFixed(1)} workouts/week",
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
      ],
    );
  }

  Widget _buildCurrentGoals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Current Goals",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              _buildGoalItem("Weekly Workouts", 4, 5, "workouts"),
              Divider(color: disabledOutlineBorderColor),
              _buildGoalItem("Monthly Calories", 2450, 3000, "calories"),
              Divider(color: disabledOutlineBorderColor),
              _buildGoalItem("Daily Streak", 12, 30, "days"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGoalItem(String title, int current, int target, String unit) {
    double progress = (current / target * 100).clamp(0, 100);
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "$current / $target $unit",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              widthFactor: progress / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: progress >= 80 ? successColor : 
                         progress >= 50 ? warningColor : primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${progress.toStringAsFixed(1)}% complete",
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab() {
    List<Map<String, dynamic>> unlockedAchievements = achievements.where((a) => a["unlocked"] == true).toList();
    List<Map<String, dynamic>> lockedAchievements = achievements.where((a) => a["unlocked"] == false).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Achievement Summary
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Icon(Icons.emoji_events, color: warningColor, size: 32),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${unlockedAchievements.length} / ${achievements.length}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Achievements Unlocked",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),

        // Unlocked Achievements
        if (unlockedAchievements.isNotEmpty) ...[
          Text(
            "Unlocked Achievements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...unlockedAchievements.map((achievement) => _buildAchievementCard(achievement, true)),
          SizedBox(height: spMd),
        ],

        // Locked Achievements
        if (lockedAchievements.isNotEmpty) ...[
          Text(
            "In Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...lockedAchievements.map((achievement) => _buildAchievementCard(achievement, false)),
        ],
      ],
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement, bool unlocked) {
    Color rarityColor = _getRarityColor(achievement["rarity"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(width: 4, color: rarityColor),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: unlocked ? rarityColor.withAlpha(20) : disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              achievement["icon"] as IconData,
              color: unlocked ? rarityColor : disabledBoldColor,
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
                      "${achievement["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: unlocked ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: rarityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${achievement["rarity"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: rarityColor,
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
                if (!unlocked && achievement["progress"] != null) ...[
                  SizedBox(height: spXs),
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: (achievement["progress"] as int) / (achievement["target"] as int),
                      child: Container(
                        decoration: BoxDecoration(
                          color: rarityColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${achievement["progress"]} / ${achievement["target"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
                if (unlocked) ...[
                  SizedBox(height: spXs),
                  Text(
                    "Unlocked on ${achievement["unlockedAt"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Exercise Statistics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          children: exerciseStats.map((stat) => _buildExerciseStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildExerciseStatCard(Map<String, dynamic> stat) {
    Color categoryColor = _getCategoryColor(stat["category"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          top: BorderSide(width: 3, color: categoryColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${stat["name"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: categoryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${stat["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: categoryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            minItemWidth: 100,
            children: [
              _buildStatItem("Total", stat["name"] == "Plank" ? "${((stat["totalTime"] as int) / 60).toStringAsFixed(0)}min" : "${stat["totalReps"]}"),
              _buildStatItem("Best", stat["name"] == "Plank" ? "${stat["bestSession"]}s" : "${stat["bestSession"]}"),
              _buildStatItem("Average", stat["name"] == "Plank" ? "${stat["averageTime"]}s" : "${stat["averageReps"]}"),
              _buildStatItem("Improvement", "+${((stat["improvement"] as double)).toStringAsFixed(1)}%"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case "common":
        return disabledBoldColor;
      case "rare":
        return infoColor;
      case "epic":
        return primaryColor;
      case "legendary":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Strength":
        return primaryColor;
      case "Cardio":
        return dangerColor;
      case "Core":
        return warningColor;
      case "HIIT":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _shareProgress() {
    // Share progress implementation
  }
}
