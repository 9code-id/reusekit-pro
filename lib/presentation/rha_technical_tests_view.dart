import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaTechnicalTestsView extends StatefulWidget {
  const RhaTechnicalTestsView({super.key});

  @override
  State<RhaTechnicalTestsView> createState() => _RhaTechnicalTestsViewState();
}

class _RhaTechnicalTestsViewState extends State<RhaTechnicalTestsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedDifficulty = "All";
  String selectedType = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> technicalTests = [
    {
      "id": "TT001",
      "title": "React.js Component Development",
      "description": "Build interactive React components with hooks and state management",
      "category": "Frontend",
      "type": "Coding",
      "difficulty": "Intermediate",
      "duration": 120,
      "questions": 8,
      "participants": 156,
      "passRate": 72.5,
      "averageScore": 78.3,
      "status": "Active",
      "tags": ["React", "JavaScript", "Components", "Hooks"],
      "createdDate": "2024-01-15",
      "lastUsed": "2024-06-18",
      "creator": "Sarah Johnson",
      "skills": ["React.js", "JavaScript ES6", "Component Design", "State Management"],
      "testSections": [
        {"name": "Basic Components", "questions": 2, "timeLimit": 30},
        {"name": "Hooks & State", "questions": 3, "timeLimit": 45},
        {"name": "Practical Project", "questions": 3, "timeLimit": 45}
      ]
    },
    {
      "id": "TT002", 
      "title": "Python Data Structures & Algorithms",
      "description": "Comprehensive test covering arrays, linked lists, trees, and sorting algorithms",
      "category": "Backend",
      "type": "Algorithm",
      "difficulty": "Advanced",
      "duration": 180,
      "questions": 12,
      "participants": 89,
      "passRate": 64.0,
      "averageScore": 71.2,
      "status": "Active",
      "tags": ["Python", "Algorithms", "Data Structures", "Problem Solving"],
      "createdDate": "2024-02-01",
      "lastUsed": "2024-06-17",
      "creator": "Mike Chen",
      "skills": ["Python", "Algorithms", "Data Structures", "Time Complexity"],
      "testSections": [
        {"name": "Arrays & Strings", "questions": 3, "timeLimit": 45},
        {"name": "Trees & Graphs", "questions": 4, "timeLimit": 60},
        {"name": "Dynamic Programming", "questions": 5, "timeLimit": 75}
      ]
    },
    {
      "id": "TT003",
      "title": "Database Design & SQL Optimization",
      "description": "Advanced SQL queries, database normalization, and performance optimization",
      "category": "Database",
      "type": "Theoretical",
      "difficulty": "Advanced",
      "duration": 90,
      "questions": 15,
      "participants": 203,
      "passRate": 58.1,
      "averageScore": 66.8,
      "status": "Active",
      "tags": ["SQL", "Database", "Optimization", "Normalization"],
      "createdDate": "2024-01-20",
      "lastUsed": "2024-06-16",
      "creator": "David Wilson",
      "skills": ["SQL", "Database Design", "Query Optimization", "Indexing"],
      "testSections": [
        {"name": "Basic Queries", "questions": 5, "timeLimit": 25},
        {"name": "Advanced Joins", "questions": 5, "timeLimit": 35},
        {"name": "Performance Tuning", "questions": 5, "timeLimit": 30}
      ]
    },
    {
      "id": "TT004",
      "title": "Mobile App Development - Flutter",
      "description": "Build cross-platform mobile applications using Flutter framework",
      "category": "Mobile",
      "type": "Coding",
      "difficulty": "Intermediate",
      "duration": 150,
      "questions": 10,
      "participants": 124,
      "passRate": 69.4,
      "averageScore": 74.6,
      "status": "Draft",
      "tags": ["Flutter", "Dart", "Mobile", "Cross-platform"],
      "createdDate": "2024-02-10",
      "lastUsed": "2024-06-10",
      "creator": "Lisa Anderson",
      "skills": ["Flutter", "Dart", "Widget Development", "State Management"],
      "testSections": [
        {"name": "Widget Basics", "questions": 3, "timeLimit": 40},
        {"name": "Navigation & State", "questions": 4, "timeLimit": 60},
        {"name": "API Integration", "questions": 3, "timeLimit": 50}
      ]
    },
    {
      "id": "TT005",
      "title": "DevOps & Cloud Infrastructure",
      "description": "Container orchestration, CI/CD pipelines, and cloud deployment strategies",
      "category": "DevOps",
      "type": "Practical",
      "difficulty": "Advanced",
      "duration": 200,
      "questions": 8,
      "participants": 67,
      "passRate": 52.2,
      "averageScore": 63.1,
      "status": "Active",
      "tags": ["Docker", "Kubernetes", "AWS", "CI/CD"],
      "createdDate": "2024-01-25",
      "lastUsed": "2024-06-15",
      "creator": "Tom Rodriguez",
      "skills": ["Docker", "Kubernetes", "AWS", "Jenkins", "Terraform"],
      "testSections": [
        {"name": "Containerization", "questions": 2, "timeLimit": 50},
        {"name": "Orchestration", "questions": 3, "timeLimit": 75},
        {"name": "Deployment", "questions": 3, "timeLimit": 75}
      ]
    },
    {
      "id": "TT006",
      "title": "Machine Learning Fundamentals",
      "description": "Supervised learning, neural networks, and model evaluation techniques",
      "category": "AI/ML",
      "type": "Theoretical",
      "difficulty": "Intermediate",
      "duration": 100,
      "questions": 20,
      "participants": 178,
      "passRate": 61.8,
      "averageScore": 69.4,
      "status": "Active",
      "tags": ["Machine Learning", "Python", "TensorFlow", "Statistics"],
      "createdDate": "2024-02-05",
      "lastUsed": "2024-06-14",
      "creator": "Anna Kim",
      "skills": ["Python", "TensorFlow", "Scikit-learn", "Statistics"],
      "testSections": [
        {"name": "ML Concepts", "questions": 7, "timeLimit": 35},
        {"name": "Algorithms", "questions": 8, "timeLimit": 40},
        {"name": "Evaluation", "questions": 5, "timeLimit": 25}
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredTests {
    return technicalTests.where((test) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${test["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${test["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (test["tags"] as List).any((tag) => "$tag".toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesCategory = selectedCategory == "All" || test["category"] == selectedCategory;
      bool matchesDifficulty = selectedDifficulty == "All" || test["difficulty"] == selectedDifficulty;
      bool matchesType = selectedType == "All" || test["type"] == selectedType;
      bool matchesStatus = selectedStatus == "All" || test["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesDifficulty && matchesType && matchesStatus;
    }).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return successColor;
      case 'Intermediate':
        return warningColor;
      case 'Advanced':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return successColor;
      case 'Draft':
        return warningColor;
      case 'Inactive':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Technical Tests"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.add, size: 24),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
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
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.quiz,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Total Tests",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${technicalTests.length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "+2 this month",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
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
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.people,
                              color: successColor,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Total Participants",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${(technicalTests.fold(0, (sum, test) => sum + (test["participants"] as int)) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "817 participants",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
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
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.trending_up,
                              color: warningColor,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Average Pass Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${((technicalTests.fold(0.0, (sum, test) => sum + (test["passRate"] as double)) / technicalTests.length)).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "62.8% pass rate",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
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
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.star,
                              color: infoColor,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Average Score",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${((technicalTests.fold(0.0, (sum, test) => sum + (test["averageScore"] as double)) / technicalTests.length)).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Out of 100",
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

            // Search and Filters
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
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search tests...",
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "Frontend", "value": "Frontend"},
                            {"label": "Backend", "value": "Backend"},
                            {"label": "Database", "value": "Database"},
                            {"label": "Mobile", "value": "Mobile"},
                            {"label": "DevOps", "value": "DevOps"},
                            {"label": "AI/ML", "value": "AI/ML"},
                          ],
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
                          items: [
                            {"label": "All", "value": "All"},
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
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "Coding", "value": "Coding"},
                            {"label": "Algorithm", "value": "Algorithm"},
                            {"label": "Theoretical", "value": "Theoretical"},
                            {"label": "Practical", "value": "Practical"},
                          ],
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "Active", "value": "Active"},
                            {"label": "Draft", "value": "Draft"},
                            {"label": "Inactive", "value": "Inactive"},
                          ],
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tests List
            ...filteredTests.map((test) {
              return Container(
                padding: EdgeInsets.all(spMd),
                margin: EdgeInsets.only(bottom: spSm),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${test["id"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${test["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${test["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getStatusColor("${test["status"]}"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${test["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
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
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),

                    // Test Details Row
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.folder,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${test["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.code,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${test["type"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor("${test["difficulty"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${test["difficulty"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getDifficultyColor("${test["difficulty"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Test Metrics
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${test["duration"]} min",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${test["questions"]} questions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 16,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${test["participants"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "participants",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                size: 16,
                                color: warningColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(test["passRate"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "pass rate",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: infoColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(test["averageScore"] as double).toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "avg score",
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

                    // Skills Tags
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (test["skills"] as List).map<Widget>((skill) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "$skill",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Test Sections
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Test Sections",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          ...(test["testSections"] as List).map<Widget>((section) {
                            return Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: disabledBoldColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${section["name"]} (${section["questions"]} questions)",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${section["timeLimit"]} min",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Edit Test",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.play_arrow,
                          size: bs.sm,
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
