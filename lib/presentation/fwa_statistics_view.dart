import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaStatisticsView extends StatefulWidget {
  const FwaStatisticsView({super.key});

  @override
  State<FwaStatisticsView> createState() => _FwaStatisticsViewState();
}

class _FwaStatisticsViewState extends State<FwaStatisticsView> {
  String selectedPeriod = "weekly";
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> weeklyStats = [
    {"label": "Total Steps", "value": "48,250", "unit": "steps", "change": "+12%", "color": primaryColor, "icon": Icons.directions_walk},
    {"label": "Calories Burned", "value": "2,840", "unit": "kcal", "change": "+8%", "color": dangerColor, "icon": Icons.local_fire_department},
    {"label": "Distance", "value": "32.5", "unit": "km", "change": "+15%", "color": successColor, "icon": Icons.place},
    {"label": "Active Minutes", "value": "420", "unit": "min", "change": "+5%", "color": warningColor, "icon": Icons.timer},
    {"label": "Workouts", "value": "5", "unit": "sessions", "change": "+25%", "color": infoColor, "icon": Icons.fitness_center},
    {"label": "Water Intake", "value": "14.5", "unit": "liters", "change": "+3%", "color": primaryColor, "icon": Icons.water_drop},
  ];

  List<Map<String, dynamic>> achievements = [
    {"title": "Step Master", "description": "Achieved 10,000 steps for 7 days", "icon": Icons.emoji_events, "color": warningColor},
    {"title": "Calorie Crusher", "description": "Burned 500+ calories in one workout", "icon": Icons.local_fire_department, "color": dangerColor},
    {"title": "Distance Runner", "description": "Ran 5km without stopping", "icon": Icons.directions_run, "color": successColor},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness Statistics"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Statistics shared successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Period Selection
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
                  Text(
                    "Statistics Period",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Select Period",
                    items: periodOptions,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Main Statistics Grid
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
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
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (stat["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: stat["color"] as Color,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  stat["icon"] as IconData,
                                  color: stat["color"] as Color,
                                  size: 24,
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: (stat["change"] as String).contains("+") ? successColor : dangerColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${stat["change"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${stat["label"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${stat["value"]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: stat["color"] as Color,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${stat["unit"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
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

            // Progress Chart Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Text(
                        "Weekly Progress Chart",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.trending_up,
                        color: successColor,
                        size: 20,
                      ),
                    ],
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: spSm,
                        children: [
                          Icon(
                            Icons.bar_chart,
                            size: 48,
                            color: primaryColor.withAlpha(100),
                          ),
                          Text(
                            "Progress Chart",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Visual representation of your weekly progress",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Recent Achievements
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Text(
                        "Recent Achievements",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('FwaAchievementsView')
                        },
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: achievements.map((achievement) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (achievement["color"] as Color).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: achievement["color"] as Color,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: achievement["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                achievement["icon"] as IconData,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 2,
                                children: [
                                  Text(
                                    "${achievement["title"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${achievement["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 16,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Goal Progress
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Goal Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: [
                      _buildGoalProgress("Daily Steps", 8240, 10000, primaryColor),
                      _buildGoalProgress("Weekly Workouts", 3, 5, successColor),
                      _buildGoalProgress("Water Intake", 1.8, 2.5, infoColor),
                      _buildGoalProgress("Sleep Hours", 6.5, 8.0, warningColor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalProgress(String title, double current, double target, Color color) {
    final percentage = (current / target * 100).clamp(0, 100);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "${current.toStringAsFixed(current % 1 == 0 ? 0 : 1)}/${target.toStringAsFixed(target % 1 == 0 ? 0 : 1)}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: FractionallySizedBox(
            widthFactor: percentage / 100,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
        Text(
          "${percentage.toStringAsFixed(0)}% completed",
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
