import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaCalculatorView extends StatefulWidget {
  const ElaCalculatorView({super.key});

  @override
  State<ElaCalculatorView> createState() => _ElaCalculatorViewState();
}

class _ElaCalculatorViewState extends State<ElaCalculatorView> {
  bool loading = false;
  String selectedCalculatorType = "gpa";
  
  // GPA Calculator variables
  List<Map<String, dynamic>> courses = [
    {
      "name": "English Literature",
      "credits": 3.0,
      "grade": "A",
      "gradePoint": 4.0,
    },
    {
      "name": "Creative Writing",
      "credits": 3.0,
      "grade": "A-",
      "gradePoint": 3.7,
    },
    {
      "name": "Grammar & Composition",
      "credits": 4.0,
      "grade": "B+",
      "gradePoint": 3.3,
    },
  ];

  // Grade Calculator variables
  List<Map<String, dynamic>> assignments = [
    {
      "name": "Essay 1",
      "score": 85.0,
      "maxScore": 100.0,
      "weight": 20.0,
    },
    {
      "name": "Quiz 1",
      "score": 92.0,
      "maxScore": 100.0,
      "weight": 10.0,
    },
    {
      "name": "Midterm Exam",
      "score": 88.0,
      "maxScore": 100.0,
      "weight": 25.0,
    },
  ];

  // Reading Level Calculator variables
  int totalWords = 150;
  int totalSentences = 8;
  int totalSyllables = 200;

  Map<String, dynamic> gradeScale = {
    "A+": 4.0,
    "A": 4.0,
    "A-": 3.7,
    "B+": 3.3,
    "B": 3.0,
    "B-": 2.7,
    "C+": 2.3,
    "C": 2.0,
    "C-": 1.7,
    "D+": 1.3,
    "D": 1.0,
    "F": 0.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ELA Calculator"),
        actions: [
          QButton(
            icon: Icons.help_outline,
            size: bs.sm,
            onPressed: () {
              _showHelp();
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
                  _buildCalculatorSelector(),
                  SizedBox(height: spLg),
                  _buildCalculatorContent(),
                ],
              ),
            ),
    );
  }

  Widget _buildCalculatorSelector() {
    List<Map<String, dynamic>> calculatorTypes = [
      {
        "id": "gpa",
        "name": "GPA Calculator",
        "description": "Calculate Grade Point Average",
        "icon": Icons.calculate,
        "color": primaryColor,
      },
      {
        "id": "grade",
        "name": "Grade Calculator",
        "description": "Calculate weighted grades",
        "icon": Icons.assessment,
        "color": successColor,
      },
      {
        "id": "reading",
        "name": "Reading Level",
        "description": "Assess text readability",
        "icon": Icons.menu_book,
        "color": infoColor,
      },
      {
        "id": "words",
        "name": "Word Counter",
        "description": "Count words and characters",
        "icon": Icons.text_fields,
        "color": warningColor,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Calculator",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: calculatorTypes.map((type) => _buildCalculatorTypeCard(type)).toList(),
        ),
      ],
    );
  }

  Widget _buildCalculatorTypeCard(Map<String, dynamic> type) {
    bool isSelected = selectedCalculatorType == type["id"];
    
    return GestureDetector(
      onTap: () {
        selectedCalculatorType = type["id"];
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(
            color: isSelected ? (type["color"] as Color) : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (type["color"] as Color).withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    type["icon"] as IconData,
                    color: type["color"] as Color,
                    size: 24,
                  ),
                ),
                Spacer(),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: type["color"] as Color,
                    size: 24,
                  ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              type["name"],
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              type["description"],
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorContent() {
    switch (selectedCalculatorType) {
      case "gpa":
        return _buildGPACalculator();
      case "grade":
        return _buildGradeCalculator();
      case "reading":
        return _buildReadingLevelCalculator();
      case "words":
        return _buildWordCountCalculator();
      default:
        return _buildGPACalculator();
    }
  }

  Widget _buildGPACalculator() {
    double totalCredits = courses.fold(0.0, (sum, course) => sum + (course["credits"] as double));
    double totalGradePoints = courses.fold(0.0, (sum, course) => 
        sum + ((course["credits"] as double) * (course["gradePoint"] as double)));
    double gpa = totalCredits > 0 ? totalGradePoints / totalCredits : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                "Your GPA",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                gpa.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: fsH2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spSm),
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
                            totalCredits.toStringAsFixed(0),
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Total Credits",
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
                            totalGradePoints.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Grade Points",
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
        ),
        SizedBox(height: spLg),
        Row(
          children: [
            Expanded(
              child: Text(
                "Course List",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            QButton(
              label: "Add Course",
              size: bs.sm,
              onPressed: () {
                _addCourse();
              },
            ),
          ],
        ),
        SizedBox(height: spMd),
        Column(
          children: courses.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> course = entry.value;
            return _buildCourseCard(course, index);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
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
              Expanded(
                child: Text(
                  "${course["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {
                  _removeCourse(index);
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Credits",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${course["credits"]}",
                      style: TextStyle(
                        fontSize: 16,
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
                      "Grade",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${course["grade"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _getGradeColor(course["grade"]),
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
                      "Grade Points",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${course["gradePoint"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
  }

  Widget _buildGradeCalculator() {
    double totalWeightedScore = 0.0;
    double totalWeight = 0.0;
    
    for (var assignment in assignments) {
      double percentage = ((assignment["score"] as double) / (assignment["maxScore"] as double)) * 100;
      double weightedScore = percentage * ((assignment["weight"] as double) / 100);
      totalWeightedScore += weightedScore;
      totalWeight += assignment["weight"] as double;
    }
    
    double currentGrade = totalWeight > 0 ? (totalWeightedScore / totalWeight) * 100 : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [successColor, successColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Grade",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "${currentGrade.toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: fsH2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spSm),
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
                            "${totalWeight.toStringAsFixed(0)}%",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Weight Covered",
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
                            _getLetterGrade(currentGrade),
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Letter Grade",
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
        ),
        SizedBox(height: spLg),
        Row(
          children: [
            Expanded(
              child: Text(
                "Assignments",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            QButton(
              label: "Add Assignment",
              size: bs.sm,
              onPressed: () {
                _addAssignment();
              },
            ),
          ],
        ),
        SizedBox(height: spMd),
        Column(
          children: assignments.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> assignment = entry.value;
            return _buildAssignmentCard(assignment, index);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAssignmentCard(Map<String, dynamic> assignment, int index) {
    double percentage = ((assignment["score"] as double) / (assignment["maxScore"] as double)) * 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
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
              Expanded(
                child: Text(
                  "${assignment["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {
                  _removeAssignment(index);
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Score",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${assignment["score"]}/${assignment["maxScore"]}",
                      style: TextStyle(
                        fontSize: 16,
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
                      "Percentage",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${percentage.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _getPercentageColor(percentage),
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
                      "Weight",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${assignment["weight"]}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
  }

  Widget _buildReadingLevelCalculator() {
    // Flesch-Kincaid Grade Level calculation
    double avgWordsPerSentence = totalSentences > 0 ? totalWords / totalSentences : 0;
    double avgSyllablesPerWord = totalWords > 0 ? totalSyllables / totalWords : 0;
    double gradeLevel = (0.39 * avgWordsPerSentence) + (11.8 * avgSyllablesPerWord) - 15.59;
    
    // Flesch Reading Ease calculation
    double readingEase = 206.835 - (1.015 * avgWordsPerSentence) - (84.6 * avgSyllablesPerWord);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [infoColor, infoColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reading Level Analysis",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                            gradeLevel.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Grade Level",
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
                            readingEase.toStringAsFixed(0),
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Reading Ease",
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
        ),
        SizedBox(height: spLg),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Text Statistics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Total Words",
                      value: totalWords.toString(),
                      onChanged: (value) {
                        totalWords = int.tryParse(value) ?? 0;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Total Sentences",
                      value: totalSentences.toString(),
                      onChanged: (value) {
                        totalSentences = int.tryParse(value) ?? 0;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Total Syllables",
                      value: totalSyllables.toString(),
                      onChanged: (value) {
                        totalSyllables = int.tryParse(value) ?? 0;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Interpretation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Text(
                _getReadabilityInterpretation(readingEase),
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWordCountCalculator() {
    String sampleText = "";
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            children: [
              Text(
                "Text Input",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QMemoField(
                label: "Enter your text here",
                value: sampleText,
                onChanged: (value) {
                  sampleText = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildCountCard(
              "Words",
              sampleText.trim().isEmpty ? 0 : sampleText.trim().split(' ').length,
              Icons.text_fields,
              primaryColor,
            ),
            _buildCountCard(
              "Characters",
              sampleText.length,
              Icons.format_size,
              successColor,
            ),
            _buildCountCard(
              "Characters (no spaces)",
              sampleText.replaceAll(' ', '').length,
              Icons.format_size,
              infoColor,
            ),
            _buildCountCard(
              "Paragraphs",
              sampleText.trim().isEmpty ? 0 : sampleText.split('\n').where((p) => p.trim().isNotEmpty).length,
              Icons.format_list_bulleted,
              warningColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCountCard(String title, int count, IconData icon, Color color) {
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
          SizedBox(height: spMd),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getGradeColor(String grade) {
    if (grade.startsWith('A')) return successColor;
    if (grade.startsWith('B')) return infoColor;
    if (grade.startsWith('C')) return warningColor;
    if (grade.startsWith('D')) return dangerColor;
    return disabledBoldColor;
  }

  Color _getPercentageColor(double percentage) {
    if (percentage >= 90) return successColor;
    if (percentage >= 80) return infoColor;
    if (percentage >= 70) return warningColor;
    if (percentage >= 60) return dangerColor;
    return disabledBoldColor;
  }

  String _getLetterGrade(double percentage) {
    if (percentage >= 97) return "A+";
    if (percentage >= 93) return "A";
    if (percentage >= 90) return "A-";
    if (percentage >= 87) return "B+";
    if (percentage >= 83) return "B";
    if (percentage >= 80) return "B-";
    if (percentage >= 77) return "C+";
    if (percentage >= 73) return "C";
    if (percentage >= 70) return "C-";
    if (percentage >= 67) return "D+";
    if (percentage >= 65) return "D";
    return "F";
  }

  String _getReadabilityInterpretation(double readingEase) {
    if (readingEase >= 90) return "Very Easy: Easily understood by an average 11-year-old student.";
    if (readingEase >= 80) return "Easy: Conversational English for consumers.";
    if (readingEase >= 70) return "Fairly Easy: Acceptable for most 13-year-old students.";
    if (readingEase >= 60) return "Standard: Easily understood by 13-15 year old students.";
    if (readingEase >= 50) return "Fairly Difficult: Fairly difficult to read.";
    if (readingEase >= 30) return "Difficult: Best understood by university graduates.";
    return "Very Difficult: Best understood by university graduates with advanced degrees.";
  }

  void _addCourse() {
    courses.add({
      "name": "New Course",
      "credits": 3.0,
      "grade": "A",
      "gradePoint": 4.0,
    });
    setState(() {});
  }

  void _removeCourse(int index) {
    courses.removeAt(index);
    setState(() {});
  }

  void _addAssignment() {
    assignments.add({
      "name": "New Assignment",
      "score": 0.0,
      "maxScore": 100.0,
      "weight": 10.0,
    });
    setState(() {});
  }

  void _removeAssignment(int index) {
    assignments.removeAt(index);
    setState(() {});
  }

  void _showHelp() {
    ss("Showing calculator help");
  }
}
