import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFitness2View extends StatefulWidget {
  @override
  State<GrlFitness2View> createState() => _GrlFitness2ViewState();
}

class _GrlFitness2ViewState extends State<GrlFitness2View> {
  bool isWorkoutActive = false;
  int currentExerciseIndex = 0;
  int currentTimer = 45;
  int restTimer = 15;
  bool isResting = false;
  bool isPaused = false;

  List<Map<String, dynamic>> exercises = [
    {
      "name": "Jumping Jacks",
      "duration": 45,
      "reps": null,
      "description": "Jump with feet apart while raising arms overhead",
      "instructions": [
        "Stand with feet together, arms at your sides",
        "Jump while spreading feet shoulder-width apart",
        "Simultaneously raise arms overhead",
        "Jump back to starting position",
        "Maintain steady rhythm throughout"
      ],
      "image": "https://picsum.photos/400/300?random=1&keyword=jumping",
      "targetMuscles": ["Legs", "Cardio", "Full Body"],
      "difficulty": "Beginner"
    },
    {
      "name": "Push-ups",
      "duration": 45,
      "reps": 15,
      "description": "Classic upper body strengthening exercise",
      "instructions": [
        "Start in plank position with hands under shoulders",
        "Lower body until chest nearly touches floor",
        "Keep core tight and body in straight line",
        "Push back up to starting position",
        "Modify on knees if needed"
      ],
      "image": "https://picsum.photos/400/300?random=2&keyword=pushup",
      "targetMuscles": ["Chest", "Arms", "Core"],
      "difficulty": "Intermediate"
    },
    {
      "name": "Mountain Climbers",
      "duration": 45,
      "reps": null,
      "description": "High-intensity core and cardio exercise",
      "instructions": [
        "Start in plank position",
        "Bring right knee toward chest",
        "Quickly switch legs in running motion",
        "Keep hips level and core engaged",
        "Maintain rapid but controlled pace"
      ],
      "image": "https://picsum.photos/400/300?random=3&keyword=mountain",
      "targetMuscles": ["Core", "Cardio", "Legs"],
      "difficulty": "Intermediate"
    },
    {
      "name": "Squats",
      "duration": 45,
      "reps": 20,
      "description": "Lower body strengthening exercise",
      "instructions": [
        "Stand with feet shoulder-width apart",
        "Lower hips back and down as if sitting",
        "Keep chest up and knees behind toes",
        "Lower until thighs parallel to floor",
        "Push through heels to return to start"
      ],
      "image": "https://picsum.photos/400/300?random=4&keyword=squat",
      "targetMuscles": ["Legs", "Glutes", "Core"],
      "difficulty": "Beginner"
    },
    {
      "name": "Plank",
      "duration": 45,
      "reps": null,
      "description": "Core stability and strength exercise",
      "instructions": [
        "Start in push-up position",
        "Lower to forearms with elbows under shoulders",
        "Keep body in straight line from head to heels",
        "Engage core and avoid sagging hips",
        "Breathe steadily and hold position"
      ],
      "image": "https://picsum.photos/400/300?random=5&keyword=plank",
      "targetMuscles": ["Core", "Shoulders", "Back"],
      "difficulty": "Intermediate"
    },
    {
      "name": "Burpees",
      "duration": 45,
      "reps": 10,
      "description": "Full-body explosive exercise",
      "instructions": [
        "Start standing with feet hip-width apart",
        "Squat down and place hands on floor",
        "Jump feet back into plank position",
        "Do a push-up (optional)",
        "Jump feet forward and explode up with arms overhead"
      ],
      "image": "https://picsum.photos/400/300?random=6&keyword=burpee",
      "targetMuscles": ["Full Body", "Cardio"],
      "difficulty": "Advanced"
    }
  ];

  Map<String, dynamic> workoutStats = {
    "totalTime": 0,
    "caloriesBurned": 0,
    "exercisesCompleted": 0,
    "totalExercises": 6,
  };

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    if (isWorkoutActive && !isPaused) {
      Future.delayed(Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            if (isResting) {
              if (restTimer > 0) {
                restTimer--;
              } else {
                // Move to next exercise
                _nextExercise();
              }
            } else {
              if (currentTimer > 0) {
                currentTimer--;
                workoutStats["totalTime"]++;
                workoutStats["caloriesBurned"] = (workoutStats["totalTime"] * 0.2).round();
              } else {
                // Start rest period
                _startRest();
              }
            }
          });
          _startTimer();
        }
      });
    }
  }

  void _startRest() {
    setState(() {
      isResting = true;
      restTimer = 15;
      workoutStats["exercisesCompleted"]++;
    });
  }

  void _nextExercise() {
    setState(() {
      if (currentExerciseIndex < exercises.length - 1) {
        currentExerciseIndex++;
        currentTimer = exercises[currentExerciseIndex]["duration"];
        isResting = false;
      } else {
        // Workout completed
        _completeWorkout();
      }
    });
  }

  void _completeWorkout() {
    setState(() {
      isWorkoutActive = false;
      workoutStats["exercisesCompleted"] = exercises.length;
    });
    ss("Workout completed! Great job!");
  }

  void _toggleWorkout() {
    setState(() {
      if (!isWorkoutActive) {
        // Start workout
        isWorkoutActive = true;
        currentExerciseIndex = 0;
        currentTimer = exercises[0]["duration"];
        isResting = false;
        isPaused = false;
        workoutStats = {
          "totalTime": 0,
          "caloriesBurned": 0,
          "exercisesCompleted": 0,
          "totalExercises": exercises.length,
        };
      } else {
        // Pause/Resume workout
        isPaused = !isPaused;
      }
    });
  }

  void _stopWorkout() {
    setState(() {
      isWorkoutActive = false;
      isPaused = false;
      currentExerciseIndex = 0;
      currentTimer = exercises[0]["duration"];
      isResting = false;
    });
  }

  void _skipExercise() {
    if (isResting) {
      _nextExercise();
    } else {
      _startRest();
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    var currentExercise = exercises[currentExerciseIndex];
    double progress = (currentExerciseIndex + 1) / exercises.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("HIIT Workout"),
        actions: [
          if (isWorkoutActive)
            GestureDetector(
              onTap: _stopWorkout,
              child: Icon(Icons.stop),
            ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Workout Progress
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Text(
                        "Exercise ${currentExerciseIndex + 1} of ${exercises.length}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(progress * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ],
              ),
            ),

            // Timer Display
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isResting 
                      ? [Colors.orange, Colors.orange.withAlpha(200)]
                      : [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Text(
                    isResting ? "REST TIME" : "EXERCISE TIME",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    _formatTime(isResting ? restTimer : currentTimer),
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (!isResting && currentExercise["reps"] != null)
                    Text(
                      "Target: ${currentExercise["reps"]} reps",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                ],
              ),
            ),

            // Current Exercise Info
            if (!isResting) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${currentExercise["name"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(currentExercise["difficulty"]).withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${currentExercise["difficulty"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getDifficultyColor(currentExercise["difficulty"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${currentExercise["image"]}",
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Text(
                      "${currentExercise["description"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),

                    // Target Muscles
                    QHorizontalScroll(
                      children: (currentExercise["targetMuscles"] as List<String>).map((muscle) {
                        return Container(
                          margin: EdgeInsets.only(right: spXs),
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            muscle,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Exercise Instructions
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "How to perform:",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...(currentExercise["instructions"] as List<String>).asMap().entries.map((entry) {
                      int index = entry.key;
                      String instruction = entry.value;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              instruction,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],

            // Rest Screen
            if (isResting)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.self_improvement,
                      color: Colors.orange,
                      size: 64,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Take a Break",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Rest and prepare for the next exercise",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    if (currentExerciseIndex < exercises.length - 1)
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Next Exercise:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${exercises[currentExerciseIndex + 1]["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

            // Workout Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Workout Stats",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              _formatTime(workoutStats["totalTime"]),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Time",
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
                              "${workoutStats["caloriesBurned"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            Text(
                              "Calories",
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
                              "${workoutStats["exercisesCompleted"]}/${workoutStats["totalExercises"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
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
                ],
              ),
            ),

            // Control Buttons
            if (!isWorkoutActive)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Start Workout",
                  size: bs.md,
                  onPressed: _toggleWorkout,
                ),
              ),

            if (isWorkoutActive)
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: isPaused ? "Resume" : "Pause",
                      size: bs.md,
                      onPressed: _toggleWorkout,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Skip",
                      size: bs.md,
                      onPressed: _skipExercise,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "beginner":
        return Colors.green;
      case "intermediate":
        return Colors.orange;
      case "advanced":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
