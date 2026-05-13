import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaLanguageLearningView extends StatefulWidget {
  const ElaLanguageLearningView({super.key});

  @override
  State<ElaLanguageLearningView> createState() => _ElaLanguageLearningViewState();
}

class _ElaLanguageLearningViewState extends State<ElaLanguageLearningView> {
  int currentTab = 0;
  String selectedLanguage = "Spanish";
  String selectedLevel = "Beginner";

  final List<Map<String, dynamic>> languages = [
    {"label": "Spanish", "value": "Spanish", "flag": "🇪🇸"},
    {"label": "French", "value": "French", "flag": "🇫🇷"},
    {"label": "German", "value": "German", "flag": "🇩🇪"},
    {"label": "Italian", "value": "Italian", "flag": "🇮🇹"},
    {"label": "Portuguese", "value": "Portuguese", "flag": "🇵🇹"},
    {"label": "Japanese", "value": "Japanese", "flag": "🇯🇵"},
  ];

  final List<Map<String, dynamic>> levels = [
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
  ];

  final List<Map<String, dynamic>> lessons = [
    {
      "id": 1,
      "title": "Basic Greetings",
      "language": "Spanish",
      "level": "Beginner",
      "duration": 15,
      "progress": 100,
      "type": "Vocabulary",
      "description": "Learn essential greetings and polite expressions",
      "wordsCount": 20,
      "isCompleted": true,
      "difficulty": 1,
      "rating": 4.8,
    },
    {
      "id": 2,
      "title": "Numbers 1-100",
      "language": "Spanish",
      "level": "Beginner",
      "duration": 25,
      "progress": 75,
      "type": "Numbers",
      "description": "Master counting and basic number usage",
      "wordsCount": 100,
      "isCompleted": false,
      "difficulty": 2,
      "rating": 4.7,
    },
    {
      "id": 3,
      "title": "Present Tense Verbs",
      "language": "Spanish",
      "level": "Beginner",
      "duration": 30,
      "progress": 45,
      "type": "Grammar",
      "description": "Understanding regular and irregular present tense",
      "wordsCount": 50,
      "isCompleted": false,
      "difficulty": 3,
      "rating": 4.6,
    },
    {
      "id": 4,
      "title": "Family Members",
      "language": "Spanish",
      "level": "Beginner",
      "duration": 20,
      "progress": 0,
      "type": "Vocabulary",
      "description": "Learn family relationship terms",
      "wordsCount": 25,
      "isCompleted": false,
      "difficulty": 1,
      "rating": 4.9,
    },
    {
      "id": 5,
      "title": "Restaurant Conversations",
      "language": "Spanish",
      "level": "Intermediate",
      "duration": 35,
      "progress": 60,
      "type": "Speaking",
      "description": "Practice ordering food and restaurant interactions",
      "wordsCount": 40,
      "isCompleted": false,
      "difficulty": 4,
      "rating": 4.5,
    },
    {
      "id": 6,
      "title": "Past Tense Usage",
      "language": "Spanish",
      "level": "Intermediate",
      "duration": 40,
      "progress": 25,
      "type": "Grammar",
      "description": "Master preterite and imperfect past tenses",
      "wordsCount": 60,
      "isCompleted": false,
      "difficulty": 5,
      "rating": 4.4,
    },
  ];

  final List<Map<String, dynamic>> achievements = [
    {
      "title": "First Steps",
      "description": "Complete your first lesson",
      "icon": Icons.star,
      "earned": true,
      "date": "2024-01-15",
    },
    {
      "title": "Streak Master",
      "description": "7 day learning streak",
      "icon": Icons.whatshot,
      "earned": true,
      "date": "2024-01-20",
    },
    {
      "title": "Vocabulary Builder",
      "description": "Learn 100 new words",
      "icon": Icons.book,
      "earned": false,
      "date": null,
    },
    {
      "title": "Grammar Expert",
      "description": "Complete 10 grammar lessons",
      "icon": Icons.school,
      "earned": false,
      "date": null,
    },
  ];

  List<Map<String, dynamic>> get filteredLessons {
    return lessons.where((lesson) {
      return "${lesson["language"]}" == selectedLanguage &&
             "${lesson["level"]}" == selectedLevel;
    }).toList();
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Vocabulary":
        return primaryColor;
      case "Grammar":
        return successColor;
      case "Speaking":
        return warningColor;
      case "Listening":
        return infoColor;
      case "Numbers":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildLessonsTab() {
    return Column(
      spacing: spMd,
      children: [
        // Language and Level Selection
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
              QDropdownField(
                label: "Language",
                items: languages,
                value: selectedLanguage,
                onChanged: (value, label) {
                  selectedLanguage = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Level",
                items: levels,
                value: selectedLevel,
                onChanged: (value, label) {
                  selectedLevel = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),

        // Progress Overview
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Text(
                "Your Progress in $selectedLanguage",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredLessons.where((l) => l["isCompleted"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Completed",
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
                      children: [
                        Text(
                          "${filteredLessons.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Total Lessons",
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
                      children: [
                        Text(
                          "${((filteredLessons.fold(0.0, (sum, lesson) => sum + (lesson["progress"] as int)) / filteredLessons.length)).toInt()}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Average",
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

        // Lessons List
        ...filteredLessons.map((lesson) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(spSm),
                  child: Row(
                    children: [
                      // Type Icon
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _getTypeColor("${lesson["type"]}"),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          lesson["type"] == "Vocabulary" ? Icons.book :
                          lesson["type"] == "Grammar" ? Icons.rule :
                          lesson["type"] == "Speaking" ? Icons.mic :
                          lesson["type"] == "Listening" ? Icons.headphones :
                          lesson["type"] == "Numbers" ? Icons.numbers :
                          Icons.school,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      
                      // Lesson Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${lesson["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if (lesson["isCompleted"] as bool)
                                  Icon(
                                    Icons.check_circle,
                                    color: successColor,
                                    size: 20,
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${lesson["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getTypeColor("${lesson["type"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${lesson["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getTypeColor("${lesson["type"]}"),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.access_time,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${lesson["duration"]} min",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.menu_book,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${lesson["wordsCount"]} words",
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
                    ],
                  ),
                ),

                // Progress Bar
                if ((lesson["progress"] as int) > 0)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Progress",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${lesson["progress"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: (lesson["progress"] as int) / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      ],
                    ),
                  ),

                // Action Button
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Container(
                    width: double.infinity,
                    child: QButton(
                      label: (lesson["isCompleted"] as bool) 
                          ? "Review Lesson" 
                          : (lesson["progress"] as int) > 0 
                              ? "Continue Learning" 
                              : "Start Lesson",
                      icon: (lesson["isCompleted"] as bool) 
                          ? Icons.refresh 
                          : (lesson["progress"] as int) > 0 
                              ? Icons.play_arrow 
                              : Icons.play_circle_outline,
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to lesson
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),

        if (filteredLessons.isEmpty)
          Container(
            padding: EdgeInsets.all(spLg),
            child: Column(
              children: [
                Icon(
                  Icons.school_outlined,
                  size: 64,
                  color: disabledColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "No lessons available",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Try selecting a different level",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildAchievementsTab() {
    return Column(
      spacing: spMd,
      children: [
        // Achievements Header
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: warningColor,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Icon(
                Icons.emoji_events,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Achievements",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${achievements.where((a) => a["earned"] as bool).length} of ${achievements.length} earned",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Achievements List
        ...achievements.map((achievement) {
          bool isEarned = achievement["earned"] as bool;
          
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: isEarned 
                  ? Border.all(color: warningColor.withAlpha(100), width: 2)
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isEarned ? warningColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    achievement["icon"] as IconData,
                    color: Colors.white,
                    size: 24,
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
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: isEarned ? primaryColor : disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${achievement["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (isEarned && achievement["date"] != null)
                        Text(
                          "Earned on ${achievement["date"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
                if (isEarned)
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 24,
                  )
                else
                  Icon(
                    Icons.lock_outline,
                    color: disabledColor,
                    size: 24,
                  ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Language Learning",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Lessons", icon: Icon(Icons.school)),
        Tab(text: "Achievements", icon: Icon(Icons.emoji_events)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildLessonsTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildAchievementsTab(),
        ),
      ],
    );
  }
}
