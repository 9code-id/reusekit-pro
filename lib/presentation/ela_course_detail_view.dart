import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaCourseDetailView extends StatefulWidget {
  const ElaCourseDetailView({super.key});

  @override
  State<ElaCourseDetailView> createState() => _ElaCourseDetailViewState();
}

class _ElaCourseDetailViewState extends State<ElaCourseDetailView> {
  int currentTab = 0;
  bool isEnrolled = false;
  bool isWishlisted = false;
  
  Map<String, dynamic> course = {
    "id": "1",
    "title": "Complete Web Development Bootcamp",
    "instructor": "Sarah Wilson",
    "instructorImage": "https://picsum.photos/100/100?random=1&keyword=person",
    "rating": 4.9,
    "totalRatings": 2847,
    "students": 15420,
    "duration": "40 hours",
    "lessons": 156,
    "level": "Beginner",
    "price": 89.99,
    "originalPrice": 199.99,
    "discount": 55,
    "image": "https://picsum.photos/400/250?random=1&keyword=coding",
    "category": "Technology",
    "isBestseller": true,
    "isNew": false,
    "lastUpdated": "2024-12-01",
    "language": "English",
    "certificates": true,
    "description": "Master web development from scratch! This comprehensive course covers HTML, CSS, JavaScript, React, Node.js, databases, and deployment. Build real projects and get job-ready skills.",
    "whatYouWillLearn": [
      "Build responsive websites with HTML, CSS, and JavaScript",
      "Create dynamic web applications with React",
      "Develop backend APIs with Node.js and Express",
      "Work with databases (MongoDB and SQL)",
      "Deploy applications to cloud platforms",
      "Master modern development tools and workflows",
      "Build a complete full-stack project portfolio",
      "Learn industry best practices and coding standards"
    ],
    "requirements": [
      "No prior programming experience required",
      "A computer with internet connection",
      "Enthusiasm to learn and practice coding",
      "Basic computer skills (file management, web browsing)"
    ],
    "targetAudience": [
      "Complete beginners who want to become web developers",
      "Students looking to switch careers to tech",
      "Entrepreneurs who want to build their own websites",
      "Anyone interested in modern web development"
    ]
  };

  List<Map<String, dynamic>> curriculum = [
    {
      "section": "Getting Started",
      "lessons": 8,
      "duration": "2.5 hours",
      "items": [
        {"title": "Course Introduction", "duration": "15 min", "type": "video", "preview": true},
        {"title": "Setting Up Development Environment", "duration": "30 min", "type": "video", "preview": false},
        {"title": "Your First HTML Page", "duration": "25 min", "type": "video", "preview": true},
        {"title": "Understanding Web Development", "duration": "20 min", "type": "video", "preview": false},
        {"title": "Tools and Resources", "duration": "15 min", "type": "article", "preview": false},
        {"title": "Quick Review Quiz", "duration": "10 min", "type": "quiz", "preview": false}
      ]
    },
    {
      "section": "HTML Fundamentals",
      "lessons": 12,
      "duration": "4 hours",
      "items": [
        {"title": "HTML Structure and Syntax", "duration": "35 min", "type": "video", "preview": false},
        {"title": "Text Elements and Formatting", "duration": "30 min", "type": "video", "preview": false},
        {"title": "Links and Navigation", "duration": "25 min", "type": "video", "preview": false},
        {"title": "Images and Media", "duration": "30 min", "type": "video", "preview": false},
        {"title": "Lists and Tables", "duration": "25 min", "type": "video", "preview": false},
        {"title": "Forms and Input Elements", "duration": "40 min", "type": "video", "preview": false},
        {"title": "HTML5 Semantic Elements", "duration": "30 min", "type": "video", "preview": false},
        {"title": "Accessibility Best Practices", "duration": "25 min", "type": "video", "preview": false},
        {"title": "HTML Project: Personal Portfolio", "duration": "60 min", "type": "project", "preview": false},
        {"title": "HTML Assessment", "duration": "20 min", "type": "quiz", "preview": false}
      ]
    },
    {
      "section": "CSS Styling",
      "lessons": 15,
      "duration": "5.5 hours",
      "items": [
        {"title": "CSS Basics and Selectors", "duration": "30 min", "type": "video", "preview": false},
        {"title": "Colors, Fonts, and Text Styling", "duration": "35 min", "type": "video", "preview": false},
        {"title": "Box Model and Layout", "duration": "40 min", "type": "video", "preview": false},
        {"title": "Flexbox Layout System", "duration": "45 min", "type": "video", "preview": false},
        {"title": "CSS Grid Layout", "duration": "40 min", "type": "video", "preview": false},
        {"title": "Responsive Design Principles", "duration": "35 min", "type": "video", "preview": false},
        {"title": "CSS Animations and Transitions", "duration": "30 min", "type": "video", "preview": false},
        {"title": "CSS Frameworks (Bootstrap)", "duration": "25 min", "type": "video", "preview": false},
        {"title": "CSS Project: Responsive Website", "duration": "90 min", "type": "project", "preview": false},
        {"title": "CSS Mastery Quiz", "duration": "25 min", "type": "quiz", "preview": false}
      ]
    },
    {
      "section": "JavaScript Programming",
      "lessons": 20,
      "duration": "8 hours",
      "items": [
        {"title": "JavaScript Fundamentals", "duration": "40 min", "type": "video", "preview": false},
        {"title": "Variables and Data Types", "duration": "35 min", "type": "video", "preview": false},
        {"title": "Functions and Scope", "duration": "45 min", "type": "video", "preview": false},
        {"title": "DOM Manipulation", "duration": "50 min", "type": "video", "preview": false},
        {"title": "Event Handling", "duration": "40 min", "type": "video", "preview": false},
        {"title": "Asynchronous JavaScript", "duration": "45 min", "type": "video", "preview": false},
        {"title": "ES6+ Modern Features", "duration": "40 min", "type": "video", "preview": false},
        {"title": "JavaScript Project: Interactive Web App", "duration": "120 min", "type": "project", "preview": false},
        {"title": "JavaScript Final Assessment", "duration": "30 min", "type": "quiz", "preview": false}
      ]
    }
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "student": "Alex Johnson",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=person",
      "rating": 5,
      "date": "2024-12-08",
      "comment": "Excellent course! Sarah explains everything clearly and the projects are very practical. I landed my first web dev job after completing this course.",
      "helpful": 24
    },
    {
      "student": "Maria Garcia",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=person",
      "rating": 5,
      "date": "2024-12-05",
      "comment": "Best investment I've made in my career. The course is well-structured and covers everything you need to know. Highly recommended!",
      "helpful": 18
    },
    {
      "student": "John Smith",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=person",
      "rating": 4,
      "date": "2024-12-02",
      "comment": "Great content and good pace. Some sections could be more detailed but overall very satisfied with the learning experience.",
      "helpful": 12
    },
    {
      "student": "Emma Wilson",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=person",
      "rating": 5,
      "date": "2024-11-28",
      "comment": "Perfect for beginners! I had zero coding experience and now I'm building my own websites. The support from instructors is amazing.",
      "helpful": 31
    }
  ];

  Map<String, dynamic> instructor = {
    "name": "Sarah Wilson",
    "title": "Senior Full-Stack Developer",
    "image": "https://picsum.photos/100/100?random=1&keyword=person",
    "rating": 4.8,
    "students": 45000,
    "courses": 12,
    "bio": "Sarah is a senior full-stack developer with over 8 years of experience at top tech companies including Google and Facebook. She's passionate about teaching and has helped thousands of students start their careers in web development."
  };

  List<Map<String, dynamic>> relatedCourses = [
    {
      "title": "Advanced React Development",
      "instructor": "Mike Chen",
      "rating": 4.7,
      "price": 79.99,
      "image": "https://picsum.photos/200/120?random=10&keyword=react"
    },
    {
      "title": "Node.js Backend Mastery",
      "instructor": "David Kumar",
      "rating": 4.6,
      "price": 89.99,
      "image": "https://picsum.photos/200/120?random=11&keyword=nodejs"
    },
    {
      "title": "JavaScript Algorithms & Data Structures",
      "instructor": "Lisa Park",
      "rating": 4.8,
      "price": 69.99,
      "image": "https://picsum.photos/200/120?random=12&keyword=javascript"
    }
  ];

  void _enrollInCourse() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    isEnrolled = true;
    setState(() {});
    ss("Successfully enrolled in ${course["title"]}!");
  }

  void _toggleWishlist() {
    isWishlisted = !isWishlisted;
    setState(() {});
    
    if (isWishlisted) {
      ss("Added to wishlist");
    } else {
      si("Removed from wishlist");
    }
  }

  void _shareCourse() {
    si("Sharing course: ${course["title"]}");
  }

  void _previewLesson(Map<String, dynamic> lesson) {
    si("Playing preview: ${lesson["title"]}");
  }

  Icon _getLessonIcon(String type) {
    switch (type) {
      case "video":
        return Icon(Icons.play_circle, color: primaryColor, size: 20);
      case "article":
        return Icon(Icons.article, color: infoColor, size: 20);
      case "quiz":
        return Icon(Icons.quiz, color: warningColor, size: 20);
      case "project":
        return Icon(Icons.assignment, color: successColor, size: 20);
      default:
        return Icon(Icons.circle, color: disabledColor, size: 20);
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Course Description",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${course["description"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        // What You'll Learn
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What You'll Learn",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...(course["whatYouWillLearn"] as List).map((item) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check, color: successColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "$item",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),

        // Requirements
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Requirements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...(course["requirements"] as List).map((item) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.fiber_manual_record, color: disabledBoldColor, size: 8),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "$item",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),

        // Target Audience
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Who This Course Is For",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...(course["targetAudience"] as List).map((item) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.person, color: primaryColor, size: 16),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "$item",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurriculumTab() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Curriculum Stats
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${curriculum.length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Sections",
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
                      "${course["lessons"]}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Lessons",
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
                      "${course["duration"]}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Duration",
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

        // Curriculum Sections
        ...curriculum.map((section) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${section["section"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${section["lessons"]} lessons • ${section["duration"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                ...(section["items"] as List).map((item) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: disabledOutlineBorderColor),
                      ),
                    ),
                    child: Row(
                      children: [
                        _getLessonIcon("${item["type"]}"),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${item["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${item["duration"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (item["preview"] == true) ...[
                          SizedBox(width: spSm),
                          QButton(
                            label: "Preview",
                            size: bs.sm,
                            onPressed: () => _previewLesson(item),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      spacing: spMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Review Stats
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${course["rating"]}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          color: index < (course["rating"] as double).floor() 
                              ? warningColor 
                              : disabledColor,
                          size: 20,
                        );
                      }),
                    ),
                    Text(
                      "${course["totalRatings"]} ratings",
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
                height: 80,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: spMd),
                  child: Column(
                    spacing: spXs,
                    children: List.generate(5, (index) {
                      int stars = 5 - index;
                      double percentage = stars == 5 ? 0.75 : 
                                        stars == 4 ? 0.20 : 
                                        stars == 3 ? 0.03 : 
                                        stars == 2 ? 0.01 : 0.01;
                      
                      return Row(
                        children: [
                          Text("$stars", style: TextStyle(fontSize: 14)),
                          SizedBox(width: spXs),
                          Icon(Icons.star, color: warningColor, size: 16),
                          SizedBox(width: spSm),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: percentage,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${(percentage * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Reviews List
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Student Reviews",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...reviews.map((review) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusLg),
                            child: Image.network(
                              "${review["avatar"]}",
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
                                  "${review["student"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ...List.generate(5, (index) {
                                      return Icon(
                                        Icons.star,
                                        color: index < (review["rating"] as int) 
                                            ? warningColor 
                                            : disabledColor,
                                        size: 16,
                                      );
                                    }),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${DateTime.parse("${review["date"]}").dMMMy}",
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
                        ],
                      ),
                      Text(
                        "${review["comment"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.thumb_up, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "Helpful (${review["helpful"]})",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
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
      ],
    );
  }

  Widget _buildInstructorTab() {
    return Column(
      spacing: spMd,
      children: [
        // Instructor Profile
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "${instructor["image"]}",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${instructor["name"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${instructor["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${instructor["rating"]} instructor rating",
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
                ],
              ),
              Text(
                "${instructor["bio"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  height: 1.5,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: [
                  Column(
                    children: [
                      Text(
                        "${instructor["students"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Students",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "${instructor["courses"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Courses",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // Related Courses
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "More Courses by ${instructor["name"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QHorizontalScroll(
                children: relatedCourses.map((relatedCourse) {
                  return Container(
                    width: 200,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                          child: Image.network(
                            "${relatedCourse["image"]}",
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${relatedCourse["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "by ${relatedCourse["instructor"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: warningColor, size: 14),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${relatedCourse["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${(relatedCourse["price"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Details"),
        actions: [
          IconButton(
            icon: Icon(isWishlisted ? Icons.favorite : Icons.favorite_border),
            onPressed: _toggleWishlist,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareCourse,
          ),
        ],
      ),
      body: Column(
        children: [
          // Course Header
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusMd),
                  child: Image.network(
                    "${course["image"]}",
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  children: [
                    if (course["isBestseller"] == true)
                      Container(
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
                    if (course["isBestseller"] == true) SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${course["category"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${course["title"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "by ${course["instructor"]}",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "${course["rating"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "(${course["totalRatings"]} ratings)",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${course["students"]} students",
                      style: TextStyle(
                        fontSize: 14,
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
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "\$${(course["originalPrice"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${course["discount"]}% OFF",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tabs
          Expanded(
            child: QTabBar(
              withoutAppBar: true,
              selectedIndex: currentTab,
              tabs: [
                Tab(text: "Overview"),
                Tab(text: "Curriculum"),
                Tab(text: "Reviews"),
                Tab(text: "Instructor"),
              ],
              tabChildren: [
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: _buildOverviewTab(),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: _buildCurriculumTab(),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: _buildReviewsTab(),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: _buildInstructorTab(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            if (!isEnrolled) ...[
              Expanded(
                child: QButton(
                  label: "Add to Cart",
                  onPressed: () {
                    si("Added to cart");
                  },
                ),
              ),
              SizedBox(width: spSm),
            ],
            Expanded(
              flex: 2,
              child: QButton(
                label: isEnrolled ? "Go to Course" : "Enroll Now",
                onPressed: isEnrolled ? () {
                  si("Opening course player");
                } : _enrollInCourse,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
