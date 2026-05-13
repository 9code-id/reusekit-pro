import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExercise5View extends StatefulWidget {
  const GrlExercise5View({super.key});

  @override
  State<GrlExercise5View> createState() => _GrlExercise5ViewState();
}

class _GrlExercise5ViewState extends State<GrlExercise5View> {
  int currentWeek = 1;
  String selectedWorkout = "strength";
  int completedExercises = 0;
  bool isWorkoutActive = false;
  int currentExerciseIndex = 0;
  int restTime = 60;
  int workoutTime = 0;

  List<Map<String, dynamic>> weeklyProgress = [
    {"week": 1, "completed": 3, "total": 5, "streak": 3},
    {"week": 2, "completed": 4, "total": 5, "streak": 7},
    {"week": 3, "completed": 2, "total": 5, "streak": 2},
    {"week": 4, "completed": 5, "total": 5, "streak": 12},
  ];

  List<Map<String, dynamic>> workoutTypes = [
    {
      "id": "strength",
      "name": "Strength Training",
      "icon": Icons.fitness_center,
      "color": primaryColor,
      "duration": "45 min",
      "exercises": 8,
      "calories": 320,
    },
    {
      "id": "cardio",
      "name": "Cardio Blast",
      "icon": Icons.directions_run,
      "color": dangerColor,
      "duration": "30 min",
      "exercises": 6,
      "calories": 280,
    },
    {
      "id": "hiit",
      "name": "HIIT Session",
      "icon": Icons.timer,
      "color": warningColor,
      "duration": "25 min",
      "exercises": 10,
      "calories": 350,
    },
    {
      "id": "yoga",
      "name": "Yoga Flow",
      "icon": Icons.self_improvement,
      "color": successColor,
      "duration": "40 min",
      "exercises": 12,
      "calories": 180,
    },
  ];

  List<Map<String, dynamic>> todayExercises = [
    {
      "name": "Push-ups",
      "sets": 3,
      "reps": "10-15",
      "completed": true,
      "muscle": "Chest, Arms",
      "difficulty": "Beginner",
    },
    {
      "name": "Squats",
      "sets": 3,
      "reps": "15-20",
      "completed": true,
      "muscle": "Legs, Glutes",
      "difficulty": "Beginner",
    },
    {
      "name": "Plank",
      "sets": 3,
      "reps": "30 sec",
      "completed": false,
      "muscle": "Core",
      "difficulty": "Intermediate",
    },
    {
      "name": "Lunges",
      "sets": 3,
      "reps": "12 each leg",
      "completed": false,
      "muscle": "Legs, Glutes",
      "difficulty": "Beginner",
    },
    {
      "name": "Mountain Climbers",
      "sets": 3,
      "reps": "20 total",
      "completed": false,
      "muscle": "Full Body",
      "difficulty": "Intermediate",
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "First Workout",
      "description": "Complete your first workout session",
      "icon": Icons.star,
      "earned": true,
      "date": "2 days ago",
    },
    {
      "title": "Week Warrior",
      "description": "Complete 5 workouts in a week",
      "icon": Icons.calendar_view_week,
      "earned": true,
      "date": "1 week ago",
    },
    {
      "title": "Consistency King",
      "description": "Maintain a 7-day streak",
      "icon": Icons.local_fire_department,
      "earned": false,
      "date": "",
    },
    {
      "title": "Strong Foundation",
      "description": "Complete 25 strength exercises",
      "icon": Icons.fitness_center,
      "earned": false,
      "date": "",
    },
  ];

  void _startWorkout() {
    isWorkoutActive = true;
    workoutTime = 0;
    currentExerciseIndex = 0;
    setState(() {});
    ss("Workout started! Let's get moving!");
  }

  void _completeExercise(int index) {
    todayExercises[index]["completed"] = !todayExercises[index]["completed"];
    completedExercises = todayExercises.where((e) => e["completed"]).length;
    setState(() {});
    
    if (todayExercises[index]["completed"]) {
      ss("Exercise completed! Great job!");
    }
  }

  void _endWorkout() {
    isWorkoutActive = false;
    setState(() {});
    ss("Workout completed! Well done!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Progress Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
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
                              "Today's Progress",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "$completedExercises of ${todayExercises.length} exercises completed",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(230),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${((completedExercises / todayExercises.length) * 100).round()}%",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Complete",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(230),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  LinearProgressIndicator(
                    value: completedExercises / todayExercises.length,
                    backgroundColor: Colors.white.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 8,
                  ),
                ],
              ),
            ),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.local_fire_department,
                    title: "Streak",
                    value: "12 days",
                    color: dangerColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.timer,
                    title: "Time",
                    value: "45 min",
                    color: warningColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.local_fire_department,
                    title: "Calories",
                    value: "320",
                    color: successColor,
                  ),
                ),
              ],
            ),

            // Workout Selection
            Text(
              "Choose Your Workout",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              height: 120,
              child: QHorizontalScroll(
                children: workoutTypes.map((workout) {
                  bool isSelected = selectedWorkout == workout["id"];
                  return GestureDetector(
                    onTap: () {
                      selectedWorkout = workout["id"];
                      setState(() {});
                    },
                    child: Container(
                      width: 160,
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? (workout["color"] as Color).withAlpha(25) : Colors.white,
                        border: Border.all(
                          color: isSelected ? (workout["color"] as Color) : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [if (isSelected) shadowMd else shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                workout["icon"],
                                color: workout["color"],
                                size: 20,
                              ),
                              Spacer(),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: workout["color"],
                                  size: 16,
                                ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${workout["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${workout["duration"]} • ${workout["exercises"]} exercises",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Today's Exercises
            Row(
              children: [
                Text(
                  "Today's Exercises",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                if (!isWorkoutActive)
                  QButton(
                    label: "Start Workout",
                    size: bs.sm,
                    onPressed: _startWorkout,
                  )
                else
                  QButton(
                    label: "End Workout",
                    size: bs.sm,
                    onPressed: _endWorkout,
                  ),
              ],
            ),

            Column(
              spacing: spSm,
              children: todayExercises.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> exercise = entry.value;
                bool isCompleted = exercise["completed"];
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isCompleted ? successColor.withAlpha(25) : Colors.white,
                    border: Border.all(
                      color: isCompleted ? successColor : disabledOutlineBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _completeExercise(index),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: isCompleted ? successColor : Colors.transparent,
                            border: Border.all(
                              color: isCompleted ? successColor : disabledBoldColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: isCompleted
                              ? Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${exercise["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                decoration: isCompleted ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${exercise["sets"]} sets • ${exercise["reps"]} reps",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${exercise["muscle"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: exercise["difficulty"] == "Beginner" 
                                        ? successColor.withAlpha(25)
                                        : warningColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${exercise["difficulty"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: exercise["difficulty"] == "Beginner" 
                                          ? successColor 
                                          : warningColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (isWorkoutActive && !isCompleted)
                        QButton(
                          icon: Icons.play_arrow,
                          size: bs.sm,
                          onPressed: () => _completeExercise(index),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Weekly Progress
            Text(
              "Weekly Progress",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: weeklyProgress.map((week) {
                      double progress = (week["completed"] as int) / (week["total"] as int);
                      return Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: progress >= 1.0 ? successColor.withAlpha(25) : primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: progress >= 1.0 ? successColor : primaryColor,
                                width: 2,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: progress,
                                  backgroundColor: Colors.transparent,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    progress >= 1.0 ? successColor : primaryColor,
                                  ),
                                  strokeWidth: 3,
                                ),
                                Text(
                                  "W${week["week"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: progress >= 1.0 ? successColor : primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${week["completed"]}/${week["total"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${week["streak"]} days",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Achievements
            Text(
              "Achievements",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: achievements.map((achievement) {
                bool isEarned = achievement["earned"];
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isEarned ? warningColor.withAlpha(25) : Colors.white,
                    border: Border.all(
                      color: isEarned ? warningColor : disabledOutlineBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isEarned ? warningColor : disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          achievement["icon"],
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${achievement["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isEarned ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${achievement["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            if (isEarned && achievement["date"].toString().isNotEmpty)
                              Text(
                                "Earned ${achievement["date"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: warningColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (isEarned)
                        Icon(
                          Icons.check_circle,
                          color: warningColor,
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
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
