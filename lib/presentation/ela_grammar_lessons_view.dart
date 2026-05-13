import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaGrammarLessonsView extends StatefulWidget {
  const ElaGrammarLessonsView({super.key});

  @override
  State<ElaGrammarLessonsView> createState() => _ElaGrammarLessonsViewState();
}

class _ElaGrammarLessonsViewState extends State<ElaGrammarLessonsView> {
  String selectedCategory = "All";
  String selectedLevel = "All";
  String searchQuery = "";

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Parts of Speech", "value": "Parts of Speech"},
    {"label": "Sentence Structure", "value": "Sentence Structure"},
    {"label": "Punctuation", "value": "Punctuation"},
    {"label": "Verb Tenses", "value": "Verb Tenses"},
    {"label": "Clauses & Phrases", "value": "Clauses & Phrases"},
    {"label": "Writing Mechanics", "value": "Writing Mechanics"},
  ];

  final List<Map<String, dynamic>> levels = [
    {"label": "All", "value": "All"},
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
  ];

  final List<Map<String, dynamic>> lessons = [
    {
      "id": 1,
      "title": "Nouns and Pronouns",
      "category": "Parts of Speech",
      "level": "Beginner",
      "duration": 20,
      "description": "Understanding the basics of nouns and how pronouns replace them",
      "objectives": [
        "Identify common and proper nouns",
        "Use personal pronouns correctly",
        "Understand noun-pronoun agreement"
      ],
      "examples": [
        "The cat (noun) → It (pronoun)",
        "Sarah (proper noun) → She (pronoun)",
        "Books (plural noun) → They (pronoun)"
      ],
      "exercises": 15,
      "completed": true,
      "score": 92,
      "difficulty": "Easy",
      "keyPoints": [
        "Nouns name people, places, things, or ideas",
        "Pronouns must agree in number and gender",
        "Proper nouns are always capitalized"
      ],
    },
    {
      "id": 2,
      "title": "Subject-Verb Agreement",
      "category": "Sentence Structure",
      "level": "Intermediate",
      "duration": 35,
      "description": "Mastering the rules of subject-verb agreement in various contexts",
      "objectives": [
        "Apply basic subject-verb agreement rules",
        "Handle complex subjects and compound subjects",
        "Deal with indefinite pronouns and collective nouns"
      ],
      "examples": [
        "The dog runs (singular)",
        "The dogs run (plural)",
        "Neither the teacher nor the students were ready"
      ],
      "exercises": 25,
      "completed": false,
      "score": 0,
      "difficulty": "Medium",
      "keyPoints": [
        "Singular subjects take singular verbs",
        "Plural subjects take plural verbs",
        "Watch for tricky subjects like collective nouns"
      ],
    },
    {
      "id": 3,
      "title": "Comma Usage Rules",
      "category": "Punctuation",
      "level": "Intermediate",
      "duration": 30,
      "description": "Comprehensive guide to using commas correctly in writing",
      "objectives": [
        "Use commas in series and compound sentences",
        "Apply comma rules with introductory elements",
        "Understand restrictive vs. non-restrictive clauses"
      ],
      "examples": [
        "I bought apples, oranges, and bananas.",
        "After the game, we went home.",
        "My brother, who lives in Texas, visited us."
      ],
      "exercises": 20,
      "completed": true,
      "score": 88,
      "difficulty": "Medium",
      "keyPoints": [
        "Use commas in series of three or more",
        "Comma before coordinating conjunctions",
        "Set off non-essential information"
      ],
    },
    {
      "id": 4,
      "title": "Past Perfect Tense",
      "category": "Verb Tenses",
      "level": "Advanced",
      "duration": 40,
      "description": "Understanding when and how to use the past perfect tense",
      "objectives": [
        "Form the past perfect tense correctly",
        "Distinguish from simple past",
        "Use in complex sentence structures"
      ],
      "examples": [
        "She had finished her homework before dinner.",
        "By the time we arrived, the movie had started.",
        "He realized he had forgotten his keys."
      ],
      "exercises": 18,
      "completed": false,
      "score": 0,
      "difficulty": "Hard",
      "keyPoints": [
        "Shows action completed before another past action",
        "Formed with 'had' + past participle",
        "Often used with time expressions"
      ],
    },
    {
      "id": 5,
      "title": "Independent and Dependent Clauses",
      "category": "Clauses & Phrases",
      "level": "Advanced",
      "duration": 45,
      "description": "Analyzing clause types and their functions in sentences",
      "objectives": [
        "Identify independent and dependent clauses",
        "Combine clauses effectively",
        "Avoid sentence fragments and run-ons"
      ],
      "examples": [
        "I went to the store (independent)",
        "Because I needed milk (dependent)",
        "I went to the store because I needed milk (complex)"
      ],
      "exercises": 22,
      "completed": true,
      "score": 95,
      "difficulty": "Hard",
      "keyPoints": [
        "Independent clauses express complete thoughts",
        "Dependent clauses need independent clauses",
        "Use appropriate conjunctions to connect"
      ],
    },
    {
      "id": 6,
      "title": "Semicolons and Colons",
      "category": "Punctuation",
      "level": "Advanced",
      "duration": 25,
      "description": "Proper usage of semicolons and colons in formal writing",
      "objectives": [
        "Use semicolons to connect related ideas",
        "Apply colons for lists and explanations",
        "Distinguish between semicolon and comma usage"
      ],
      "examples": [
        "She loves reading; books are her passion.",
        "Bring these items: pen, paper, and calculator.",
        "The result was clear: we had succeeded."
      ],
      "exercises": 16,
      "completed": false,
      "score": 0,
      "difficulty": "Hard",
      "keyPoints": [
        "Semicolons connect independent clauses",
        "Colons introduce lists or explanations",
        "Use sparingly for maximum impact"
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredLessons {
    return lessons.where((lesson) {
      bool matchesCategory = selectedCategory == "All" || 
                           "${lesson["category"]}" == selectedCategory;
      bool matchesLevel = selectedLevel == "All" || 
                         "${lesson["level"]}" == selectedLevel;
      bool matchesSearch = searchQuery.isEmpty ||
                          "${lesson["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${lesson["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesLevel && matchesSearch;
    }).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Medium":
        return warningColor;
      case "Hard":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grammar Lessons"),
        actions: [
          IconButton(
            icon: Icon(Icons.quiz),
            onPressed: () {
              // Navigate to grammar quiz
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              // Navigate to saved lessons
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
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
                  QTextField(
                    label: "Search lessons...",
                    value: searchQuery,
                    hint: "Enter lesson title or topic",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categories,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Level",
                          items: levels,
                          value: selectedLevel,
                          onChanged: (value, label) {
                            selectedLevel = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
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
                    "Grammar Progress",
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
                              "${lessons.where((l) => l["completed"] as bool).length}",
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
                              "${lessons.length}",
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
                              "${((lessons.where((l) => l["completed"] as bool).length / lessons.length) * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Progress",
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
              bool isCompleted = lesson["completed"] as bool;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: isCompleted 
                      ? Border.all(color: successColor.withAlpha(100), width: 2)
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: _getLevelColor("${lesson["level"]}"),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              isCompleted ? Icons.check_circle : Icons.school,
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
                                  "${lesson["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
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
                                        color: _getLevelColor("${lesson["level"]}"),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${lesson["level"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getDifficultyColor("${lesson["difficulty"]}"),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${lesson["difficulty"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (isCompleted)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${lesson["score"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "${lesson["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),

                          // Learning Objectives
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Learning Objectives:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                ...(lesson["objectives"] as List).map((objective) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "• ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: infoColor,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${objective}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: infoColor,
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

                          // Examples
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Examples:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                ...(lesson["examples"] as List).take(2).map((example) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      "• ${example}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),

                          // Key Points
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Key Points:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                ...(lesson["keyPoints"] as List).map((point) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.lightbulb_outline,
                                          size: 12,
                                          color: warningColor,
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            "${point}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: warningColor,
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

                          // Lesson Stats
                          Row(
                            children: [
                              Icon(
                                Icons.assignment,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${lesson["exercises"]} exercises",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.category,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${lesson["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: isCompleted ? "Review Lesson" : "Start Lesson",
                                  icon: isCompleted ? Icons.refresh : Icons.play_arrow,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to lesson content
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Practice Quiz",
                                  icon: Icons.quiz,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to lesson quiz
                                  },
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

            if (filteredLessons.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No lessons found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
