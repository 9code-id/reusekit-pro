import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaFitnessGoalsView extends StatefulWidget {
  const FwaFitnessGoalsView({super.key});

  @override
  State<FwaFitnessGoalsView> createState() => _FwaFitnessGoalsViewState();
}

class _FwaFitnessGoalsViewState extends State<FwaFitnessGoalsView> {
  String primaryGoal = "";
  String activityLevel = "";
  String targetWeight = "";
  String currentWeight = "";
  String height = "";
  String workoutDays = "";
  String preferredWorkoutTime = "";
  List<String> selectedGoals = [];
  List<String> selectedActivities = [];
  bool loading = false;

  List<Map<String, dynamic>> fitnessGoals = [
    {
      "id": "weight_loss",
      "title": "Weight Loss",
      "description": "Burn fat and lose weight",
      "icon": Icons.trending_down,
      "color": dangerColor,
    },
    {
      "id": "muscle_gain",
      "title": "Muscle Gain",
      "description": "Build lean muscle mass",
      "icon": Icons.fitness_center,
      "color": primaryColor,
    },
    {
      "id": "endurance",
      "title": "Endurance",
      "description": "Improve cardiovascular health",
      "icon": Icons.directions_run,
      "color": infoColor,
    },
    {
      "id": "strength",
      "title": "Strength Training",
      "description": "Increase overall strength",
      "icon": Icons.sports_gymnastics,
      "color": warningColor,
    },
    {
      "id": "flexibility",
      "title": "Flexibility",
      "description": "Improve mobility and flexibility",
      "icon": Icons.accessibility_new,
      "color": successColor,
    },
    {
      "id": "general_fitness",
      "title": "General Fitness",
      "description": "Overall health and wellness",
      "icon": Icons.favorite,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> activities = [
    {
      "id": "gym",
      "title": "Gym Workouts",
      "icon": Icons.fitness_center,
    },
    {
      "id": "running",
      "title": "Running",
      "icon": Icons.directions_run,
    },
    {
      "id": "cycling",
      "title": "Cycling",
      "icon": Icons.directions_bike,
    },
    {
      "id": "swimming",
      "title": "Swimming",
      "icon": Icons.pool,
    },
    {
      "id": "yoga",
      "title": "Yoga",
      "icon": Icons.self_improvement,
    },
    {
      "id": "sports",
      "title": "Sports",
      "icon": Icons.sports_soccer,
    },
    {
      "id": "dancing",
      "title": "Dancing",
      "icon": Icons.music_note,
    },
    {
      "id": "hiking",
      "title": "Hiking",
      "icon": Icons.terrain,
    },
  ];

  List<Map<String, dynamic>> activityLevels = [
    {"label": "Beginner - New to fitness", "value": "beginner"},
    {"label": "Intermediate - Some experience", "value": "intermediate"},
    {"label": "Advanced - Very experienced", "value": "advanced"},
  ];

  List<Map<String, dynamic>> workoutDaysOptions = [
    {"label": "2-3 days per week", "value": "2-3"},
    {"label": "4-5 days per week", "value": "4-5"},
    {"label": "6-7 days per week", "value": "6-7"},
  ];

  List<Map<String, dynamic>> workoutTimeOptions = [
    {"label": "Early Morning (5:00-8:00 AM)", "value": "early_morning"},
    {"label": "Morning (8:00-12:00 PM)", "value": "morning"},
    {"label": "Afternoon (12:00-5:00 PM)", "value": "afternoon"},
    {"label": "Evening (5:00-8:00 PM)", "value": "evening"},
    {"label": "Night (8:00-11:00 PM)", "value": "night"},
  ];

  Future<void> _handleSaveGoals() async {
    if (selectedGoals.isEmpty) {
      se("Please select at least one fitness goal");
      return;
    }

    if (activityLevel.isEmpty) {
      se("Please select your activity level");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Fitness goals saved successfully!");
    // navigateTo(FwaProgressTrackingView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Step 2 of 3",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(height: spLg),

              // Title Section
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXl),
                      ),
                      child: Icon(
                        Icons.track_changes,
                        color: primaryColor,
                        size: 48,
                      ),
                    ),

                    SizedBox(height: spMd),

                    Text(
                      "Your Fitness Goals",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    SizedBox(height: spSm),

                    Text(
                      "Let's create a personalized plan for your fitness journey",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spXl),

              // Fitness Goals Selection
              Text(
                "What are your primary fitness goals?",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              SizedBox(height: spMd),

              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: fitnessGoals.map((goal) {
                  bool isSelected = selectedGoals.contains(goal["id"]);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        selectedGoals.remove(goal["id"]);
                      } else {
                        selectedGoals.add(goal["id"]);
                      }
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? (goal["color"] as Color).withAlpha(25)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected 
                              ? goal["color"] as Color
                              : disabledOutlineBorderColor,
                          width: 2,
                        ),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            goal["icon"] as IconData,
                            color: goal["color"] as Color,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${goal["title"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${goal["description"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (isSelected) ...[
                            SizedBox(height: spSm),
                            Icon(
                              Icons.check_circle,
                              color: goal["color"] as Color,
                              size: 20,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: spLg),

              // Activity Level
              Text(
                "What's your current activity level?",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              SizedBox(height: spMd),

              QDropdownField(
                label: "Activity Level",
                items: activityLevels,
                value: activityLevel,
                onChanged: (value, label) {
                  activityLevel = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spLg),

              // Body Measurements
              Text(
                "Body Measurements (Optional)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              SizedBox(height: spMd),

              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Current Weight (kg)",
                      value: currentWeight,
                      onChanged: (value) {
                        currentWeight = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Target Weight (kg)",
                      value: targetWeight,
                      onChanged: (value) {
                        targetWeight = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: spMd),

              QNumberField(
                label: "Height (cm)",
                value: height,
                onChanged: (value) {
                  height = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spLg),

              // Workout Preferences
              Text(
                "Workout Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              SizedBox(height: spMd),

              QDropdownField(
                label: "Workout Days per Week",
                items: workoutDaysOptions,
                value: workoutDays,
                onChanged: (value, label) {
                  workoutDays = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spMd),

              QDropdownField(
                label: "Preferred Workout Time",
                items: workoutTimeOptions,
                value: preferredWorkoutTime,
                onChanged: (value, label) {
                  preferredWorkoutTime = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spLg),

              // Preferred Activities
              Text(
                "What activities do you enjoy?",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              SizedBox(height: spMd),

              Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: activities.map((activity) {
                  bool isSelected = selectedActivities.contains(activity["id"]);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        selectedActivities.remove(activity["id"]);
                      } else {
                        selectedActivities.add(activity["id"]);
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? primaryColor.withAlpha(25)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected 
                              ? primaryColor
                              : disabledOutlineBorderColor,
                        ),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            activity["icon"] as IconData,
                            color: isSelected ? primaryColor : disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${activity["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected ? primaryColor : disabledBoldColor,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: spXl),

              // Action Buttons
              Column(
                spacing: spSm,
                children: [
                  // Save Goals Button
                  Container(
                    width: double.infinity,
                    child: loading
                        ? Container(
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : QButton(
                            label: "Save & Continue",
                            size: bs.md,
                            onPressed: _handleSaveGoals,
                          ),
                  ),

                  // Skip Button
                  Container(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        // navigateTo(FwaProgressTrackingView());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Text(
                          "Skip for Now",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: spMd),

              // Progress Indicator
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Your goals help us create personalized workout plans and track your progress effectively.",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
