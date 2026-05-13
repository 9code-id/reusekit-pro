import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFitness7View extends StatefulWidget {
  @override
  State<GrlFitness7View> createState() => _GrlFitness7ViewState();
}

class _GrlFitness7ViewState extends State<GrlFitness7View> {
  String selectedPeriod = "Week";
  int selectedWeek = 1;

  Map<String, dynamic> fitnessStats = {
    "totalWorkouts": 24,
    "totalMinutes": 1260,
    "caloriesBurned": 8540,
    "currentStreak": 7,
    "weeklyGoal": 5,
    "weeklyCompleted": 4,
    "averageHeartRate": 142,
    "personalBests": {
      "longestWorkout": 65,
      "highestCalories": 485,
      "bestStreak": 12,
    }
  };

  List<Map<String, dynamic>> weeklyData = [
    {"day": "Mon", "workouts": 1, "calories": 320, "minutes": 45},
    {"day": "Tue", "workouts": 0, "calories": 0, "minutes": 0},
    {"day": "Wed", "workouts": 1, "calories": 280, "minutes": 35},
    {"day": "Thu", "workouts": 1, "calories": 410, "minutes": 55},
    {"day": "Fri", "workouts": 0, "calories": 0, "minutes": 0},
    {"day": "Sat", "workouts": 1, "calories": 380, "minutes": 50},
    {"day": "Sun", "workouts": 1, "calories": 295, "minutes": 40},
  ];

  List<Map<String, dynamic>> recentWorkouts = [
    {
      "type": "HIIT Training",
      "date": "Today",
      "duration": 35,
      "calories": 285,
      "exercises": 8,
      "completed": true
    },
    {
      "type": "Strength Training",
      "date": "Yesterday",
      "duration": 45,
      "calories": 320,
      "exercises": 12,
      "completed": true
    },
    {
      "type": "Cardio Blast",
      "date": "2 days ago",
      "duration": 30,
      "calories": 250,
      "exercises": 6,
      "completed": true
    },
    {
      "type": "Yoga Flow",
      "date": "3 days ago",
      "duration": 25,
      "calories": 120,
      "exercises": 10,
      "completed": true
    },
    {
      "type": "Core Workout",
      "date": "4 days ago",
      "duration": 20,
      "calories": 180,
      "exercises": 8,
      "completed": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness Progress"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "This Week",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${fitnessStats["weeklyCompleted"]}/${fitnessStats["weeklyGoal"]} workouts",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${fitnessStats["totalWorkouts"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Total Workouts",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${((fitnessStats["totalMinutes"] as int) / 60).toStringAsFixed(1)}h",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Time Exercised",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${((fitnessStats["caloriesBurned"] as int) / 1000).toStringAsFixed(1)}k",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Calories Burned",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (fitnessStats["weeklyCompleted"] as int) / (fitnessStats["weeklyGoal"] as int),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Weekly Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(weeklyData.length, (index) {
                        final data = weeklyData[index];
                        final maxCalories = weeklyData.map((d) => d["calories"] as int).reduce((a, b) => a > b ? a : b);
                        final height = maxCalories > 0 ? ((data["calories"] as int) / maxCalories) * 150 : 0.0;
                        
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: spXs),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: height,
                                  decoration: BoxDecoration(
                                    color: (data["workouts"] as int) > 0 ? primaryColor : disabledColor,
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                                  ),
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "${data["day"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: (data["workouts"] as int) > 0 ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(Icons.local_fire_department, color: dangerColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Streak",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${fitnessStats["currentStreak"]} days",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
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
                            Icon(Icons.favorite, color: dangerColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Avg Heart Rate",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${fitnessStats["averageHeartRate"]} bpm",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),
            Text(
              "Personal Bests",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
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
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.schedule, color: warningColor, size: 24),
                            SizedBox(height: spSm),
                            Text(
                              "${fitnessStats["personalBests"]["longestWorkout"]} min",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Longest Workout",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.local_fire_department, color: dangerColor, size: 24),
                            SizedBox(height: spSm),
                            Text(
                              "${fitnessStats["personalBests"]["highestCalories"]} cal",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Most Calories",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.trending_up, color: successColor, size: 24),
                            SizedBox(height: spSm),
                            Text(
                              "${fitnessStats["personalBests"]["bestStreak"]} days",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Best Streak",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
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
            Text(
              "Recent Workouts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...List.generate(recentWorkouts.length, (index) {
              final workout = recentWorkouts[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.fitness_center,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${workout["type"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${workout["date"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${workout["duration"]} min",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${workout["calories"]} cal",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
