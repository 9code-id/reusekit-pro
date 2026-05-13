import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaStudyPlanView extends StatefulWidget {
  const ElaStudyPlanView({super.key});

  @override
  State<ElaStudyPlanView> createState() => _ElaStudyPlanViewState();
}

class _ElaStudyPlanViewState extends State<ElaStudyPlanView> {
  String selectedGoal = "Complete Course";
  String selectedTimeframe = "4 weeks";
  int dailyStudyHours = 2;
  bool isCustomPlan = false;
  
  List<Map<String, dynamic>> goalOptions = [
    {"label": "Complete Course", "value": "Complete Course"},
    {"label": "Pass Exam", "value": "Pass Exam"},
    {"label": "Learn New Skill", "value": "Learn New Skill"},
    {"label": "Career Change", "value": "Career Change"},
  ];
  
  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "2 weeks", "value": "2 weeks"},
    {"label": "4 weeks", "value": "4 weeks"},
    {"label": "8 weeks", "value": "8 weeks"},
    {"label": "12 weeks", "value": "12 weeks"},
  ];
  
  List<Map<String, dynamic>> weeklyPlan = [
    {
      "week": 1,
      "title": "Fundamentals & Basics",
      "progress": 100,
      "completed": true,
      "tasks": [
        {"name": "Introduction to Programming", "completed": true, "duration": "2 hours"},
        {"name": "Variables and Data Types", "completed": true, "duration": "1.5 hours"},
        {"name": "Basic Operations", "completed": true, "duration": "1 hour"},
        {"name": "Practice Exercises", "completed": true, "duration": "2 hours"},
      ],
    },
    {
      "week": 2,
      "title": "Control Structures",
      "progress": 75,
      "completed": false,
      "tasks": [
        {"name": "Conditional Statements", "completed": true, "duration": "2 hours"},
        {"name": "Loops and Iterations", "completed": true, "duration": "2.5 hours"},
        {"name": "Functions and Methods", "completed": true, "duration": "2 hours"},
        {"name": "Advanced Exercises", "completed": false, "duration": "1.5 hours"},
      ],
    },
    {
      "week": 3,
      "title": "Data Structures",
      "progress": 30,
      "completed": false,
      "tasks": [
        {"name": "Arrays and Lists", "completed": true, "duration": "2 hours"},
        {"name": "Hash Tables", "completed": false, "duration": "2 hours"},
        {"name": "Trees and Graphs", "completed": false, "duration": "3 hours"},
        {"name": "Practical Projects", "completed": false, "duration": "2 hours"},
      ],
    },
    {
      "week": 4,
      "title": "Final Project & Review",
      "progress": 0,
      "completed": false,
      "tasks": [
        {"name": "Project Planning", "completed": false, "duration": "1 hour"},
        {"name": "Implementation", "completed": false, "duration": "4 hours"},
        {"name": "Testing & Debugging", "completed": false, "duration": "2 hours"},
        {"name": "Final Review", "completed": false, "duration": "1 hour"},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study Plan"),
        actions: [
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {
              isCustomPlan = !isCustomPlan;
              setState(() {});
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Study Goal Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.flag,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Your Study Goal",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Master Python Programming",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Complete in 4 weeks with 2 hours/day commitment",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: 0.51,
                    backgroundColor: Colors.white.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "51% Complete • 2 weeks remaining",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.today,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "14",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Days Left",
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
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Colors.orange,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "28",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Hours Left",
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
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "12",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Day Streak",
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
            SizedBox(height: spLg),

            // Customize Plan Toggle
            if (isCustomPlan) ...[
              Text(
                "Customize Your Plan",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Study Goal",
                      items: goalOptions,
                      value: selectedGoal,
                      onChanged: (value, label) {
                        selectedGoal = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Timeline",
                      items: timeframeOptions,
                      value: selectedTimeframe,
                      onChanged: (value, label) {
                        selectedTimeframe = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Text(
                    "Daily Study Hours: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "$dailyStudyHours hours",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Slider(
                value: dailyStudyHours.toDouble(),
                min: 1,
                max: 8,
                divisions: 7,
                onChanged: (value) {
                  dailyStudyHours = value.round();
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),
            ],

            // Weekly Breakdown
            Text(
              "Weekly Breakdown",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Column(
              children: weeklyPlan.map((week) {
                bool isCompleted = week["completed"] as bool;
                int progress = week["progress"] as int;
                List tasks = week["tasks"] as List;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.all(spMd),
                    childrenPadding: EdgeInsets.only(left: spMd, right: spMd, bottom: spMd),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isCompleted ? successColor : primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: isCompleted 
                          ? Icon(Icons.check, color: Colors.white, size: 20)
                          : Text(
                              "W${week["week"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                      ),
                    ),
                    title: Text(
                      "${week["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "$progress% Complete",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${tasks.where((t) => t["completed"] == true).length}/${tasks.length} tasks",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: progress / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isCompleted ? successColor : primaryColor,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Column(
                        children: tasks.map<Widget>((task) {
                          bool taskCompleted = task["completed"] as bool;
                          return Container(
                            margin: EdgeInsets.only(bottom: spXs),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: taskCompleted ? successColor.withAlpha(20) : Colors.grey.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  taskCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                                  color: taskCompleted ? successColor : disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${task["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: taskCompleted ? successColor : primaryColor,
                                      decoration: taskCompleted ? TextDecoration.lineThrough : null,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${task["duration"]}",
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
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Action Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Continue Today's Study",
                icon: Icons.play_arrow,
                size: bs.md,
                onPressed: () {
                  // Navigate to current lesson
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
