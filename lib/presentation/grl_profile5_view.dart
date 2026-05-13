import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProfile5View extends StatefulWidget {
  @override
  State<GrlProfile5View> createState() => _GrlProfile5ViewState();
}

class _GrlProfile5ViewState extends State<GrlProfile5View> {
  Map<String, dynamic> user = {
    "name": "Alex Thompson",
    "username": "@alexfit",
    "avatar": "https://picsum.photos/100/100?random=16&keyword=fitness",
    "profession": "Certified Personal Trainer",
    "location": "Los Angeles, CA",
    "memberSince": "2020",
    "totalWorkouts": 1456,
    "totalCalories": 234500,
    "currentStreak": 12,
    "personalBests": 8,
    "followers": 3240,
    "following": 892,
    "level": "Advanced",
    "badges": 15,
  };

  List<Map<String, dynamic>> stats = [
    {
      "label": "Workouts",
      "value": "1,456",
      "icon": Icons.fitness_center,
      "color": primaryColor,
      "trend": "+12",
    },
    {
      "label": "Calories",
      "value": "234K",
      "icon": Icons.local_fire_department,
      "color": dangerColor,
      "trend": "+1.2K",
    },
    {
      "label": "Streak",
      "value": "12 days",
      "icon": Icons.emoji_events,
      "color": warningColor,
      "trend": "Active",
    },
    {
      "label": "Personal Bests",
      "value": "8",
      "icon": Icons.trending_up,
      "color": successColor,
      "trend": "+2",
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "icon": Icons.emoji_events,
      "title": "100 Workout Streak",
      "description": "Completed 100 consecutive workouts",
      "color": warningColor,
      "completed": true,
    },
    {
      "icon": Icons.speed,
      "title": "Speed Demon",
      "description": "Completed 10 HIIT workouts in a week",
      "color": dangerColor,
      "completed": true,
    },
    {
      "icon": Icons.fitness_center,
      "title": "Strength Master",
      "description": "Lifted 10,000 lbs total weight",
      "color": primaryColor,
      "completed": true,
    },
    {
      "icon": Icons.group,
      "title": "Social Butterfly",
      "description": "Worked out with 20 different people",
      "color": infoColor,
      "completed": false,
    },
  ];

  List<Map<String, dynamic>> workoutHistory = [
    {
      "name": "Full Body Strength",
      "duration": "45 min",
      "calories": 380,
      "date": "Today",
      "type": "Strength",
      "completed": true,
    },
    {
      "name": "Morning Cardio",
      "duration": "30 min", 
      "calories": 250,
      "date": "Yesterday",
      "type": "Cardio",
      "completed": true,
    },
    {
      "name": "Yoga Flow",
      "duration": "60 min",
      "calories": 180,
      "date": "2 days ago",
      "type": "Flexibility",
      "completed": true,
    },
    {
      "name": "HIIT Training",
      "duration": "25 min",
      "calories": 320,
      "date": "3 days ago",
      "type": "HIIT",
      "completed": true,
    },
  ];

  List<Map<String, dynamic>> goals = [
    {
      "title": "Weekly Workout Goal",
      "current": 4,
      "target": 5,
      "unit": "workouts",
      "color": primaryColor,
    },
    {
      "title": "Monthly Calorie Goal",
      "current": 8500,
      "target": 12000,
      "unit": "calories",
      "color": dangerColor,
    },
    {
      "title": "Weight Loss Goal",
      "current": 3.2,
      "target": 10.0,
      "unit": "lbs",
      "color": successColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(200),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowLg],
              ),
              child: Column(
                children: [
                  // Avatar and Basic Info
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [shadowMd],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            "${user["avatar"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${user["name"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${user["username"]}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                            Text(
                              "${user["profession"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white.withAlpha(200),
                                  size: 14,
                                ),
                                SizedBox(width: spXxs),
                                Text(
                                  "${user["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(200),
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
                  
                  // Level and Badges
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${user["level"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.military_tech,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${user["badges"]} Badges",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Member since ${user["memberSince"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(180),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Social Stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildSocialStat("Followers", "${(user["followers"] as int) / 1000}K"),
                      ),
                      Expanded(
                        child: _buildSocialStat("Following", "${user["following"]}"),
                      ),
                      Expanded(
                        child: _buildSocialStat("Workouts", "${(user["totalWorkouts"] as int) / 1000}K"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Fitness Stats Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: stats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${stat["value"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${stat["label"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "${stat["trend"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "this week",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Goals Progress
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
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
                  SizedBox(height: spMd),
                  Column(
                    children: goals.map((goal) {
                      double progress = (goal["current"] as num) / (goal["target"] as num);
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${goal["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${goal["current"]}/${goal["target"]} ${goal["unit"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: progress.clamp(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: goal["color"] as Color,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                ),
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

            // Achievements
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Achievements",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: achievements.map((achievement) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: achievement["completed"] == true 
                              ? (achievement["color"] as Color).withAlpha(20)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: achievement["completed"] == true 
                                ? achievement["color"] as Color
                                : disabledColor,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              achievement["icon"] as IconData,
                              color: achievement["completed"] == true 
                                  ? achievement["color"] as Color
                                  : disabledColor,
                              size: 24,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${achievement["title"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: achievement["completed"] == true 
                                    ? primaryColor
                                    : disabledColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${achievement["description"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
                                height: 1.3,
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

            // Recent Workouts
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Workouts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: workoutHistory.take(3).map((workout) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _getWorkoutTypeColor(workout["type"]).withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getWorkoutTypeIcon(workout["type"]),
                                color: _getWorkoutTypeColor(workout["type"]),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${workout["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${workout["duration"]} • ${workout["calories"]} cal",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${workout["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Start Workout",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View Progress",
                    color: secondaryColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Color _getWorkoutTypeColor(String type) {
    switch (type) {
      case "Strength":
        return primaryColor;
      case "Cardio":
        return dangerColor;
      case "Flexibility":
        return successColor;
      case "HIIT":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  IconData _getWorkoutTypeIcon(String type) {
    switch (type) {
      case "Strength":
        return Icons.fitness_center;
      case "Cardio":
        return Icons.directions_run;
      case "Flexibility":
        return Icons.self_improvement;
      case "HIIT":
        return Icons.speed;
      default:
        return Icons.sports;
    }
  }
}
