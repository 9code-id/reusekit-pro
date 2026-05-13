import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTracking7View extends StatefulWidget {
  @override
  State<GrlTracking7View> createState() => _GrlTracking7ViewState();
}

class _GrlTracking7ViewState extends State<GrlTracking7View> {
  String selectedTimeRange = 'today';
  
  List<Map<String, dynamic>> activities = [
    {
      "id": 1,
      "type": "workout",
      "title": "Morning Run",
      "duration": 45,
      "distance": 5.2,
      "calories": 320,
      "startTime": "07:00",
      "endTime": "07:45",
      "date": "2024-01-23",
      "intensity": "moderate",
      "heartRate": {"avg": 142, "max": 168},
      "pace": "8:40 /km",
      "steps": 6500,
    },
    {
      "id": 2,
      "type": "workout",
      "title": "Strength Training",
      "duration": 60,
      "distance": 0,
      "calories": 280,
      "startTime": "18:30",
      "endTime": "19:30",
      "date": "2024-01-23",
      "intensity": "high",
      "heartRate": {"avg": 135, "max": 175},
      "exercises": ["Push-ups", "Squats", "Deadlifts"],
      "sets": 12,
      "reps": 144,
    },
    {
      "id": 3,
      "type": "nutrition",
      "title": "Breakfast",
      "calories": 450,
      "protein": 25,
      "carbs": 60,
      "fat": 15,
      "time": "08:00",
      "date": "2024-01-23",
      "foods": ["Oatmeal", "Banana", "Greek Yogurt", "Almonds"],
    },
    {
      "id": 4,
      "type": "sleep",
      "title": "Night Sleep",
      "duration": 480,
      "quality": "good",
      "deepSleep": 120,
      "lightSleep": 280,
      "remSleep": 80,
      "bedTime": "22:30",
      "wakeTime": "06:30",
      "date": "2024-01-22",
      "restingHeartRate": 58,
    },
    {
      "id": 5,
      "type": "hydration",
      "title": "Water Intake",
      "amount": 2.4,
      "goal": 3.0,
      "time": "All Day",
      "date": "2024-01-23",
      "drinks": [
        {"type": "water", "amount": 1.8},
        {"type": "tea", "amount": 0.4},
        {"type": "coffee", "amount": 0.2},
      ],
    },
  ];

  Map<String, dynamic> dailyStats = {
    "steps": 12450,
    "stepsGoal": 10000,
    "calories": 1050,
    "caloriesGoal": 2000,
    "activeMinutes": 105,
    "activeGoal": 60,
    "distance": 5.2,
    "distanceGoal": 5.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // navigateTo(AnalyticsView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Time Range Selector
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QHorizontalScroll(
              children: [
                'today', 'week', 'month', 'year'
              ].map((range) => GestureDetector(
                onTap: () {
                  selectedTimeRange = range;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: selectedTimeRange == range ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: selectedTimeRange == range ? primaryColor : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Text(
                    range.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: selectedTimeRange == range ? Colors.white : primaryColor,
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
          
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Daily Overview
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
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.today,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Today's Progress",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // Progress Circles
                        Row(
                          children: [
                            Expanded(
                              child: _buildProgressCircle(
                                "Steps",
                                dailyStats["steps"] as int,
                                dailyStats["stepsGoal"] as int,
                                successColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: _buildProgressCircle(
                                "Calories",
                                dailyStats["calories"] as int,
                                dailyStats["caloriesGoal"] as int,
                                warningColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: _buildProgressCircle(
                                "Active",
                                dailyStats["activeMinutes"] as int,
                                dailyStats["activeGoal"] as int,
                                infoColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Quick Stats
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
                              Icon(
                                Icons.directions_run,
                                color: primaryColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${(dailyStats["distance"] as double).toStringAsFixed(1)} km",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Distance",
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
                              Icon(
                                Icons.favorite,
                                color: dangerColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "142",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Avg HR",
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
                  
                  Text(
                    "Recent Activities",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Activity Timeline
                  ...activities.map((activity) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      children: [
                        // Activity Header
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: _getActivityColor(activity["type"]).withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: _getActivityColor(activity["type"]),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  _getActivityIcon(activity["type"]),
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${activity["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${activity["date"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (activity["duration"] != null)
                                Text(
                                  "${_formatDuration(activity["duration"] as int)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _getActivityColor(activity["type"]),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        
                        // Activity Details
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: _buildActivityDetails(activity),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(AddActivityView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildProgressCircle(String title, int current, int goal, Color color) {
    double progress = (current / goal).clamp(0.0, 1.0);
    
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 6,
                backgroundColor: Colors.white.withAlpha(76),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Text(
              "${((progress * 100).toInt())}%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Text(
          "$current/$goal",
          style: TextStyle(
            fontSize: 10,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityDetails(Map<String, dynamic> activity) {
    String type = activity["type"];
    
    switch (type) {
      case "workout":
        return _buildWorkoutDetails(activity);
      case "nutrition":
        return _buildNutritionDetails(activity);
      case "sleep":
        return _buildSleepDetails(activity);
      case "hydration":
        return _buildHydrationDetails(activity);
      default:
        return Container();
    }
  }

  Widget _buildWorkoutDetails(Map<String, dynamic> workout) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Primary Stats
        Row(
          children: [
            if (workout["distance"] != null && workout["distance"] > 0) ...[
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${(workout["distance"] as double).toStringAsFixed(1)} km",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Distance",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Expanded(
              child: Column(
                children: [
                  Text(
                    "${workout["calories"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
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
            if (workout["heartRate"] != null) ...[
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${workout["heartRate"]["avg"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Avg HR",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        
        SizedBox(height: spMd),
        
        // Additional Info
        Row(
          children: [
            Icon(
              Icons.schedule,
              size: 16,
              color: primaryColor,
            ),
            SizedBox(width: spXs),
            Text(
              "${workout["startTime"]} - ${workout["endTime"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
              decoration: BoxDecoration(
                color: _getIntensityColor(workout["intensity"]).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${workout["intensity"]}".toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: _getIntensityColor(workout["intensity"]),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNutritionDetails(Map<String, dynamic> nutrition) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    "${nutrition["calories"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
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
            Expanded(
              child: Column(
                children: [
                  Text(
                    "${nutrition["protein"]}g",
                    style: TextStyle(
                      fontSize: fsH6,
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
            Expanded(
              child: Column(
                children: [
                  Text(
                    "${nutrition["carbs"]}g",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  Text(
                    "Carbs",
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
        
        Text(
          "Foods: ${(nutrition["foods"] as List).join(", ")}",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSleepDetails(Map<String, dynamic> sleep) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    "${_formatDuration(sleep["duration"] as int)}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Duration",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "${sleep["quality"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "Quality",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "${sleep["restingHeartRate"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  Text(
                    "RHR",
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
        
        Row(
          children: [
            Icon(
              Icons.bedtime,
              size: 16,
              color: primaryColor,
            ),
            SizedBox(width: spXs),
            Text(
              "${sleep["bedTime"]} - ${sleep["wakeTime"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHydrationDetails(Map<String, dynamic> hydration) {
    double progress = (hydration["amount"] as double) / (hydration["goal"] as double);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${(hydration["amount"] as double).toStringAsFixed(1)}L / ${(hydration["goal"] as double).toStringAsFixed(1)}L",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress.clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: infoColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "${(progress * 100).toInt()}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: infoColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case 'workout':
        return primaryColor;
      case 'nutrition':
        return warningColor;
      case 'sleep':
        return infoColor;
      case 'hydration':
        return successColor;
      default:
        return primaryColor;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'workout':
        return Icons.fitness_center;
      case 'nutrition':
        return Icons.restaurant;
      case 'sleep':
        return Icons.bedtime;
      case 'hydration':
        return Icons.local_drink;
      default:
        return Icons.sports;
    }
  }

  Color _getIntensityColor(String intensity) {
    switch (intensity) {
      case 'high':
        return dangerColor;
      case 'moderate':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return primaryColor;
    }
  }

  String _formatDuration(int minutes) {
    int hours = minutes ~/ 60;
    int mins = minutes % 60;
    if (hours > 0) {
      return "${hours}h ${mins}m";
    }
    return "${mins}m";
  }
}
