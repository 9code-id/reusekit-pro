import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTimeline7View extends StatefulWidget {
  @override
  State<GrlTimeline7View> createState() => _GrlTimeline7ViewState();
}

class _GrlTimeline7ViewState extends State<GrlTimeline7View> {
  List<Map<String, dynamic>> learningPath = [
    {
      "id": "1",
      "title": "Introduction to Programming",
      "description": "Learn the fundamentals of programming concepts and logic",
      "duration": "2 weeks",
      "difficulty": "Beginner",
      "status": "completed",
      "progress": 100,
      "lessons": 12,
      "completedLessons": 12,
      "certificate": true,
      "startDate": "2024-01-01",
      "completedDate": "2024-01-14",
      "instructor": {
        "name": "Dr. Sarah Johnson",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=teacher"
      }
    },
    {
      "id": "2",
      "title": "Data Structures & Algorithms",
      "description": "Master essential data structures and algorithmic thinking",
      "duration": "4 weeks",
      "difficulty": "Intermediate",
      "status": "completed",
      "progress": 100,
      "lessons": 24,
      "completedLessons": 24,
      "certificate": true,
      "startDate": "2024-01-15",
      "completedDate": "2024-02-12",
      "instructor": {
        "name": "Prof. Michael Chen",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=professor"
      }
    },
    {
      "id": "3",
      "title": "Web Development Fundamentals",
      "description": "Build modern web applications with HTML, CSS, and JavaScript",
      "duration": "6 weeks",
      "difficulty": "Intermediate",
      "status": "in_progress",
      "progress": 65,
      "lessons": 36,
      "completedLessons": 23,
      "certificate": false,
      "startDate": "2024-02-13",
      "completedDate": null,
      "instructor": {
        "name": "Alex Rodriguez",
        "avatar": "https://picsum.photos/40/40?random=3&keyword=developer"
      }
    },
    {
      "id": "4",
      "title": "Frontend Frameworks",
      "description": "Deep dive into React.js and modern frontend development",
      "duration": "5 weeks",
      "difficulty": "Advanced",
      "status": "locked",
      "progress": 0,
      "lessons": 30,
      "completedLessons": 0,
      "certificate": false,
      "startDate": null,
      "completedDate": null,
      "instructor": {
        "name": "Emma Thompson",
        "avatar": "https://picsum.photos/40/40?random=4&keyword=engineer"
      }
    },
    {
      "id": "5",
      "title": "Backend Development",
      "description": "Server-side programming with databases and APIs",
      "duration": "6 weeks",
      "difficulty": "Advanced",
      "status": "locked",
      "progress": 0,
      "lessons": 42,
      "completedLessons": 0,
      "certificate": false,
      "startDate": null,
      "completedDate": null,
      "instructor": {
        "name": "David Kumar",
        "avatar": "https://picsum.photos/40/40?random=5&keyword=architect"
      }
    },
    {
      "id": "6",
      "title": "Full Stack Project",
      "description": "Build and deploy a complete full-stack application",
      "duration": "8 weeks",
      "difficulty": "Expert",
      "status": "locked",
      "progress": 0,
      "lessons": 48,
      "completedLessons": 0,
      "certificate": false,
      "startDate": null,
      "completedDate": null,
      "instructor": {
        "name": "Lisa Anderson",
        "avatar": "https://picsum.photos/40/40?random=6&keyword=mentor"
      }
    }
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "locked":
      default:
        return disabledBoldColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "beginner":
        return successColor;
      case "intermediate":
        return warningColor;
      case "advanced":
        return infoColor;
      case "expert":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "in_progress":
        return Icons.play_circle_filled;
      case "locked":
      default:
        return Icons.lock;
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return "";
    DateTime date = DateTime.parse(dateStr);
    List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }

  String _getStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "in_progress":
        return "In Progress";
      case "locked":
        return "Locked";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learning Path"),
        actions: [
          IconButton(
            icon: Icon(Icons.school),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Learning Path Header
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
                              "Full Stack Development",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Complete Web Development Journey",
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
                                "Overall Progress",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              LinearProgressIndicator(
                                value: 0.44,
                                backgroundColor: Colors.white.withAlpha(60),
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "44%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH6,
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

            // Learning Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
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
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "2",
                          style: TextStyle(
                            fontSize: fsH5,
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
                    padding: EdgeInsets.all(spSm),
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
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "1",
                          style: TextStyle(
                            fontSize: fsH5,
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
                    padding: EdgeInsets.all(spSm),
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
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "31",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Weeks",
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

            // Learning Timeline
            Text(
              "Course Timeline",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ...learningPath.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> course = entry.value;
              bool isLast = index == learningPath.length - 1;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline Indicator
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: _getStatusColor("${course["status"]}"),
                            shape: BoxShape.circle,
                            boxShadow: [shadowMd],
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _getStatusIcon("${course["status"]}"),
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                "${index + 1}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 3,
                            height: 80,
                            color: course["status"] == "completed"
                                ? successColor.withAlpha(150)
                                : Colors.grey.shade300,
                            margin: EdgeInsets.symmetric(vertical: spSm),
                          ),
                      ],
                    ),

                    SizedBox(width: spMd),

                    // Course Content
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                          border: course["status"] == "in_progress"
                              ? Border.all(
                                  color: warningColor.withAlpha(100),
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Course Header
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${course["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getDifficultyColor("${course["difficulty"]}").withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${course["difficulty"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getDifficultyColor("${course["difficulty"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spXs),

                            // Status Badge
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor("${course["status"]}").withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    _getStatusText("${course["status"]}"),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor("${course["status"]}"),
                                    ),
                                  ),
                                ),
                                if (course["certificate"] == true) ...[
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.verified,
                                    size: 16,
                                    color: successColor,
                                  ),
                                  Text(
                                    "Certificate",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Description
                            Text(
                              "${course["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),

                            SizedBox(height: spMd),

                            // Progress Bar (if applicable)
                            if (course["status"] != "locked") ...[
                              Row(
                                children: [
                                  Expanded(
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
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${course["progress"]}%",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: _getStatusColor("${course["status"]}"),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        LinearProgressIndicator(
                                          value: (course["progress"] as int) / 100,
                                          backgroundColor: Colors.grey.shade200,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            _getStatusColor("${course["status"]}"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spMd),
                            ],

                            // Course Details
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              size: 16,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${course["duration"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.play_lesson,
                                            size: 16,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${course["completedLessons"]}/${course["lessons"]} lessons",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundImage: NetworkImage("${(course["instructor"] as Map)["avatar"]}"),
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "Instructor: ${(course["instructor"] as Map)["name"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (course["startDate"] != null) ...[
                                    SizedBox(height: spSm),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Started: ${_formatDate(course["startDate"] as String?)}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        if (course["completedDate"] != null)
                                          Text(
                                            "Completed: ${_formatDate(course["completedDate"] as String?)}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: successColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),

                            // Action Buttons
                            if (course["status"] != "locked") ...[
                              SizedBox(height: spMd),
                              Row(
                                children: [
                                  if (course["status"] == "completed")
                                    Expanded(
                                      child: QButton(
                                        label: "View Certificate",
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                    )
                                  else if (course["status"] == "in_progress")
                                    Expanded(
                                      child: QButton(
                                        label: "Continue Learning",
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                    ),
                                  if (course["status"] == "completed") ...[
                                    SizedBox(width: spSm),
                                    QButton(
                                      icon: Icons.refresh,
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ],
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
    );
  }
}
