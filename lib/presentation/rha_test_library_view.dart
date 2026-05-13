import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaTestLibraryView extends StatefulWidget {
  const RhaTestLibraryView({super.key});

  @override
  State<RhaTestLibraryView> createState() => _RhaTestLibraryViewState();
}

class _RhaTestLibraryViewState extends State<RhaTestLibraryView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedDifficulty = "all";
  String selectedType = "all";
  bool loading = false;

  List<Map<String, dynamic>> testLibrary = [
    {
      "id": "TL001",
      "title": "JavaScript Fundamentals",
      "description": "Comprehensive test covering ES6+, DOM manipulation, and asynchronous programming",
      "category": "Programming Languages",
      "subcategory": "JavaScript",
      "difficulty": "Intermediate",
      "type": "Multiple Choice",
      "questions": 50,
      "duration": 75,
      "tags": ["javascript", "frontend", "es6", "async"],
      "popularity": 95,
      "rating": 4.8,
      "usageCount": 1247,
      "lastUpdated": "2024-12-10",
      "provider": "TechSkills Inc.",
      "premium": false,
      "topics": [
        "Variables and Data Types",
        "Functions and Scope",
        "ES6 Features",
        "DOM Manipulation",
        "Async/Await and Promises"
      ]
    },
    {
      "id": "TL002",
      "title": "Data Structures & Algorithms",
      "description": "Advanced problem-solving test covering arrays, trees, graphs, and algorithm optimization",
      "category": "Computer Science",
      "subcategory": "Algorithms",
      "difficulty": "Advanced",
      "type": "Coding Challenge",
      "questions": 25,
      "duration": 120,
      "tags": ["algorithms", "data structures", "problem solving"],
      "popularity": 89,
      "rating": 4.9,
      "usageCount": 892,
      "lastUpdated": "2024-12-08",
      "provider": "CodeMaster Pro",
      "premium": true,
      "topics": [
        "Array Manipulation",
        "Linked Lists",
        "Binary Trees",
        "Graph Algorithms",
        "Dynamic Programming"
      ]
    },
    {
      "id": "TL003",
      "title": "Project Management Fundamentals",
      "description": "Assessment covering Agile methodologies, risk management, and team leadership",
      "category": "Management",
      "subcategory": "Project Management",
      "difficulty": "Intermediate",
      "type": "Scenario Based",
      "questions": 40,
      "duration": 90,
      "tags": ["project management", "agile", "scrum", "leadership"],
      "popularity": 78,
      "rating": 4.5,
      "usageCount": 567,
      "lastUpdated": "2024-12-05",
      "provider": "ManagementPro",
      "premium": false,
      "topics": [
        "Project Planning",
        "Agile Methodologies",
        "Risk Management",
        "Team Leadership",
        "Stakeholder Communication"
      ]
    },
    {
      "id": "TL004",
      "title": "Machine Learning Concepts",
      "description": "Test covering supervised learning, neural networks, and model evaluation techniques",
      "category": "Data Science",
      "subcategory": "Machine Learning",
      "difficulty": "Advanced",
      "type": "Mixed Format",
      "questions": 35,
      "duration": 100,
      "tags": ["machine learning", "ai", "neural networks", "data science"],
      "popularity": 92,
      "rating": 4.7,
      "usageCount": 743,
      "lastUpdated": "2024-12-12",
      "provider": "AI Academy",
      "premium": true,
      "topics": [
        "Supervised Learning",
        "Unsupervised Learning",
        "Neural Networks",
        "Model Evaluation",
        "Feature Engineering"
      ]
    },
    {
      "id": "TL005",
      "title": "Customer Service Excellence",
      "description": "Comprehensive assessment of communication skills, problem resolution, and customer psychology",
      "category": "Soft Skills",
      "subcategory": "Customer Service",
      "difficulty": "Beginner",
      "type": "Situational Judgment",
      "questions": 30,
      "duration": 60,
      "tags": ["customer service", "communication", "problem solving"],
      "popularity": 84,
      "rating": 4.6,
      "usageCount": 1156,
      "lastUpdated": "2024-12-07",
      "provider": "ServiceSkills Ltd.",
      "premium": false,
      "topics": [
        "Active Listening",
        "Conflict Resolution",
        "Customer Psychology",
        "Service Recovery",
        "Professional Communication"
      ]
    }
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Programming Languages", "value": "Programming Languages"},
    {"label": "Computer Science", "value": "Computer Science"},
    {"label": "Data Science", "value": "Data Science"},
    {"label": "Management", "value": "Management"},
    {"label": "Soft Skills", "value": "Soft Skills"},
    {"label": "Design", "value": "Design"},
    {"label": "Marketing", "value": "Marketing"},
  ];

  List<Map<String, dynamic>> difficultyOptions = [
    {"label": "All Levels", "value": "all"},
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
    {"label": "Expert", "value": "Expert"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Multiple Choice", "value": "Multiple Choice"},
    {"label": "Coding Challenge", "value": "Coding Challenge"},
    {"label": "Scenario Based", "value": "Scenario Based"},
    {"label": "Mixed Format", "value": "Mixed Format"},
    {"label": "Situational Judgment", "value": "Situational Judgment"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Test Library",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Browse Tests", icon: Icon(Icons.search)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "My Library", icon: Icon(Icons.bookmark)),
      ],
      tabChildren: [
        _buildBrowseTab(),
        _buildCategoriesTab(),
        _buildMyLibraryTab(),
      ],
    );
  }

  Widget _buildBrowseTab() {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildFeaturedTests(),
          _buildTestGrid(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
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
            label: "Search tests, skills, or topics...",
            value: searchQuery,
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
                  items: categoryOptions,
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
                  label: "Difficulty",
                  items: difficultyOptions,
                  value: selectedDifficulty,
                  onChanged: (value, label) {
                    selectedDifficulty = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedTests() {
    List<Map<String, dynamic>> featured = testLibrary.where((test) => (test["popularity"] as int) > 90).toList();

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
          Row(
            children: [
              Icon(Icons.star, color: warningColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Featured Tests",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          QHorizontalScroll(
            children: featured.map((test) => Container(
              width: 280,
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, size: 12, color: warningColor),
                            SizedBox(width: 2),
                            Text(
                              "Featured",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      if (test["premium"] == true)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Premium",
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
                    "${test["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${test["description"]}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.quiz, size: 14, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${test["questions"]} questions",
                        style: TextStyle(fontSize: 10, color: disabledBoldColor),
                      ),
                      SizedBox(width: spXs),
                      Icon(Icons.timer, size: 14, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${test["duration"]} min",
                        style: TextStyle(fontSize: 10, color: disabledBoldColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, size: 14, color: warningColor),
                          SizedBox(width: 2),
                          Text(
                            "${test["rating"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${test["usageCount"]} uses",
                        style: TextStyle(fontSize: 10, color: disabledBoldColor),
                      ),
                      Spacer(),
                      QButton(
                        label: "Add to Library",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTestGrid() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Text(
                  "All Tests (${testLibrary.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Sort",
                  icon: Icons.sort,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          ...testLibrary.map((test) => _buildTestItem(test)),
        ],
      ),
    );
  }

  Widget _buildTestItem(Map<String, dynamic> test) {
    Color difficultyColor = _getDifficultyColor(test["difficulty"]);

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: difficultyColor, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${test["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        if (test["premium"] == true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Premium",
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
                      "${test["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: difficultyColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${test["difficulty"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: difficultyColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${test["category"]} • ${test["subcategory"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.quiz, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${test["questions"]} questions",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.timer, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${test["duration"]} min",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          QHorizontalScroll(
            children: (test["tags"] as List).map((tag) => Container(
              margin: EdgeInsets.only(right: spXs),
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "#$tag",
                style: TextStyle(
                  fontSize: 10,
                  color: primaryColor,
                ),
              ),
            )).toList(),
          ),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: warningColor),
                  SizedBox(width: 4),
                  Text(
                    "${test["rating"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: spSm),
              Text(
                "${test["usageCount"]} uses",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Text(
                "by ${test["provider"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              QButton(
                label: "Preview",
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                label: "Add to Library",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "beginner":
        return successColor;
      case "intermediate":
        return warningColor;
      case "advanced":
        return dangerColor;
      case "expert":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildCategoriesTab() {
    List<Map<String, dynamic>> categories = [
      {
        "name": "Programming Languages",
        "icon": Icons.code,
        "testCount": 156,
        "subcategories": ["JavaScript", "Python", "Java", "C++", "Go"],
        "color": primaryColor,
      },
      {
        "name": "Data Science",
        "icon": Icons.analytics,
        "testCount": 89,
        "subcategories": ["Machine Learning", "Statistics", "Data Analysis", "Visualization"],
        "color": infoColor,
      },
      {
        "name": "Management",
        "icon": Icons.business,
        "testCount": 67,
        "subcategories": ["Project Management", "Team Leadership", "Strategy", "Operations"],
        "color": successColor,
      },
      {
        "name": "Soft Skills",
        "icon": Icons.psychology,
        "testCount": 123,
        "subcategories": ["Communication", "Problem Solving", "Teamwork", "Adaptability"],
        "color": warningColor,
      },
      {
        "name": "Design",
        "icon": Icons.palette,
        "testCount": 45,
        "subcategories": ["UI/UX", "Graphic Design", "Web Design", "Typography"],
        "color": dangerColor,
      },
      {
        "name": "Marketing",
        "icon": Icons.campaign,
        "testCount": 38,
        "subcategories": ["Digital Marketing", "Content Strategy", "SEO", "Analytics"],
        "color": secondaryColor,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCategoriesHeader(),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: categories.map((category) => _buildCategoryCard(category)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.category, color: primaryColor, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Test Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Browse tests by skill category and subject area",
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
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(color: category["color"] as Color, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
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
              Spacer(),
              Text(
                "${category["testCount"]} tests",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: category["color"] as Color,
                ),
              ),
            ],
          ),
          Text(
            "${category["name"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: (category["subcategories"] as List).take(3).map((sub) => Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: category["color"] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  "$sub",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            )).toList(),
          ),
          if ((category["subcategories"] as List).length > 3)
            Text(
              "+${(category["subcategories"] as List).length - 3} more",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Browse Tests",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyLibraryTab() {
    List<Map<String, dynamic>> myTests = [
      {
        "id": "ML001",
        "title": "JavaScript Fundamentals",
        "addedDate": "2024-12-15",
        "lastUsed": "2024-12-16",
        "timesUsed": 5,
        "category": "Programming Languages",
        "difficulty": "Intermediate",
        "favorite": true,
      },
      {
        "id": "ML002",
        "title": "Project Management Fundamentals",
        "addedDate": "2024-12-10",
        "lastUsed": "2024-12-14",
        "timesUsed": 3,
        "category": "Management",
        "difficulty": "Intermediate",
        "favorite": false,
      },
      {
        "id": "ML003",
        "title": "Customer Service Excellence",
        "addedDate": "2024-12-08",
        "lastUsed": "2024-12-12",
        "timesUsed": 8,
        "category": "Soft Skills",
        "difficulty": "Beginner",
        "favorite": true,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildMyLibraryHeader(),
          _buildLibraryStats(),
          _buildMyTestsList(myTests),
        ],
      ),
    );
  }

  Widget _buildMyLibraryHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.bookmark, color: primaryColor, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Test Library",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Your saved and frequently used assessments",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Organize",
            icon: Icons.folder,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLibraryStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard("Saved Tests", "23", Icons.bookmark_added, primaryColor),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard("Favorites", "8", Icons.favorite, dangerColor),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard("Total Uses", "47", Icons.play_arrow, successColor),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard("Categories", "6", Icons.category, infoColor),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyTestsList(List<Map<String, dynamic>> tests) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Text(
                  "Recently Used",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "View All",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          if (tests.isEmpty) ...[
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark_border, size: 48, color: disabledBoldColor),
                    SizedBox(height: spSm),
                    Text(
                      "No saved tests yet",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Browse and add tests to your library",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            ...tests.map((test) => _buildMyTestItem(test)),
          ],
        ],
      ),
    );
  }

  Widget _buildMyTestItem(Map<String, dynamic> test) {
    Color difficultyColor = _getDifficultyColor(test["difficulty"]);

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: difficultyColor, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${test["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              if (test["favorite"] == true)
                Icon(Icons.favorite, color: dangerColor, size: 20)
              else
                Icon(Icons.favorite_border, color: disabledBoldColor, size: 20),
            ],
          ),
          Row(
            children: [
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${test["category"]} • ${test["difficulty"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Last used: ${test["lastUsed"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Used ${test["timesUsed"]} times • Added ${test["addedDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Use Test",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
