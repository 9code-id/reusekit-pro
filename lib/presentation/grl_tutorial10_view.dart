import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTutorial10View extends StatefulWidget {
  @override
  State<GrlTutorial10View> createState() => _GrlTutorial10ViewState();
}

class _GrlTutorial10ViewState extends State<GrlTutorial10View> {
  String userName = "John Doe";
  String completionDate = "March 15, 2024";
  double overallProgress = 85.0;
  
  List<Map<String, dynamic>> achievements = [
    {
      "title": "First Steps",
      "description": "Completed the welcome tutorial",
      "icon": Icons.flag,
      "color": Color(0xFF3B82F6),
      "earned": true,
      "date": "March 10, 2024"
    },
    {
      "title": "Feature Explorer",
      "description": "Explored all main features",
      "icon": Icons.explore,
      "color": Color(0xFF10B981),
      "earned": true,
      "date": "March 12, 2024"
    },
    {
      "title": "Quick Learner",
      "description": "Completed interactive tutorial",
      "icon": Icons.school,
      "color": Color(0xFFF59E0B),
      "earned": true,
      "date": "March 13, 2024"
    },
    {
      "title": "Quiz Master",
      "description": "Passed all knowledge quizzes",
      "icon": Icons.quiz,
      "color": Color(0xFF8B5CF6),
      "earned": true,
      "date": "March 14, 2024"
    },
    {
      "title": "Tip Collector",
      "description": "Learned 50+ tips and tricks",
      "icon": Icons.lightbulb,
      "color": Color(0xFFEF4444),
      "earned": false,
      "date": ""
    },
    {
      "title": "Expert User",
      "description": "Mastered advanced features",
      "icon": Icons.star,
      "color": Color(0xFF06B6D4),
      "earned": false,
      "date": ""
    },
  ];

  List<Map<String, dynamic>> completedSections = [
    {
      "name": "Getting Started",
      "progress": 100.0,
      "lessons": 4,
      "completedLessons": 4,
    },
    {
      "name": "Basic Features",
      "progress": 100.0,
      "lessons": 6,
      "completedLessons": 6,
    },
    {
      "name": "Advanced Tools",
      "progress": 80.0,
      "lessons": 5,
      "completedLessons": 4,
    },
    {
      "name": "Tips & Tricks",
      "progress": 60.0,
      "lessons": 8,
      "completedLessons": 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutorial Complete"),
        actions: [
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              ss("Sharing achievements...");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Completion celebration
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withAlpha(20),
                    successColor.withAlpha(20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Celebration icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.celebration,
                      size: 40,
                      color: successColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Congratulations!",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spXs),
                  
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "You've successfully completed the tutorial program and are now ready to explore all features!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "Completed on $completionDate",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Overall progress
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Overall Progress",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${overallProgress.toInt()}%",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Container(
                    width: double.infinity,
                    height: 8,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: overallProgress / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Section breakdown
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Section Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  ...completedSections.map((section) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${section["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${section["completedLessons"]}/${section["lessons"]} lessons",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${(section["progress"] as double).toInt()}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: (section["progress"] as double) == 100 ? successColor : warningColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Container(
                            width: double.infinity,
                            height: 4,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (section["progress"] as double) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (section["progress"] as double) == 100 ? successColor : warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Achievements
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Achievements Earned",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 150,
                    children: achievements.map((achievement) {
                      final isEarned = achievement["earned"] as bool;
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isEarned ? (achievement["color"] as Color).withAlpha(10) : disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isEarned ? achievement["color"] as Color : disabledColor,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isEarned ? (achievement["color"] as Color).withAlpha(20) : disabledColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                achievement["icon"] as IconData,
                                size: 24,
                                color: isEarned ? achievement["color"] as Color : disabledColor,
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            Text(
                              "${achievement["title"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isEarned ? achievement["color"] as Color : disabledColor,
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Text(
                              "${achievement["description"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: isEarned ? disabledBoldColor : disabledColor,
                              ),
                            ),
                            
                            if (isEarned && achievement["date"].isNotEmpty) ...[
                              SizedBox(height: spXs),
                              Text(
                                "${achievement["date"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: achievement["color"] as Color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Action buttons
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Start Using App",
                    size: bs.md,
                    onPressed: () {
                      ss("Welcome to the full app experience!");
                    },
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          si("Downloading certificate...");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          child: Text(
                            "Download Certificate",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: disabledOutlineBorderColor,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ss("Retaking tutorial...");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          child: Text(
                            "Retake Tutorial",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
