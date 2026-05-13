import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaStressManagementView extends StatefulWidget {
  const FwaStressManagementView({super.key});

  @override
  State<FwaStressManagementView> createState() => _FwaStressManagementViewState();
}

class _FwaStressManagementViewState extends State<FwaStressManagementView> {
  int currentStressLevel = 6;
  int selectedTechnique = 0;
  bool isTrackingStress = false;
  
  final List<String> stressLevels = [
    "Very Low", "Low", "Mild", "Moderate", "High", "Very High", "Severe"
  ];

  final List<Map<String, dynamic>> techniques = [
    {
      "id": 1,
      "title": "Quick Relief",
      "subtitle": "5-10 minute techniques",
      "icon": Icons.flash_on,
      "color": Colors.orange,
      "exercises": [
        {
          "name": "5-4-3-2-1 Grounding",
          "duration": "5 min",
          "description": "Identify 5 things you see, 4 you can touch, 3 you hear, 2 you smell, 1 you taste",
          "effectiveness": 85,
        },
        {
          "name": "Progressive Muscle Relaxation",
          "duration": "8 min",
          "description": "Tense and release muscle groups systematically",
          "effectiveness": 90,
        },
        {
          "name": "Box Breathing",
          "duration": "5 min",
          "description": "4-count breathing pattern for immediate calm",
          "effectiveness": 80,
        },
      ],
    },
    {
      "id": 2,
      "title": "Deep Practice",
      "subtitle": "15-30 minute sessions",
      "icon": Icons.spa,
      "color": Colors.blue,
      "exercises": [
        {
          "name": "Body Scan Meditation",
          "duration": "20 min",
          "description": "Systematic relaxation through body awareness",
          "effectiveness": 95,
        },
        {
          "name": "Guided Visualization",
          "duration": "15 min",
          "description": "Mental imagery for stress relief and peace",
          "effectiveness": 88,
        },
        {
          "name": "Mindful Movement",
          "duration": "25 min",
          "description": "Gentle yoga flow for stress release",
          "effectiveness": 92,
        },
      ],
    },
    {
      "id": 3,
      "title": "Cognitive Tools",
      "subtitle": "Mental strategies",
      "icon": Icons.psychology,
      "color": Colors.purple,
      "exercises": [
        {
          "name": "Thought Challenging",
          "duration": "10 min",
          "description": "Question and reframe negative thoughts",
          "effectiveness": 85,
        },
        {
          "name": "Worry Time",
          "duration": "15 min",
          "description": "Scheduled time to process concerns",
          "effectiveness": 78,
        },
        {
          "name": "Perspective Shifting",
          "duration": "8 min",
          "description": "View situations from different angles",
          "effectiveness": 82,
        },
      ],
    },
    {
      "id": 4,
      "title": "Physical Release",
      "subtitle": "Movement & exercise",
      "icon": Icons.directions_run,
      "color": Colors.green,
      "exercises": [
        {
          "name": "Stress-Relief Walk",
          "duration": "15 min",
          "description": "Mindful walking to clear your head",
          "effectiveness": 75,
        },
        {
          "name": "Tension Release Stretches",
          "duration": "12 min",
          "description": "Target areas that hold stress",
          "effectiveness": 88,
        },
        {
          "name": "Energy Release Workout",
          "duration": "20 min",
          "description": "High-intensity movement to burn stress",
          "effectiveness": 90,
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> stressFactors = [
    {"factor": "Work", "level": 8, "icon": Icons.work},
    {"factor": "Relationships", "level": 4, "icon": Icons.people},
    {"factor": "Health", "level": 3, "icon": Icons.favorite},
    {"factor": "Finances", "level": 7, "icon": Icons.account_balance_wallet},
    {"factor": "Sleep", "level": 6, "icon": Icons.bedtime},
    {"factor": "Time Management", "level": 9, "icon": Icons.schedule},
  ];

  final List<Map<String, dynamic>> weeklyProgress = [
    {"day": "Mon", "level": 7, "techniques": 2},
    {"day": "Tue", "level": 5, "techniques": 3},
    {"day": "Wed", "level": 8, "techniques": 1},
    {"day": "Thu", "level": 4, "techniques": 4},
    {"day": "Fri", "level": 6, "techniques": 2},
    {"day": "Sat", "level": 3, "techniques": 2},
    {"day": "Sun", "level": 2, "techniques": 3},
  ];

  Color getStressLevelColor(int level) {
    if (level <= 2) return successColor;
    if (level <= 4) return warningColor;
    if (level <= 6) return Colors.orange;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stress Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // View stress analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Stress Level
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    getStressLevelColor(currentStressLevel),
                    getStressLevelColor(currentStressLevel).withAlpha(180)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Current Stress Level",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.psychology, color: Colors.white),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Text(
                        "$currentStressLevel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${stressLevels[currentStressLevel - 1]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "out of 10",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
                      Expanded(
                        child: QButton(
                          label: "Update Level",
                          size: bs.sm,
                          onPressed: () {
                            // Show stress level selector
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Quick Relief",
                          size: bs.sm,
                          onPressed: () {
                            // Start quick relief technique
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Weekly Progress
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Weekly Stress Trends",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: weeklyProgress.map((day) => Column(
                      children: [
                        Text(
                          "${day["day"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          width: 30,
                          height: (day["level"] as int) * 8.0,
                          decoration: BoxDecoration(
                            color: getStressLevelColor(day["level"]),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${day["level"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )).toList(),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "5.3",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Avg Level",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "17",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Techniques Used",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Stress Factors
            Text(
              "Stress Factors",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...stressFactors.map((factor) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: getStressLevelColor(factor["level"]).withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      factor["icon"],
                      color: getStressLevelColor(factor["level"]),
                      size: 20,
                    ),
                  ),
                  
                  SizedBox(width: spMd),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${factor["factor"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: (factor["level"] as int) / 10,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            getStressLevelColor(factor["level"]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(width: spMd),
                  
                  Text(
                    "${factor["level"]}/10",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: getStressLevelColor(factor["level"]),
                    ),
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Technique Categories
            Text(
              "Stress Management Techniques",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...techniques.map((category) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Category Header
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: (category["color"] as Color).withAlpha(25),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: category["color"],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            category["icon"],
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
                                "${category["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${category["subtitle"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: disabledBoldColor,
                        ),
                      ],
                    ),
                  ),
                  
                  // Exercises List
                  ...(category["exercises"] as List).map((exercise) => Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey[200]!, width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${exercise["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${exercise["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${exercise["duration"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(Icons.trending_up, size: 16, color: successColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${exercise["effectiveness"]}% effective",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(width: spMd),
                        
                        QButton(
                          label: "Try",
                          size: bs.sm,
                          onPressed: () {
                            // Start technique
                          },
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
