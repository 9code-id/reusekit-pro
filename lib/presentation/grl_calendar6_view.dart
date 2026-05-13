import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCalendar6View extends StatefulWidget {
  @override
  State<GrlCalendar6View> createState() => _GrlCalendar6ViewState();
}

class _GrlCalendar6ViewState extends State<GrlCalendar6View> {
  int selectedTabIndex = 0;
  
  List<Map<String, dynamic>> workouts = [
    {
      "id": 1,
      "name": "Morning Run",
      "type": "cardio",
      "duration": 30,
      "calories": 250,
      "time": "07:00",
      "completed": true,
      "date": DateTime.now(),
    },
    {
      "id": 2,
      "name": "Weight Training",
      "type": "strength",
      "duration": 45,
      "calories": 180,
      "time": "18:00",
      "completed": false,
      "date": DateTime.now(),
    },
    {
      "id": 3,
      "name": "Yoga Session",
      "type": "flexibility",
      "duration": 60,
      "calories": 120,
      "time": "19:30",
      "completed": false,
      "date": DateTime.now().add(Duration(days: 1)),
    },
  ];

  List<Map<String, dynamic>> meals = [
    {
      "id": 1,
      "name": "Protein Smoothie",
      "type": "breakfast",
      "calories": 280,
      "protein": 25,
      "time": "08:00",
      "completed": true,
    },
    {
      "id": 2,
      "name": "Grilled Chicken Salad",
      "type": "lunch",
      "calories": 350,
      "protein": 35,
      "time": "12:30",
      "completed": false,
    },
    {
      "id": 3,
      "name": "Salmon with Vegetables",
      "type": "dinner",
      "calories": 420,
      "protein": 40,
      "time": "19:00",
      "completed": false,
    },
  ];

  Map<String, dynamic> todayStats = {
    "steps": 8750,
    "calories_burned": 430,
    "water_intake": 6,
    "sleep_hours": 7.5,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                _buildTabButton("Overview", 0, Icons.dashboard),
                _buildTabButton("Workouts", 1, Icons.fitness_center),
                _buildTabButton("Nutrition", 2, Icons.restaurant),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedTabIndex == 1) {
            // navigateTo(AddWorkoutView());
          } else if (selectedTabIndex == 2) {
            // navigateTo(AddMealView());
          }
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index, IconData icon) {
    bool isSelected = selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTabIndex = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spMd),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: isSelected ? primaryColor : Colors.transparent,
              ),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? primaryColor : disabledBoldColor,
              ),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? primaryColor : disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildWorkoutsTab();
      case 2:
        return _buildNutritionTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Daily Stats Header
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Progress",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${DateTime.now().day} ${_getMonthName(DateTime.now().month)}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Stats Grid
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Steps",
                  "${todayStats["steps"]}",
                  "10,000 goal",
                  Icons.directions_walk,
                  primaryColor,
                  (todayStats["steps"] as int) / 10000,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Calories",
                  "${todayStats["calories_burned"]}",
                  "500 goal",
                  Icons.local_fire_department,
                  dangerColor,
                  (todayStats["calories_burned"] as int) / 500,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Water",
                  "${todayStats["water_intake"]} cups",
                  "8 cups goal",
                  Icons.water_drop,
                  infoColor,
                  (todayStats["water_intake"] as int) / 8,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Sleep",
                  "${todayStats["sleep_hours"]}h",
                  "8h goal",
                  Icons.bedtime,
                  successColor,
                  (todayStats["sleep_hours"] as double) / 8,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Today's Activities
          Text(
            "Today's Activities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Workout Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: warningColor,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.fitness_center,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Workouts Scheduled",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "${workouts.where((w) => (w["date"] as DateTime).day == DateTime.now().day).length}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...workouts.where((workout) {
                  DateTime workoutDate = workout["date"] as DateTime;
                  return workoutDate.day == DateTime.now().day;
                }).map((workout) => Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (workout["completed"] as bool) 
                        ? successColor.withAlpha(10) 
                        : warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        (workout["completed"] as bool) ? Icons.check_circle : Icons.schedule,
                        size: 16,
                        color: (workout["completed"] as bool) ? successColor : warningColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${workout["time"]} - ${workout["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Meal Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: successColor,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.restaurant,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Nutrition Plan",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "${meals.fold(0, (sum, meal) => sum + (meal["calories"] as int))}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      " cal",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...meals.map((meal) => Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (meal["completed"] as bool) 
                        ? successColor.withAlpha(10) 
                        : infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        (meal["completed"] as bool) ? Icons.check_circle : Icons.schedule,
                        size: 16,
                        color: (meal["completed"] as bool) ? successColor : infoColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${meal["time"]} - ${meal["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "${meal["calories"]} cal",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Workout Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${workouts.where((w) => w["completed"] as bool).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${workouts.fold(0, (sum, w) => sum + (w["duration"] as int))}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Minutes",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${workouts.fold(0, (sum, w) => sum + (w["calories"] as int))}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Calories",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Workouts List
          Text(
            "Scheduled Workouts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...workouts.map((workout) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getWorkoutTypeColor(workout["type"]),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getWorkoutTypeColor(workout["type"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getWorkoutTypeIcon(workout["type"]),
                        size: 20,
                        color: _getWorkoutTypeColor(workout["type"]),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${workout["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${workout["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getWorkoutTypeColor(workout["type"]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (workout["completed"] as bool)
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 24,
                      ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${workout["time"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.timer,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${workout["duration"]} min",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.local_fire_department,
                      size: 16,
                      color: dangerColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${workout["calories"]} cal",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                if (!(workout["completed"] as bool))
                  Container(
                    margin: EdgeInsets.only(top: spMd),
                    child: Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Start Workout",
                            size: bs.sm,
                            onPressed: () {
                              workout["completed"] = true;
                              setState(() {});
                              ss("Workout completed!");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Reschedule",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildNutritionTab() {
    int totalCalories = meals.fold(0, (sum, meal) => sum + (meal["calories"] as int));
    int totalProtein = meals.fold(0, (sum, meal) => sum + (meal["protein"] as int));
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nutrition Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$totalCalories",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Calories",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${totalProtein}g",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Protein",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Meal Plan
          Text(
            "Today's Meal Plan",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...meals.map((meal) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getMealTypeColor(meal["type"]),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getMealTypeColor(meal["type"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getMealTypeIcon(meal["type"]),
                        size: 20,
                        color: _getMealTypeColor(meal["type"]),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${meal["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${meal["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getMealTypeColor(meal["type"]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (meal["completed"] as bool)
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 24,
                      ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${meal["time"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.local_fire_department,
                      size: 16,
                      color: dangerColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${meal["calories"]} cal",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.fitness_center,
                      size: 16,
                      color: successColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${meal["protein"]}g protein",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                if (!(meal["completed"] as bool))
                  Container(
                    margin: EdgeInsets.only(top: spMd),
                    child: QButton(
                      label: "Mark as Eaten",
                      size: bs.sm,
                      onPressed: () {
                        meal["completed"] = true;
                        setState(() {});
                        ss("Meal logged!");
                      },
                    ),
                  ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String goal, IconData icon, Color color, double progress) {
    return Container(
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
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            goal,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: progress > 1.0 ? 1.0 : progress,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }

  Color _getWorkoutTypeColor(String type) {
    switch (type) {
      case 'cardio':
        return dangerColor;
      case 'strength':
        return primaryColor;
      case 'flexibility':
        return successColor;
      default:
        return primaryColor;
    }
  }

  IconData _getWorkoutTypeIcon(String type) {
    switch (type) {
      case 'cardio':
        return Icons.directions_run;
      case 'strength':
        return Icons.fitness_center;
      case 'flexibility':
        return Icons.self_improvement;
      default:
        return Icons.fitness_center;
    }
  }

  Color _getMealTypeColor(String type) {
    switch (type) {
      case 'breakfast':
        return warningColor;
      case 'lunch':
        return successColor;
      case 'dinner':
        return primaryColor;
      default:
        return primaryColor;
    }
  }

  IconData _getMealTypeIcon(String type) {
    switch (type) {
      case 'breakfast':
        return Icons.free_breakfast;
      case 'lunch':
        return Icons.lunch_dining;
      case 'dinner':
        return Icons.dinner_dining;
      default:
        return Icons.restaurant;
    }
  }
}
