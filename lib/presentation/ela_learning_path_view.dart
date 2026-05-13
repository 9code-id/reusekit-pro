import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaLearningPathView extends StatefulWidget {
  const ElaLearningPathView({super.key});

  @override
  State<ElaLearningPathView> createState() => _ElaLearningPathViewState();
}

class _ElaLearningPathViewState extends State<ElaLearningPathView> {
  int selectedPath = 0;
  String selectedSkillLevel = "Beginner";

  List<Map<String, dynamic>> learningPaths = [
    {
      "id": 1,
      "title": "Reading Foundations",
      "description": "Build essential reading skills from phonics to fluency",
      "grade_level": "K-2",
      "duration": "12 weeks",
      "modules": 8,
      "progress": 65,
      "difficulty": "Beginner",
      "skills": ["Phonics", "Fluency", "Vocabulary", "Comprehension"],
      "color": successColor,
      "icon": Icons.menu_book,
      "completed_modules": 5,
      "total_activities": 48,
      "completed_activities": 31,
    },
    {
      "id": 2,
      "title": "Writing Mastery",
      "description": "Develop strong writing skills across different genres",
      "grade_level": "3-5",
      "duration": "16 weeks",
      "modules": 10,
      "progress": 40,
      "difficulty": "Intermediate",
      "skills": ["Grammar", "Composition", "Research", "Editing"],
      "color": infoColor,
      "icon": Icons.edit,
      "completed_modules": 4,
      "total_activities": 60,
      "completed_activities": 24,
    },
    {
      "id": 3,
      "title": "Literary Analysis",
      "description": "Advanced analysis and interpretation of literature",
      "grade_level": "6-8",
      "duration": "20 weeks",
      "modules": 12,
      "progress": 25,
      "difficulty": "Advanced",
      "skills": ["Critical Thinking", "Analysis", "Interpretation", "Discussion"],
      "color": warningColor,
      "icon": Icons.psychology,
      "completed_modules": 3,
      "total_activities": 72,
      "completed_activities": 18,
    },
    {
      "id": 4,
      "title": "Speaking & Listening",
      "description": "Build confidence in oral communication and active listening",
      "grade_level": "K-5",
      "duration": "10 weeks",
      "modules": 6,
      "progress": 80,
      "difficulty": "Beginner",
      "skills": ["Presentation", "Discussion", "Listening", "Collaboration"],
      "color": primaryColor,
      "icon": Icons.record_voice_over,
      "completed_modules": 5,
      "total_activities": 36,
      "completed_activities": 29,
    },
  ];

  List<Map<String, dynamic>> currentModules = [
    {
      "id": 1,
      "title": "Sight Words Recognition",
      "description": "Learn and practice high-frequency sight words",
      "progress": 85,
      "status": "In Progress",
      "activities": 6,
      "completed": 5,
      "estimated_time": "45 minutes",
      "due_date": "2025-06-20",
    },
    {
      "id": 2,
      "title": "Reading Fluency Practice",
      "description": "Improve reading speed and accuracy",
      "progress": 60,
      "status": "In Progress",
      "activities": 8,
      "completed": 5,
      "estimated_time": "30 minutes",
      "due_date": "2025-06-22",
    },
    {
      "id": 3,
      "title": "Vocabulary Building",
      "description": "Expand vocabulary through context clues",
      "progress": 0,
      "status": "Not Started",
      "activities": 10,
      "completed": 0,
      "estimated_time": "60 minutes",
      "due_date": "2025-06-25",
    },
  ];

  List<Map<String, dynamic>> skillLevels = [
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
  ];

  List<Map<String, dynamic>> get filteredPaths {
    return learningPaths.where((path) {
      return (path["difficulty"] as String) == selectedSkillLevel;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "In Progress":
        return warningColor;
      case "Completed":
        return successColor;
      case "Not Started":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ELA Learning Paths"),
        actions: [
          IconButton(
            icon: Icon(Icons.track_changes),
            onPressed: () {
              //navigateTo('progress_tracking')
            },
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              //navigateTo('achievements')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Filter Section
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
                    "Filter by Skill Level",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Difficulty Level",
                    items: skillLevels,
                    value: selectedSkillLevel,
                    onChanged: (value, label) {
                      selectedSkillLevel = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Current Progress Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Overall Progress",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "52%",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Completed",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "17",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Modules Completed",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "102",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Activities Done",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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

            // Learning Paths
            Text(
              "Available Learning Paths",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredPaths.map((path) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (path["color"] as Color).withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            path["icon"] as IconData,
                            color: path["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${path["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${path["grade_level"]} • ${path["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: (path["color"] as Color),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${path["difficulty"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Text(
                      "${path["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),

                    // Progress
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Progress",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${path["progress"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: path["color"] as Color,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (path["progress"] as int) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: path["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Stats
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${path["completed_modules"]}/${path["modules"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Modules",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${path["completed_activities"]}/${path["total_activities"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Activities",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: (path["progress"] as int) > 0 ? "Continue" : "Start",
                          size: bs.sm,
                          onPressed: () {
                            selectedPath = path["id"] as int;
                            setState(() {});
                            //navigateTo('learning_path_detail')
                          },
                        ),
                      ],
                    ),

                    // Skills Tags
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (path["skills"] as List).map((skill) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$skill",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),

            // Current Active Modules
            Text(
              "Current Modules",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...currentModules.map((module) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: getStatusColor("${module["status"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${module["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${module["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: getStatusColor("${module["status"]}"),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${module["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    if ((module["progress"] as int) > 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${module["progress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: getStatusColor("${module["status"]}"),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (module["progress"] as int) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: getStatusColor("${module["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${module["completed"]}/${module["activities"]} Activities",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Est. ${module["estimated_time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Due: ${module["due_date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        QButton(
                          label: (module["progress"] as int) > 0 ? "Continue" : "Start",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('module_activities')
                          },
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
    );
  }
}
