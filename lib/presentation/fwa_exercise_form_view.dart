import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaExerciseFormView extends StatefulWidget {
  const FwaExerciseFormView({super.key});

  @override
  State<FwaExerciseFormView> createState() => _FwaExerciseFormViewState();
}

class _FwaExerciseFormViewState extends State<FwaExerciseFormView> {
  String exerciseName = "";
  String exerciseCategory = "Strength";
  String muscleGroup = "Chest";
  String difficulty = "Beginner";
  String equipment = "Bodyweight";
  String duration = "30";
  String sets = "3";
  String reps = "12";
  String restTime = "60";
  String caloriesBurned = "50";
  String instructions = "";
  String tips = "";
  List<String> exerciseImages = [];
  
  List<Map<String, dynamic>> categories = [
    {"label": "Strength", "value": "Strength"},
    {"label": "Cardio", "value": "Cardio"},
    {"label": "Flexibility", "value": "Flexibility"},
    {"label": "Balance", "value": "Balance"},
    {"label": "HIIT", "value": "HIIT"},
    {"label": "Yoga", "value": "Yoga"},
  ];
  
  List<Map<String, dynamic>> muscleGroups = [
    {"label": "Chest", "value": "Chest"},
    {"label": "Back", "value": "Back"},
    {"label": "Shoulders", "value": "Shoulders"},
    {"label": "Arms", "value": "Arms"},
    {"label": "Legs", "value": "Legs"},
    {"label": "Core", "value": "Core"},
    {"label": "Full Body", "value": "Full Body"},
  ];
  
  List<Map<String, dynamic>> difficultyLevels = [
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
  ];
  
  List<Map<String, dynamic>> equipmentTypes = [
    {"label": "Bodyweight", "value": "Bodyweight"},
    {"label": "Dumbbells", "value": "Dumbbells"},
    {"label": "Barbell", "value": "Barbell"},
    {"label": "Kettlebell", "value": "Kettlebell"},
    {"label": "Resistance Bands", "value": "Resistance Bands"},
    {"label": "Cable Machine", "value": "Cable Machine"},
    {"label": "Machine", "value": "Machine"},
  ];

  final formKey = GlobalKey<FormState>();

  Widget _buildBasicInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Exercise Name",
            value: exerciseName,
            hint: "e.g., Push Ups, Squats, Bench Press",
            validator: Validator.required,
            onChanged: (value) {
              exerciseName = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories,
                  value: exerciseCategory,
                  onChanged: (value, label) {
                    exerciseCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Muscle Group",
                  items: muscleGroups,
                  value: muscleGroup,
                  onChanged: (value, label) {
                    muscleGroup = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Difficulty",
                  items: difficultyLevels,
                  value: difficulty,
                  onChanged: (value, label) {
                    difficulty = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Equipment",
                  items: equipmentTypes,
                  value: equipment,
                  onChanged: (value, label) {
                    equipment = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutDetails() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Workout Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Duration (minutes)",
                  value: duration,
                  validator: Validator.required,
                  onChanged: (value) {
                    duration = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Calories Burned",
                  value: caloriesBurned,
                  validator: Validator.required,
                  onChanged: (value) {
                    caloriesBurned = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          if (exerciseCategory == "Strength") ...[
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QNumberField(
                    label: "Sets",
                    value: sets,
                    validator: Validator.required,
                    onChanged: (value) {
                      sets = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QNumberField(
                    label: "Reps",
                    value: reps,
                    validator: Validator.required,
                    onChanged: (value) {
                      reps = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QNumberField(
                    label: "Rest (seconds)",
                    value: restTime,
                    validator: Validator.required,
                    onChanged: (value) {
                      restTime = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
          
          SizedBox(height: spSm),
          
          // Visual preview of workout stats
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.timer, color: primaryColor, size: 20),
                      SizedBox(height: 4),
                      Text(
                        "$duration min",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Duration",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (exerciseCategory == "Strength") ...[
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.repeat, color: primaryColor, size: 20),
                        SizedBox(height: 4),
                        Text(
                          "${sets}x$reps",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Sets x Reps",
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.local_fire_department, color: primaryColor, size: 20),
                      SizedBox(height: 4),
                      Text(
                        "$caloriesBurned cal",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Calories",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Instructions & Media",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          QMemoField(
            label: "Exercise Instructions",
            value: instructions,
            hint: "Describe step-by-step how to perform this exercise correctly...",
            validator: Validator.required,
            onChanged: (value) {
              instructions = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QMemoField(
            label: "Tips & Form Notes",
            value: tips,
            hint: "Add helpful tips for proper form and safety...",
            onChanged: (value) {
              tips = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QMultiImagePicker(
            label: "Exercise Images/Videos",
            value: exerciseImages,
            maxImages: 5,
            hint: "Add demonstration images or videos",
            helper: "Upload clear images showing proper form and technique",
            onChanged: (value) {
              exerciseImages = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyIndicator() {
    List<Color> colors = [successColor, warningColor, dangerColor];
    int level = difficultyLevels.indexWhere((d) => d["value"] == difficulty);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Difficulty Level",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: List.generate(3, (index) {
              bool isActive = index <= level;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < 2 ? spXs : 0),
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive ? colors[level] : disabledOutlineBorderColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
              );
            }),
          ),
          
          SizedBox(height: spXs),
          
          Center(
            child: Text(
              difficulty,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors[level],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Exercise"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ss("Exercise created successfully!");
                back();
              }
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildBasicInfo(),
              _buildDifficultyIndicator(),
              _buildWorkoutDetails(),
              _buildInstructions(),
              
              // Save button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Exercise",
                  size: bs.md,
                  icon: Icons.add,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ss("Exercise created successfully!");
                      back();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
