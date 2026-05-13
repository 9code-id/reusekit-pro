import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaWorkoutPlanView extends StatefulWidget {
  const HcaWorkoutPlanView({super.key});

  @override
  State<HcaWorkoutPlanView> createState() => _HcaWorkoutPlanViewState();
}

class _HcaWorkoutPlanViewState extends State<HcaWorkoutPlanView> {
  int currentTab = 0;
  String selectedDay = "Monday";
  List<String> weekDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

  List<Map<String, dynamic>> workoutPlans = [
    {
      "id": 1,
      "name": "Full Body Strength",
      "duration": "45 min",
      "difficulty": "Intermediate",
      "equipment": "Gym",
      "calories": 350,
      "exercises": 8,
      "isActive": true,
      "image": "https://picsum.photos/400/200?random=1&keyword=gym-workout",
      "days": ["Monday", "Wednesday", "Friday"],
      "description": "Complete full body strength training workout focusing on compound movements."
    },
    {
      "id": 2,
      "name": "Cardio HIIT",
      "duration": "30 min",
      "difficulty": "Advanced",
      "equipment": "Bodyweight",
      "calories": 280,
      "exercises": 6,
      "isActive": false,
      "image": "https://picsum.photos/400/200?random=2&keyword=cardio-hiit",
      "days": ["Tuesday", "Thursday"],
      "description": "High-intensity interval training to boost cardiovascular fitness and burn fat."
    },
    {
      "id": 3,
      "name": "Yoga & Flexibility",
      "duration": "60 min",
      "difficulty": "Beginner",
      "equipment": "Mat",
      "calories": 150,
      "exercises": 12,
      "isActive": true,
      "image": "https://picsum.photos/400/200?random=3&keyword=yoga",
      "days": ["Saturday", "Sunday"],
      "description": "Gentle yoga flow focusing on flexibility, balance, and mindfulness."
    }
  ];

  List<Map<String, dynamic>> todayWorkout = [
    {
      "exercise": "Push-ups",
      "sets": 3,
      "reps": "12-15",
      "rest": "60s",
      "completed": true,
      "notes": "Focus on proper form"
    },
    {
      "exercise": "Squats",
      "sets": 4,
      "reps": "15-20",
      "rest": "90s",
      "completed": true,
      "notes": "Go deep, chest up"
    },
    {
      "exercise": "Plank",
      "sets": 3,
      "reps": "45s",
      "rest": "60s",
      "completed": false,
      "notes": "Keep core tight"
    },
    {
      "exercise": "Burpees",
      "sets": 3,
      "reps": "8-10",
      "rest": "90s",
      "completed": false,
      "notes": "Explosive movement"
    },
    {
      "exercise": "Mountain Climbers",
      "sets": 3,
      "reps": "20",
      "rest": "60s",
      "completed": false,
      "notes": "Fast but controlled"
    }
  ];

  List<Map<String, dynamic>> weeklySchedule = [
    {"day": "Mon", "workout": "Full Body", "duration": "45m", "completed": true},
    {"day": "Tue", "workout": "Cardio HIIT", "duration": "30m", "completed": true},
    {"day": "Wed", "workout": "Full Body", "duration": "45m", "completed": true},
    {"day": "Thu", "workout": "Rest Day", "duration": "-", "completed": false},
    {"day": "Fri", "workout": "Full Body", "duration": "45m", "completed": false},
    {"day": "Sat", "workout": "Yoga", "duration": "60m", "completed": false},
    {"day": "Sun", "workout": "Yoga", "duration": "60m", "completed": false},
  ];

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Workout Plans",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "My Plans", icon: Icon(Icons.fitness_center)),
        Tab(text: "Today", icon: Icon(Icons.today)),
        Tab(text: "Schedule", icon: Icon(Icons.calendar_month)),
      ],
      tabChildren: [
        // My Plans Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Active Plan Header
              Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Active Plans",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${workoutPlans.where((plan) => plan["isActive"] as bool).length}",
                                style: TextStyle(
                                  fontSize: fsH1,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Active Plans",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withAlpha(220),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "5",
                                style: TextStyle(
                                  fontSize: fsH1,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Days This Week",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withAlpha(220),
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

              SizedBox(height: spLg),

              // Workout Plans List
              Text(
                "All Workout Plans",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...workoutPlans.map((plan) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Plan Image
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              "${plan["image"]}",
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor(plan["difficulty"]),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${plan["difficulty"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            if (plan["isActive"] as bool)
                              Positioned(
                                top: spSm,
                                left: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "Active",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Plan Content
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${plan["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${plan["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),

                            // Plan Stats
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${plan["duration"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.local_fire_department,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${plan["calories"]} cal",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.fitness_center,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${plan["exercises"]} exercises",
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

                            SizedBox(height: spSm),

                            // Equipment and Days
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${plan["equipment"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(plan["days"] as List).length} days/week",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: plan["isActive"] as bool ? "View Details" : "Start Plan",
                                    size: bs.sm,
                                    onPressed: () {
                                      if (!(plan["isActive"] as bool)) {
                                        plan["isActive"] = true;
                                        setState(() {});
                                        ss("Workout plan activated!");
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: plan["isActive"] as bool ? Icons.pause : Icons.play_arrow,
                                  size: bs.sm,
                                  onPressed: () {
                                    plan["isActive"] = !(plan["isActive"] as bool);
                                    setState(() {});
                                    ss(plan["isActive"] as bool ? "Plan activated" : "Plan paused");
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),

        // Today Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Today's Plan Header
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.today,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Today's Workout",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Full Body Strength • 45 minutes",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    // Progress
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Progress",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${((todayWorkout.where((ex) => ex["completed"] as bool).length / todayWorkout.length) * 100).toInt()}%",
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
                                value: todayWorkout.where((ex) => ex["completed"] as bool).length / todayWorkout.length,
                                backgroundColor: disabledColor,
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Exercise List
              Text(
                "Exercises",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...todayWorkout.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> exercise = entry.value;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: exercise["completed"] as bool ? successColor : disabledColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: exercise["completed"] as bool 
                              ? successColor.withAlpha(30) 
                              : primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: exercise["completed"] as bool
                              ? Icon(
                                  Icons.check,
                                  color: successColor,
                                  size: 20,
                                )
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${exercise["exercise"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${exercise["sets"]} sets",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${exercise["reps"]} reps",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${exercise["rest"]} rest",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            if (exercise["notes"] != null) ...[
                              SizedBox(height: spXs),
                              Text(
                                "${exercise["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      QButton(
                        icon: exercise["completed"] as bool ? Icons.refresh : Icons.check,
                        size: bs.sm,
                        onPressed: () {
                          exercise["completed"] = !(exercise["completed"] as bool);
                          setState(() {});
                          ss(exercise["completed"] as bool ? "Exercise completed!" : "Exercise reset");
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),

        // Schedule Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Weekly Overview
              Text(
                "Weekly Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...weeklySchedule.map((day) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: day["completed"] as bool ? successColor : primaryColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: day["completed"] as bool 
                              ? successColor.withAlpha(30) 
                              : primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: day["completed"] as bool
                              ? Icon(
                                  Icons.check_circle,
                                  color: successColor,
                                  size: 24,
                                )
                              : Text(
                                  "${day["day"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${day["workout"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            if (day["duration"] != "-") ...[
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${day["duration"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (day["workout"] != "Rest Day" && !(day["completed"] as bool))
                        QButton(
                          label: "Start",
                          size: bs.sm,
                          onPressed: () {
                            day["completed"] = true;
                            setState(() {});
                            ss("Workout started!");
                          },
                        ),
                    ],
                  ),
                );
              }).toList(),

              SizedBox(height: spLg),

              // Add Custom Workout
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add Custom Workout",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {
                    ss("Custom workout creation started");
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
