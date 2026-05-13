import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaFitnessTrackerView extends StatefulWidget {
  const MhaFitnessTrackerView({super.key});

  @override
  State<MhaFitnessTrackerView> createState() => _MhaFitnessTrackerViewState();
}

class _MhaFitnessTrackerViewState extends State<MhaFitnessTrackerView> {
  int currentTab = 0;
  Map<String, dynamic> todayStats = {
    "steps": 8540,
    "targetSteps": 10000,
    "calories": 342,
    "targetCalories": 400,
    "distance": 6.7,
    "targetDistance": 8.0,
    "activeMinutes": 45,
    "targetActiveMinutes": 60,
    "heartRate": 78,
    "workouts": 1,
  };

  List<Map<String, dynamic>> recentWorkouts = [
    {
      "id": 1,
      "type": "Running",
      "duration": 35,
      "calories": 280,
      "distance": 4.5,
      "date": "2024-01-15",
      "time": "07:00",
      "heartRate": 145,
      "icon": Icons.directions_run,
      "color": primaryColor,
    },
    {
      "id": 2,
      "type": "Strength Training",
      "duration": 45,
      "calories": 190,
      "distance": 0,
      "date": "2024-01-14",
      "time": "18:30",
      "heartRate": 120,
      "icon": Icons.fitness_center,
      "color": successColor,
    },
    {
      "id": 3,
      "type": "Cycling",
      "duration": 60,
      "calories": 350,
      "distance": 15.2,
      "date": "2024-01-13",
      "time": "16:00",
      "heartRate": 135,
      "icon": Icons.directions_bike,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> weeklyProgress = [
    {
      "day": "Mon",
      "steps": 9200,
      "calories": 380,
      "workouts": 1,
    },
    {
      "day": "Tue",
      "steps": 7800,
      "calories": 320,
      "workouts": 0,
    },
    {
      "day": "Wed",
      "steps": 10500,
      "calories": 425,
      "workouts": 2,
    },
    {
      "day": "Thu",
      "steps": 8900,
      "calories": 365,
      "workouts": 1,
    },
    {
      "day": "Fri",
      "steps": 11200,
      "calories": 480,
      "workouts": 1,
    },
    {
      "day": "Sat",
      "steps": 6500,
      "calories": 280,
      "workouts": 0,
    },
    {
      "day": "Sun",
      "steps": 8540,
      "calories": 342,
      "workouts": 1,
    },
  ];

  List<Map<String, dynamic>> exerciseTypes = [
    {
      "name": "Running",
      "icon": Icons.directions_run,
      "color": primaryColor,
      "sessions": 12,
      "totalTime": 420,
      "avgCalories": 285,
    },
    {
      "name": "Strength Training",
      "icon": Icons.fitness_center,
      "color": successColor,
      "sessions": 8,
      "totalTime": 360,
      "avgCalories": 195,
    },
    {
      "name": "Cycling",
      "icon": Icons.directions_bike,
      "color": infoColor,
      "sessions": 6,
      "totalTime": 300,
      "avgCalories": 340,
    },
    {
      "name": "Swimming",
      "icon": Icons.pool,
      "color": warningColor,
      "sessions": 4,
      "totalTime": 180,
      "avgCalories": 420,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Fitness Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Today", icon: Icon(Icons.today)),
        Tab(text: "Workouts", icon: Icon(Icons.fitness_center)),
        Tab(text: "Progress", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildTodayTab(),
        _buildWorkoutsTab(),
        _buildProgressTab(),
      ],
    );
  }

  Widget _buildTodayTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTodayOverview(),
          _buildDailyGoals(),
          _buildQuickWorkouts(),
        ],
      ),
    );
  }

  Widget _buildTodayOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.dashboard,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Today's Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 150,
            children: [
              _buildStatCard("Steps", "${todayStats["steps"]}", "${todayStats["targetSteps"]}", Icons.directions_walk, primaryColor),
              _buildStatCard("Calories", "${todayStats["calories"]}", "${todayStats["targetCalories"]}", Icons.local_fire_department, dangerColor),
              _buildStatCard("Distance", "${todayStats["distance"]}km", "${todayStats["targetDistance"]}km", Icons.straighten, successColor),
              _buildStatCard("Active", "${todayStats["activeMinutes"]}min", "${todayStats["targetActiveMinutes"]}min", Icons.timer, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String target, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color,
          width: 1,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            "Goal: $target",
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          Container(
            width: double.infinity,
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _calculateProgress(value, target),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateProgress(String current, String target) {
    double currentValue = double.tryParse(current.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
    double targetValue = double.tryParse(target.replaceAll(RegExp(r'[^\d.]'), '')) ?? 1;
    return (currentValue / targetValue).clamp(0.0, 1.0);
  }

  Widget _buildDailyGoals() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Daily Goals",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildGoalProgressBar("Steps", todayStats["steps"] as int, todayStats["targetSteps"] as int, primaryColor),
          _buildGoalProgressBar("Calories", todayStats["calories"] as int, todayStats["targetCalories"] as int, dangerColor),
          _buildGoalProgressBar("Active Minutes", todayStats["activeMinutes"] as int, todayStats["targetActiveMinutes"] as int, infoColor),
        ],
      ),
    );
  }

  Widget _buildGoalProgressBar(String title, int current, int target, Color color) {
    double progress = (current / target).clamp(0.0, 1.0);
    bool achieved = current >= target;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "$current/$target",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spXs),
              Icon(
                achieved ? Icons.check_circle : Icons.radio_button_unchecked,
                color: achieved ? successColor : disabledBoldColor,
                size: 16,
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: achieved ? successColor : color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickWorkouts() {
    List<Map<String, dynamic>> quickWorkouts = [
      {
        "name": "Quick Cardio",
        "duration": "15 min",
        "calories": "120-150",
        "icon": Icons.favorite,
        "color": dangerColor,
      },
      {
        "name": "Strength",
        "duration": "20 min",
        "calories": "80-100",
        "icon": Icons.fitness_center,
        "color": successColor,
      },
      {
        "name": "Stretching",
        "duration": "10 min",
        "calories": "30-50",
        "icon": Icons.accessibility_new,
        "color": infoColor,
      },
      {
        "name": "HIIT",
        "duration": "25 min",
        "calories": "200-250",
        "icon": Icons.flash_on,
        "color": warningColor,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.play_circle,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Quick Workouts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 140,
            children: quickWorkouts.map((workout) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (workout["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: workout["color"] as Color,
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      workout["icon"] as IconData,
                      color: workout["color"] as Color,
                      size: 32,
                    ),
                    Text(
                      "${workout["name"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${workout["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${workout["calories"]} cal",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Start",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('StartWorkoutView')
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildWorkoutStats(),
          _buildRecentWorkouts(),
          _buildWorkoutActions(),
        ],
      ),
    );
  }

  Widget _buildWorkoutStats() {
    int totalWorkouts = recentWorkouts.length;
    int totalMinutes = recentWorkouts.fold(0, (sum, workout) => sum + (workout["duration"] as int));
    int totalCalories = recentWorkouts.fold(0, (sum, workout) => sum + (workout["calories"] as int));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.bar_chart,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Workout Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildSummaryCard("Workouts", "$totalWorkouts", Icons.fitness_center, primaryColor),
              SizedBox(width: spSm),
              _buildSummaryCard("Minutes", "$totalMinutes", Icons.timer, successColor),
              SizedBox(width: spSm),
              _buildSummaryCard("Calories", "$totalCalories", Icons.local_fire_department, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentWorkouts() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Recent Workouts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...recentWorkouts.map((workout) => _buildWorkoutCard(workout)).toList(),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(Map<String, dynamic> workout) {
    Color workoutColor = workout["color"] as Color;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: workoutColor.withAlpha(100),
          width: 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: workoutColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              workout["icon"] as IconData,
              color: workoutColor,
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
                    Text(
                      "${workout["type"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${workout["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${workout["duration"]} min",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.local_fire_department,
                      color: dangerColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${workout["calories"]} cal",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if ((workout["distance"] as num) > 0) ...[
                      SizedBox(width: spSm),
                      Icon(
                        Icons.straighten,
                        color: successColor,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${workout["distance"]} km",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.add_circle,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Workout Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Log Workout",
                  icon: Icons.add,
                  onPressed: () {
                    //navigateTo('LogWorkoutView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Start Timer",
                  icon: Icons.play_arrow,
                  onPressed: () {
                    //navigateTo('WorkoutTimerView')
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildWeeklyProgress(),
          _buildExerciseBreakdown(),
        ],
      ),
    );
  }

  Widget _buildWeeklyProgress() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Weekly Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            child: Column(
              spacing: spXs,
              children: weeklyProgress.map((day) {
                int steps = day["steps"] as int;
                double progress = (steps / 10000).clamp(0.0, 1.0);
                
                return Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        "${day["day"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progress,
                          child: Container(
                            decoration: BoxDecoration(
                              color: progress >= 1.0 ? successColor : progress >= 0.7 ? warningColor : primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    SizedBox(
                      width: 50,
                      child: Text(
                        "$steps",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseBreakdown() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.pie_chart,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Exercise Breakdown",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...exerciseTypes.map((exercise) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (exercise["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: exercise["color"] as Color,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: exercise["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      exercise["icon"] as IconData,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${exercise["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${exercise["sessions"]} sessions",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${exercise["totalTime"]} min",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "~${exercise["avgCalories"]} cal/session",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
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
    );
  }
}
