import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaExamPreparationView extends StatefulWidget {
  const ElaExamPreparationView({super.key});

  @override
  State<ElaExamPreparationView> createState() => _ElaExamPreparationViewState();
}

class _ElaExamPreparationViewState extends State<ElaExamPreparationView> {
  String selectedSubject = "Python Programming";
  int studyDaysLeft = 12;
  
  List<Map<String, dynamic>> subjects = [
    {"label": "Python Programming", "value": "Python Programming"},
    {"label": "Data Structures", "value": "Data Structures"},
    {"label": "Algorithms", "value": "Algorithms"},
    {"label": "Web Development", "value": "Web Development"},
  ];
  
  List<Map<String, dynamic>> studyPlan = [
    {
      "day": 1,
      "topics": ["Variables & Data Types", "Basic Operations"],
      "completed": true,
      "studyTime": 2.5
    },
    {
      "day": 2,
      "topics": ["Functions", "Control Structures"],
      "completed": true,
      "studyTime": 3.0
    },
    {
      "day": 3,
      "topics": ["Lists & Dictionaries", "File Handling"],
      "completed": false,
      "studyTime": 2.5
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam Preparation"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject Selection
            QDropdownField(
              label: "Select Subject",
              items: subjects,
              value: selectedSubject,
              onChanged: (value, label) {
                selectedSubject = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),

            // Progress Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Text(
                    "$studyDaysLeft Days Until Exam",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: 0.65,
                    backgroundColor: Colors.white.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "65% Preparation Complete",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Study Plan
            Text(
              "Study Plan",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Column(
              children: studyPlan.map((day) {
                bool completed = day["completed"] as bool;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: completed ? successColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: completed ? Border.all(color: successColor) : null,
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: completed ? successColor : primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: completed 
                            ? Icon(Icons.check, color: Colors.white)
                            : Text("${day["day"]}", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Day ${day["day"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            ...((day["topics"] as List).map((topic) => 
                              Text("• $topic", style: TextStyle(fontSize: 12, color: disabledBoldColor))
                            )),
                            Text(
                              "${day["studyTime"]} hours",
                              style: TextStyle(fontSize: 11, color: disabledBoldColor),
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
    );
  }
}