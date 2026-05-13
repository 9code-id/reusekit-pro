import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaGradebookView extends StatefulWidget {
  const ElaGradebookView({super.key});

  @override
  State<ElaGradebookView> createState() => _ElaGradebookViewState();
}

class _ElaGradebookViewState extends State<ElaGradebookView> {
  String selectedClass = "English Literature 101";
  String selectedStudent = "All Students";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> students = [
    {
      "id": 1,
      "name": "Alex Johnson",
      "email": "alex.johnson@school.edu",
      "overall_grade": 87.5,
      "letter_grade": "B+",
      "assignments_completed": 12,
      "assignments_total": 15,
      "last_activity": "2024-12-15",
      "attendance_rate": 95
    },
    {
      "id": 2,
      "name": "Sarah Williams",
      "email": "sarah.williams@school.edu",
      "overall_grade": 94.2,
      "letter_grade": "A",
      "assignments_completed": 15,
      "assignments_total": 15,
      "last_activity": "2024-12-16",
      "attendance_rate": 100
    },
    {
      "id": 3,
      "name": "Michael Brown",
      "email": "michael.brown@school.edu",
      "overall_grade": 76.8,
      "letter_grade": "C+",
      "assignments_completed": 10,
      "assignments_total": 15,
      "last_activity": "2024-12-10",
      "attendance_rate": 88
    },
    {
      "id": 4,
      "name": "Emily Davis",
      "email": "emily.davis@school.edu",
      "overall_grade": 91.3,
      "letter_grade": "A-",
      "assignments_completed": 14,
      "assignments_total": 15,
      "last_activity": "2024-12-14",
      "attendance_rate": 97
    }
  ];

  List<Map<String, dynamic>> assignments = [
    {
      "id": 1,
      "title": "Poetry Analysis: Robert Frost",
      "category": "Literature",
      "due_date": "2024-12-20",
      "points": 100,
      "submissions": 3,
      "total_students": 4,
      "avg_score": 85.5,
      "graded": true
    },
    {
      "id": 2,
      "title": "Grammar Workshop: Sentence Structure",
      "category": "Grammar",
      "due_date": "2024-12-18",
      "points": 50,
      "submissions": 4,
      "total_students": 4,
      "avg_score": 92.0,
      "graded": true
    },
    {
      "id": 3,
      "title": "Creative Writing: Short Story",
      "category": "Creative Writing",
      "due_date": "2024-12-25",
      "points": 150,
      "submissions": 2,
      "total_students": 4,
      "avg_score": 88.5,
      "graded": false
    }
  ];

  List<Map<String, dynamic>> get filteredStudents {
    List<Map<String, dynamic>> filtered = students;
    
    if (selectedStudent != "All Students") {
      filtered = filtered.where((student) => 
        student["name"] == selectedStudent).toList();
    }
    
    return filtered;
  }

  List<Map<String, dynamic>> get filteredAssignments {
    List<Map<String, dynamic>> filtered = assignments;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((assignment) => 
        assignment["category"] == selectedCategory).toList();
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

  void _viewStudentDetails(Map<String, dynamic> student) {
    // navigateTo(StudentGradeDetailView(student: student))
  }

  void _gradeAssignment(Map<String, dynamic> assignment) {
    // navigateTo(GradeAssignmentView(assignment: assignment))
  }

  void _exportGrades() {
    ss("Grades exported successfully!");
  }

  void _sendGradeReports() {
    ss("Grade reports sent to all students!");
  }

  double get classAverage {
    if (students.isEmpty) return 0.0;
    double total = students.fold(0.0, (sum, student) => 
        sum + (student["overall_grade"] as num).toDouble());
    return total / students.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gradebook"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () => _exportGrades(),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _sendGradeReports(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Class selector and filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Select Class",
                    items: [
                      {"label": "English Literature 101", "value": "English Literature 101"},
                      {"label": "Creative Writing Workshop", "value": "Creative Writing Workshop"},
                      {"label": "English Grammar", "value": "English Grammar"},
                    ],
                    value: selectedClass,
                    onChanged: (value, label) {
                      selectedClass = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Class overview
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
                    selectedClass,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${students.length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Students",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${assignments.length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Assignments",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${classAverage.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Class Average",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
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
            
            SizedBox(height: spLg),
            
            // Quick stats
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
                          students.where((s) => s["letter_grade"].startsWith("A")).length,
                          successColor,
                        ),
                      ),
                      Expanded(
                        child: _buildGradeDistributionItem(
                          "B's",
                          students.where((s) => s["letter_grade"].startsWith("B")).length,
                          infoColor,
                        ),
                      ),
                      Expanded(
                        child: _buildGradeDistributionItem(
                          "C's",
                          students.where((s) => s["letter_grade"].startsWith("C")).length,
                          warningColor,
                        ),
                      ),
                      Expanded(
                        child: _buildGradeDistributionItem(
                          "Below",
                          students.where((s) => ["D", "F"].contains(s["letter_grade"])).length,
                          dangerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Student filter
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter Students",
                    items: [
                      {"label": "All Students", "value": "All Students"},
                      ...students.map((student) => {
                        "label": student["name"],
                        "value": student["name"]
                      }).toList(),
                    ],
                    value: selectedStudent,
                    onChanged: (value, label) {
                      selectedStudent = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Students list
            Text(
              "Students (${filteredStudents.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...filteredStudents.map((student) {
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
                      color: _getGradeColor(student["letter_grade"]),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: primaryColor,
                          child: Text(
                            "${student["name"].split(" ").map((n) => n[0]).join("")}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${student["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${student["email"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getGradeColor(student["letter_grade"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${student["letter_grade"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildStudentStatItem(
                            "Grade",
                            "${(student["overall_grade"] as num).toStringAsFixed(1)}%",
                            Icons.grade,
                          ),
                        ),
                        Expanded(
                          child: _buildStudentStatItem(
                            "Completed",
                            "${student["assignments_completed"]}/${student["assignments_total"]}",
                            Icons.assignment,
                          ),
                        ),
                        Expanded(
                          child: _buildStudentStatItem(
                            "Attendance",
                            "${student["attendance_rate"]}%",
                            Icons.event_available,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Text(
                          "Last activity: ${DateTime.parse(student["last_activity"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () => _viewStudentDetails(student),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            
            SizedBox(height: spLg),
            
            // Assignment filter
            QCategoryPicker(
              label: "Filter Assignments",
              items: [
                {"label": "All", "value": "All"},
                {"label": "Literature", "value": "Literature"},
                {"label": "Grammar", "value": "Grammar"},
                {"label": "Creative Writing", "value": "Creative Writing"},
              ],
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Assignments list
            Text(
              "Assignments (${filteredAssignments.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...filteredAssignments.map((assignment) {
              final submissionRate = ((assignment["submissions"] as int) / (assignment["total_students"] as int) * 100).round();
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${assignment["title"]}",
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
                            color: assignment["graded"] ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            assignment["graded"] ? "Graded" : "Pending",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: assignment["graded"] ? successColor : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildAssignmentStatItem(
                            "Submissions",
                            "${assignment["submissions"]}/${assignment["total_students"]} ($submissionRate%)",
                            Icons.upload,
                          ),
                        ),
                        Expanded(
                          child: _buildAssignmentStatItem(
                            "Avg Score",
                            "${(assignment["avg_score"] as num).toStringAsFixed(1)}%",
                            Icons.analytics,
                          ),
                        ),
                        Expanded(
                          child: _buildAssignmentStatItem(
                            "Points",
                            "${assignment["points"]}",
                            Icons.star,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Text(
                          "Due: ${DateTime.parse(assignment["due_date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "${assignment["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: assignment["graded"] ? "View Grades" : "Grade Now",
                          size: bs.sm,
                          onPressed: () => _gradeAssignment(assignment),
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

  Widget _buildStudentStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: disabledBoldColor,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
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

  Widget _buildAssignmentStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: disabledBoldColor,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
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
