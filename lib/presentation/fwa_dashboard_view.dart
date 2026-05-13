import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaDashboardView extends StatefulWidget {
  const FwaDashboardView({super.key});

  @override
  State<FwaDashboardView> createState() => _FwaDashboardViewState();
}

class _FwaDashboardViewState extends State<FwaDashboardView> {
  int currentTab = 0;

  List<Map<String, dynamic>> weeklyStats = [
    {
      "title": "Workouts Completed",
      "value": 5,
      "target": 6,
      "unit": "",
      "change": 2,
      "trend": "up",
      "icon": Icons.fitness_center,
      "color": primaryColor
    },
    {
      "title": "Calories Burned",
      "value": 1850,
      "target": 2100,
      "unit": "kcal",
      "change": 350,
      "trend": "up", 
      "icon": Icons.local_fire_department,
      "color": dangerColor
    },
    {
      "title": "Active Minutes",
      "value": 285,
      "target": 350,
      "unit": "min",
      "change": -15,
      "trend": "down",
      "icon": Icons.timer,
      "color": warningColor
    },
    {
      "title": "Distance Covered",
      "value": 32.5,
      "target": 40.0,
      "unit": "km",
      "change": 8.2,
      "trend": "up",
      "icon": Icons.directions_run,
      "color": successColor
    }
  ];

  List<Map<String, dynamic>> chartData = [
    {"day": "Mon", "calories": 420, "workouts": 1},
    {"day": "Tue", "calories": 380, "workouts": 1},
    {"day": "Wed", "calories": 0, "workouts": 0},
    {"day": "Thu", "calories": 450, "workouts": 1},
    {"day": "Fri", "calories": 320, "workouts": 1},
    {"day": "Sat", "calories": 280, "workouts": 1},
    {"day": "Sun", "calories": 0, "workouts": 0}
  ];

  List<Map<String, dynamic>> workoutTypes = [
    {"type": "Cardio", "sessions": 12, "percentage": 40, "color": primaryColor},
    {"type": "Strength", "sessions": 8, "percentage": 27, "color": successColor},
    {"type": "Yoga", "sessions": 6, "percentage": 20, "color": warningColor},
    {"type": "HIIT", "sessions": 4, "percentage": 13, "color": dangerColor}
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "5-Day Streak",
      "description": "Workout 5 days in a row",
      "icon": Icons.local_fire_department,
      "color": dangerColor,
      "earned": true,
      "date": "2 days ago"
    },
    {
      "title": "Calorie Crusher",
      "description": "Burn 500+ calories in one session",
      "icon": Icons.bolt,
      "color": warningColor,
      "earned": true,
      "date": "1 week ago"
    },
    {
      "title": "Marathon Runner",
      "description": "Run 10km in one session",
      "icon": Icons.directions_run,
      "color": primaryColor,
      "earned": false,
      "progress": 0.7
    },
    {
      "title": "Strength Champion",
      "description": "Complete 20 strength workouts",
      "icon": Icons.fitness_center,
      "color": successColor,
      "earned": false,
      "progress": 0.4
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Achievements", icon: Icon(Icons.emoji_events)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Weekly Stats
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "This Week's Progress",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: weeklyStats.map((stat) {
                        double progress = (stat["value"] as num) / (stat["target"] as num);
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (stat["color"] as Color).withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spSm,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    stat["icon"],
                                    color: stat["color"],
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${stat["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${stat["value"]}",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (stat["unit"].toString().isNotEmpty)
                                    Text(
                                      " ${stat["unit"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  Spacer(),
                                  Text(
                                    "${(stat["change"] as num) > 0 ? '+' : ''}${stat["change"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: stat["trend"] == "up" ? successColor : dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Target: ${stat["target"]} ${stat["unit"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${(progress * 100).toInt()}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  LinearProgressIndicator(
                                    value: progress > 1.0 ? 1.0 : progress,
                                    backgroundColor: disabledColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(stat["color"]),
                                    borderRadius: BorderRadius.circular(radiusSm),
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
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // navigateTo('Start Workout')
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: primaryColor.withAlpha(30),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: primaryColor,
                                  size: 32,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Start Workout",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // navigateTo('Log Activity')
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: successColor.withAlpha(30),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.add_circle,
                                  color: successColor,
                                  size: 32,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Log Activity",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // navigateTo('View Progress')
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: warningColor.withAlpha(30),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  color: warningColor,
                                  size: 32,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "View Progress",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // navigateTo('Settings')
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: disabledBoldColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: disabledBoldColor.withAlpha(30),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: disabledBoldColor,
                                  size: 32,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Settings",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Analytics Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Weekly Chart
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Weekly Calories Burned",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      height: 200,
                      child: Row(
                        children: chartData.map((data) {
                          double maxCalories = chartData.map((d) => d["calories"] as int).reduce((a, b) => a > b ? a : b).toDouble();
                          double normalizedHeight = maxCalories > 0 ? ((data["calories"] as int) / maxCalories) * 150 + 20 : 20;
                          
                          return Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if ((data["calories"] as int) > 0)
                                        Text(
                                          "${data["calories"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      SizedBox(height: spXs),
                                      Container(
                                        width: 25,
                                        height: normalizedHeight,
                                        decoration: BoxDecoration(
                                          color: (data["calories"] as int) > 0 ? dangerColor : disabledColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${data["day"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),

              // Workout Types
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Workout Types Distribution",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      spacing: spSm,
                      children: workoutTypes.map((type) {
                        return Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: type["color"],
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${type["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "${type["sessions"]} sessions",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${type["percentage"]}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Achievements Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Achievements",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      spacing: spSm,
                      children: achievements.map((achievement) {
                        return Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: achievement["earned"] ? 
                                   (achievement["color"] as Color).withAlpha(10) : 
                                   disabledColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: achievement["earned"] ? 
                                     (achievement["color"] as Color).withAlpha(30) : 
                                     disabledColor.withAlpha(30),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: achievement["earned"] ? 
                                         achievement["color"] : 
                                         disabledBoldColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  achievement["icon"],
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${achievement["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: achievement["earned"] ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${achievement["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    if (achievement["earned"])
                                      Text(
                                        "Earned ${achievement["date"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    else if (achievement.containsKey("progress"))
                                      Column(
                                        spacing: spXs,
                                        children: [
                                          SizedBox(height: spXs),
                                          LinearProgressIndicator(
                                            value: achievement["progress"],
                                            backgroundColor: disabledColor,
                                            valueColor: AlwaysStoppedAnimation<Color>(achievement["color"]),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          Text(
                                            "${((achievement["progress"] as double) * 100).toInt()}% Complete",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              if (achievement["earned"])
                                Icon(
                                  Icons.check_circle,
                                  color: successColor,
                                  size: 20,
                                ),
                            ],
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
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}
