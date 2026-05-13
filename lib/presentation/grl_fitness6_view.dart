import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFitness6View extends StatefulWidget {
  @override
  State<GrlFitness6View> createState() => _GrlFitness6ViewState();
}

class _GrlFitness6ViewState extends State<GrlFitness6View> {
  bool isResting = false;
  int currentExercise = 0;
  int currentSet = 1;
  int restTime = 30;
  int exerciseTime = 45;
  bool isPlaying = false;

  List<Map<String, dynamic>> workoutExercises = [
    {
      "name": "Jumping Jacks",
      "duration": 45,
      "rest": 15,
      "sets": 3,
      "calories": 8,
      "image": "https://picsum.photos/300/200?random=1&keyword=jumping",
      "instructions": [
        "Stand with feet together, arms at sides",
        "Jump while spreading legs shoulder-width apart",
        "Simultaneously raise arms overhead",
        "Jump back to starting position"
      ]
    },
    {
      "name": "Push-ups",
      "duration": 30,
      "rest": 20,
      "sets": 3,
      "calories": 6,
      "image": "https://picsum.photos/300/200?random=2&keyword=pushup",
      "instructions": [
        "Start in plank position",
        "Lower body until chest nearly touches floor",
        "Push back up to starting position",
        "Keep body straight throughout"
      ]
    },
    {
      "name": "Mountain Climbers",
      "duration": 40,
      "rest": 15,
      "sets": 3,
      "calories": 10,
      "image": "https://picsum.photos/300/200?random=3&keyword=mountain",
      "instructions": [
        "Start in plank position",
        "Bring right knee toward chest",
        "Quickly switch legs",
        "Continue alternating at rapid pace"
      ]
    },
    {
      "name": "Squats",
      "duration": 35,
      "rest": 20,
      "sets": 3,
      "calories": 7,
      "image": "https://picsum.photos/300/200?random=4&keyword=squat",
      "instructions": [
        "Stand with feet shoulder-width apart",
        "Lower body as if sitting back into chair",
        "Keep knees behind toes",
        "Return to standing position"
      ]
    },
    {
      "name": "Burpees",
      "duration": 30,
      "rest": 25,
      "sets": 3,
      "calories": 12,
      "image": "https://picsum.photos/300/200?random=5&keyword=burpee",
      "instructions": [
        "Start in standing position",
        "Drop into squat, place hands on floor",
        "Jump feet back into plank",
        "Jump feet back to squat, then jump up"
      ]
    },
    {
      "name": "Plank",
      "duration": 60,
      "rest": 15,
      "sets": 2,
      "calories": 5,
      "image": "https://picsum.photos/300/200?random=6&keyword=plank",
      "instructions": [
        "Start in push-up position",
        "Hold body straight as a board",
        "Keep core engaged",
        "Don't let hips sag or pike up"
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final exercise = workoutExercises[currentExercise];
    final totalExercises = workoutExercises.length;
    final progress = (currentExercise + 1) / totalExercises;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("HIIT Workout"),
        actions: [
          IconButton(
            icon: Icon(Icons.pause),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Exercise ${currentExercise + 1}/$totalExercises",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Set $currentSet/${exercise["sets"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isResting ? warningColor : primaryColor,
                        width: 8,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isResting ? "REST" : "WORK",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            isResting ? "$restTime" : "$exerciseTime",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "seconds",
                            style: TextStyle(
                              color: Colors.white.withAlpha(180),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: spLg),
                  Text(
                    "${exercise["name"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${exercise["calories"]} cal/min",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isResting) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "${exercise["image"]}",
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Instructions:",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...List.generate(
                          (exercise["instructions"] as List).length,
                          (index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${(exercise["instructions"] as List)[index]}",
                                      style: TextStyle(
                                        color: Colors.white.withAlpha(200),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    child: QButton(
                      label: isPlaying ? "PAUSE" : "START",
                      size: bs.md,
                      onPressed: () {
                        isPlaying = !isPlaying;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.skip_next, color: Colors.white, size: 24),
                    onPressed: () {
                      if (currentExercise < totalExercises - 1) {
                        currentExercise++;
                        setState(() {});
                      }
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.refresh, color: Colors.white, size: 24),
                    onPressed: () {
                      currentSet = 1;
                      currentExercise = 0;
                      isResting = false;
                      isPlaying = false;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
