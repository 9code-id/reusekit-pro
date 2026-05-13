import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHealth7View extends StatefulWidget {
  @override
  State<GrlHealth7View> createState() => _GrlHealth7ViewState();
}

class _GrlHealth7ViewState extends State<GrlHealth7View> {
  int currentStep = 0;
  String selectedGoal = "";
  String activityLevel = "";
  String dietaryPreference = "";
  String healthCondition = "";
  String targetWeight = "";
  String currentWeight = "";
  String height = "";
  String age = "";
  String gender = "";
  List<String> preferredActivities = [];
  List<String> availableDays = [];
  String workoutDuration = "";
  String experience = "";

  List<Map<String, dynamic>> fitnessGoals = [
    {
      "id": "weight_loss",
      "title": "Weight Loss",
      "description": "Burn calories and reduce body weight",
      "icon": Icons.trending_down,
      "color": Colors.red
    },
    {
      "id": "muscle_gain",
      "title": "Muscle Gain",
      "description": "Build strength and muscle mass",
      "icon": Icons.fitness_center,
      "color": Colors.blue
    },
    {
      "id": "endurance",
      "title": "Endurance",
      "description": "Improve cardiovascular fitness",
      "icon": Icons.directions_run,
      "color": Colors.green
    },
    {
      "id": "flexibility",
      "title": "Flexibility",
      "description": "Enhance mobility and flexibility",
      "icon": Icons.self_improvement,
      "color": Colors.purple
    },
    {
      "id": "general_health",
      "title": "General Health",
      "description": "Overall wellness and health",
      "icon": Icons.health_and_safety,
      "color": Colors.orange
    }
  ];

  List<Map<String, dynamic>> activities = [
    {"id": "running", "name": "Running", "icon": Icons.directions_run},
    {"id": "cycling", "name": "Cycling", "icon": Icons.directions_bike},
    {"id": "swimming", "name": "Swimming", "icon": Icons.pool},
    {"id": "weightlifting", "name": "Weight Lifting", "icon": Icons.fitness_center},
    {"id": "yoga", "name": "Yoga", "icon": Icons.self_improvement},
    {"id": "pilates", "name": "Pilates", "icon": Icons.accessibility},
    {"id": "dancing", "name": "Dancing", "icon": Icons.music_note},
    {"id": "hiking", "name": "Hiking", "icon": Icons.terrain},
  ];

  List<Map<String, dynamic>> experienceLevels = [
    {"label": "Beginner", "value": "beginner"},
    {"label": "Intermediate", "value": "intermediate"},
    {"label": "Advanced", "value": "advanced"},
  ];

  List<Map<String, dynamic>> activityLevels = [
    {"label": "Sedentary", "value": "sedentary"},
    {"label": "Lightly Active", "value": "light"},
    {"label": "Moderately Active", "value": "moderate"},
    {"label": "Very Active", "value": "very_active"},
    {"label": "Extremely Active", "value": "extreme"},
  ];

  List<Map<String, dynamic>> dietPreferences = [
    {"label": "No Restrictions", "value": "none"},
    {"label": "Vegetarian", "value": "vegetarian"},
    {"label": "Vegan", "value": "vegan"},
    {"label": "Keto", "value": "keto"},
    {"label": "Mediterranean", "value": "mediterranean"},
    {"label": "Low Carb", "value": "low_carb"},
  ];

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
  ];

  List<String> weekDays = [
    "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness Assessment"),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Step ${currentStep + 1} of 5",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${((currentStep + 1) / 5 * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: (currentStep + 1) / 5,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          ),

          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildStepContent(),
            ),
          ),

          // Navigation Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      size: bs.md,
                      onPressed: () {
                        if (currentStep > 0) {
                          currentStep--;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: currentStep == 4 ? "Generate Plan" : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentStep == 4) {
                        _generatePlan();
                      } else {
                        if (_validateStep()) {
                          currentStep++;
                          setState(() {});
                        }
                      }
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

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildGoalSelection();
      case 1:
        return _buildBasicInfo();
      case 2:
        return _buildActivityPreferences();
      case 3:
        return _buildSchedule();
      case 4:
        return _buildHealthInfo();
      default:
        return Container();
    }
  }

  Widget _buildGoalSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "What's Your Fitness Goal?",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Select your primary fitness goal to get a personalized plan.",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        ...fitnessGoals.map((goal) {
          bool isSelected = selectedGoal == goal["id"];
          return GestureDetector(
            onTap: () {
              selectedGoal = goal["id"];
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: isSelected ? (goal["color"] as Color).withAlpha(50) : Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: isSelected ? goal["color"] as Color : disabledOutlineBorderColor,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (goal["color"] as Color).withAlpha(100),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      goal["icon"] as IconData,
                      color: goal["color"] as Color,
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
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${goal["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: goal["color"] as Color,
                      size: 24,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Basic Information",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Help us understand your current physical condition.",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QNumberField(
                label: "Age",
                value: age,
                hint: "Enter your age",
                onChanged: (value) {
                  age = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Gender",
                items: genderOptions,
                value: gender,
                onChanged: (value, label) {
                  gender = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QNumberField(
                label: "Height (cm)",
                value: height,
                hint: "Enter height in cm",
                onChanged: (value) {
                  height = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QNumberField(
                label: "Current Weight (kg)",
                value: currentWeight,
                hint: "Enter current weight",
                onChanged: (value) {
                  currentWeight = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        if (selectedGoal == "weight_loss")
          QNumberField(
            label: "Target Weight (kg)",
            value: targetWeight,
            hint: "Enter your target weight",
            onChanged: (value) {
              targetWeight = value;
              setState(() {});
            },
          ),
        QDropdownField(
          label: "Current Activity Level",
          items: activityLevels,
          value: activityLevel,
          onChanged: (value, label) {
            activityLevel = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildActivityPreferences() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Activity Preferences",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Select activities you enjoy or want to try.",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),
        QDropdownField(
          label: "Experience Level",
          items: experienceLevels,
          value: experience,
          onChanged: (value, label) {
            experience = value;
            setState(() {});
          },
        ),
        Text(
          "Preferred Activities (Select multiple):",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: activities.map((activity) {
            bool isSelected = preferredActivities.contains(activity["id"]);
            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  preferredActivities.remove(activity["id"]);
                } else {
                  preferredActivities.add(activity["id"]);
                }
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(50) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      activity["icon"] as IconData,
                      color: isSelected ? primaryColor : disabledBoldColor,
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${activity["name"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    if (isSelected)
                      Container(
                        margin: EdgeInsets.only(top: spXs),
                        child: Icon(
                          Icons.check_circle,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Workout Schedule",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "When are you available to work out?",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),
        QDropdownField(
          label: "Preferred Workout Duration",
          items: [
            {"label": "15-30 minutes", "value": "short"},
            {"label": "30-45 minutes", "value": "medium"},
            {"label": "45-60 minutes", "value": "long"},
            {"label": "60+ minutes", "value": "extended"},
          ],
          value: workoutDuration,
          onChanged: (value, label) {
            workoutDuration = value;
            setState(() {});
          },
        ),
        Text(
          "Available Days (Select multiple):",
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
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            spacing: spSm,
            children: weekDays.map((day) {
              bool isSelected = availableDays.contains(day);
              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    availableDays.remove(day);
                  } else {
                    availableDays.add(day);
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(50) : Colors.transparent,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        day,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildHealthInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Health Information",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "Final details to customize your fitness plan.",
          style: TextStyle(
            fontSize: 16,
            color: disabledBoldColor,
          ),
        ),
        QDropdownField(
          label: "Dietary Preference",
          items: dietPreferences,
          value: dietaryPreference,
          onChanged: (value, label) {
            dietaryPreference = value;
            setState(() {});
          },
        ),
        QMemoField(
          label: "Health Conditions or Injuries",
          value: healthCondition,
          hint: "List any health conditions, injuries, or physical limitations",
          onChanged: (value) {
            healthCondition = value;
            setState(() {});
          },
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(Icons.info, color: Colors.blue, size: 20),
                  SizedBox(width: spSm),
                  Text(
                    "Assessment Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
              Text(
                "• Goal: ${fitnessGoals.firstWhere((g) => g["id"] == selectedGoal, orElse: () => {"title": "Not selected"})["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue.shade700,
                ),
              ),
              Text(
                "• Experience: ${experience.isNotEmpty ? experienceLevels.firstWhere((e) => e["value"] == experience)["label"] : "Not selected"}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue.shade700,
                ),
              ),
              Text(
                "• Preferred Activities: ${preferredActivities.length} selected",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue.shade700,
                ),
              ),
              Text(
                "• Available Days: ${availableDays.length} days per week",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _validateStep() {
    switch (currentStep) {
      case 0:
        if (selectedGoal.isEmpty) {
          se("Please select a fitness goal");
          return false;
        }
        break;
      case 1:
        if (age.isEmpty || gender.isEmpty || height.isEmpty || currentWeight.isEmpty || activityLevel.isEmpty) {
          se("Please fill in all basic information");
          return false;
        }
        break;
      case 2:
        if (experience.isEmpty || preferredActivities.isEmpty) {
          se("Please select your experience level and at least one activity");
          return false;
        }
        break;
      case 3:
        if (workoutDuration.isEmpty || availableDays.isEmpty) {
          se("Please select workout duration and available days");
          return false;
        }
        break;
    }
    return true;
  }

  void _generatePlan() {
    if (dietaryPreference.isEmpty) {
      se("Please select your dietary preference");
      return;
    }
    
    showLoading();
    
    // Simulate plan generation
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Your personalized fitness plan has been generated!");
    });
  }
}
