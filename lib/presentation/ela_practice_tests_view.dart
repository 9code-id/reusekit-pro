import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaPracticeTestsView extends StatefulWidget {
  const ElaPracticeTestsView({super.key});

  @override
  State<ElaPracticeTestsView> createState() => _ElaPracticeTestsViewState();
}

class _ElaPracticeTestsViewState extends State<ElaPracticeTestsView> {
  int selectedDifficulty = 0;
  String selectedSubject = "All Subjects";
  bool loading = false;

  List<Map<String, dynamic>> difficultyLevels = [
    {"label": "All Levels", "value": "all"},
    {"label": "Beginner", "value": "beginner"},
    {"label": "Intermediate", "value": "intermediate"},
    {"label": "Advanced", "value": "advanced"},
  ];

  List<Map<String, dynamic>> subjects = [
    {"label": "All Subjects", "value": "all"},
    {"label": "Reading Comprehension", "value": "reading"},
    {"label": "Grammar & Usage", "value": "grammar"},
    {"label": "Writing Skills", "value": "writing"},
    {"label": "Vocabulary", "value": "vocabulary"},
  ];

  List<Map<String, dynamic>> practiceTests = [
    {
      "id": 1,
      "title": "Reading Comprehension Test 1",
      "description": "Test your understanding of complex passages",
      "difficulty": "Intermediate",
      "duration": "45 minutes",
      "questions": 25,
      "subject": "Reading",
      "completed": false,
      "score": null,
      "color": primaryColor,
    },
    {
      "id": 2,
      "title": "Grammar Fundamentals",
      "description": "Master the basics of English grammar",
      "difficulty": "Beginner",
      "duration": "30 minutes",
      "questions": 20,
      "subject": "Grammar",
      "completed": true,
      "score": 85,
      "color": successColor,
    },
    {
      "id": 3,
      "title": "Advanced Writing Assessment",
      "description": "Demonstrate your writing skills and creativity",
      "difficulty": "Advanced",
      "duration": "60 minutes",
      "questions": 15,
      "subject": "Writing",
      "completed": false,
      "score": null,
      "color": warningColor,
    },
    {
      "id": 4,
      "title": "Vocabulary Builder Test",
      "description": "Expand your English vocabulary knowledge",
      "difficulty": "Intermediate",
      "duration": "25 minutes",
      "questions": 30,
      "subject": "Vocabulary",
      "completed": true,
      "score": 92,
      "color": infoColor,
    },
    {
      "id": 5,
      "title": "Comprehensive ELA Assessment",
      "description": "Complete assessment covering all ELA areas",
      "difficulty": "Advanced",
      "duration": "90 minutes",
      "questions": 50,
      "subject": "All",
      "completed": false,
      "score": null,
      "color": dangerColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Practice Tests"),
        actions: [
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () {
              // Navigate to analytics
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: spLg),
                  _buildFilters(),
                  SizedBox(height: spLg),
                  _buildStatsSection(),
                  SizedBox(height: spLg),
                  _buildTestsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ELA Practice Tests",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Improve your English Language Arts skills with our comprehensive practice tests",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(230),
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "5",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Total Tests",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
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
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "2",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
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
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "88.5%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Avg Score",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Filter Tests",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        QCategoryPicker(
          label: "Difficulty Level",
          items: difficultyLevels,
          value: difficultyLevels[selectedDifficulty]["value"],
          onChanged: (index, label, value, item) {
            selectedDifficulty = index;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        QDropdownField(
          label: "Subject",
          items: subjects,
          value: selectedSubject,
          onChanged: (value, label) {
            selectedSubject = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Performance Overview",
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
            _buildStatCard(
              "Reading",
              "85%",
              Icons.book,
              successColor,
              "Last: 85%",
            ),
            _buildStatCard(
              "Grammar",
              "88%",
              Icons.spellcheck,
              infoColor,
              "Last: 88%",
            ),
            _buildStatCard(
              "Writing",
              "Not tested",
              Icons.edit,
              disabledColor,
              "Take test",
            ),
            _buildStatCard(
              "Vocabulary",
              "92%",
              Icons.library_books,
              warningColor,
              "Last: 92%",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String score,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: color,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            score,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Available Tests",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            QButton(
              label: "View All",
              size: bs.sm,
              onPressed: () {
                // Navigate to all tests
              },
            ),
          ],
        ),
        SizedBox(height: spSm),
        Column(
          children: practiceTests.map((test) => _buildTestCard(test)).toList(),
        ),
      ],
    );
  }

  Widget _buildTestCard(Map<String, dynamic> test) {
    bool isCompleted = test["completed"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: test["color"] as Color,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${test["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
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
              if (isCompleted)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${test["score"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: (test["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${test["difficulty"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: test["color"] as Color,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.access_time,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${test["duration"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.quiz,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${test["questions"]} questions",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: isCompleted ? "Retake" : "Start Test",
                size: bs.sm,
                onPressed: () {
                  _startTest(test);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _startTest(Map<String, dynamic> test) {
    // Navigate to test
    ss("Starting test: ${test["title"]}");
  }
}
