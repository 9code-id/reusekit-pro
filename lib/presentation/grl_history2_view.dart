import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHistory2View extends StatefulWidget {
  @override
  State<GrlHistory2View> createState() => _GrlHistory2ViewState();
}

class _GrlHistory2ViewState extends State<GrlHistory2View> {
  int selectedTab = 0;
  String searchQuery = "";
  
  final List<String> tabs = ["All Activities", "Workouts", "Meals", "Sleep", "Measurements"];
  
  final List<Map<String, dynamic>> activityLogs = [
    {
      "id": "LOG001",
      "type": "Workout",
      "title": "Morning Cardio Session",
      "description": "30-minute high-intensity interval training",
      "date": "2024-01-20",
      "time": "06:30",
      "duration": 30,
      "calories": 280,
      "notes": "Felt energetic throughout the session. Heart rate peaked at 165 bpm.",
      "metrics": {
        "heartRate": {"avg": 145, "max": 165},
        "steps": 3500,
        "distance": 2.8,
        "intensity": "High"
      },
      "exercises": [
        {"name": "Jumping Jacks", "duration": 5, "calories": 45},
        {"name": "Burpees", "duration": 10, "calories": 120},
        {"name": "Running", "duration": 15, "calories": 115}
      ],
      "status": "Completed",
      "icon": Icons.directions_run,
      "color": "red"
    },
    {
      "id": "LOG002",
      "type": "Meal",
      "title": "Breakfast",
      "description": "Protein-rich breakfast with oats and berries",
      "date": "2024-01-20",
      "time": "08:00",
      "calories": 450,
      "notes": "Added extra blueberries for antioxidants. Feeling satisfied.",
      "metrics": {
        "protein": 25,
        "carbs": 55,
        "fat": 12,
        "fiber": 8,
        "sugar": 15
      },
      "foods": [
        {"name": "Steel-cut oats", "quantity": "1 cup", "calories": 150},
        {"name": "Greek yogurt", "quantity": "200g", "calories": 130},
        {"name": "Blueberries", "quantity": "100g", "calories": 85},
        {"name": "Almonds", "quantity": "30g", "calories": 85}
      ],
      "status": "Logged",
      "icon": Icons.restaurant,
      "color": "green"
    },
    {
      "id": "LOG003",
      "type": "Sleep",
      "title": "Night Sleep",
      "description": "Deep sleep with minimal interruptions",
      "date": "2024-01-19",
      "time": "22:30",
      "duration": 480,
      "notes": "Used sleep meditation app. Woke up feeling refreshed.",
      "metrics": {
        "bedtime": "22:30",
        "wakeup": "06:30",
        "deepSleep": 180,
        "remSleep": 120,
        "lightSleep": 180,
        "awake": 15,
        "sleepScore": 87
      },
      "stages": [
        {"stage": "Light Sleep", "duration": 180, "percentage": 37.5},
        {"stage": "Deep Sleep", "duration": 180, "percentage": 37.5},
        {"stage": "REM Sleep", "duration": 120, "percentage": 25.0}
      ],
      "status": "Analyzed",
      "icon": Icons.bedtime,
      "color": "blue"
    },
    {
      "id": "LOG004",
      "type": "Measurement",
      "title": "Body Weight",
      "description": "Weekly weight check",
      "date": "2024-01-19",
      "time": "07:00",
      "notes": "Lost 0.5kg from last week. On track with weight loss goal.",
      "metrics": {
        "weight": 74.5,
        "bmi": 24.2,
        "bodyFat": 18.5,
        "muscleMass": 32.8,
        "waterPercentage": 58.2
      },
      "previousValues": {
        "weight": 75.0,
        "bmi": 24.4,
        "bodyFat": 19.0,
        "muscleMass": 32.5
      },
      "status": "Recorded",
      "icon": Icons.monitor_weight,
      "color": "purple"
    },
    {
      "id": "LOG005",
      "type": "Workout",
      "title": "Strength Training",
      "description": "Upper body focused resistance training",
      "date": "2024-01-18",
      "time": "17:00",
      "duration": 45,
      "calories": 220,
      "notes": "Increased weight for bench press. Form was good throughout.",
      "metrics": {
        "sets": 12,
        "reps": 156,
        "totalWeight": 2400,
        "maxWeight": 80,
        "intensity": "Medium"
      },
      "exercises": [
        {"name": "Bench Press", "sets": 4, "reps": 32, "weight": 70},
        {"name": "Pull-ups", "sets": 3, "reps": 24, "weight": 0},
        {"name": "Shoulder Press", "sets": 3, "reps": 30, "weight": 25},
        {"name": "Bicep Curls", "sets": 2, "reps": 20, "weight": 15}
      ],
      "status": "Completed",
      "icon": Icons.fitness_center,
      "color": "orange"
    },
    {
      "id": "LOG006",
      "type": "Meal",
      "title": "Lunch",
      "description": "Balanced meal with lean protein and vegetables",
      "date": "2024-01-18",
      "time": "12:30",
      "calories": 520,
      "notes": "Grilled chicken was perfectly seasoned. Felt full but not overstuffed.",
      "metrics": {
        "protein": 45,
        "carbs": 35,
        "fat": 20,
        "fiber": 12,
        "sodium": 850
      },
      "foods": [
        {"name": "Grilled chicken breast", "quantity": "150g", "calories": 250},
        {"name": "Quinoa", "quantity": "100g", "calories": 120},
        {"name": "Mixed vegetables", "quantity": "200g", "calories": 80},
        {"name": "Olive oil", "quantity": "1 tbsp", "calories": 70}
      ],
      "status": "Logged",
      "icon": Icons.lunch_dining,
      "color": "green"
    }
  ];

  List<Map<String, dynamic>> get filteredLogs {
    List<Map<String, dynamic>> filtered = activityLogs;
    
    if (selectedTab != 0) {
      String type = tabs[selectedTab];
      if (type == "Workouts") {
        filtered = filtered.where((log) => 
          "${log["type"]}" == "Workout").toList();
      } else if (type == "Meals") {
        filtered = filtered.where((log) => 
          "${log["type"]}" == "Meal").toList();
      } else if (type == "Sleep") {
        filtered = filtered.where((log) => 
          "${log["type"]}" == "Sleep").toList();
      } else if (type == "Measurements") {
        filtered = filtered.where((log) => 
          "${log["type"]}" == "Measurement").toList();
      }
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((log) =>
        "${log["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${log["description"]}".toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    return filtered;
  }

  Color _getLogColor(String colorName) {
    switch (colorName) {
      case "red": return dangerColor;
      case "green": return successColor;
      case "blue": return primaryColor;
      case "orange": return warningColor;
      case "purple": return Color(0xFF9C27B0);
      default: return disabledColor;
    }
  }

  String _formatDuration(int minutes) {
    if (minutes >= 60) {
      int hours = minutes ~/ 60;
      int remainingMinutes = minutes % 60;
      return "${hours}h ${remainingMinutes}m";
    } else {
      return "${minutes}m";
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalWorkouts = activityLogs.where((log) => log["type"] == "Workout").length;
    int totalMeals = activityLogs.where((log) => log["type"] == "Meal").length;
    int totalSleep = activityLogs.where((log) => log["type"] == "Sleep").length;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity History"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search activities...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Activity Type Tabs
            QCategoryPicker(
              items: tabs.map((tab) => {
                "label": tab,
                "value": tab,
              }).toList(),
              value: tabs[selectedTab],
              onChanged: (index, label, value, item) {
                selectedTab = index;
                setState(() {});
              },
            ),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.fitness_center,
                          color: dangerColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$totalWorkouts",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Workouts",
                          style: TextStyle(
                            fontSize: 11,
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.restaurant,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$totalMeals",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Meals",
                          style: TextStyle(
                            fontSize: 11,
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.bedtime,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$totalSleep",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Sleep Logs",
                          style: TextStyle(
                            fontSize: 11,
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.timeline,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${activityLogs.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Logs",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Activity Logs
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Activity Logs",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredLogs.length} entries",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Column(
                    spacing: spSm,
                    children: filteredLogs.map((log) {
                      Color logColor = _getLogColor("${log["color"]}");
                      String logType = "${log["type"]}";
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: logColor,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            spacing: spSm,
                            children: [
                              // Header
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: logColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      log["icon"] as IconData,
                                      color: logColor,
                                      size: 24,
                                    ),
                                  ),
                                  
                                  SizedBox(width: spSm),
                                  
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${log["title"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: logColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                logType.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w600,
                                                  color: logColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        
                                        Text(
                                          "${log["description"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${log["date"]} at ${log["time"]}",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            if (log["duration"] != null) ...[
                                              Text(
                                                " • ",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: disabledColor,
                                                ),
                                              ),
                                              Text(
                                                _formatDuration(log["duration"] as int),
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  if (log["calories"] != null)
                                    Column(
                                      children: [
                                        Text(
                                          "${log["calories"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: dangerColor,
                                          ),
                                        ),
                                        Text(
                                          "calories",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),

                              // Metrics Display
                              if (log["metrics"] != null)
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: _buildMetricsForType(logType, log["metrics"]),
                                ),

                              // Detailed Information
                              if (logType == "Workout" && log["exercises"] != null)
                                _buildWorkoutDetails(log["exercises"] as List),
                              
                              if (logType == "Meal" && log["foods"] != null)
                                _buildMealDetails(log["foods"] as List),
                              
                              if (logType == "Sleep" && log["stages"] != null)
                                _buildSleepDetails(log["stages"] as List),
                              
                              if (logType == "Measurement" && log["previousValues"] != null)
                                _buildMeasurementDetails(log["metrics"], log["previousValues"]),

                              // Notes
                              if (log["notes"] != null && "${log["notes"]}".isNotEmpty)
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        "Notes:",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${log["notes"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              // Actions
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "View Details",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.edit,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.share,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMetricsForType(String type, dynamic metrics) {
    switch (type) {
      case "Workout":
        return Column(
          spacing: spXs,
          children: [
            if (metrics["heartRate"] != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Heart Rate:", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
                  Text("${metrics["heartRate"]["avg"]} avg, ${metrics["heartRate"]["max"]} max bpm", 
                       style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: primaryColor)),
                ],
              ),
            if (metrics["steps"] != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Steps:", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
                  Text("${metrics["steps"]}", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: primaryColor)),
                ],
              ),
            if (metrics["distance"] != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Distance:", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
                  Text("${metrics["distance"]} km", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: primaryColor)),
                ],
              ),
          ],
        );
      case "Meal":
        return Column(
          spacing: spXs,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Protein:", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
                Text("${metrics["protein"]}g", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: successColor)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Carbs:", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
                Text("${metrics["carbs"]}g", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: warningColor)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Fat:", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
                Text("${metrics["fat"]}g", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: dangerColor)),
              ],
            ),
          ],
        );
      case "Sleep":
        return Column(
          spacing: spXs,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sleep Score:", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
                Text("${metrics["sleepScore"]}/100", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: primaryColor)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Deep Sleep:", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
                Text("${metrics["deepSleep"]} min", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: primaryColor)),
              ],
            ),
          ],
        );
      case "Measurement":
        return Column(
          spacing: spXs,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Weight:", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
                Text("${metrics["weight"]} kg", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: primaryColor)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("BMI:", style: TextStyle(fontSize: 11, color: disabledBoldColor)),
                Text("${metrics["bmi"]}", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: primaryColor)),
              ],
            ),
          ],
        );
      default:
        return Container();
    }
  }

  Widget _buildWorkoutDetails(List exercises) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Text(
          "Exercises:",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Column(
          spacing: 2,
          children: exercises.take(3).map((exercise) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${exercise["name"]}",
                  style: TextStyle(fontSize: 10, color: disabledBoldColor),
                ),
                Text(
                  "${exercise["duration"]}min • ${exercise["calories"]}cal",
                  style: TextStyle(fontSize: 10, color: disabledBoldColor),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMealDetails(List foods) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Text(
          "Foods:",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Column(
          spacing: 2,
          children: foods.take(3).map((food) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${food["name"]} (${food["quantity"]})",
                  style: TextStyle(fontSize: 10, color: disabledBoldColor),
                ),
                Text(
                  "${food["calories"]}cal",
                  style: TextStyle(fontSize: 10, color: disabledBoldColor),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSleepDetails(List stages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Text(
          "Sleep Stages:",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Column(
          spacing: 2,
          children: stages.map((stage) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${stage["stage"]}",
                  style: TextStyle(fontSize: 10, color: disabledBoldColor),
                ),
                Text(
                  "${stage["duration"]}min (${(stage["percentage"] as double).toStringAsFixed(1)}%)",
                  style: TextStyle(fontSize: 10, color: disabledBoldColor),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMeasurementDetails(dynamic current, dynamic previous) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Text(
          "Changes from last measurement:",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Weight:", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
            Text(
              "${((current["weight"] as double) - (previous["weight"] as double)).toStringAsFixed(1)}kg",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: (current["weight"] as double) < (previous["weight"] as double) ? successColor : dangerColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
