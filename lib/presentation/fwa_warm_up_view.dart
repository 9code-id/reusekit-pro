import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaWarmUpView extends StatefulWidget {
  const FwaWarmUpView({super.key});

  @override
  State<FwaWarmUpView> createState() => _FwaWarmUpViewState();
}

class _FwaWarmUpViewState extends State<FwaWarmUpView> {
  int currentExerciseIndex = 0;
  bool isPlaying = false;
  bool isPaused = false;
  int currentTime = 30;
  int totalTime = 30;
  
  final List<Map<String, dynamic>> warmUpExercises = [
    {
      "name": "Jumping Jacks",
      "duration": 30,
      "description": "Start with feet together and arms at your sides. Jump up and spread your feet shoulder-width apart while raising your arms overhead.",
      "image": "https://picsum.photos/400/300?random=1&keyword=jumping",
      "tips": "Keep your core engaged and land softly on your feet",
      "reps": "30 seconds",
      "difficulty": "Easy",
    },
    {
      "name": "Arm Circles",
      "duration": 20,
      "description": "Extend your arms to the sides and make small circles, gradually increasing the size. Then reverse direction.",
      "image": "https://picsum.photos/400/300?random=2&keyword=stretch",
      "tips": "Keep your shoulders relaxed and movements controlled",
      "reps": "10 forward, 10 backward",
      "difficulty": "Easy",
    },
    {
      "name": "High Knees",
      "duration": 30,
      "description": "Stand tall and run in place, bringing your knees up as high as possible toward your chest.",
      "image": "https://picsum.photos/400/300?random=3&keyword=running",
      "tips": "Pump your arms and maintain good posture",
      "reps": "30 seconds",
      "difficulty": "Medium",
    },
    {
      "name": "Leg Swings",
      "duration": 20,
      "description": "Hold onto a wall or stable surface. Swing one leg forward and backward, then side to side.",
      "image": "https://picsum.photos/400/300?random=4&keyword=leg",
      "tips": "Keep your supporting leg straight and core stable",
      "reps": "10 each direction per leg",
      "difficulty": "Easy",
    },
    {
      "name": "Butt Kicks",
      "duration": 30,
      "description": "Run in place while kicking your heels up toward your glutes. Keep your knees pointing down.",
      "image": "https://picsum.photos/400/300?random=5&keyword=kick",
      "tips": "Keep your torso upright and knees under your hips",
      "reps": "30 seconds",
      "difficulty": "Medium",
    },
    {
      "name": "Shoulder Rolls",
      "duration": 15,
      "description": "Roll your shoulders up, back, and down in a smooth circular motion. Then reverse direction.",
      "image": "https://picsum.photos/400/300?random=6&keyword=shoulder",
      "tips": "Keep movements slow and controlled",
      "reps": "8 each direction",
      "difficulty": "Easy",
    },
  ];

  Map<String, dynamic> get currentExercise => warmUpExercises[currentExerciseIndex];
  
  int get totalDuration {
    return warmUpExercises.fold(0, (sum, exercise) => sum + (exercise["duration"] as int));
  }
  
  int get completedDuration {
    int completed = 0;
    for (int i = 0; i < currentExerciseIndex; i++) {
      completed += warmUpExercises[i]["duration"] as int;
    }
    return completed + (totalTime - currentTime);
  }

  double get overallProgress {
    return completedDuration / totalDuration;
  }

  Color getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy": return successColor;
      case "Medium": return warningColor;
      case "Hard": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  void startTimer() {
    if (!isPlaying) {
      isPlaying = true;
      isPaused = false;
      setState(() {});
      
      // Simulate timer countdown
      Future.delayed(Duration(seconds: 1), () {
        if (isPlaying && !isPaused && currentTime > 0) {
          currentTime--;
          setState(() {});
          startTimer();
        } else if (currentTime == 0) {
          moveToNextExercise();
        }
      });
    }
  }

  void pauseTimer() {
    isPaused = true;
    setState(() {});
  }

  void resumeTimer() {
    isPaused = false;
    startTimer();
  }

  void stopTimer() {
    isPlaying = false;
    isPaused = false;
    currentTime = currentExercise["duration"];
    setState(() {});
  }

  void moveToNextExercise() {
    if (currentExerciseIndex < warmUpExercises.length - 1) {
      currentExerciseIndex++;
      currentTime = currentExercise["duration"];
      totalTime = currentExercise["duration"];
      setState(() {});
      
      if (isPlaying) {
        startTimer();
      }
    } else {
      // Warm-up completed
      isPlaying = false;
      ss("Warm-up completed! Great job!");
    }
  }

  void moveToPreviousExercise() {
    if (currentExerciseIndex > 0) {
      currentExerciseIndex--;
      currentTime = currentExercise["duration"];
      totalTime = currentExercise["duration"];
      stopTimer();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    currentTime = currentExercise["duration"];
    totalTime = currentExercise["duration"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Warm-Up Routine"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              // Show warm-up info
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Overall Progress
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Warm-Up Progress",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${currentExerciseIndex + 1} of ${warmUpExercises.length}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: overallProgress,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "${(overallProgress * 100).toInt()}% Complete",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${totalDuration - completedDuration}s remaining",
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
            
            SizedBox(height: spLg),
            
            // Current Exercise Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Exercise Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusXs),
                    child: Image.network(
                      "${currentExercise["image"]}",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Exercise Info
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentExercise["name"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXxs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: getDifficultyColor(currentExercise["difficulty"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXxs),
                                  ),
                                  child: Text(
                                    "${currentExercise["difficulty"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: getDifficultyColor(currentExercise["difficulty"]),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${currentExercise["reps"]}",
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
                      // Timer Circle
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor, width: 3),
                        ),
                        child: Center(
                          child: Text(
                            "$currentTime",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Exercise Description
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Instructions:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${currentExercise["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(Icons.lightbulb, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Tip:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXxs),
                        Text(
                          "${currentExercise["tips"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Control Buttons
            Row(
              children: [
                // Previous Button
                if (currentExerciseIndex > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      icon: Icons.skip_previous,
                      color: disabledBoldColor,
                      size: bs.md,
                      onPressed: moveToPreviousExercise,
                    ),
                  ),
                
                if (currentExerciseIndex > 0) SizedBox(width: spSm),
                
                // Play/Pause Button
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: !isPlaying 
                      ? "Start" 
                      : (isPaused ? "Resume" : "Pause"),
                    icon: !isPlaying 
                      ? Icons.play_arrow 
                      : (isPaused ? Icons.play_arrow : Icons.pause),
                    color: !isPlaying 
                      ? successColor
                      : (isPaused ? successColor : warningColor),
                    size: bs.md,
                    onPressed: () {
                      if (!isPlaying) {
                        startTimer();
                      } else if (isPaused) {
                        resumeTimer();
                      } else {
                        pauseTimer();
                      }
                    },
                  ),
                ),
                
                SizedBox(width: spSm),
                
                // Next/Skip Button
                Expanded(
                  child: QButton(
                    label: currentExerciseIndex < warmUpExercises.length - 1 
                      ? "Skip" 
                      : "Finish",
                    icon: currentExerciseIndex < warmUpExercises.length - 1 
                      ? Icons.skip_next 
                      : Icons.check,
                    color: infoColor,
                    size: bs.md,
                    onPressed: moveToNextExercise,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Exercise List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
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
                  
                  ...warmUpExercises.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> exercise = entry.value;
                    bool isCompleted = index < currentExerciseIndex;
                    bool isCurrent = index == currentExerciseIndex;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isCurrent 
                          ? primaryColor.withAlpha(10)
                          : (isCompleted ? successColor.withAlpha(10) : Colors.transparent),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(
                          color: isCurrent 
                            ? primaryColor
                            : (isCompleted ? successColor : disabledColor),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Status Icon
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isCompleted 
                                ? successColor
                                : (isCurrent ? primaryColor : disabledColor),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isCompleted 
                                ? Icons.check
                                : (isCurrent ? Icons.play_arrow : Icons.schedule),
                              color: Colors.white,
                              size: 16,
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isCurrent 
                                      ? primaryColor
                                      : (isCompleted ? successColor : disabledBoldColor),
                                  ),
                                ),
                                Text(
                                  "${exercise["duration"]}s • ${exercise["difficulty"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Duration
                          Text(
                            "${exercise["duration"]}s",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
