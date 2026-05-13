import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaGradeView extends StatefulWidget {
  const ElaGradeView({super.key});

  @override
  State<ElaGradeView> createState() => _ElaGradeViewState();
}

class _ElaGradeViewState extends State<ElaGradeView> {
  String selectedSemester = "Fall 2024";
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> grades = [
    {
      "id": 1,
      "assignment": "Poetry Analysis: Robert Frost",
      "type": "Essay",
      "submitted_date": "2024-12-15",
      "graded_date": "2024-12-17",
      "points_earned": 85,
      "points_possible": 100,
      "percentage": 85,
      "letter_grade": "B",
      "status": "Graded",
      "teacher": "Ms. Johnson",
      "feedback": "Good analysis of metaphors and symbolism. Work on thesis clarity.",
      "category": "Literature"
    },
    {
      "id": 2,
      "assignment": "Grammar Workshop: Sentence Structure",
      "type": "Practice",
      "submitted_date": "2024-12-14",
      "graded_date": "2024-12-16",
      "points_earned": 48,
      "points_possible": 50,
      "percentage": 96,
      "letter_grade": "A",
      "status": "Graded",
      "teacher": "Mr. Smith",
      "feedback": "Excellent understanding of complex sentences.",
      "category": "Grammar"
    },
    {
      "id": 3,
      "assignment": "Creative Writing: Short Story",
      "type": "Creative",
      "submitted_date": "2024-12-12",
      "graded_date": "2024-12-18",
      "points_earned": 135,
      "points_possible": 150,
      "percentage": 90,
      "letter_grade": "A-",
      "status": "Graded",
      "teacher": "Ms. Williams",
      "feedback": "Creative plot and good character development. Minor dialogue issues.",
      "category": "Creative Writing"
    },
    {
      "id": 4,
      "assignment": "Reading Comprehension: Shakespeare",
      "type": "Quiz",
      "submitted_date": "2024-12-10",
      "graded_date": "",
      "points_earned": 0,
      "points_possible": 75,
      "percentage": 0,
      "letter_grade": "F",
      "status": "Late Submission",
      "teacher": "Ms. Johnson",
      "feedback": "Assignment submitted after deadline.",
      "category": "Literature"
    },
    {
      "id": 5,
      "assignment": "Vocabulary Test: Unit 3",
      "type": "Test",
      "submitted_date": "2024-12-08",
      "graded_date": "2024-12-09",
      "points_earned": 42,
      "points_possible": 50,
      "percentage": 84,
      "letter_grade": "B",
      "status": "Graded",
      "teacher": "Mr. Smith",
      "feedback": "Good vocabulary retention. Review prefix meanings.",
      "category": "Vocabulary"
    }
  ];

  List<Map<String, dynamic>> get filteredGrades {
    List<Map<String, dynamic>> filtered = grades;
    
    if (selectedFilter != "All") {
      filtered = filtered.where((grade) => 
        grade["category"] == selectedFilter).toList();
    }
    
    return filtered;
  }

  Color _getGradeColor(String letterGrade) {
    switch (letterGrade) {
      case "A":
      case "A-":
      case "A+":
        return successColor;
      case "B":
      case "B-":
      case "B+":
        return infoColor;
      case "C":
      case "C-":
      case "C+":
        return warningColor;
      case "D":
      case "D-":
      case "D+":
        return Color(0xFFFF9800);
      case "F":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Graded":
        return successColor;
      case "Pending":
        return warningColor;
      case "Late Submission":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _viewGradeDetails(Map<String, dynamic> grade) {
    // navigateTo(GradeDetailView(grade: grade))
  }

  double get overallGPA {
    final gradedAssignments = grades.where((g) => g["status"] == "Graded").toList();
    if (gradedAssignments.isEmpty) return 0.0;
    
    double totalPoints = 0;
    int totalAssignments = gradedAssignments.length;
    
    for (var grade in gradedAssignments) {
      double percentage = (grade["percentage"] as num).toDouble();
      if (percentage >= 97) totalPoints += 4.0;
      else if (percentage >= 93) totalPoints += 3.7;
      else if (percentage >= 90) totalPoints += 3.3;
      else if (percentage >= 87) totalPoints += 3.0;
      else if (percentage >= 83) totalPoints += 2.7;
      else if (percentage >= 80) totalPoints += 2.3;
      else if (percentage >= 77) totalPoints += 2.0;
      else if (percentage >= 73) totalPoints += 1.7;
      else if (percentage >= 70) totalPoints += 1.3;
      else if (percentage >= 67) totalPoints += 1.0;
      else if (percentage >= 65) totalPoints += 0.7;
      else totalPoints += 0.0;
    }
    
    return totalPoints / totalAssignments;
  }

  double get overallPercentage {
    final gradedAssignments = grades.where((g) => g["status"] == "Graded").toList();
    if (gradedAssignments.isEmpty) return 0.0;
    
    double totalEarned = 0;
    double totalPossible = 0;
    
    for (var grade in gradedAssignments) {
      totalEarned += (grade["points_earned"] as num).toDouble();
      totalPossible += (grade["points_possible"] as num).toDouble();
    }
    
    return (totalEarned / totalPossible) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Grades"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // navigateTo(GradeAnalyticsView())
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Semester selector
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Select Semester",
                    items: [
                      {"label": "Fall 2024", "value": "Fall 2024"},
                      {"label": "Spring 2024", "value": "Spring 2024"},
                      {"label": "Fall 2023", "value": "Fall 2023"},
                    ],
                    value: selectedSemester,
                    onChanged: (value, label) {
                      selectedSemester = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Overall grade summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Text(
                    "Overall Grade",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${overallPercentage.toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: fsH1,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "GPA: ${overallGPA.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Grade distribution
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Grade Distribution",
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
                        child: _buildGradeDistributionItem(
                          "A's",
                          grades.where((g) => g["letter_grade"].startsWith("A")).length,
                          successColor,
                        ),
                      ),
                      Expanded(
                        child: _buildGradeDistributionItem(
                          "B's",
                          grades.where((g) => g["letter_grade"].startsWith("B")).length,
                          infoColor,
                        ),
                      ),
                      Expanded(
                        child: _buildGradeDistributionItem(
                          "C's",
                          grades.where((g) => g["letter_grade"].startsWith("C")).length,
                          warningColor,
                        ),
                      ),
                      Expanded(
                        child: _buildGradeDistributionItem(
                          "Below",
                          grades.where((g) => ["D", "F"].contains(g["letter_grade"])).length,
                          dangerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Filter by category
            QCategoryPicker(
              label: "Filter by Category",
              items: [
                {"label": "All", "value": "All"},
                {"label": "Literature", "value": "Literature"},
                {"label": "Grammar", "value": "Grammar"},
                {"label": "Creative Writing", "value": "Creative Writing"},
                {"label": "Vocabulary", "value": "Vocabulary"},
              ],
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Grades list
            Text(
              "Recent Grades (${filteredGrades.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...filteredGrades.map((grade) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getGradeColor(grade["letter_grade"]),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${grade["assignment"]}",
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
                            color: _getGradeColor(grade["letter_grade"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${grade["letter_grade"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Text(
                          "${grade["points_earned"]}/${grade["points_possible"]} points",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "${grade["percentage"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _getGradeColor(grade["letter_grade"]),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(grade["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${grade["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor(grade["status"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.category,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${grade["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(
                          Icons.person,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${grade["teacher"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    if (grade["feedback"].toString().isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(
                            color: infoColor.withAlpha(50),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Teacher Feedback:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${grade["feedback"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        if (grade["graded_date"].toString().isNotEmpty)
                          Text(
                            "Graded: ${DateTime.parse(grade["graded_date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        Spacer(),
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () => _viewGradeDetails(grade),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            
            if (filteredGrades.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.grade,
                      color: disabledColor,
                      size: 60,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No grades found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Grades will appear here once assignments are graded",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeDistributionItem(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          "$count",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
