import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaLessonListView extends StatefulWidget {
  const ElaLessonListView({super.key});

  @override
  State<ElaLessonListView> createState() => _ElaLessonListViewState();
}

class _ElaLessonListViewState extends State<ElaLessonListView> {
  String searchQuery = "";
  String selectedGrade = "All Grades";
  String selectedSubject = "All Subjects";
  bool loading = true;

  List<Map<String, dynamic>> gradeOptions = [
    {"label": "All Grades", "value": "All Grades"},
    {"label": "Grade 1", "value": "Grade 1"},
    {"label": "Grade 2", "value": "Grade 2"},
    {"label": "Grade 3", "value": "Grade 3"},
    {"label": "Grade 4", "value": "Grade 4"},
    {"label": "Grade 5", "value": "Grade 5"},
    {"label": "Grade 6", "value": "Grade 6"},
  ];

  List<Map<String, dynamic>> subjectOptions = [
    {"label": "All Subjects", "value": "All Subjects"},
    {"label": "Reading", "value": "Reading"},
    {"label": "Writing", "value": "Writing"},
    {"label": "Grammar", "value": "Grammar"},
    {"label": "Vocabulary", "value": "Vocabulary"},
    {"label": "Literature", "value": "Literature"},
  ];

  List<Map<String, dynamic>> lessons = [
    {
      "id": "lesson_001",
      "title": "Introduction to Character Analysis",
      "subject": "Literature",
      "grade": "Grade 5",
      "duration": "45 minutes",
      "difficulty": "Medium",
      "progress": 85,
      "totalSections": 6,
      "completedSections": 5,
      "description": "Learn how to analyze character traits, motivations, and development in stories",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=books",
      "status": "In Progress",
      "lastAccessed": "2024-03-15",
      "type": "Interactive",
      "hasQuiz": true,
      "rating": 4.8,
      "enrolledStudents": 156,
    },
    {
      "id": "lesson_002",
      "title": "Poetry Elements and Structure",
      "subject": "Literature",
      "grade": "Grade 4",
      "duration": "30 minutes",
      "difficulty": "Easy",
      "progress": 100,
      "totalSections": 4,
      "completedSections": 4,
      "description": "Explore rhythm, rhyme, meter, and other elements that make poetry special",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=poetry",
      "status": "Completed",
      "lastAccessed": "2024-03-14",
      "type": "Video",
      "hasQuiz": true,
      "rating": 4.9,
      "enrolledStudents": 203,
    },
    {
      "id": "lesson_003",
      "title": "Creative Writing Workshop",
      "subject": "Writing",
      "grade": "Grade 6",
      "duration": "60 minutes",
      "difficulty": "Hard",
      "progress": 0,
      "totalSections": 8,
      "completedSections": 0,
      "description": "Develop your creative writing skills through guided exercises and prompts",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=writing",
      "status": "Not Started",
      "lastAccessed": null,
      "type": "Workshop",
      "hasQuiz": false,
      "rating": 4.7,
      "enrolledStudents": 89,
    },
    {
      "id": "lesson_004",
      "title": "Reading Comprehension Strategies",
      "subject": "Reading",
      "grade": "Grade 3",
      "duration": "40 minutes",
      "difficulty": "Medium",
      "progress": 60,
      "totalSections": 5,
      "completedSections": 3,
      "description": "Master essential reading strategies to improve comprehension and retention",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=reading",
      "status": "In Progress",
      "lastAccessed": "2024-03-16",
      "type": "Interactive",
      "hasQuiz": true,
      "rating": 4.6,
      "enrolledStudents": 267,
    },
    {
      "id": "lesson_005",
      "title": "Grammar Fundamentals",
      "subject": "Grammar",
      "grade": "Grade 2",
      "duration": "25 minutes",
      "difficulty": "Easy",
      "progress": 40,
      "totalSections": 3,
      "completedSections": 1,
      "description": "Learn the basic building blocks of English grammar in a fun way",
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=grammar",
      "status": "In Progress",
      "lastAccessed": "2024-03-13",
      "type": "Game",
      "hasQuiz": true,
      "rating": 4.5,
      "enrolledStudents": 145,
    },
    {
      "id": "lesson_006",
      "title": "Vocabulary Building Adventures",
      "subject": "Vocabulary",
      "grade": "Grade 4",
      "duration": "35 minutes",
      "difficulty": "Medium",
      "progress": 75,
      "totalSections": 4,
      "completedSections": 3,
      "description": "Expand your vocabulary through interactive games and contextual learning",
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=vocabulary",
      "status": "In Progress",
      "lastAccessed": "2024-03-15",
      "type": "Game",
      "hasQuiz": true,
      "rating": 4.8,
      "enrolledStudents": 198,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadLessons();
  }

  void _loadLessons() async {
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredLessons {
    return lessons.where((lesson) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${lesson["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${lesson["subject"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesGrade = selectedGrade == "All Grades" || 
          lesson["grade"] == selectedGrade;
      
      bool matchesSubject = selectedSubject == "All Subjects" || 
          lesson["subject"] == selectedSubject;
      
      return matchesSearch && matchesGrade && matchesSubject;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Not Started":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
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
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("ELA Lessons"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("ELA Lessons"),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              // Sort functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search lessons...",
                    value: searchQuery,
                    hint: "Search by title or subject",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Grade Level",
                    items: gradeOptions,
                    value: selectedGrade,
                    onChanged: (value, label) {
                      selectedGrade = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Subject",
                    items: subjectOptions,
                    value: selectedSubject,
                    onChanged: (value, label) {
                      selectedSubject = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Results Count
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${filteredLessons.length} lessons found",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Lessons Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredLessons.map((lesson) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnail
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(radiusMd),
                              ),
                              child: Image.network(
                                "${lesson["thumbnail"]}",
                                width: double.infinity,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${lesson["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${lesson["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            if (lesson["progress"] > 0)
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.3),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: (lesson["progress"] as num) / 100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Content
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                "${lesson["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),

                              // Subject & Grade
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${lesson["subject"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
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
                                      color: secondaryColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${lesson["grade"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),

                              // Description
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

                              // Stats
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${lesson["duration"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getDifficultyColor("${lesson["difficulty"]}").withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${lesson["difficulty"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getDifficultyColor("${lesson["difficulty"]}"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),

                              // Progress
                              if (lesson["progress"] > 0)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Progress",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "${lesson["progress"]}%",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "${lesson["completedSections"]}/${lesson["totalSections"]} sections",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                  ],
                                ),

                              Spacer(),

                              // Action Button
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: lesson["progress"] == 0 
                                      ? "Start Lesson" 
                                      : lesson["progress"] == 100 
                                          ? "Review" 
                                          : "Continue",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to lesson detail
                                  },
                                ),
                              ),
                            ],
                          ),
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
