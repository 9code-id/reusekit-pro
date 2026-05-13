import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaHomeView extends StatefulWidget {
  const ElaHomeView({super.key});

  @override
  State<ElaHomeView> createState() => _ElaHomeViewState();
}

class _ElaHomeViewState extends State<ElaHomeView> {
  String searchQuery = "";
  
  Map<String, dynamic> userProgress = {
    "totalCourses": 12,
    "completedCourses": 8,
    "activeCourses": 3,
    "certificates": 5,
    "currentStreak": 15,
    "totalHours": 47.5
  };

  List<Map<String, dynamic>> featuredCourses = [
    {
      "id": "1",
      "title": "Complete Web Development Bootcamp",
      "instructor": "Sarah Wilson",
      "rating": 4.9,
      "students": 15420,
      "duration": "40 hours",
      "level": "Beginner",
      "price": 89.99,
      "originalPrice": 199.99,
      "image": "https://picsum.photos/300/200?random=1&keyword=coding",
      "category": "Technology",
      "isBestseller": true,
      "progress": 0
    },
    {
      "id": "2",
      "title": "Digital Marketing Mastery",
      "instructor": "Mike Johnson",
      "rating": 4.7,
      "students": 8950,
      "duration": "25 hours",
      "level": "Intermediate",
      "price": 69.99,
      "originalPrice": 149.99,
      "image": "https://picsum.photos/300/200?random=2&keyword=marketing",
      "category": "Marketing",
      "isBestseller": false,
      "progress": 0
    },
    {
      "id": "3",
      "title": "UI/UX Design Fundamentals",
      "instructor": "Emma Davis",
      "rating": 4.8,
      "students": 12300,
      "duration": "30 hours",
      "level": "Beginner",
      "price": 79.99,
      "originalPrice": 179.99,
      "image": "https://picsum.photos/300/200?random=3&keyword=design",
      "category": "Design",
      "isBestseller": true,
      "progress": 0
    }
  ];

  List<Map<String, dynamic>> myCourses = [
    {
      "id": "4",
      "title": "Python for Data Science",
      "instructor": "Dr. James Chen",
      "progress": 75,
      "nextLesson": "Machine Learning Basics",
      "image": "https://picsum.photos/300/200?random=4&keyword=python",
      "totalLessons": 24,
      "completedLessons": 18,
      "timeLeft": "2.5 hours"
    },
    {
      "id": "5",
      "title": "React Native Development",
      "instructor": "Lisa Rodriguez",
      "progress": 45,
      "nextLesson": "Navigation in React Native",
      "image": "https://picsum.photos/300/200?random=5&keyword=mobile",
      "totalLessons": 32,
      "completedLessons": 14,
      "timeLeft": "8 hours"
    },
    {
      "id": "6",
      "title": "Business Analytics",
      "instructor": "Mark Thompson",
      "progress": 90,
      "nextLesson": "Final Project Review",
      "image": "https://picsum.photos/300/200?random=6&keyword=analytics",
      "totalLessons": 20,
      "completedLessons": 18,
      "timeLeft": "1 hour"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "Technology", "icon": Icons.computer, "color": primaryColor, "courses": 245},
    {"name": "Business", "icon": Icons.business, "color": successColor, "courses": 189},
    {"name": "Design", "icon": Icons.palette, "color": warningColor, "courses": 156},
    {"name": "Marketing", "icon": Icons.campaign, "color": dangerColor, "courses": 134},
    {"name": "Health", "icon": Icons.health_and_safety, "color": infoColor, "courses": 98},
    {"name": "Languages", "icon": Icons.language, "color": primaryColor, "courses": 87}
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "First Course Complete",
      "description": "Completed your first course",
      "icon": Icons.school,
      "achieved": true
    },
    {
      "title": "Week Streak",
      "description": "7 days of continuous learning",
      "icon": Icons.local_fire_department,
      "achieved": true
    },
    {
      "title": "Course Master",
      "description": "Complete 10 courses",
      "icon": Icons.workspace_premium,
      "achieved": false
    }
  ];

  void _enrollInCourse(Map<String, dynamic> course) {
    ss("Enrolled in: ${course["title"]}");
    // Add course to myCourses and update state
  }

  void _continueCourse(Map<String, dynamic> course) {
    si("Continuing: ${course["title"]}");
    // Navigate to course detail
  }

  void _openCategory(Map<String, dynamic> category) {
    si("Opening ${category["name"]} courses");
    // Navigate to category view
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EduLearn Academy"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              si("Opening notifications");
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              si("Opening profile");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back, Alex!",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Continue your learning journey",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${userProgress["currentStreak"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Day Streak",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.white.withAlpha(100),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${userProgress["totalHours"]}h",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Hours",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.white.withAlpha(100),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${userProgress["certificates"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Certificates",
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

            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search courses...",
                    value: searchQuery,
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
                  onPressed: () {
                    si("Searching for: $searchQuery");
                  },
                ),
              ],
            ),

            // Continue Learning
            if (myCourses.isNotEmpty) ...[
              Text(
                "Continue Learning",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QHorizontalScroll(
                children: myCourses.map((course) {
                  return Container(
                    width: 280,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                          child: Image.network(
                            "${course["image"]}",
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            spacing: spSm,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${course["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "by ${course["instructor"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${course["progress"]}% complete",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: successColor,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        LinearProgressIndicator(
                                          value: (course["progress"] as int) / 100,
                                          backgroundColor: disabledColor,
                                          valueColor: AlwaysStoppedAnimation<Color>(successColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Next: ${course["nextLesson"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "Continue",
                                  size: bs.sm,
                                  onPressed: () => _continueCourse(course),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],

            // Categories
            Text(
              "Explore Categories",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: categories.map((category) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: InkWell(
                    onTap: () => _openCategory(category),
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: (category["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            category["icon"] as IconData,
                            color: category["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Text(
                          "${category["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${category["courses"]} courses",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Featured Courses
            Text(
              "Featured Courses",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QHorizontalScroll(
              children: featuredCourses.map((course) {
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            child: Image.network(
                              "${course["image"]}",
                              width: double.infinity,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (course["isBestseller"] == true)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "BESTSELLER",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${course["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "by ${course["instructor"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${course["rating"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "(${course["students"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "\$${(course["price"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "\$${(course["originalPrice"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Enroll Now",
                                size: bs.sm,
                                onPressed: () => _enrollInCourse(course),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Quick Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Your Learning Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${userProgress["completedCourses"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Completed",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${userProgress["activeCourses"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "In Progress",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${userProgress["totalCourses"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
