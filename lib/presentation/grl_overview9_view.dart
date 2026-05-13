import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOverview9View extends StatefulWidget {
  @override
  State<GrlOverview9View> createState() => _GrlOverview9ViewState();
}

class _GrlOverview9ViewState extends State<GrlOverview9View> {
  List<Map<String, dynamic>> fitnessMetrics = [
    {
      "title": "Daily Steps",
      "value": 12450,
      "goal": 10000,
      "unit": "steps",
      "color": Colors.blue,
      "icon": Icons.directions_walk,
      "change": 15.2
    },
    {
      "title": "Calories Burned",
      "value": 485,
      "goal": 400,
      "unit": "kcal",
      "color": Colors.red,
      "icon": Icons.local_fire_department,
      "change": 8.5
    },
    {
      "title": "Active Minutes",
      "value": 42,
      "goal": 30,
      "unit": "min",
      "color": Colors.green,
      "icon": Icons.timer,
      "change": 12.3
    },
    {
      "title": "Distance",
      "value": 8.7,
      "goal": 6.0,
      "unit": "km",
      "color": Colors.purple,
      "icon": Icons.map,
      "change": 20.1
    },
  ];

  List<Map<String, dynamic>> workoutHistory = [
    {
      "name": "Morning Run",
      "type": "Cardio",
      "duration": 45,
      "calories": 320,
      "time": "7:00 AM",
      "date": "Today",
      "intensity": "High"
    },
    {
      "name": "Strength Training",
      "type": "Strength",
      "duration": 60,
      "calories": 280,
      "time": "6:00 PM",
      "date": "Yesterday",
      "intensity": "Medium"
    },
    {
      "name": "Yoga Session",
      "type": "Flexibility",
      "duration": 30,
      "calories": 150,
      "time": "8:00 PM",
      "date": "Yesterday",
      "intensity": "Low"
    },
    {
      "name": "Cycling",
      "type": "Cardio",
      "duration": 90,
      "calories": 450,
      "time": "3:00 PM",
      "date": "2 days ago",
      "intensity": "High"
    },
  ];

  List<Map<String, dynamic>> weeklyGoals = [
    {
      "title": "Workout Days",
      "current": 4,
      "target": 5,
      "unit": "days",
      "progress": 0.8
    },
    {
      "title": "Total Distance",
      "current": 35.2,
      "target": 40.0,
      "unit": "km",
      "progress": 0.88
    },
    {
      "title": "Weight Loss",
      "current": 1.2,
      "target": 2.0,
      "unit": "kg",
      "progress": 0.6
    },
    {
      "title": "Sleep Hours",
      "current": 7.5,
      "target": 8.0,
      "unit": "hrs",
      "progress": 0.94
    },
  ];

  List<Map<String, dynamic>> challenges = [
    {
      "title": "30-Day Step Challenge",
      "description": "Walk 10,000 steps daily for 30 days",
      "progress": 0.73,
      "daysLeft": 8,
      "participants": 1250,
      "reward": "Fitness Badge"
    },
    {
      "title": "Marathon Prep",
      "description": "Complete 200km running distance",
      "progress": 0.45,
      "daysLeft": 45,
      "participants": 450,
      "reward": "Special Medal"
    },
    {
      "title": "Strength Builder",
      "description": "20 strength training sessions",
      "progress": 0.65,
      "daysLeft": 15,
      "participants": 680,
      "reward": "Pro Membership"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Motivational Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Great Progress, Mike!",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "You're 25% ahead of your weekly goal",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "5-day streak active!",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),

            // Daily Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: fitnessMetrics.map((metric) {
                double progress = (metric["value"] as num) / (metric["goal"] as num);
                progress = progress > 1.0 ? 1.0 : progress;
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              color: metric["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  size: 12,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "+${(metric["change"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            metric["title"] == "Distance" 
                                ? "${(metric["value"] as double).toStringAsFixed(1)}"
                                : "${metric["value"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${metric["unit"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Goal: ${metric["goal"]} ${metric["unit"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                              Text(
                                "${(progress * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: metric["color"] as Color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: metric["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Workouts
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.fitness_center,
                        color: primaryColor,
                        size: 20,
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
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: workoutHistory.map((workout) {
                      Color typeColor = _getWorkoutTypeColor("${workout["type"]}");
                      IconData typeIcon = _getWorkoutTypeIcon("${workout["type"]}");
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: typeColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: typeColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                typeIcon,
                                color: typeColor,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${workout["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: _getIntensityColor("${workout["intensity"]}").withAlpha(50),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${workout["intensity"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getIntensityColor("${workout["intensity"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${workout["duration"]} min",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        " • ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Text(
                                        "${workout["calories"]} kcal",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${workout["date"]} at ${workout["time"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledColor,
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
                  ),
                ],
              ),
            ),

            // Weekly Goals
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.track_changes,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Weekly Goals",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: weeklyGoals.map((goal) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${goal["title"]}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  goal["title"] == "Total Distance" || goal["title"] == "Weight Loss" || goal["title"] == "Sleep Hours"
                                      ? "${(goal["current"] as double).toStringAsFixed(1)}"
                                      : "${goal["current"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "/${goal["target"]} ${goal["unit"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(100),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: goal["progress"] as double,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _getProgressColor(goal["progress"] as double),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "${((goal["progress"] as double) * 100).toInt()}% complete",
                              style: TextStyle(
                                fontSize: 11,
                                color: _getProgressColor(goal["progress"] as double),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Active Challenges
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Active Challenges",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QHorizontalScroll(
                    children: challenges.map((challenge) {
                      return Container(
                        width: 280,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    Icons.emoji_events,
                                    color: warningColor,
                                    size: 20,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${challenge["daysLeft"]} days left",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${challenge["title"]}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${challenge["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                height: 1.3,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Progress",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${((challenge["progress"] as double) * 100).toInt()}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: disabledColor.withAlpha(100),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: challenge["progress"] as double,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: warningColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 14,
                                  color: disabledColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${challenge["participants"]} participants",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.card_giftcard,
                                  size: 14,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${challenge["reward"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: successColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Start Workout",
                    icon: Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View Stats",
                    icon: Icons.analytics,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getWorkoutTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'cardio':
        return Colors.red;
      case 'strength':
        return Colors.blue;
      case 'flexibility':
        return Colors.purple;
      default:
        return Colors.green;
    }
  }

  IconData _getWorkoutTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'cardio':
        return Icons.directions_run;
      case 'strength':
        return Icons.fitness_center;
      case 'flexibility':
        return Icons.self_improvement;
      default:
        return Icons.sports;
    }
  }

  Color _getIntensityColor(String intensity) {
    switch (intensity.toLowerCase()) {
      case 'low':
        return successColor;
      case 'medium':
        return warningColor;
      case 'high':
        return dangerColor;
      default:
        return infoColor;
    }
  }

  Color _getProgressColor(double progress) {
    if (progress >= 0.8) return successColor;
    if (progress >= 0.5) return warningColor;
    return dangerColor;
  }
}
