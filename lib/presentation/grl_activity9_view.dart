import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlActivity9View extends StatefulWidget {
  @override
  State<GrlActivity9View> createState() => _GrlActivity9ViewState();
}

class _GrlActivity9ViewState extends State<GrlActivity9View> {
  bool isWorkoutActive = false;
  int currentExercise = 0;
  int currentSet = 1;
  int timeRemaining = 45;
  int restTimeRemaining = 30;
  bool isResting = false;
  bool isPaused = false;
  
  final Map<String, dynamic> activeWorkout = {
    "title": "Morning Power Workout",
    "totalDuration": 30,
    "exercises": [
      {
        "name": "Jumping Jacks",
        "duration": 45,
        "sets": 3,
        "restBetweenSets": 30,
        "instructions": "Keep your core engaged and land softly on your feet",
        "targetMuscles": ["Cardio", "Full Body"],
        "image": "https://placehold.co/300x200?text=Jumping+Jacks",
        "calories": 8
      },
      {
        "name": "Push-ups",
        "duration": 60,
        "sets": 3,
        "restBetweenSets": 45,
        "instructions": "Keep your body straight from head to heels",
        "targetMuscles": ["Chest", "Triceps", "Core"],
        "image": "https://placehold.co/300x200?text=Push+ups",
        "calories": 10
      },
      {
        "name": "Squats",
        "duration": 50,
        "sets": 3,
        "restBetweenSets": 40,
        "instructions": "Lower down as if sitting in a chair, keep knees aligned",
        "targetMuscles": ["Legs", "Glutes", "Core"],
        "image": "https://placehold.co/300x200?text=Squats",
        "calories": 12
      },
      {
        "name": "Plank",
        "duration": 60,
        "sets": 2,
        "restBetweenSets": 60,
        "instructions": "Keep your body straight and breathe normally",
        "targetMuscles": ["Core", "Shoulders"],
        "image": "https://placehold.co/300x200?text=Plank",
        "calories": 6
      },
      {
        "name": "Burpees",
        "duration": 40,
        "sets": 3,
        "restBetweenSets": 60,
        "instructions": "Explosive movement, jump high and land softly",
        "targetMuscles": ["Full Body", "Cardio"],
        "image": "https://placehold.co/300x200?text=Burpees",
        "calories": 15
      }
    ]
  };

  Map<String, dynamic> get currentExerciseData {
    return (activeWorkout["exercises"] as List)[currentExercise];
  }

  int get totalExercises {
    return (activeWorkout["exercises"] as List).length;
  }

  int get totalSets {
    return currentExerciseData["sets"] as int;
  }

  double get overallProgress {
    int totalSetsCompleted = 0;
    int totalSetsInWorkout = 0;
    
    List exercises = activeWorkout["exercises"] as List;
    for (int i = 0; i < exercises.length; i++) {
      int exerciseSets = exercises[i]["sets"] as int;
      totalSetsInWorkout += exerciseSets;
      
      if (i < currentExercise) {
        totalSetsCompleted += exerciseSets;
      } else if (i == currentExercise) {
        totalSetsCompleted += currentSet - 1;
      }
    }
    
    return totalSetsCompleted / totalSetsInWorkout;
  }

  void _startWorkout() {
    isWorkoutActive = true;
    timeRemaining = currentExerciseData["duration"] as int;
    setState(() {});
    _startTimer();
  }

  void _startTimer() {
    if (!isWorkoutActive || isPaused) return;
    
    Future.delayed(Duration(seconds: 1), () {
      if (!isWorkoutActive || isPaused) return;
      
      if (isResting) {
        if (restTimeRemaining > 0) {
          restTimeRemaining--;
          setState(() {});
          _startTimer();
        } else {
          _endRest();
        }
      } else {
        if (timeRemaining > 0) {
          timeRemaining--;
          setState(() {});
          _startTimer();
        } else {
          _completeSet();
        }
      }
    });
  }

  void _completeSet() {
    if (currentSet < totalSets) {
      // Start rest between sets
      isResting = true;
      restTimeRemaining = currentExerciseData["restBetweenSets"] as int;
      setState(() {});
      _startTimer();
    } else {
      // Move to next exercise
      _nextExercise();
    }
  }

  void _endRest() {
    isResting = false;
    currentSet++;
    timeRemaining = currentExerciseData["duration"] as int;
    setState(() {});
    _startTimer();
  }

  void _nextExercise() {
    if (currentExercise < totalExercises - 1) {
      currentExercise++;
      currentSet = 1;
      timeRemaining = currentExerciseData["duration"] as int;
      setState(() {});
      _startTimer();
    } else {
      _completeWorkout();
    }
  }

  void _completeWorkout() {
    isWorkoutActive = false;
    isPaused = false;
    isResting = false;
    setState(() {});
    ss("Workout completed! Great job!");
  }

  void _pauseWorkout() {
    isPaused = !isPaused;
    setState(() {});
    if (!isPaused) {
      _startTimer();
    }
  }

  void _skipExercise() {
    _nextExercise();
  }

  void _skipSet() {
    if (currentSet < totalSets) {
      currentSet++;
      timeRemaining = currentExerciseData["duration"] as int;
      setState(() {});
    } else {
      _nextExercise();
    }
  }

  void _stopWorkout() async {
    bool isConfirmed = await confirm("Are you sure you want to stop the workout?");
    if (isConfirmed) {
      isWorkoutActive = false;
      isPaused = false;
      isResting = false;
      currentExercise = 0;
      currentSet = 1;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isWorkoutActive) {
      return _buildWorkoutPreview();
    }
    
    return _buildActiveWorkout();
  }

  Widget _buildWorkoutPreview() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Session"),
        actions: [
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
            // Workout Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "${activeWorkout["title"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.timer,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${activeWorkout["totalDuration"]} min",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Duration",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.fitness_center,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${totalExercises}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Exercises",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(activeWorkout["exercises"] as List).fold(0, (sum, ex) => sum + (ex["calories"] as int))}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Calories",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Exercise List
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Exercises",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Column(
                    spacing: spSm,
                    children: (activeWorkout["exercises"] as List).asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> exercise = entry.value;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: index == 0 ? primaryColor : disabledColor,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${exercise["image"]}",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            
                            SizedBox(width: spSm),
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${exercise["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  
                                  Text(
                                    "${exercise["instructions"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  
                                  Row(
                                    children: [
                                      Text(
                                        "${exercise["sets"]} sets",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        " • ",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Text(
                                        "${exercise["duration"]}s each",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        " • ",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Text(
                                        "${exercise["calories"]} cal",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  QHorizontalScroll(
                                    children: (exercise["targetMuscles"] as List).map((muscle) {
                                      return Container(
                                        margin: EdgeInsets.only(right: spXs),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "$muscle",
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w600,
                                            color: successColor,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            
                            Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: index == 0 ? primaryColor : disabledColor,
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

            // Start Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start Workout",
                size: bs.md,
                onPressed: _startWorkout,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveWorkout() {
    return Scaffold(
      appBar: AppBar(
        title: Text("${currentExerciseData["name"]}"),
        leading: IconButton(
          icon: Icon(Icons.stop),
          onPressed: _stopWorkout,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: _skipExercise,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Progress Indicator
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Exercise ${currentExercise + 1} of $totalExercises",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Set $currentSet of $totalSets",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: overallProgress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                  
                  Text(
                    "${(overallProgress * 100).toInt()}% Complete",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Exercise Image
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Image.network(
                    "${currentExerciseData["image"]}",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SizedBox(height: spLg),

            // Timer Display
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  if (isResting) ...[
                    Text(
                      "Rest Time",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${restTimeRemaining ~/ 60}:${(restTimeRemaining % 60).toString().padLeft(2, '0')}",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ] else ...[
                    Text(
                      "Exercise Time",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${timeRemaining ~/ 60}:${(timeRemaining % 60).toString().padLeft(2, '0')}",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "${currentExerciseData["instructions"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Control Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: isPaused ? "Resume" : "Pause",
                    size: bs.md,
                    onPressed: _pauseWorkout,
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.skip_next,
                  size: bs.md,
                  onPressed: _skipSet,
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.stop,
                  size: bs.md,
                  onPressed: _stopWorkout,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
