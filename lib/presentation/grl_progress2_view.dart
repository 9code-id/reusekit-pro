import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProgress2View extends StatefulWidget {
  @override
  State<GrlProgress2View> createState() => _GrlProgress2ViewState();
}

class _GrlProgress2ViewState extends State<GrlProgress2View> {
  List<Map<String, dynamic>> learningProgress = [
    {
      "id": "1",
      "course": "Advanced Flutter Development",
      "instructor": "Dr. Sarah Johnson",
      "instructorAvatar": "https://picsum.photos/40/40?random=1&keyword=instructor",
      "progress": 68,
      "completedLessons": 17,
      "totalLessons": 25,
      "currentModule": "State Management",
      "nextLesson": "Redux Implementation",
      "estimatedCompletion": "2024-02-15",
      "difficulty": "Advanced",
      "category": "Programming",
      "rating": 4.8,
      "certificate": true,
      "timeSpent": "42 hours",
      "lastAccessed": "2024-01-20T14:30:00Z"
    },
    {
      "id": "2",
      "course": "UI/UX Design Fundamentals",
      "instructor": "Michael Chen",
      "instructorAvatar": "https://picsum.photos/40/40?random=2&keyword=designer",
      "progress": 85,
      "completedLessons": 21,
      "totalLessons": 24,
      "currentModule": "Prototyping",
      "nextLesson": "Interactive Prototypes",
      "estimatedCompletion": "2024-01-28",
      "difficulty": "Intermediate",
      "category": "Design",
      "rating": 4.9,
      "certificate": true,
      "timeSpent": "38 hours",
      "lastAccessed": "2024-01-19T16:45:00Z"
    },
    {
      "id": "3",
      "course": "Data Science with Python",
      "instructor": "Dr. Emily Rodriguez",
      "instructorAvatar": "https://picsum.photos/40/40?random=3&keyword=scientist",
      "progress": 35,
      "completedLessons": 12,
      "totalLessons": 34,
      "currentModule": "Data Visualization",
      "nextLesson": "Matplotlib Basics",
      "estimatedCompletion": "2024-03-20",
      "difficulty": "Beginner",
      "category": "Data Science",
      "rating": 4.7,
      "certificate": true,
      "timeSpent": "28 hours",
      "lastAccessed": "2024-01-18T10:15:00Z"
    },
    {
      "id": "4",
      "course": "Digital Marketing Strategy",
      "instructor": "Alex Thompson",
      "instructorAvatar": "https://picsum.photos/40/40?random=4&keyword=marketer",
      "progress": 92,
      "completedLessons": 18,
      "totalLessons": 19,
      "currentModule": "Analytics & Optimization",
      "nextLesson": "Final Project",
      "estimatedCompletion": "2024-01-25",
      "difficulty": "Intermediate",
      "category": "Marketing",
      "rating": 4.6,
      "certificate": true,
      "timeSpent": "31 hours",
      "lastAccessed": "2024-01-20T09:20:00Z"
    },
    {
      "id": "5",
      "course": "Machine Learning Basics",
      "instructor": "Prof. David Kumar",
      "instructorAvatar": "https://picsum.photos/40/40?random=5&keyword=professor",
      "progress": 12,
      "completedLessons": 3,
      "totalLessons": 28,
      "currentModule": "Introduction to ML",
      "nextLesson": "Supervised Learning",
      "estimatedCompletion": "2024-04-10",
      "difficulty": "Advanced",
      "category": "AI/ML",
      "rating": 4.9,
      "certificate": true,
      "timeSpent": "8 hours",
      "lastAccessed": "2024-01-15T13:30:00Z"
    },
    {
      "id": "6",
      "course": "Photography Masterclass",
      "instructor": "Lisa Anderson",
      "instructorAvatar": "https://picsum.photos/40/40?random=6&keyword=photographer",
      "progress": 100,
      "completedLessons": 22,
      "totalLessons": 22,
      "currentModule": "Course Completed",
      "nextLesson": null,
      "estimatedCompletion": "Completed",
      "difficulty": "Beginner",
      "category": "Creative",
      "rating": 4.8,
      "certificate": true,
      "timeSpent": "45 hours",
      "lastAccessed": "2024-01-10T18:00:00Z"
    }
  ];

  String selectedCategory = "all";
  List<String> categories = ["all", "Programming", "Design", "Data Science", "Marketing", "AI/ML", "Creative"];

  List<Map<String, dynamic>> get filteredCourses {
    if (selectedCategory == "all") {
      return learningProgress;
    }
    return learningProgress.where((course) => course["category"] == selectedCategory).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "beginner":
        return successColor;
      case "intermediate":
        return warningColor;
      case "advanced":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getProgressColor(int progress) {
    if (progress >= 90) {
      return successColor;
    } else if (progress >= 70) {
      return warningColor;
    } else if (progress >= 30) {
      return infoColor;
    } else {
      return disabledBoldColor;
    }
  }

  String _getProgressStatus(int progress) {
    if (progress == 100) {
      return "Completed";
    } else if (progress >= 90) {
      return "Almost Done";
    } else if (progress >= 70) {
      return "Good Progress";
    } else if (progress >= 30) {
      return "In Progress";
    } else {
      return "Just Started";
    }
  }

  String _formatLastAccessed(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }

  Widget _buildStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          size: 14,
          color: warningColor,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learning Progress"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Learning Dashboard Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Learning Journey",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Track your course progress and achievements",
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
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Average Progress",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              LinearProgressIndicator(
                                value: 0.65,
                                backgroundColor: Colors.white.withAlpha(60),
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "65%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Learning Statistics
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.emoji_events,
                          color: successColor,
                          size: 28,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "1",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Completed",
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
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.play_circle_filled,
                          color: warningColor,
                          size: 28,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "5",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "In Progress",
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
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: infoColor,
                          size: 28,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "192h",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Time",
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

            // Category Filter
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter by Category",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((category) {
                        bool isSelected = selectedCategory == category;
                        return Container(
                          margin: EdgeInsets.only(right: spSm),
                          child: GestureDetector(
                            onTap: () {
                              selectedCategory = category;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                category == "all" ? "All Courses" : category,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Course Progress List
            Text(
              "Course Progress (${filteredCourses.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ...filteredCourses.map((course) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: _getProgressColor(course["progress"] as int).withAlpha(60),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course Header
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage("${course["instructorAvatar"]}"),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${course["course"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "by ${course["instructor"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  _buildStars(course["rating"] as double),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${course["rating"]}",
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor("${course["difficulty"]}").withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${course["difficulty"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: _getDifficultyColor("${course["difficulty"]}"),
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            if (course["certificate"] == true)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.verified,
                                    size: 14,
                                    color: successColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "Certificate",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Progress Section
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
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
                                "${course["progress"]}%",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: _getProgressColor(course["progress"] as int),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: (course["progress"] as int) / 100,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getProgressColor(course["progress"] as int),
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _getProgressStatus(course["progress"] as int),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: _getProgressColor(course["progress"] as int),
                                ),
                              ),
                              Text(
                                "${course["completedLessons"]}/${course["totalLessons"]} lessons",
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

                    SizedBox(height: spMd),

                    // Course Details
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Current Module",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${course["currentModule"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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
                                "Time Spent",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${course["timeSpent"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    if (course["nextLesson"] != null) ...[
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Next Lesson",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${course["nextLesson"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
                                  "Last Accessed",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  _formatLastAccessed("${course["lastAccessed"]}"),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],

                    SizedBox(height: spMd),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: course["progress"] == 100 ? "View Certificate" : "Continue Learning",
                            size: bs.md,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.md,
                          onPressed: () {},
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
