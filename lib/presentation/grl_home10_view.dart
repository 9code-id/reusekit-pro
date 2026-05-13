import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHome10View extends StatefulWidget {
  @override
  State<GrlHome10View> createState() => _GrlHome10ViewState();
}

class _GrlHome10ViewState extends State<GrlHome10View> {
  int currentIndex = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedDifficulty = "All";
  bool showCompleted = true;
  bool showFavorites = false;

  List<Map<String, dynamic>> courses = [
    {
      "id": 1,
      "title": "Flutter Development Masterclass",
      "instructor": "Dr. Sarah Johnson",
      "rating": 4.8,
      "students": 12500,
      "duration": "24 hours",
      "level": "Intermediate",
      "category": "Programming",
      "price": 89.99,
      "image": "https://picsum.photos/300/200?random=1&keyword=code",
      "progress": 65,
      "isFavorite": true,
      "isCompleted": false,
      "description": "Complete guide to Flutter development from basics to advanced concepts"
    },
    {
      "id": 2,
      "title": "UI/UX Design Fundamentals",
      "instructor": "Alex Chen",
      "rating": 4.7,
      "students": 8900,
      "duration": "18 hours",
      "level": "Beginner",
      "category": "Design",
      "price": 69.99,
      "image": "https://picsum.photos/300/200?random=2&keyword=design",
      "progress": 100,
      "isFavorite": true,
      "isCompleted": true,
      "description": "Learn the principles of user interface and user experience design"
    },
    {
      "id": 3,
      "title": "Digital Marketing Strategy",
      "instructor": "Maria Rodriguez",
      "rating": 4.6,
      "students": 15200,
      "duration": "20 hours",
      "level": "Advanced",
      "category": "Marketing",
      "price": 99.99,
      "image": "https://picsum.photos/300/200?random=3&keyword=marketing",
      "progress": 30,
      "isFavorite": false,
      "isCompleted": false,
      "description": "Master digital marketing strategies for modern businesses"
    },
    {
      "id": 4,
      "title": "Data Science with Python",
      "instructor": "Prof. David Kim",
      "rating": 4.9,
      "students": 18700,
      "duration": "32 hours",
      "level": "Advanced",
      "category": "Data Science",
      "price": 129.99,
      "image": "https://picsum.photos/300/200?random=4&keyword=data",
      "progress": 0,
      "isFavorite": false,
      "isCompleted": false,
      "description": "Comprehensive data science course using Python and machine learning"
    },
    {
      "id": 5,
      "title": "Photography Essentials",
      "instructor": "James Wilson",
      "rating": 4.5,
      "students": 6800,
      "duration": "15 hours",
      "level": "Beginner",
      "category": "Photography",
      "price": 49.99,
      "image": "https://picsum.photos/300/200?random=5&keyword=camera",
      "progress": 85,
      "isFavorite": true,
      "isCompleted": false,
      "description": "Learn essential photography techniques and composition skills"
    },
    {
      "id": 6,
      "title": "Business Leadership",
      "instructor": "Lisa Thompson",
      "rating": 4.7,
      "students": 9500,
      "duration": "16 hours",
      "level": "Intermediate",
      "category": "Business",
      "price": 79.99,
      "image": "https://picsum.photos/300/200?random=6&keyword=business",
      "progress": 100,
      "isFavorite": false,
      "isCompleted": true,
      "description": "Develop essential leadership skills for business success"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All", "count": 156},
    {"label": "Programming", "value": "Programming", "count": 42},
    {"label": "Design", "value": "Design", "count": 28},
    {"label": "Marketing", "value": "Marketing", "count": 35},
    {"label": "Data Science", "value": "Data Science", "count": 18},
    {"label": "Photography", "value": "Photography", "count": 15},
    {"label": "Business", "value": "Business", "count": 18}
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "Quick Learner",
      "description": "Complete 5 courses in a month",
      "icon": Icons.speed,
      "earned": true,
      "date": "2024-01-15"
    },
    {
      "title": "Perfect Score",
      "description": "Get 100% in final assessment",
      "icon": Icons.star,
      "earned": true,
      "date": "2024-01-20"
    },
    {
      "title": "Dedication",
      "description": "Study for 30 consecutive days",
      "icon": Icons.calendar_today,
      "earned": false,
      "date": null
    },
    {
      "title": "Expert",
      "description": "Complete 20 advanced courses",
      "icon": Icons.school,
      "earned": false,
      "date": null
    }
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "type": "completed",
      "title": "UI/UX Design Fundamentals",
      "description": "Course completed with 98% score",
      "time": "2 hours ago",
      "icon": Icons.check_circle
    },
    {
      "type": "started",
      "title": "Flutter Development Masterclass",
      "description": "Started new lesson: Advanced Widgets",
      "time": "1 day ago",
      "icon": Icons.play_circle
    },
    {
      "type": "achievement",
      "title": "Perfect Score Achievement",
      "description": "Earned for excellent performance",
      "time": "2 days ago",
      "icon": Icons.star
    },
    {
      "type": "enrolled",
      "title": "Photography Essentials",
      "description": "Successfully enrolled in course",
      "time": "3 days ago",
      "icon": Icons.add_circle
    }
  ];

  List<Map<String, dynamic>> get filteredCourses {
    return courses.where((course) {
      bool matchesSearch = course["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          course["instructor"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || course["category"] == selectedCategory;
      bool matchesDifficulty = selectedDifficulty == "All" || course["level"] == selectedDifficulty;
      bool matchesCompleted = !showCompleted || course["isCompleted"] == false;
      bool matchesFavorites = !showFavorites || course["isFavorite"] == true;
      
      return matchesSearch && matchesCategory && matchesDifficulty && matchesCompleted && matchesFavorites;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "Learning Hub",
      selectedIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle),
          label: "My Courses",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Explore",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        _buildHomeTab(),
        _buildMyCoursesTab(),
        _buildExploreTab(),
        _buildProfileTab(),
      ],
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
    );
  }

  Widget _buildHomeTab() {
    int completedCourses = courses.where((c) => c["isCompleted"] == true).length;
    int totalStudyHours = courses.fold(0, (sum, course) => sum + (((course["progress"] as int) / 100) * int.parse((course["duration"] as String).split(" ")[0])).toInt());
    double averageProgress = courses.fold(0.0, (sum, course) => sum + (course["progress"] as int)) / courses.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back, Sarah!",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Continue your learning journey",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    _buildWelcomeStats("${completedCourses}", "Completed", Icons.check_circle),
                    SizedBox(width: spMd),
                    _buildWelcomeStats("${totalStudyHours}h", "Study Time", Icons.access_time),
                    SizedBox(width: spMd),
                    _buildWelcomeStats("${averageProgress.toInt()}%", "Progress", Icons.trending_up),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Continue Learning Section
          Text(
            "Continue Learning",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          QHorizontalScroll(
            children: courses.where((course) => (course["progress"] as int) > 0 && (course["progress"] as int) < 100).map((course) {
              return Container(
                width: 280,
                margin: EdgeInsets.only(right: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                      child: Stack(
                        children: [
                          Image.network(
                            "${course["image"]}",
                            width: double.infinity,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(230),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${course["progress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
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
                          SizedBox(height: spXs),
                          Text(
                            "by ${course["instructor"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          LinearProgressIndicator(
                            value: (course["progress"] as int) / 100,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Continue",
                              size: bs.sm,
                              onPressed: () {},
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
          SizedBox(height: spMd),

          // Featured Courses
          Text(
            "Featured Courses",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: courses.take(4).map((course) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                      child: Stack(
                        children: [
                          Image.network(
                            "${course["image"]}",
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${course["level"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          if (course["isFavorite"] == true)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Icon(
                                Icons.favorite,
                                color: dangerColor,
                                size: 20,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${course["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "by ${course["instructor"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.star, color: warningColor, size: 14),
                              SizedBox(width: 2),
                              Text(
                                "${course["rating"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "(${((course["students"] as int) / 1000).toStringAsFixed(1)}K)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.access_time, color: disabledBoldColor, size: 14),
                              SizedBox(width: 4),
                              Text(
                                "${course["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${(course["price"] as double).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              QButton(
                                label: "Enroll",
                                size: bs.sm,
                                onPressed: () {},
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
    );
  }

  Widget _buildWelcomeStats(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(50),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withAlpha(200),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyCoursesTab() {
    List<Map<String, dynamic>> myCourses = courses.where((course) => (course["progress"] as int) > 0).toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Overview
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [infoColor, infoColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Progress",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${myCourses.length}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Enrolled Courses",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.white.withAlpha(100),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${courses.where((c) => c["isCompleted"] == true).length}",
                            style: TextStyle(
                              fontSize: 24,
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
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Filter Options
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Hide Completed",
                      "value": true,
                      "checked": showCompleted,
                    }
                  ],
                  value: [
                    if (showCompleted)
                      {
                        "label": "Hide Completed",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showCompleted = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Favorites Only",
                      "value": true,
                      "checked": showFavorites,
                    }
                  ],
                  value: [
                    if (showFavorites)
                      {
                        "label": "Favorites Only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showFavorites = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Course List
          Text(
            "My Courses",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: filteredCourses.where((course) => (course["progress"] as int) > 0).map((course) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusLg)),
                      child: Image.network(
                        "${course["image"]}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${course["title"]}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (course["isFavorite"] == true)
                                  Icon(
                                    Icons.favorite,
                                    color: dangerColor,
                                    size: 16,
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "by ${course["instructor"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: (course["progress"] as int) / 100,
                                    backgroundColor: disabledColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      course["isCompleted"] == true ? successColor : primaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${course["progress"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: course["isCompleted"] == true ? successColor : primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            QButton(
                              label: course["isCompleted"] == true ? "Review" : "Continue",
                              size: bs.sm,
                              onPressed: () {},
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
    );
  }

  Widget _buildExploreTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search
          QTextField(
            label: "Search courses, instructors...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),

          // Categories
          Text(
            "Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          QCategoryPicker(
            items: categories,
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),

          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Difficulty Level",
                  items: [
                    {"label": "All Levels", "value": "All"},
                    {"label": "Beginner", "value": "Beginner"},
                    {"label": "Intermediate", "value": "Intermediate"},
                    {"label": "Advanced", "value": "Advanced"},
                  ],
                  value: selectedDifficulty,
                  onChanged: (value, label) {
                    selectedDifficulty = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Results
          Text(
            "Courses (${filteredCourses.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: filteredCourses.map((course) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                      child: Stack(
                        children: [
                          Image.network(
                            "${course["image"]}",
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${course["level"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () {
                                course["isFavorite"] = !(course["isFavorite"] as bool);
                                setState(() {});
                              },
                              child: Icon(
                                course["isFavorite"] == true ? Icons.favorite : Icons.favorite_border,
                                color: dangerColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${course["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "by ${course["instructor"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.star, color: warningColor, size: 14),
                              SizedBox(width: 2),
                              Text(
                                "${course["rating"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "(${((course["students"] as int) / 1000).toStringAsFixed(1)}K)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${course["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${(course["price"] as double).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              QButton(
                                label: "Enroll",
                                size: bs.sm,
                                onPressed: () {},
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
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage("https://picsum.photos/200/200?random=100&keyword=person"),
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Sarah Johnson",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "sarah.johnson@email.com",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Premium Member",
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
          SizedBox(height: spMd),

          // Learning Stats
          Text(
            "Learning Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Completed Courses", "${courses.where((c) => c["isCompleted"] == true).length}", Icons.school, successColor),
              _buildStatCard("Study Hours", "${courses.fold(0, (sum, course) => sum + (((course["progress"] as int) / 100) * int.parse((course["duration"] as String).split(" ")[0])).toInt())}", Icons.access_time, infoColor),
              _buildStatCard("Certificates", "${courses.where((c) => c["isCompleted"] == true).length}", Icons.workspace_premium, warningColor),
              _buildStatCard("Current Streak", "15 days", Icons.local_fire_department, dangerColor),
            ],
          ),
          SizedBox(height: spMd),

          // Achievements
          Text(
            "Achievements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: achievements.map((achievement) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: achievement["earned"] == true ? successColor : disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: achievement["earned"] == true ? successColor : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        achievement["icon"],
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: achievement["earned"] == true ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${achievement["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (achievement["earned"] == true && achievement["date"] != null)
                            Text(
                              "Earned on ${achievement["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (achievement["earned"] == true)
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 20,
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),

          // Recent Activity
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: recentActivity.map((activity) {
              Color activityColor = primaryColor;
              switch (activity["type"]) {
                case "completed":
                  activityColor = successColor;
                  break;
                case "started":
                  activityColor = infoColor;
                  break;
                case "achievement":
                  activityColor = warningColor;
                  break;
                case "enrolled":
                  activityColor = primaryColor;
                  break;
              }

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: activityColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        activity["icon"],
                        color: activityColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${activity["title"]}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${activity["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${activity["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
