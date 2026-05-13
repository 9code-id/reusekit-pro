import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExercise6View extends StatefulWidget {
  const GrlExercise6View({super.key});

  @override
  State<GrlExercise6View> createState() => _GrlExercise6ViewState();
}

class _GrlExercise6ViewState extends State<GrlExercise6View> {
  String selectedExercise = "push_ups";
  int currentSet = 1;
  int currentRep = 0;
  bool isResting = false;
  int restTimeRemaining = 60;
  bool isTimerRunning = false;
  String workoutPhase = "warmup"; // warmup, exercise, cooldown

  List<Map<String, dynamic>> exercises = [
    {
      "id": "push_ups",
      "name": "Push-ups",
      "sets": 3,
      "reps": 15,
      "restTime": 60,
      "instructions": [
        "Start in a plank position with hands shoulder-width apart",
        "Lower your body until chest nearly touches the floor",
        "Push back up to starting position",
        "Keep your core tight throughout the movement"
      ],
      "targetMuscles": ["Chest", "Shoulders", "Triceps"],
      "difficulty": "Beginner",
      "calories": 45,
      "image": "https://picsum.photos/300/200?random=1&keyword=pushup",
    },
    {
      "id": "squats",
      "name": "Bodyweight Squats",
      "sets": 3,
      "reps": 20,
      "restTime": 45,
      "instructions": [
        "Stand with feet shoulder-width apart",
        "Lower your body as if sitting back into a chair",
        "Keep your chest up and knees behind toes",
        "Return to standing position"
      ],
      "targetMuscles": ["Quadriceps", "Glutes", "Hamstrings"],
      "difficulty": "Beginner",
      "calories": 38,
      "image": "https://picsum.photos/300/200?random=2&keyword=squat",
    },
    {
      "id": "plank",
      "name": "Plank Hold",
      "sets": 3,
      "reps": 30,
      "restTime": 60,
      "instructions": [
        "Start in a push-up position",
        "Lower onto your forearms",
        "Keep your body in a straight line",
        "Hold the position for specified time"
      ],
      "targetMuscles": ["Core", "Shoulders", "Glutes"],
      "difficulty": "Intermediate",
      "calories": 32,
      "image": "https://picsum.photos/300/200?random=3&keyword=plank",
    },
    {
      "id": "burpees",
      "name": "Burpees",
      "sets": 3,
      "reps": 10,
      "restTime": 90,
      "instructions": [
        "Start in standing position",
        "Drop into a squat, then jump back into plank",
        "Do a push-up, then jump feet back to squat",
        "Explode up with arms overhead"
      ],
      "targetMuscles": ["Full Body"],
      "difficulty": "Advanced",
      "calories": 68,
      "image": "https://picsum.photos/300/200?random=4&keyword=burpee",
    },
  ];

  List<Map<String, dynamic>> workoutHistory = [
    {
      "date": "Today",
      "exercise": "Push-ups",
      "sets": 3,
      "reps": 45,
      "duration": "12 min",
      "calories": 135,
    },
    {
      "date": "Yesterday",
      "exercise": "Squats",
      "sets": 3,
      "reps": 60,
      "duration": "15 min",
      "calories": 114,
    },
    {
      "date": "2 days ago",
      "exercise": "Plank",
      "sets": 3,
      "reps": 90,
      "duration": "8 min",
      "calories": 96,
    },
  ];

  Map<String, dynamic> get currentExercise => 
      exercises.firstWhere((e) => e["id"] == selectedExercise);

  void _startTimer() {
    isTimerRunning = true;
    setState(() {});
    
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isTimerRunning) {
        timer.cancel();
        return;
      }
      
      if (restTimeRemaining > 0) {
        restTimeRemaining--;
        setState(() {});
      } else {
        timer.cancel();
        isResting = false;
        isTimerRunning = false;
        restTimeRemaining = (currentExercise["restTime"] as int);
        setState(() {});
        ss("Rest complete! Ready for next set");
      }
    });
  }

  void _completeSet() {
    if (currentSet < (currentExercise["sets"] as int)) {
      currentSet++;
      isResting = true;
      restTimeRemaining = (currentExercise["restTime"] as int);
      _startTimer();
      ss("Set completed! Take a rest");
    } else {
      currentSet = 1;
      ss("Exercise completed! Great job!");
    }
    setState(() {});
  }

  void _skipRest() {
    isResting = false;
    isTimerRunning = false;
    restTimeRemaining = (currentExercise["restTime"] as int);
    setState(() {});
  }

  void _resetExercise() {
    currentSet = 1;
    currentRep = 0;
    isResting = false;
    isTimerRunning = false;
    restTimeRemaining = (currentExercise["restTime"] as int);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise Guide"),
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
            // Exercise Selection
            Text(
              "Select Exercise",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              height: 120,
              child: QHorizontalScroll(
                children: exercises.map((exercise) {
                  bool isSelected = selectedExercise == exercise["id"];
                  Color difficultyColor = exercise["difficulty"] == "Beginner" 
                      ? successColor
                      : exercise["difficulty"] == "Intermediate" 
                          ? warningColor 
                          : dangerColor;
                  
                  return GestureDetector(
                    onTap: () {
                      selectedExercise = exercise["id"];
                      _resetExercise();
                    },
                    child: Container(
                      width: 180,
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(25) : Colors.white,
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: difficultyColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${exercise["difficulty"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: difficultyColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Spacer(),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: primaryColor,
                                  size: 16,
                                ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${exercise["name"]}",
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
                            "${exercise["sets"]} sets • ${exercise["reps"]} reps",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${exercise["calories"]} calories",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Current Exercise Display
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Exercise Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "${currentExercise["image"]}",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: spMd),

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
                            SizedBox(height: spXs),
                            Text(
                              "Set $currentSet of ${currentExercise["sets"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${currentExercise["reps"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Target Reps",
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

                  SizedBox(height: spMd),

                  // Target Muscles
                  Row(
                    children: [
                      Icon(
                        Icons.fitness_center,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Target: ",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (currentExercise["targetMuscles"] as List).join(", "),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Rest Timer (if resting)
            if (isResting)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: warningColor),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Rest Time",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${restTimeRemaining}s",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    LinearProgressIndicator(
                      value: 1 - (restTimeRemaining / (currentExercise["restTime"] as int)),
                      backgroundColor: warningColor.withAlpha(50),
                      valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                      minHeight: 6,
                    ),
                    SizedBox(width: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Skip Rest",
                            size: bs.sm,
                            onPressed: _skipRest,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Exercise Instructions
            Text(
              "How to Perform",
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
                spacing: spSm,
                children: (currentExercise["instructions"] as List).asMap().entries.map((entry) {
                  int index = entry.key;
                  String instruction = entry.value;
                  
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Text(
                          instruction,
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            // Action Buttons
            if (!isResting)
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Complete Set",
                      onPressed: _completeSet,
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.refresh,
                    size: bs.sm,
                    onPressed: _resetExercise,
                  ),
                ],
              ),

            // Exercise Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.local_fire_department,
                    title: "Calories",
                    value: "${currentExercise["calories"]}",
                    color: dangerColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.timer,
                    title: "Rest Time",
                    value: "${currentExercise["restTime"]}s",
                    color: warningColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.trending_up,
                    title: "Difficulty",
                    value: "${currentExercise["difficulty"]}",
                    color: currentExercise["difficulty"] == "Beginner" 
                        ? successColor
                        : currentExercise["difficulty"] == "Intermediate" 
                            ? warningColor 
                            : dangerColor,
                  ),
                ),
              ],
            ),

            // Workout History
            Text(
              "Recent Workouts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: workoutHistory.map((workout) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${workout["exercise"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${workout["sets"]} sets • ${workout["reps"]} total reps",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${workout["date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${workout["duration"]} • ${workout["calories"]} cal",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
            size: 20,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
