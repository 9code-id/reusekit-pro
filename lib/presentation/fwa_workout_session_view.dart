import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaWorkoutSessionView extends StatefulWidget {
  const FwaWorkoutSessionView({super.key});

  @override
  State<FwaWorkoutSessionView> createState() => _FwaWorkoutSessionViewState();
}

class _FwaWorkoutSessionViewState extends State<FwaWorkoutSessionView> {
  List<Map<String, dynamic>> workoutExercises = [
    {
      "id": 1,
      "name": "Push-ups",
      "sets": 3,
      "reps": 15,
      "restTime": 60,
      "completed": true,
      "completedSets": 3,
      "actualReps": [15, 12, 10],
      "image": "https://picsum.photos/100/100?random=1&keyword=pushup",
      "targetMuscles": ["Chest", "Shoulders"],
      "notes": "Focus on proper form"
    },
    {
      "id": 2,
      "name": "Squats",
      "sets": 3,
      "reps": 20,
      "restTime": 45,
      "completed": true,
      "completedSets": 3,
      "actualReps": [20, 18, 15],
      "image": "https://picsum.photos/100/100?random=2&keyword=squat",
      "targetMuscles": ["Legs", "Glutes"],
      "notes": "Keep knees behind toes"
    },
    {
      "id": 3,
      "name": "Plank",
      "sets": 3,
      "reps": "45 sec",
      "restTime": 30,
      "completed": false,
      "completedSets": 1,
      "actualReps": [45],
      "image": "https://picsum.photos/100/100?random=3&keyword=plank",
      "targetMuscles": ["Core", "Shoulders"],
      "notes": "Hold steady position"
    },
    {
      "id": 4,
      "name": "Lunges",
      "sets": 3,
      "reps": 12,
      "restTime": 60,
      "completed": false,
      "completedSets": 0,
      "actualReps": [],
      "image": "https://picsum.photos/100/100?random=4&keyword=lunge",
      "targetMuscles": ["Legs", "Glutes"],
      "notes": "Alternate legs"
    },
    {
      "id": 5,
      "name": "Mountain Climbers",
      "sets": 3,
      "reps": "30 sec",
      "restTime": 45,
      "completed": false,
      "completedSets": 0,
      "actualReps": [],
      "image": "https://picsum.photos/100/100?random=5&keyword=mountain",
      "targetMuscles": ["Cardio", "Core"],
      "notes": "Keep core tight"
    }
  ];

  int currentExerciseIndex = 2; // Currently on Plank
  bool isResting = false;
  bool isWorkoutActive = true;
  int restTimeRemaining = 0;
  int workoutTimeElapsed = 1247; // seconds
  int totalCaloriesBurned = 85;

  String get formattedWorkoutTime {
    int minutes = (workoutTimeElapsed / 60).floor();
    int seconds = workoutTimeElapsed % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  String get formattedRestTime {
    int minutes = (restTimeRemaining / 60).floor();
    int seconds = restTimeRemaining % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  double get workoutProgress {
    int completedExercises = workoutExercises.where((e) => e["completed"]).length;
    return completedExercises / workoutExercises.length;
  }

  Map<String, dynamic> get currentExercise {
    return workoutExercises[currentExerciseIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Session"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () async {
            bool isConfirmed = await confirm("Are you sure you want to end this workout session?");
            if (isConfirmed) {
              back();
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.pause),
            onPressed: () {
              if (isWorkoutActive) {
                sw("Workout paused");
              } else {
                si("Workout resumed");
              }
              isWorkoutActive = !isWorkoutActive;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Workout Progress & Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              formattedWorkoutTime,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Workout Time",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "$totalCaloriesBurned",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Calories Burned",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${workoutExercises.where((e) => e["completed"]).length}/${workoutExercises.length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Exercises",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Overall Progress",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${(workoutProgress * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        value: workoutProgress,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Rest Timer (when resting)
            if (isResting)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: warningColor.withAlpha(50),
                    width: 2,
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.timer,
                      color: warningColor,
                      size: 48,
                    ),
                    Text(
                      "Rest Time",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      formattedRestTime,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Skip Rest",
                            size: bs.sm,
                            onPressed: () {
                              isResting = false;
                              restTimeRemaining = 0;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Add 30s",
                            size: bs.sm,
                            onPressed: () {
                              restTimeRemaining += 30;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Current Exercise
            if (!isResting)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Current Exercise",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${currentExerciseIndex + 1} of ${workoutExercises.length}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${currentExercise["image"]}",
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
                                "${currentExercise["name"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${currentExercise["sets"]} sets × ${currentExercise["reps"]} reps",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Wrap(
                                spacing: spXs,
                                children: (currentExercise["targetMuscles"] as List).map((muscle) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "$muscle",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList().cast<Widget>(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (currentExercise["notes"] != null)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info, color: infoColor, size: 16),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${currentExercise["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Mark Complete",
                            size: bs.md,
                            onPressed: () {
                              currentExercise["completed"] = true;
                              currentExercise["completedSets"] = currentExercise["sets"];
                              
                              if (currentExerciseIndex < workoutExercises.length - 1) {
                                isResting = true;
                                restTimeRemaining = currentExercise["restTime"];
                                currentExerciseIndex++;
                              } else {
                                // Workout complete
                                ss("Workout completed! Great job!");
                              }
                              
                              setState(() {});
                            },
                          ),
                        ),
                        QButton(
                          icon: Icons.info,
                          size: bs.md,
                          onPressed: () {
                            // navigateTo('Exercise Detail')
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Exercise List
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Exercise List",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: workoutExercises.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> exercise = entry.value;
                      bool isCurrent = index == currentExerciseIndex && !isResting;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: exercise["completed"] ? successColor.withAlpha(10) :
                                 isCurrent ? primaryColor.withAlpha(10) :
                                 Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: exercise["completed"] ? successColor.withAlpha(30) :
                                   isCurrent ? primaryColor.withAlpha(50) :
                                   disabledColor,
                            width: isCurrent ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusXs),
                                child: Image.network(
                                  "${exercise["image"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${exercise["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${exercise["sets"]} sets × ${exercise["reps"]} reps",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (exercise["completed"])
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 24,
                              )
                            else if (isCurrent)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "CURRENT",
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            else
                              Text(
                                "${exercise["completedSets"]}/${exercise["sets"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
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
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QButton(
                label: "End Workout",
                size: bs.md,
                onPressed: () async {
                  bool isConfirmed = await confirm("Are you sure you want to end this workout session?");
                  if (isConfirmed) {
                    // navigateTo('Workout Summary')
                  }
                },
              ),
            ),
            if (!isResting && currentExerciseIndex > 0)
              QButton(
                icon: Icons.skip_previous,
                size: bs.md,
                onPressed: () {
                  currentExerciseIndex--;
                  setState(() {});
                },
              ),
            if (!isResting && currentExerciseIndex < workoutExercises.length - 1)
              QButton(
                icon: Icons.skip_next,
                size: bs.md,
                onPressed: () {
                  currentExerciseIndex++;
                  setState(() {});
                },
              ),
          ],
        ),
      ),
    );
  }
}
