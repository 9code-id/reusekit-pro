import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExercise2View extends StatefulWidget {
  @override
  State<GrlExercise2View> createState() => _GrlExercise2ViewState();
}

class _GrlExercise2ViewState extends State<GrlExercise2View> {
  bool isWorkoutActive = false;
  int currentExerciseIndex = 0;
  int exerciseTimeRemaining = 30;
  int restTimeRemaining = 10;
  bool isResting = false;
  String workoutPhase = "prepare"; // prepare, exercise, rest, completed

  List<Map<String, dynamic>> workoutPlan = [
    {
      "name": "Jumping Jacks",
      "duration": 30,
      "restAfter": 10,
      "instructions": "Jump your feet apart while raising your arms overhead, then jump back to start",
      "image": "https://picsum.photos/300/200?random=1&keyword=jumping",
      "completed": false,
      "calories": 25
    },
    {
      "name": "Push-ups",
      "duration": 30,
      "restAfter": 15,
      "instructions": "Lower your body to the ground, then push back up to starting position",
      "image": "https://picsum.photos/300/200?random=2&keyword=pushup",
      "completed": false,
      "calories": 30
    },
    {
      "name": "Squats",
      "duration": 30,
      "restAfter": 10,
      "instructions": "Lower into sitting position, then drive through heels to stand",
      "image": "https://picsum.photos/300/200?random=3&keyword=squat",
      "completed": false,
      "calories": 35
    },
    {
      "name": "Plank",
      "duration": 45,
      "restAfter": 15,
      "instructions": "Hold your body in a straight line from head to heels",
      "image": "https://picsum.photos/300/200?random=4&keyword=plank",
      "completed": false,
      "calories": 20
    },
    {
      "name": "Mountain Climbers",
      "duration": 30,
      "restAfter": 10,
      "instructions": "Bring knees to chest alternately while maintaining plank position",
      "image": "https://picsum.photos/300/200?random=5&keyword=mountain",
      "completed": false,
      "calories": 40
    },
    {
      "name": "Burpees",
      "duration": 30,
      "restAfter": 0,
      "instructions": "Drop to plank, do push-up, jump feet to hands, then jump up",
      "image": "https://picsum.photos/300/200?random=6&keyword=burpee",
      "completed": false,
      "calories": 45
    }
  ];

  Map<String, dynamic> workoutStats = {
    "totalTime": 0,
    "caloriesBurned": 0,
    "exercisesCompleted": 0,
    "startTime": DateTime.now()
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Session"),
        actions: [
          if (isWorkoutActive)
            IconButton(
              icon: Icon(Icons.pause),
              onPressed: () => _pauseWorkout(),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isWorkoutActive && workoutPhase != "completed") ...[
              // Workout Overview
              _buildWorkoutOverview(),
              SizedBox(height: spMd),
              _buildExerciseList(),
            ] else if (workoutPhase == "completed") ...[
              // Workout Completed
              _buildWorkoutSummary(),
            ] else ...[
              // Active Workout
              _buildActiveWorkout(),
            ],
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildWorkoutOverview() {
    int totalDuration = workoutPlan.fold(0, (sum, exercise) => 
        sum + (exercise["duration"] as int) + (exercise["restAfter"] as int));
    int totalCalories = workoutPlan.fold(0, (sum, exercise) => 
        sum + (exercise["calories"] as int));

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.fitness_center, color: Colors.white, size: 24),
              SizedBox(width: spSm),
              Text(
                "HIIT Workout Session",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildOverviewStat("Duration", "${(totalDuration / 60).ceil()} min", Icons.timer),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewStat("Exercises", "${workoutPlan.length}", Icons.list),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewStat("Calories", "$totalCalories", Icons.local_fire_department),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "High-intensity interval training combining cardio and strength exercises for maximum calorie burn.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(230),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewStat(String label, String value, IconData icon) {
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
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withAlpha(200),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Exercise Sequence",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          children: List.generate(workoutPlan.length, (index) {
            final exercise = workoutPlan[index];
            final isCompleted = exercise["completed"] as bool;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: isCompleted ? successColor : primaryColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Exercise Number
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isCompleted ? successColor : primaryColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: isCompleted
                          ? Icon(Icons.check, color: Colors.white, size: 20)
                          : Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                    ),
                  ),
                  
                  SizedBox(width: spSm),
                  
                  // Exercise Image
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      image: DecorationImage(
                        image: NetworkImage("${exercise["image"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  SizedBox(width: spSm),
                  
                  // Exercise Info
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
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${exercise["instructions"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.timer, size: 14, color: infoColor),
                            SizedBox(width: 4),
                            Text(
                              "${exercise["duration"]}s",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.local_fire_department, size: 14, color: dangerColor),
                            SizedBox(width: 4),
                            Text(
                              "${exercise["calories"]} cal",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildActiveWorkout() {
    Map<String, dynamic> currentExercise = workoutPlan[currentExerciseIndex];
    double progress = isResting 
        ? ((currentExercise["restAfter"] as int) - restTimeRemaining) / (currentExercise["restAfter"] as int)
        : ((currentExercise["duration"] as int) - exerciseTimeRemaining) / (currentExercise["duration"] as int);

    return Column(
      children: [
        // Progress Indicator
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Exercise ${currentExerciseIndex + 1} of ${workoutPlan.length}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${((currentExerciseIndex + 1) / workoutPlan.length * 100).toInt()}% Complete",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              LinearProgressIndicator(
                value: (currentExerciseIndex + progress) / workoutPlan.length,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Current Exercise
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isResting 
                  ? [warningColor, warningColor.withAlpha(180)]
                  : [primaryColor, primaryColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowLg],
          ),
          child: Column(
            children: [
              Text(
                isResting ? "REST TIME" : "EXERCISE",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withAlpha(200),
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: spSm),
              
              // Exercise Image
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${currentExercise["image"]}"),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.white, width: 3),
                ),
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "${currentExercise["name"]}",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: spSm),
              
              // Timer
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(20),
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Center(
                  child: Text(
                    "${isResting ? restTimeRemaining : exerciseTimeRemaining}",
                    style: TextStyle(
                      fontSize: fsH1,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: spSm),
              
              if (!isResting)
                Text(
                  "${currentExercise["instructions"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(230),
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Next Exercise Preview
        if (currentExerciseIndex + 1 < workoutPlan.length)
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Text(
                  "Next: ",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${workoutPlan[currentExerciseIndex + 1]["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${workoutPlan[currentExerciseIndex + 1]["duration"]}s",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildWorkoutSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [successColor, successColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowLg],
      ),
      child: Column(
        children: [
          Icon(Icons.celebration, color: Colors.white, size: 48),
          SizedBox(height: spSm),
          Text(
            "Workout Completed!",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard("Time", "${workoutStats["totalTime"]} min", Icons.timer),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard("Calories", "${workoutStats["caloriesBurned"]}", Icons.local_fire_department),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard("Exercises", "${workoutStats["exercisesCompleted"]}", Icons.fitness_center),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
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
      ),
    );
  }

  Widget _buildBottomActions() {
    if (workoutPhase == "completed") {
      return Container(
        padding: EdgeInsets.all(spMd),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Share Results",
                size: bs.md,
                onPressed: () => _shareResults(),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "New Workout",
                size: bs.md,
                onPressed: () => _startNewWorkout(),
              ),
            ),
          ],
        ),
      );
    }

    if (!isWorkoutActive) {
      return Container(
        padding: EdgeInsets.all(spMd),
        child: QButton(
          label: "Start Workout",
          size: bs.md,
          onPressed: () => _startWorkout(),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Skip",
              size: bs.md,
              onPressed: () => _skipExercise(),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Stop Workout",
              size: bs.md,
              onPressed: () => _stopWorkout(),
            ),
          ),
        ],
      ),
    );
  }

  void _startWorkout() {
    isWorkoutActive = true;
    workoutPhase = "exercise";
    workoutStats["startTime"] = DateTime.now();
    _startExerciseTimer();
    setState(() {});
  }

  void _startExerciseTimer() {
    // Timer implementation would go here
  }

  void _skipExercise() {
    _nextExercise();
  }

  void _nextExercise() {
    workoutPlan[currentExerciseIndex]["completed"] = true;
    workoutStats["exercisesCompleted"]++;
    workoutStats["caloriesBurned"] += workoutPlan[currentExerciseIndex]["calories"];
    
    if (currentExerciseIndex + 1 < workoutPlan.length) {
      currentExerciseIndex++;
      exerciseTimeRemaining = workoutPlan[currentExerciseIndex]["duration"];
      _startExerciseTimer();
    } else {
      _completeWorkout();
    }
    setState(() {});
  }

  void _completeWorkout() {
    workoutPhase = "completed";
    isWorkoutActive = false;
    workoutStats["totalTime"] = DateTime.now().difference(workoutStats["startTime"]).inMinutes;
    setState(() {});
  }

  void _pauseWorkout() {
    // Pause implementation
  }

  void _stopWorkout() {
    // Stop workout implementation
  }

  void _shareResults() {
    // Share results implementation
  }

  void _startNewWorkout() {
    // Reset and start new workout
  }
}
