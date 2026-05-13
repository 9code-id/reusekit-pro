import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaRecommendationsView extends StatefulWidget {
  const ElaRecommendationsView({super.key});

  @override
  State<ElaRecommendationsView> createState() => _ElaRecommendationsViewState();
}

class _ElaRecommendationsViewState extends State<ElaRecommendationsView> {
  String selectedCategory = "All";
  String selectedGrade = "All Grades";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Reading", "value": "Reading"},
    {"label": "Writing", "value": "Writing"},
    {"label": "Speaking", "value": "Speaking"},
    {"label": "Listening", "value": "Listening"},
  ];

  List<Map<String, dynamic>> grades = [
    {"label": "All Grades", "value": "All Grades"},
    {"label": "Kindergarten", "value": "K"},
    {"label": "Grade 1", "value": "1"},
    {"label": "Grade 2", "value": "2"},
    {"label": "Grade 3", "value": "3"},
    {"label": "Grade 4", "value": "4"},
    {"label": "Grade 5", "value": "5"},
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "id": 1,
      "title": "Phonics Games Collection",
      "category": "Reading",
      "type": "Interactive Activity",
      "description": "Engaging phonics games to improve letter-sound recognition",
      "grade_levels": ["K", "1"],
      "difficulty": "Beginner",
      "duration": "15-20 minutes",
      "rating": 4.8,
      "reviews": 245,
      "features": ["Interactive", "Audio Support", "Progress Tracking"],
      "image": "https://picsum.photos/300/200?random=1&keyword=education",
      "reason": "Based on your student's phonics assessment scores",
      "priority": "High",
      "completion_rate": 89,
    },
    {
      "id": 2,
      "title": "Creative Writing Prompts",
      "category": "Writing",
      "type": "Writing Activity",
      "description": "Inspiring prompts to spark creative writing and imagination",
      "grade_levels": ["2", "3", "4"],
      "difficulty": "Intermediate",
      "duration": "30-45 minutes",
      "rating": 4.6,
      "reviews": 186,
      "features": ["Guided Templates", "Illustration Tools", "Peer Sharing"],
      "image": "https://picsum.photos/300/200?random=2&keyword=writing",
      "reason": "To develop creative expression and writing fluency",
      "priority": "Medium",
      "completion_rate": 76,
    },
    {
      "id": 3,
      "title": "Reading Comprehension Stories",
      "category": "Reading",
      "type": "Digital Book",
      "description": "Interactive stories with comprehension questions and activities",
      "grade_levels": ["3", "4", "5"],
      "difficulty": "Intermediate",
      "duration": "25-35 minutes",
      "rating": 4.9,
      "reviews": 312,
      "features": ["Audio Narration", "Vocabulary Support", "Quiz Questions"],
      "image": "https://picsum.photos/300/200?random=3&keyword=books",
      "reason": "Perfect for improving reading comprehension skills",
      "priority": "High",
      "completion_rate": 92,
    },
    {
      "id": 4,
      "title": "Presentation Skills Workshop",
      "category": "Speaking",
      "type": "Video Lesson",
      "description": "Learn effective presentation and public speaking techniques",
      "grade_levels": ["4", "5"],
      "difficulty": "Advanced",
      "duration": "40-50 minutes",
      "rating": 4.5,
      "reviews": 98,
      "features": ["Video Examples", "Practice Exercises", "Feedback Tools"],
      "image": "https://picsum.photos/300/200?random=4&keyword=presentation",
      "reason": "To build confidence in oral communication",
      "priority": "Low",
      "completion_rate": 68,
    },
    {
      "id": 5,
      "title": "Active Listening Activities",
      "category": "Listening",
      "type": "Audio Exercise",
      "description": "Interactive exercises to improve listening and comprehension",
      "grade_levels": ["K", "1", "2"],
      "difficulty": "Beginner",
      "duration": "10-15 minutes",
      "rating": 4.7,
      "reviews": 156,
      "features": ["Audio Stories", "Response Questions", "Visual Cues"],
      "image": "https://picsum.photos/300/200?random=5&keyword=listening",
      "reason": "Based on listening skills assessment results",
      "priority": "Medium",
      "completion_rate": 84,
    },
    {
      "id": 6,
      "title": "Grammar Detective Game",
      "category": "Writing",
      "type": "Interactive Game",
      "description": "Fun detective game to learn grammar rules and usage",
      "grade_levels": ["3", "4"],
      "difficulty": "Intermediate",
      "duration": "20-25 minutes",
      "rating": 4.4,
      "reviews": 203,
      "features": ["Gamification", "Achievement Badges", "Progress Reports"],
      "image": "https://picsum.photos/300/200?random=6&keyword=detective",
      "reason": "To strengthen grammar and language mechanics",
      "priority": "Medium",
      "completion_rate": 79,
    },
  ];

  List<Map<String, dynamic>> get filteredRecommendations {
    return recommendations.where((rec) {
      bool categoryMatch = selectedCategory == "All" || 
                          (rec["category"] as String) == selectedCategory;
      bool gradeMatch = selectedGrade == "All Grades" || 
                       (rec["grade_levels"] as List).contains(selectedGrade);
      return categoryMatch && gradeMatch;
    }).toList();
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ELA Recommendations"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              //navigateTo('recommendation_settings')
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              //navigateTo('saved_recommendations')
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
            // AI Insights Banner
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AI-Powered Recommendations",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Personalized based on your learning progress and goals",
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

            // Filters
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
                    "Filter Recommendations",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
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
                          label: "Grade Level",
                          items: grades,
                          value: selectedGrade,
                          onChanged: (value, label) {
                            selectedGrade = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredRecommendations.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Recommendations",
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredRecommendations.where((r) => r["priority"] == "High").length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "High Priority",
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "4.6",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Avg Rating",
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

            // Recommendations List
            Text(
              "Recommended for You",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredRecommendations.map((recommendation) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Header
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            "${recommendation["image"]}",
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: getPriorityColor("${recommendation["priority"]}"),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${recommendation["priority"]} Priority",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${recommendation["type"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
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
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${recommendation["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: getDifficultyColor("${recommendation["difficulty"]}"),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${recommendation["difficulty"]}",
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
                            "${recommendation["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),

                          // AI Reason
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border(
                                left: BorderSide(
                                  width: 3,
                                  color: infoColor,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.psychology,
                                  color: infoColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${recommendation["reason"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Stats Row
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${recommendation["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.star,
                                size: 16,
                                color: warningColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${recommendation["rating"]} (${recommendation["reviews"]})",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${recommendation["completion_rate"]}% completion",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          // Grade Levels
                          Wrap(
                            spacing: spXs,
                            children: (recommendation["grade_levels"] as List).map((grade) {
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
                                  "Grade $grade",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          // Features
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (recommendation["features"] as List).map((feature) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$feature",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Start Activity",
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigateTo('activity_detail')
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.bookmark_border,
                                size: bs.sm,
                                onPressed: () {
                                  //saveRecommendation()
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.share,
                                size: bs.sm,
                                onPressed: () {
                                  //shareRecommendation()
                                },
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

            if (filteredRecommendations.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No recommendations found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filter settings",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
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
