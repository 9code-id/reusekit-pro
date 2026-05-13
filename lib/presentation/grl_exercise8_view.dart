import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExercise8View extends StatefulWidget {
  const GrlExercise8View({super.key});

  @override
  State<GrlExercise8View> createState() => _GrlExercise8ViewState();
}

class _GrlExercise8ViewState extends State<GrlExercise8View> {
  String selectedGoal = "weight_loss";
  List<String> availableEquipment = [];
  List<String> selectedMuscleGroups = [];
  String fitnessLevel = "beginner";
  String workoutFrequency = "3_times";
  String sessionDuration = "30_45";
  String preferredTime = "morning";
  
  List<Map<String, dynamic>> fitnessGoals = [
    {
      "id": "weight_loss",
      "title": "Weight Loss",
      "description": "Burn calories and lose body fat",
      "icon": Icons.trending_down,
      "color": dangerColor,
      "focus": "Cardio + Strength",
    },
    {
      "id": "muscle_gain",
      "title": "Muscle Building",
      "description": "Build strength and muscle mass",
      "icon": Icons.fitness_center,
      "color": primaryColor,
      "focus": "Strength Training",
    },
    {
      "id": "endurance",
      "title": "Endurance",
      "description": "Improve cardiovascular fitness",
      "icon": Icons.directions_run,
      "color": successColor,
      "focus": "Cardio Focused",
    },
    {
      "id": "flexibility",
      "title": "Flexibility",
      "description": "Increase mobility and flexibility",
      "icon": Icons.self_improvement,
      "color": warningColor,
      "focus": "Yoga + Stretching",
    },
    {
      "id": "general_fitness",
      "title": "General Fitness",
      "description": "Overall health and wellness",
      "icon": Icons.health_and_safety,
      "color": infoColor,
      "focus": "Balanced Mix",
    },
  ];

  List<Map<String, dynamic>> equipmentOptions = [
    {"label": "Dumbbells", "value": "dumbbells", "checked": false},
    {"label": "Resistance Bands", "value": "resistance_bands", "checked": false},
    {"label": "Kettlebells", "value": "kettlebells", "checked": false},
    {"label": "Barbell", "value": "barbell", "checked": false},
    {"label": "Pull-up Bar", "value": "pullup_bar", "checked": false},
    {"label": "Yoga Mat", "value": "yoga_mat", "checked": false},
    {"label": "Bench", "value": "bench", "checked": false},
    {"label": "Treadmill", "value": "treadmill", "checked": false},
  ];

  List<Map<String, dynamic>> muscleGroups = [
    {"label": "Chest", "value": "chest", "checked": false},
    {"label": "Back", "value": "back", "checked": false},
    {"label": "Shoulders", "value": "shoulders", "checked": false},
    {"label": "Arms", "value": "arms", "checked": false},
    {"label": "Core", "value": "core", "checked": false},
    {"label": "Legs", "value": "legs", "checked": false},
    {"label": "Glutes", "value": "glutes", "checked": false},
    {"label": "Full Body", "value": "full_body", "checked": false},
  ];

  List<Map<String, dynamic>> fitnessLevels = [
    {"label": "Beginner (0-6 months)", "value": "beginner"},
    {"label": "Intermediate (6-24 months)", "value": "intermediate"},
    {"label": "Advanced (2+ years)", "value": "advanced"},
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "2 times per week", "value": "2_times"},
    {"label": "3 times per week", "value": "3_times"},
    {"label": "4 times per week", "value": "4_times"},
    {"label": "5+ times per week", "value": "5_times"},
  ];

  List<Map<String, dynamic>> durationOptions = [
    {"label": "15-30 minutes", "value": "15_30"},
    {"label": "30-45 minutes", "value": "30_45"},
    {"label": "45-60 minutes", "value": "45_60"},
    {"label": "60+ minutes", "value": "60_plus"},
  ];

  List<Map<String, dynamic>> timeOptions = [
    {"label": "Early Morning (6-8 AM)", "value": "morning"},
    {"label": "Mid Morning (8-10 AM)", "value": "mid_morning"},
    {"label": "Afternoon (12-2 PM)", "value": "afternoon"},
    {"label": "Evening (5-7 PM)", "value": "evening"},
    {"label": "Night (7-9 PM)", "value": "night"},
  ];

  List<Map<String, dynamic>> generatedPrograms = [];

  void _generateProgram() {
    showLoading();
    
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      
      // Simulate program generation
      generatedPrograms = [
        {
          "name": "Beginner Fat Burn Program",
          "duration": "4 weeks",
          "workoutsPerWeek": 3,
          "avgDuration": 35,
          "difficulty": "Beginner",
          "focus": "Weight Loss",
          "exercises": [
            "Bodyweight Squats",
            "Push-ups",
            "Mountain Climbers",
            "Plank",
            "Jumping Jacks"
          ],
          "equipment": ["None required"],
          "estimatedCalories": 280,
        },
        {
          "name": "Strength Foundation",
          "duration": "6 weeks",
          "workoutsPerWeek": 3,
          "avgDuration": 45,
          "difficulty": "Beginner",
          "focus": "Muscle Building",
          "exercises": [
            "Dumbbell Chest Press",
            "Bent-over Rows",
            "Squats",
            "Shoulder Press",
            "Bicep Curls"
          ],
          "equipment": ["Dumbbells", "Bench"],
          "estimatedCalories": 320,
        },
      ];
      
      setState(() {});
      ss("Custom workout program generated successfully!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Program Generator"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
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
            // Header Section
            Container(
              width: double.infinity,
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
                  Icon(
                    Icons.auto_awesome,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Custom Program Generator",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Create a personalized workout program based on your goals, equipment, and preferences",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                ],
              ),
            ),

            // Fitness Goals Selection
            Text(
              "Primary Fitness Goal",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: fitnessGoals.map((goal) {
                bool isSelected = selectedGoal == goal["id"];
                return GestureDetector(
                  onTap: () {
                    selectedGoal = goal["id"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? (goal["color"] as Color).withAlpha(25) : Colors.white,
                      border: Border.all(
                        color: isSelected ? (goal["color"] as Color) : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [if (isSelected) shadowMd else shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (goal["color"] as Color).withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            goal["icon"],
                            color: goal["color"],
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${goal["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${goal["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: (goal["color"] as Color).withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${goal["focus"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: goal["color"],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: goal["color"],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Personal Information
            Text(
              "Personal Information",
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
                spacing: spMd,
                children: [
                  QDropdownField(
                    label: "Fitness Level",
                    items: fitnessLevels,
                    value: fitnessLevel,
                    onChanged: (value, label) {
                      fitnessLevel = value;
                      setState(() {});
                    },
                  ),

                  QDropdownField(
                    label: "Workout Frequency",
                    items: frequencyOptions,
                    value: workoutFrequency,
                    onChanged: (value, label) {
                      workoutFrequency = value;
                      setState(() {});
                    },
                  ),

                  QDropdownField(
                    label: "Session Duration",
                    items: durationOptions,
                    value: sessionDuration,
                    onChanged: (value, label) {
                      sessionDuration = value;
                      setState(() {});
                    },
                  ),

                  QDropdownField(
                    label: "Preferred Time",
                    items: timeOptions,
                    value: preferredTime,
                    onChanged: (value, label) {
                      preferredTime = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Available Equipment
            Text(
              "Available Equipment",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QSwitch(
              items: equipmentOptions,
              value: equipmentOptions.where((item) => item["checked"]).toList(),
              onChanged: (values, ids) {
                for (var item in equipmentOptions) {
                  item["checked"] = values.any((v) => v["value"] == item["value"]);
                }
                availableEquipment = values.map((v) => v["value"] as String).toList();
                setState(() {});
              },
            ),

            // Target Muscle Groups
            Text(
              "Target Muscle Groups",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QSwitch(
              items: muscleGroups,
              value: muscleGroups.where((item) => item["checked"]).toList(),
              onChanged: (values, ids) {
                for (var item in muscleGroups) {
                  item["checked"] = values.any((v) => v["value"] == item["value"]);
                }
                selectedMuscleGroups = values.map((v) => v["value"] as String).toList();
                setState(() {});
              },
            ),

            // Program Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.insights,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Program Summary",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryItem(
                          "Goal",
                          fitnessGoals.firstWhere((g) => g["id"] == selectedGoal)["title"],
                        ),
                      ),
                      Expanded(
                        child: _buildSummaryItem(
                          "Level",
                          fitnessLevel.toUpperCase(),
                        ),
                      ),
                      Expanded(
                        child: _buildSummaryItem(
                          "Equipment",
                          "${availableEquipment.length} items",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryItem(
                          "Frequency",
                          workoutFrequency.replaceAll("_", " "),
                        ),
                      ),
                      Expanded(
                        child: _buildSummaryItem(
                          "Duration",
                          sessionDuration.replaceAll("_", "-") + " min",
                        ),
                      ),
                      Expanded(
                        child: _buildSummaryItem(
                          "Muscles",
                          "${selectedMuscleGroups.length} groups",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Generate Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Generate My Program",
                onPressed: _generateProgram,
              ),
            ),

            // Generated Programs
            if (generatedPrograms.isNotEmpty) ...[
              Text(
                "Generated Programs",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Column(
                spacing: spMd,
                children: generatedPrograms.map((program) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                      border: Border.all(color: successColor, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${program["name"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${program["duration"]} • ${program["workoutsPerWeek"]} workouts/week",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "RECOMMENDED",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: spMd),

                        // Program Stats
                        Row(
                          children: [
                            Expanded(
                              child: _buildProgramStat(
                                icon: Icons.timer,
                                label: "Avg Duration",
                                value: "${program["avgDuration"]} min",
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: _buildProgramStat(
                                icon: Icons.local_fire_department,
                                label: "Est. Calories",
                                value: "${program["estimatedCalories"]}",
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: _buildProgramStat(
                                icon: Icons.trending_up,
                                label: "Difficulty",
                                value: "${program["difficulty"]}",
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: spMd),

                        // Sample Exercises
                        Text(
                          "Sample Exercises:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Wrap(
                          spacing: spSm,
                          runSpacing: spXs,
                          children: (program["exercises"] as List).map((exercise) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                exercise,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        SizedBox(height: spMd),

                        // Equipment Required
                        Row(
                          children: [
                            Icon(
                              Icons.fitness_center,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Equipment: ",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                (program["equipment"] as List).join(", "),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: spMd),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Start Program",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Program started! Good luck with your fitness journey!");
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.share,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgramStat({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 16,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
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
