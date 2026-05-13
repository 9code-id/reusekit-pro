import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFitness8View extends StatefulWidget {
  @override
  State<GrlFitness8View> createState() => _GrlFitness8ViewState();
}

class _GrlFitness8ViewState extends State<GrlFitness8View> {
  String selectedGoalType = "Weight Loss";
  String activityLevel = "Moderate";
  int targetWeight = 70;
  int currentWeight = 75;
  int weeklyWorkouts = 4;

  List<Map<String, dynamic>> fitnessGoals = [
    {
      "type": "Weight Loss",
      "icon": Icons.trending_down,
      "color": dangerColor,
      "description": "Lose weight and burn fat"
    },
    {
      "type": "Muscle Gain",
      "icon": Icons.fitness_center,
      "color": primaryColor,
      "description": "Build muscle and strength"
    },
    {
      "type": "Endurance",
      "icon": Icons.directions_run,
      "color": warningColor,
      "description": "Improve cardio fitness"
    },
    {
      "type": "Flexibility",
      "icon": Icons.self_improvement,
      "color": successColor,
      "description": "Increase mobility and flexibility"
    },
  ];

  List<Map<String, dynamic>> activityLevels = [
    {
      "level": "Beginner",
      "description": "Just starting out",
      "workouts": "2-3 times per week"
    },
    {
      "level": "Moderate",
      "description": "Some exercise experience",
      "workouts": "3-4 times per week"
    },
    {
      "level": "Active",
      "description": "Regular exercise routine",
      "workouts": "4-5 times per week"
    },
    {
      "level": "Advanced",
      "description": "Very active lifestyle",
      "workouts": "5-6 times per week"
    },
  ];

  Map<String, dynamic> currentGoalProgress = {
    "goal": "Lose 5kg in 3 months",
    "startDate": "Jan 1, 2024",
    "targetDate": "Apr 1, 2024",
    "progress": 0.4,
    "currentValue": 3,
    "targetValue": 5,
    "unit": "kg lost",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness Goals"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.flag, color: Colors.white, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Current Goal",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${currentGoalProgress["goal"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "${currentGoalProgress["startDate"]} - ${currentGoalProgress["targetDate"]}",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Progress",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${((currentGoalProgress["progress"] as double) * 100).toInt()}%",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: currentGoalProgress["progress"] as double,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${currentGoalProgress["currentValue"]} ${currentGoalProgress["unit"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Achieved",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${currentGoalProgress["targetValue"]} ${currentGoalProgress["unit"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Target",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Set New Goal",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Create Goal",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              "Goal Type",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...List.generate(fitnessGoals.length, (index) {
              final goal = fitnessGoals[index];
              final isSelected = selectedGoalType == goal["type"];
              
              return GestureDetector(
                onTap: () {
                  selectedGoalType = goal["type"] as String;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: isSelected 
                        ? Border.all(color: primaryColor, width: 2)
                        : Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (goal["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          goal["icon"] as IconData,
                          color: goal["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${goal["type"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${goal["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: primaryColor,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(height: spLg),
            Text(
              "Activity Level",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...List.generate(activityLevels.length, (index) {
              final level = activityLevels[index];
              final isSelected = activityLevel == level["level"];
              
              return GestureDetector(
                onTap: () {
                  activityLevel = level["level"] as String;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(25) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: isSelected 
                        ? Border.all(color: primaryColor, width: 2)
                        : Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${level["level"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${level["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${level["workouts"]}",
                              style: TextStyle(
                                color: warningColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.radio_button_checked,
                          color: primaryColor,
                          size: 24,
                        )
                      else
                        Icon(
                          Icons.radio_button_unchecked,
                          color: disabledBoldColor,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(height: spLg),
            Text(
              "Target Settings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Weight",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Text(
                                  "$currentWeight",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  " kg",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Target Weight",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Text(
                                  "$targetWeight",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
                                  ),
                                ),
                                Text(
                                  " kg",
                                  style: TextStyle(
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
                  SizedBox(height: spMd),
                  Divider(),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Weekly Workout Goal",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "$weeklyWorkouts workouts",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            QButton(
              label: "Update Goals",
              size: bs.md,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
