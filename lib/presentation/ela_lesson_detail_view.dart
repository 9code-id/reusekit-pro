import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaLessonDetailView extends StatefulWidget {
  const ElaLessonDetailView({super.key});

  @override
  State<ElaLessonDetailView> createState() => _ElaLessonDetailViewState();
}

class _ElaLessonDetailViewState extends State<ElaLessonDetailView> {
  bool loading = true;
  bool isEnrolled = true;
  int currentTab = 0;

  Map<String, dynamic> lesson = {
    "id": "lesson_001",
    "title": "Introduction to Character Analysis",
    "subject": "Literature",
    "grade": "Grade 5",
    "duration": "45 minutes",
    "difficulty": "Medium",
    "progress": 65,
    "totalSections": 6,
    "completedSections": 4,
    "description": "Master the art of character analysis through interactive lessons and real-world examples. This comprehensive course will teach you how to identify character traits, analyze motivations, track character development, and understand the role of characters in storytelling.",
    "thumbnail": "https://picsum.photos/400/250?random=1&keyword=books",
    "status": "In Progress",
    "lastAccessed": "2024-03-15",
    "type": "Interactive",
    "hasQuiz": true,
    "rating": 4.8,
    "enrolledStudents": 156,
    "instructor": "Mrs. Sarah Johnson",
    "instructorAvatar": "https://picsum.photos/80/80?random=10&keyword=teacher",
    "publishedDate": "2024-01-15",
    "tags": ["Character Analysis", "Literature", "Reading Comprehension", "Critical Thinking"],
    "learningObjectives": [
      "Identify and analyze character traits in literature",
      "Understand character motivations and conflicts",
      "Track character development throughout a story",
      "Compare and contrast different characters",
      "Apply character analysis to real-world situations",
    ],
    "prerequisites": [
      "Basic reading comprehension skills",
      "Familiarity with story elements",
      "Completed Grade 4 ELA requirements",
    ],
  };

  List<Map<String, dynamic>> sections = [
    {
      "id": "section_1",
      "title": "What is Character Analysis?",
      "duration": "8 minutes",
      "type": "Video",
      "isCompleted": true,
      "isLocked": false,
      "description": "Introduction to character analysis concepts and importance",
    },
    {
      "id": "section_2", 
      "title": "Character Traits and Attributes",
      "duration": "12 minutes",
      "type": "Interactive",
      "isCompleted": true,
      "isLocked": false,
      "description": "Learn to identify physical and personality traits",
    },
    {
      "id": "section_3",
      "title": "Understanding Character Motivations",
      "duration": "10 minutes",
      "type": "Reading",
      "isCompleted": true,
      "isLocked": false,
      "description": "Explore why characters make certain decisions",
    },
    {
      "id": "section_4",
      "title": "Character Development and Growth",
      "duration": "15 minutes",
      "type": "Interactive",
      "isCompleted": true,
      "isLocked": false,
      "description": "Track how characters change throughout the story",
    },
    {
      "id": "section_5",
      "title": "Practice Exercise: Character Analysis",
      "duration": "20 minutes",
      "type": "Exercise",
      "isCompleted": false,
      "isLocked": false,
      "description": "Apply your knowledge with guided practice",
    },
    {
      "id": "section_6",
      "title": "Final Assessment Quiz",
      "duration": "15 minutes",
      "type": "Quiz",
      "isCompleted": false,
      "isLocked": false,
      "description": "Test your understanding of character analysis",
    },
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "id": "review_1",
      "studentName": "Emily Chen",
      "studentAvatar": "https://picsum.photos/50/50?random=20&keyword=student",
      "rating": 5,
      "comment": "This lesson really helped me understand how to analyze characters better. The interactive exercises were engaging!",
      "date": "2024-03-10",
      "helpful": 12,
    },
    {
      "id": "review_2",
      "studentName": "Marcus Thompson",
      "studentAvatar": "https://picsum.photos/50/50?random=21&keyword=student",
      "rating": 4,
      "comment": "Great explanations and examples. I wish there were more practice exercises though.",
      "date": "2024-03-08",
      "helpful": 8,
    },
    {
      "id": "review_3",
      "studentName": "Sofia Rodriguez",
      "studentAvatar": "https://picsum.photos/50/50?random=22&keyword=student",
      "rating": 5,
      "comment": "Mrs. Johnson explains everything so clearly. I feel much more confident analyzing characters now!",
      "date": "2024-03-05",
      "helpful": 15,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadLessonDetails();
  }

  void _loadLessonDetails() async {
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    setState(() {});
  }

  Color _getSectionTypeColor(String type) {
    switch (type) {
      case "Video":
        return primaryColor;
      case "Interactive":
        return warningColor;
      case "Reading":
        return infoColor;
      case "Exercise":
        return successColor;
      case "Quiz":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getSectionTypeIcon(String type) {
    switch (type) {
      case "Video":
        return Icons.play_circle;
      case "Interactive":
        return Icons.touch_app;
      case "Reading":
        return Icons.menu_book;
      case "Exercise":
        return Icons.assignment;
      case "Quiz":
        return Icons.quiz;
      default:
        return Icons.circle;
    }
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : index < rating
                  ? Icons.star_half
                  : Icons.star_border,
          color: warningColor,
          size: 16,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Lesson Details"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return QTabBar(
      title: "${lesson["title"]}",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.info)),
        Tab(text: "Content", icon: Icon(Icons.list)),
        Tab(text: "Reviews", icon: Icon(Icons.rate_review)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lesson Thumbnail
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusMd),
                  child: Image.network(
                    "${lesson["thumbnail"]}",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Lesson Info
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Rating
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "${lesson["title"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Column(
                          children: [
                            _buildStarRating(lesson["rating"] as double),
                            SizedBox(height: 4),
                            Text(
                              "${lesson["rating"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Tags
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${lesson["subject"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${lesson["grade"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: warningColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${lesson["difficulty"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Stats
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${lesson["duration"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.people,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${lesson["enrolledStudents"]} students",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.play_circle,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${lesson["totalSections"]} sections",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Progress
              if (isEnrolled)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Your Progress",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${lesson["progress"]}%",
                            style: TextStyle(
                              fontSize: fsH6,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (lesson["progress"] as num) / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${lesson["completedSections"]}/${lesson["totalSections"]} sections completed",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),

              // Description
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${lesson["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Learning Objectives
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Learning Objectives",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Column(
                      children: (lesson["learningObjectives"] as List).map((objective) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "$objective",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
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

              // Instructor
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${lesson["instructorAvatar"]}",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Instructor",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${lesson["instructor"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "ELA Specialist",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.message,
                      size: bs.sm,
                      onPressed: () {
                        // Message instructor
                      },
                    ),
                  ],
                ),
              ),

              // Action Buttons
              if (isEnrolled)
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: lesson["progress"] == 0 
                        ? "Start Lesson" 
                        : "Continue Learning",
                    size: bs.md,
                    onPressed: () {
                      // Navigate to lesson player
                    },
                  ),
                )
              else
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Enroll Now",
                    size: bs.md,
                    onPressed: () {
                      // Enroll in lesson
                    },
                  ),
                ),
            ],
          ),
        ),

        // Content Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Progress Summary
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.school,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Course Progress",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${lesson["completedSections"]} of ${lesson["totalSections"]} sections completed",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${lesson["progress"]}%",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Sections List
              Column(
                children: sections.map((section) {
                  int index = sections.indexOf(section);
                  bool isCompleted = section["isCompleted"];
                  bool isLocked = section["isLocked"];
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: isCompleted 
                          ? Border.all(color: successColor.withValues(alpha: 0.3), width: 2)
                          : null,
                    ),
                    child: Row(
                      children: [
                        // Section Number/Status
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isCompleted 
                                ? successColor 
                                : isLocked 
                                    ? disabledColor 
                                    : _getSectionTypeColor("${section["type"]}"),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Center(
                            child: isCompleted 
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                : isLocked 
                                    ? Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                          ),
                        ),
                        SizedBox(width: spSm),

                        // Section Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${section["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: isLocked ? disabledBoldColor : primaryColor,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${section["description"]}",
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
                                  Icon(
                                    _getSectionTypeIcon("${section["type"]}"),
                                    size: 14,
                                    color: _getSectionTypeColor("${section["type"]}"),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${section["type"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: _getSectionTypeColor("${section["type"]}"),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.schedule,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${section["duration"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Action Button
                        if (!isLocked)
                          QButton(
                            label: isCompleted ? "Review" : "Start",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to section
                            },
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Reviews Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Rating Summary
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "${lesson["rating"]}",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        _buildStarRating(lesson["rating"] as double),
                        SizedBox(height: 4),
                        Text(
                          "${reviews.length} reviews",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        children: [
                          _buildRatingBar("5 stars", 70),
                          _buildRatingBar("4 stars", 20),
                          _buildRatingBar("3 stars", 8),
                          _buildRatingBar("2 stars", 1),
                          _buildRatingBar("1 star", 1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Reviews List
              Column(
                children: reviews.map((review) {
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
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusLg),
                              child: Image.network(
                                "${review["studentAvatar"]}",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${review["studentName"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      _buildStarRating((review["rating"] as num).toDouble()),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${review["date"]}",
                                        style: TextStyle(
                                          fontSize: 11,
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
                        SizedBox(height: spXs),
                        Text(
                          "${review["comment"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Mark as helpful
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Helpful (${review["helpful"]})",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBar(String label, int percentage) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: spXs),
          SizedBox(
            width: 30,
            child: Text(
              "$percentage%",
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
