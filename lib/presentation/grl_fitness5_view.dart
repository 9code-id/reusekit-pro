import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFitness5View extends StatefulWidget {
  @override
  State<GrlFitness5View> createState() => _GrlFitness5ViewState();
}

class _GrlFitness5ViewState extends State<GrlFitness5View> {
  int currentWeek = 1;
  int selectedDay = 1;

  List<Map<String, dynamic>> workoutPlan = [
    {
      "week": 1,
      "days": [
        {
          "day": 1,
          "title": "Upper Body Focus",
          "completed": true,
          "exercises": [
            {"name": "Push-ups", "sets": 3, "reps": "12-15", "completed": true},
            {"name": "Dumbbell Rows", "sets": 3, "reps": "10-12", "completed": true},
            {"name": "Shoulder Press", "sets": 3, "reps": "8-10", "completed": true},
            {"name": "Tricep Dips", "sets": 2, "reps": "8-12", "completed": true},
          ]
        },
        {
          "day": 2,
          "title": "Lower Body Power",
          "completed": true,
          "exercises": [
            {"name": "Squats", "sets": 4, "reps": "15-20", "completed": true},
            {"name": "Lunges", "sets": 3, "reps": "12 each leg", "completed": true},
            {"name": "Calf Raises", "sets": 3, "reps": "15-20", "completed": true},
            {"name": "Glute Bridges", "sets": 3, "reps": "15-18", "completed": true},
          ]
        },
        {
          "day": 3,
          "title": "Core & Cardio",
          "completed": false,
          "exercises": [
            {"name": "Plank", "sets": 3, "reps": "30-45 sec", "completed": false},
            {"name": "Mountain Climbers", "sets": 3, "reps": "20 each", "completed": false},
            {"name": "Russian Twists", "sets": 3, "reps": "20-25", "completed": false},
            {"name": "Jumping Jacks", "sets": 3, "reps": "30 sec", "completed": false},
          ]
        },
        {
          "day": 4,
          "title": "Active Recovery",
          "completed": false,
          "exercises": [
            {"name": "Light Stretching", "sets": 1, "reps": "10 min", "completed": false},
            {"name": "Walking", "sets": 1, "reps": "20-30 min", "completed": false},
            {"name": "Deep Breathing", "sets": 1, "reps": "5 min", "completed": false},
          ]
        },
        {
          "day": 5,
          "title": "Full Body Circuit",
          "completed": false,
          "exercises": [
            {"name": "Burpees", "sets": 3, "reps": "8-10", "completed": false},
            {"name": "Deadlifts", "sets": 3, "reps": "10-12", "completed": false},
            {"name": "Pull-ups", "sets": 3, "reps": "5-8", "completed": false},
            {"name": "Leg Raises", "sets": 3, "reps": "12-15", "completed": false},
          ]
        },
        {
          "day": 6,
          "title": "Flexibility & Mobility",
          "completed": false,
          "exercises": [
            {"name": "Yoga Flow", "sets": 1, "reps": "15 min", "completed": false},
            {"name": "Hip Stretches", "sets": 1, "reps": "10 min", "completed": false},
            {"name": "Shoulder Rolls", "sets": 1, "reps": "5 min", "completed": false},
          ]
        },
        {
          "day": 7,
          "title": "Rest Day",
          "completed": false,
          "exercises": [
            {"name": "Complete Rest", "sets": 1, "reps": "All day", "completed": false},
          ]
        },
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    final currentWeekData = workoutPlan[currentWeek - 1];
    final days = currentWeekData["days"] as List;
    final selectedDayData = days.firstWhere((day) => day["day"] == selectedDay);
    final exercises = selectedDayData["exercises"] as List;

    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Plan"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusLg)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Week $currentWeek",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "30 Day Challenge",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      final day = days[index];
                      final dayNumber = day["day"] as int;
                      final isSelected = selectedDay == dayNumber;
                      final isCompleted = day["completed"] as bool;
                      
                      return GestureDetector(
                        onTap: () {
                          selectedDay = dayNumber;
                          setState(() {});
                        },
                        child: Container(
                          width: 60,
                          margin: EdgeInsets.only(right: spSm),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? Colors.white 
                                : Colors.white.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: isCompleted 
                                ? Border.all(color: successColor, width: 2)
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Day",
                                style: TextStyle(
                                  color: isSelected ? primaryColor : Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "$dayNumber",
                                style: TextStyle(
                                  color: isSelected ? primaryColor : Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (isCompleted) ...[
                                SizedBox(height: spXs),
                                Icon(
                                  Icons.check_circle,
                                  color: isSelected ? successColor : Colors.white,
                                  size: 16,
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
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
                              "${selectedDayData["title"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Day $selectedDay Workout",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (selectedDayData["completed"] as bool)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle, color: successColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "Completed",
                                style: TextStyle(
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.fitness_center, color: primaryColor, size: 24),
                              SizedBox(height: spXs),
                              Text(
                                "${exercises.length}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Exercises",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.schedule, color: warningColor, size: 24),
                              SizedBox(height: spXs),
                              Text(
                                "25-30",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Minutes",
                                style: TextStyle(
                                  color: warningColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.local_fire_department, color: dangerColor, size: 24),
                              SizedBox(height: spXs),
                              Text(
                                "180",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Calories",
                                style: TextStyle(
                                  color: dangerColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Text(
                    "Exercises",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...List.generate(exercises.length, (index) {
                    final exercise = exercises[index];
                    final isCompleted = exercise["completed"] as bool;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: isCompleted 
                            ? Border.all(color: successColor.withAlpha(100))
                            : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isCompleted 
                                  ? successColor 
                                  : primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: isCompleted
                                  ? Icon(Icons.check, color: Colors.white, size: 20)
                                  : Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${exercise["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    decoration: isCompleted 
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${exercise["sets"]} sets × ${exercise["reps"]} reps",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isCompleted)
                            QButton(
                              label: "Start",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: spLg),
                  if (!(selectedDayData["completed"] as bool))
                    QButton(
                      label: "Complete Workout",
                      size: bs.md,
                      onPressed: () {},
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
