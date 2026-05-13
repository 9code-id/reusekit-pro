import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaStepCounterView extends StatefulWidget {
  const FwaStepCounterView({super.key});

  @override
  State<FwaStepCounterView> createState() => _FwaStepCounterViewState();
}

class _FwaStepCounterViewState extends State<FwaStepCounterView> {
  bool isTracking = true;
  int currentSteps = 8247;
  int dailyGoal = 10000;
  double distanceWalked = 6.2;
  int caloriesBurned = 312;
  int activeMinutes = 94;
  String selectedPeriod = "Today";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "Week", "value": "Week"},
    {"label": "Month", "value": "Month"},
    {"label": "Year", "value": "Year"},
  ];

  List<Map<String, dynamic>> stepHistory = [
    {
      "date": DateTime.now(),
      "steps": 8247,
      "goal": 10000,
      "distance": 6.2,
      "calories": 312,
      "active_minutes": 94,
      "goal_achieved": false,
    },
    {
      "date": DateTime.now().subtract(Duration(days: 1)),
      "steps": 12340,
      "goal": 10000,
      "distance": 9.3,
      "calories": 467,
      "active_minutes": 128,
      "goal_achieved": true,
    },
    {
      "date": DateTime.now().subtract(Duration(days: 2)),
      "steps": 9876,
      "goal": 10000,
      "distance": 7.4,
      "calories": 374,
      "active_minutes": 102,
      "goal_achieved": false,
    },
    {
      "date": DateTime.now().subtract(Duration(days: 3)),
      "steps": 11256,
      "goal": 10000,
      "distance": 8.5,
      "calories": 426,
      "active_minutes": 115,
      "goal_achieved": true,
    },
    {
      "date": DateTime.now().subtract(Duration(days: 4)),
      "steps": 8934,
      "goal": 10000,
      "distance": 6.7,
      "calories": 338,
      "active_minutes": 89,
      "goal_achieved": false,
    },
    {
      "date": DateTime.now().subtract(Duration(days: 5)),
      "steps": 10567,
      "goal": 10000,
      "distance": 8.0,
      "calories": 400,
      "active_minutes": 108,
      "goal_achieved": true,
    },
    {
      "date": DateTime.now().subtract(Duration(days: 6)),
      "steps": 9234,
      "goal": 10000,
      "distance": 7.0,
      "calories": 350,
      "active_minutes": 95,
      "goal_achieved": false,
    },
  ];

  List<Map<String, dynamic>> hourlySteps = [
    {"hour": "6AM", "steps": 124},
    {"hour": "7AM", "steps": 456},
    {"hour": "8AM", "steps": 789},
    {"hour": "9AM", "steps": 345},
    {"hour": "10AM", "steps": 678},
    {"hour": "11AM", "steps": 432},
    {"hour": "12PM", "steps": 567},
    {"hour": "1PM", "steps": 890},
    {"hour": "2PM", "steps": 654},
    {"hour": "3PM", "steps": 789},
    {"hour": "4PM", "steps": 543},
    {"hour": "5PM", "steps": 876},
    {"hour": "6PM", "steps": 432},
    {"hour": "7PM", "steps": 234},
    {"hour": "8PM", "steps": 156},
    {"hour": "9PM", "steps": 89},
    {"hour": "10PM", "steps": 45},
    {"hour": "11PM", "steps": 23},
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "First 10K",
      "description": "Reach 10,000 steps in a day",
      "icon": Icons.emoji_events,
      "achieved": true,
      "date": DateTime.now().subtract(Duration(days: 1)),
    },
    {
      "title": "Week Warrior",
      "description": "Meet goal 5 days in a week",
      "icon": Icons.calendar_today,
      "achieved": false,
      "date": null,
    },
    {
      "title": "Distance Master",
      "description": "Walk 10km in a single day",
      "icon": Icons.straighten,
      "achieved": false,
      "date": null,
    },
    {
      "title": "Consistency King",
      "description": "Meet goal 30 days in a row",
      "icon": Icons.trending_up,
      "achieved": false,
      "date": null,
    },
  ];

  Map<String, dynamic> get weeklyStats {
    List<Map<String, dynamic>> thisWeek = stepHistory.take(7).toList();
    int totalSteps = thisWeek.fold(0, (sum, day) => sum + (day["steps"] as int));
    int goalsDays = thisWeek.where((day) => day["goal_achieved"]).length;
    double avgSteps = totalSteps / 7;
    double totalDistance = thisWeek.fold(0.0, (sum, day) => sum + (day["distance"] as double));
    
    return {
      "total_steps": totalSteps,
      "goal_days": goalsDays,
      "avg_steps": avgSteps,
      "total_distance": totalDistance,
    };
  }

  @override
  Widget build(BuildContext context) {
    double progress = currentSteps / dailyGoal;
    if (progress > 1.0) progress = 1.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Step Counter"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Current Steps Progress
            Container(
              padding: EdgeInsets.all(spSm),
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
                        isTracking ? Icons.directions_walk : Icons.pause,
                        color: isTracking ? primaryColor : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        isTracking ? "Step Tracking Active" : "Step Tracking Paused",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: isTracking ? primaryColor : disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        icon: isTracking ? Icons.pause : Icons.play_arrow,
                        size: bs.sm,
                        onPressed: () {
                          isTracking = !isTracking;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  // Circular Progress
                  Container(
                    width: 200,
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 180,
                          height: 180,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 12,
                            backgroundColor: primaryColor.withAlpha(20),
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$currentSteps",
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "of $dailyGoal steps",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${(progress * 100).toInt()}% complete",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Quick Stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickStat("Distance", "${distanceWalked.toStringAsFixed(1)} km", Icons.straighten, infoColor),
                      ),
                      Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                      Expanded(
                        child: _buildQuickStat("Calories", "$caloriesBurned kcal", Icons.local_fire_department, dangerColor),
                      ),
                      Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                      Expanded(
                        child: _buildQuickStat("Active", "${activeMinutes}min", Icons.timer, successColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Period Selector
            QDropdownField(
              label: "View Period",
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),

            // Weekly Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.analytics, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Weekly Summary",
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
                        child: _buildSummaryCard(
                          "Total Steps",
                          "${(weeklyStats["total_steps"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                          Icons.directions_walk,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Goal Days",
                          "${weeklyStats["goal_days"]}/7",
                          Icons.flag,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Daily Average",
                          "${(weeklyStats["avg_steps"] as double).toInt()}",
                          Icons.trending_up,
                          infoColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Distance",
                          "${(weeklyStats["total_distance"] as double).toStringAsFixed(1)}km",
                          Icons.straighten,
                          warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Hourly Activity Chart
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timeline, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Today's Hourly Activity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 150,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: hourlySteps.map((data) {
                          int steps = data["steps"];
                          double height = (steps / 1000) * 120;
                          if (height < 10) height = 10;
                          if (height > 120) height = 120;
                          
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (steps > 500)
                                  Text(
                                    "$steps",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                SizedBox(height: spXs),
                                Container(
                                  width: 16,
                                  height: height,
                                  decoration: BoxDecoration(
                                    color: steps > 500 ? primaryColor : primaryColor.withAlpha(30),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXs)),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Transform.rotate(
                                  angle: -1.5708, // 90 degrees
                                  child: Text(
                                    "${data["hour"]}",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Step History
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.history, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Recent Activity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...stepHistory.take(5).map((day) {
                    bool goalAchieved = day["goal_achieved"];
                    double dayProgress = (day["steps"] as int) / (day["goal"] as int);
                    if (dayProgress > 1.0) dayProgress = 1.0;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: goalAchieved ? successColor.withAlpha(10) : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: goalAchieved ? successColor.withAlpha(30) : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${(day["date"] as DateTime).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              if (goalAchieved)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check, size: 10, color: Colors.white),
                                      SizedBox(width: 2),
                                      Text(
                                        "Goal",
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${day["steps"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: goalAchieved ? successColor : primaryColor,
                                ),
                              ),
                              Text(
                                " / ${day["goal"]} steps",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${(dayProgress * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: goalAchieved ? successColor : primaryColor,
                                ),
                              ),
                            ],
                          ),
                          LinearProgressIndicator(
                            value: dayProgress,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              goalAchieved ? successColor : primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${(day["distance"] as double).toStringAsFixed(1)}km",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${day["calories"]} cal",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${day["active_minutes"]}min",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Achievements
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.emoji_events, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Achievements",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${achievements.where((a) => a["achieved"]).length}/${achievements.length}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  ...achievements.map((achievement) {
                    bool achieved = achievement["achieved"];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: achieved ? warningColor.withAlpha(10) : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: achieved ? warningColor.withAlpha(30) : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: achieved ? warningColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              achievement["icon"],
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${achievement["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: achieved ? warningColor : disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${achievement["description"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (achieved && achievement["date"] != null)
                                  Text(
                                    "Achieved: ${(achievement["date"] as DateTime).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (achieved)
                            Icon(Icons.check_circle, color: warningColor, size: 20),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
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
    );
  }

  Widget _buildSummaryCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
