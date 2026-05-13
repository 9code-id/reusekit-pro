import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaProgrammingTutorialsView extends StatefulWidget {
  const ElaProgrammingTutorialsView({super.key});

  @override
  State<ElaProgrammingTutorialsView> createState() => _ElaProgrammingTutorialsViewState();
}

class _ElaProgrammingTutorialsViewState extends State<ElaProgrammingTutorialsView> {
  String selectedLanguage = "All";
  String selectedLevel = "All";
  String selectedCategory = "All";
  String searchQuery = "";
  bool loading = false;
  List<String> enrolledTutorials = [];

  List<Map<String, dynamic>> languages = [
    {"label": "All", "value": "All"},
    {"label": "Python", "value": "Python"},
    {"label": "JavaScript", "value": "JavaScript"},
    {"label": "Java", "value": "Java"},
    {"label": "C++", "value": "C++"},
    {"label": "HTML/CSS", "value": "HTML/CSS"},
  ];

  List<Map<String, dynamic>> levels = [
    {"label": "All", "value": "All"},
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Web Development", "value": "Web Development"},
    {"label": "Mobile Apps", "value": "Mobile Apps"},
    {"label": "Data Science", "value": "Data Science"},
    {"label": "Game Development", "value": "Game Development"},
    {"label": "Desktop Apps", "value": "Desktop Apps"},
  ];

  List<Map<String, dynamic>> tutorials = [
    {
      "id": "1",
      "title": "Python Fundamentals",
      "language": "Python",
      "level": "Beginner",
      "category": "Data Science",
      "instructor": "Dr. Sarah Johnson",
      "duration": 480, // minutes
      "lessons": 24,
      "rating": 4.8,
      "students": 12450,
      "description": "Complete introduction to Python programming for beginners",
      "thumbnail": "https://picsum.photos/400/250?random=1&keyword=python",
      "price": 0, // Free
      "tags": ["Variables", "Functions", "Loops", "Data Types"],
      "prerequisites": ["Basic computer knowledge"],
      "learningOutcomes": [
        "Understand Python syntax and basics",
        "Write simple Python programs",
        "Work with data structures",
        "Handle errors and exceptions"
      ],
      "syllabus": [
        {"title": "Introduction to Python", "duration": 20},
        {"title": "Variables and Data Types", "duration": 25},
        {"title": "Control Structures", "duration": 30},
        {"title": "Functions and Modules", "duration": 35},
      ],
      "completed": false,
      "progress": 0,
    },
    {
      "id": "2",
      "title": "JavaScript for Web Development",
      "language": "JavaScript",
      "level": "Intermediate",
      "category": "Web Development",
      "instructor": "Mike Chen",
      "duration": 600,
      "lessons": 30,
      "rating": 4.7,
      "students": 8920,
      "description": "Master JavaScript for modern web development",
      "thumbnail": "https://picsum.photos/400/250?random=2&keyword=javascript",
      "price": 49,
      "tags": ["DOM", "Events", "Async", "ES6"],
      "prerequisites": ["HTML/CSS basics", "Programming fundamentals"],
      "learningOutcomes": [
        "Master JavaScript ES6+ features",
        "Build interactive web applications",
        "Handle asynchronous programming",
        "Work with APIs and fetch data"
      ],
      "syllabus": [
        {"title": "JavaScript Basics", "duration": 30},
        {"title": "DOM Manipulation", "duration": 40},
        {"title": "Event Handling", "duration": 35},
        {"title": "Asynchronous JavaScript", "duration": 45},
      ],
      "completed": false,
      "progress": 0,
    },
    {
      "id": "3",
      "title": "Java Object-Oriented Programming",
      "language": "Java",
      "level": "Intermediate",
      "category": "Desktop Apps",
      "instructor": "Prof. David Kim",
      "duration": 720,
      "lessons": 36,
      "rating": 4.9,
      "students": 6780,
      "description": "Deep dive into Java OOP concepts and design patterns",
      "thumbnail": "https://picsum.photos/400/250?random=3&keyword=java",
      "price": 79,
      "tags": ["Classes", "Inheritance", "Polymorphism", "Design Patterns"],
      "prerequisites": ["Java basics", "Programming experience"],
      "learningOutcomes": [
        "Master OOP principles in Java",
        "Implement design patterns",
        "Build scalable applications",
        "Handle collections and generics"
      ],
      "syllabus": [
        {"title": "Classes and Objects", "duration": 40},
        {"title": "Inheritance and Polymorphism", "duration": 50},
        {"title": "Abstract Classes and Interfaces", "duration": 45},
        {"title": "Design Patterns", "duration": 60},
      ],
      "completed": false,
      "progress": 0,
    },
    {
      "id": "4",
      "title": "HTML & CSS Responsive Design",
      "language": "HTML/CSS",
      "level": "Beginner",
      "category": "Web Development",
      "instructor": "Lisa Martinez",
      "duration": 360,
      "lessons": 18,
      "rating": 4.6,
      "students": 15670,
      "description": "Create beautiful, responsive websites with HTML and CSS",
      "thumbnail": "https://picsum.photos/400/250?random=4&keyword=website",
      "price": 0,
      "tags": ["HTML5", "CSS3", "Flexbox", "Grid", "Responsive"],
      "prerequisites": ["Basic computer skills"],
      "learningOutcomes": [
        "Build semantic HTML structures",
        "Style with modern CSS",
        "Create responsive layouts",
        "Optimize for mobile devices"
      ],
      "syllabus": [
        {"title": "HTML Fundamentals", "duration": 25},
        {"title": "CSS Styling", "duration": 30},
        {"title": "Flexbox Layout", "duration": 20},
        {"title": "CSS Grid", "duration": 25},
      ],
      "completed": false,
      "progress": 0,
    },
    {
      "id": "5",
      "title": "C++ Game Development",
      "language": "C++",
      "level": "Advanced",
      "category": "Game Development",
      "instructor": "Alex Rodriguez",
      "duration": 900,
      "lessons": 45,
      "rating": 4.5,
      "students": 3450,
      "description": "Build games using C++ and popular game engines",
      "thumbnail": "https://picsum.photos/400/250?random=5&keyword=game",
      "price": 129,
      "tags": ["Game Engine", "Graphics", "Physics", "AI"],
      "prerequisites": ["C++ proficiency", "Math basics", "OOP knowledge"],
      "learningOutcomes": [
        "Develop games in C++",
        "Implement game physics",
        "Create AI behaviors",
        "Optimize game performance"
      ],
      "syllabus": [
        {"title": "Game Development Basics", "duration": 60},
        {"title": "Graphics and Rendering", "duration": 80},
        {"title": "Physics Engine", "duration": 70},
        {"title": "AI and Game Logic", "duration": 90},
      ],
      "completed": false,
      "progress": 0,
    },
    {
      "id": "6",
      "title": "Python Data Science Bootcamp",
      "language": "Python",
      "level": "Advanced",
      "category": "Data Science",
      "instructor": "Dr. Emma Watson",
      "duration": 1080,
      "lessons": 54,
      "rating": 4.9,
      "students": 9870,
      "description": "Complete data science workflow with Python libraries",
      "thumbnail": "https://picsum.photos/400/250?random=6&keyword=datascience",
      "price": 99,
      "tags": ["Pandas", "NumPy", "Matplotlib", "Machine Learning"],
      "prerequisites": ["Python basics", "Statistics knowledge"],
      "learningOutcomes": [
        "Analyze data with Pandas",
        "Create visualizations",
        "Build machine learning models",
        "Deploy data science projects"
      ],
      "syllabus": [
        {"title": "Data Manipulation with Pandas", "duration": 90},
        {"title": "Data Visualization", "duration": 80},
        {"title": "Statistical Analysis", "duration": 70},
        {"title": "Machine Learning", "duration": 120},
      ],
      "completed": false,
      "progress": 0,
    },
  ];

  List<Map<String, dynamic>> get filteredTutorials {
    return tutorials.where((tutorial) {
      bool languageMatch = selectedLanguage == "All" || tutorial["language"] == selectedLanguage;
      bool levelMatch = selectedLevel == "All" || tutorial["level"] == selectedLevel;
      bool categoryMatch = selectedCategory == "All" || tutorial["category"] == selectedCategory;
      bool searchMatch = searchQuery.isEmpty ||
          tutorial["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          tutorial["instructor"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return languageMatch && levelMatch && categoryMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Programming Tutorials"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Navigate to saved tutorials
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to learning analytics
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
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.school,
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
                          "Learn Programming",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Master programming languages with expert-led tutorials",
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

            // Search and Filter Section
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
                    "Find Your Course",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  QTextField(
                    label: "Search tutorials...",
                    value: searchQuery,
                    hint: "Enter course title or instructor name",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Language",
                          items: languages,
                          value: selectedLanguage,
                          onChanged: (value, label) {
                            selectedLanguage = value;
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
                  QDropdownField(
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Statistics Section
            Container(
              padding: EdgeInsets.all(spSm),
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
                          "${filteredTutorials.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Courses",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${enrolledTutorials.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Enrolled",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${((filteredTutorials.map((t) => t["students"] as int).reduce((a, b) => a + b)) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Students",
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
            ),

            // Learning Paths
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
                    "Recommended Learning Paths",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  QHorizontalScroll(
                    children: [
                      _buildLearningPath(
                        "Web Developer",
                        ["HTML/CSS", "JavaScript", "React"],
                        Icons.web,
                        primaryColor,
                      ),
                      _buildLearningPath(
                        "Data Scientist",
                        ["Python", "Pandas", "Machine Learning"],
                        Icons.analytics,
                        successColor,
                      ),
                      _buildLearningPath(
                        "Mobile Developer",
                        ["Java", "Kotlin", "Flutter"],
                        Icons.phone_android,
                        warningColor,
                      ),
                      _buildLearningPath(
                        "Game Developer",
                        ["C++", "Unity", "3D Graphics"],
                        Icons.sports_esports,
                        dangerColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tutorials Grid
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Available Courses",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "${filteredTutorials.length} courses",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            if (filteredTutorials.isEmpty)
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
                      "No courses found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredTutorials.map((tutorial) {
                  final isEnrolled = enrolledTutorials.contains(tutorial["id"]);
                  
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
                        Stack(
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(radiusMd),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(radiusMd),
                                ),
                                child: Image.network(
                                  "${tutorial["thumbnail"]}",
                                  fit: BoxFit.cover,
                                ),
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
                                  color: _getLevelColor(tutorial["level"]),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${tutorial["level"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: spXs,
                              left: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(180),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${(tutorial["duration"] as int) ~/ 60}h ${(tutorial["duration"] as int) % 60}m",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            if (isEnrolled)
                              Positioned(
                                top: spXs,
                                left: spXs,
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        // Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${tutorial["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "by ${tutorial["instructor"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${tutorial["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${tutorial["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.people,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${((tutorial["students"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${tutorial["language"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    tutorial["price"] == 0 ? "Free" : "\$${tutorial["price"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: tutorial["price"] == 0 ? successColor : primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: isEnrolled ? "Continue Learning" : "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    _showTutorialDetails(tutorial);
                                  },
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
        ),
      ),
    );
  }

  Widget _buildLearningPath(String title, List<String> skills, IconData icon, Color color) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          ...skills.map((skill) {
            return Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  skill,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  void _showTutorialDetails(Map<String, dynamic> tutorial) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: EdgeInsets.only(top: spSm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Header
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${tutorial["title"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "by ${tutorial["instructor"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              tutorial["price"] == 0 ? "Free" : "\$${tutorial["price"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: tutorial["price"] == 0 ? successColor : primaryColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: _getLevelColor(tutorial["level"]),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${tutorial["level"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Course Stats
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${tutorial["lessons"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Lessons",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${(tutorial["duration"] as int) ~/ 60}h",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Duration",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${tutorial["rating"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Rating",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Description
                    _buildSection("Course Description", "${tutorial["description"]}"),

                    // Learning Outcomes
                    _buildListSection("What You'll Learn", tutorial["learningOutcomes"]),

                    // Prerequisites
                    _buildListSection("Prerequisites", tutorial["prerequisites"]),

                    // Course Syllabus
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
                            "Course Syllabus",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ...((tutorial["syllabus"] as List).map((lesson) {
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(5),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.play_circle_outline,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${lesson["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${lesson["duration"]} min",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList()),
                        ],
                      ),
                    ),

                    // Tags
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
                            "Course Topics",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (tutorial["tags"] as List).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$tag",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Enroll Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: enrolledTutorials.contains(tutorial["id"]) 
                            ? "Continue Learning" 
                            : "Enroll Now",
                        size: bs.md,
                        onPressed: () {
                          if (!enrolledTutorials.contains(tutorial["id"])) {
                            enrolledTutorials.add(tutorial["id"]);
                            setState(() {});
                            ss("Successfully enrolled in ${tutorial["title"]}!");
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
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
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListSection(String title, List<dynamic> items) {
    return Container(
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
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...items.map((item) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 4,
                  margin: EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: successColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "$item",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
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
}
