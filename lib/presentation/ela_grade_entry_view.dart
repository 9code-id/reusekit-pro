import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaGradeEntryView extends StatefulWidget {
  const ElaGradeEntryView({super.key});

  @override
  State<ElaGradeEntryView> createState() => _ElaGradeEntryViewState();
}

class _ElaGradeEntryViewState extends State<ElaGradeEntryView> {
  String selectedClass = "Grade 3A";
  String selectedAssignment = "Reading Comprehension Test";
  String selectedSubject = "Reading";
  String searchQuery = "";
  bool showOnlyUngraded = false;

  List<Map<String, dynamic>> classOptions = [
    {"label": "Grade 3A", "value": "Grade 3A"},
    {"label": "Grade 3B", "value": "Grade 3B"},
    {"label": "Grade 4A", "value": "Grade 4A"},
    {"label": "Grade 4B", "value": "Grade 4B"},
    {"label": "Grade 5A", "value": "Grade 5A"},
  ];

  List<Map<String, dynamic>> assignmentOptions = [
    {"label": "Reading Comprehension Test", "value": "Reading Comprehension Test"},
    {"label": "Narrative Writing Assignment", "value": "Narrative Writing Assignment"},
    {"label": "Vocabulary Quiz", "value": "Vocabulary Quiz"},
    {"label": "Speaking Presentation", "value": "Speaking Presentation"},
    {"label": "Listening Exercise", "value": "Listening Exercise"},
  ];

  List<Map<String, dynamic>> subjectOptions = [
    {"label": "All Subjects", "value": "All Subjects"},
    {"label": "Reading", "value": "Reading"},
    {"label": "Writing", "value": "Writing"},
    {"label": "Speaking", "value": "Speaking"},
    {"label": "Listening", "value": "Listening"},
  ];

  List<Map<String, dynamic>> students = [
    {
      "id": "STU001",
      "name": "Alice Johnson",
      "studentNumber": "2024001",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=girl",
      "assignments": {
        "Reading Comprehension Test": {"score": "85", "maxScore": 100, "graded": true, "comments": "Excellent understanding of the text"},
        "Narrative Writing Assignment": {"score": "", "maxScore": 100, "graded": false, "comments": ""},
        "Vocabulary Quiz": {"score": "92", "maxScore": 100, "graded": true, "comments": "Strong vocabulary skills"},
        "Speaking Presentation": {"score": "", "maxScore": 100, "graded": false, "comments": ""},
        "Listening Exercise": {"score": "88", "maxScore": 100, "graded": true, "comments": "Good attention to detail"},
      }
    },
    {
      "id": "STU002",
      "name": "Bob Smith",
      "studentNumber": "2024002",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=boy",
      "assignments": {
        "Reading Comprehension Test": {"score": "72", "maxScore": 100, "graded": true, "comments": "Needs more practice with inference questions"},
        "Narrative Writing Assignment": {"score": "", "maxScore": 100, "graded": false, "comments": ""},
        "Vocabulary Quiz": {"score": "", "maxScore": 100, "graded": false, "comments": ""},
        "Speaking Presentation": {"score": "78", "maxScore": 100, "graded": true, "comments": "Good content, work on confidence"},
        "Listening Exercise": {"score": "", "maxScore": 100, "graded": false, "comments": ""},
      }
    },
    {
      "id": "STU003",
      "name": "Carol Brown",
      "studentNumber": "2024003",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=girl",
      "assignments": {
        "Reading Comprehension Test": {"score": "95", "maxScore": 100, "graded": true, "comments": "Outstanding performance"},
        "Narrative Writing Assignment": {"score": "90", "maxScore": 100, "graded": true, "comments": "Creative story with good structure"},
        "Vocabulary Quiz": {"score": "", "maxScore": 100, "graded": false, "comments": ""},
        "Speaking Presentation": {"score": "92", "maxScore": 100, "graded": true, "comments": "Confident and well-organized"},
        "Listening Exercise": {"score": "89", "maxScore": 100, "graded": true, "comments": "Excellent comprehension"},
      }
    },
    {
      "id": "STU004",
      "name": "David Wilson",
      "studentNumber": "2024004",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=boy",
      "assignments": {
        "Reading Comprehension Test": {"score": "", "maxScore": 100, "graded": false, "comments": ""},
        "Narrative Writing Assignment": {"score": "", "maxScore": 100, "graded": false, "comments": ""},
        "Vocabulary Quiz": {"score": "68", "maxScore": 100, "graded": true, "comments": "Focus on spelling and definitions"},
        "Speaking Presentation": {"score": "", "maxScore": 100, "graded": false, "comments": ""},
        "Listening Exercise": {"score": "75", "maxScore": 100, "graded": true, "comments": "Good effort, practice active listening"},
      }
    },
    {
      "id": "STU005",
      "name": "Emma Davis",
      "studentNumber": "2024005",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=girl",
      "assignments": {
        "Reading Comprehension Test": {"score": "80", "maxScore": 100, "graded": true, "comments": "Good progress, keep practicing"},
        "Narrative Writing Assignment": {"score": "", "maxScore": 100, "graded": false, "comments": ""},
        "Vocabulary Quiz": {"score": "85", "maxScore": 100, "graded": true, "comments": "Nice improvement from last quiz"},
        "Speaking Presentation": {"score": "", "maxScore": 100, "graded": false, "comments": ""},
        "Listening Exercise": {"score": "", "maxScore": 100, "graded": false, "comments": ""},
      }
    },
  ];

  List<Map<String, dynamic>> get filteredStudents {
    return students.where((student) {
      bool matchesSearch = searchQuery.isEmpty || 
          student["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          student["studentNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      if (showOnlyUngraded) {
        var assignment = student["assignments"][selectedAssignment];
        bool isUngraded = assignment != null && !(assignment["graded"] as bool);
        return matchesSearch && isUngraded;
      }
      
      return matchesSearch;
    }).toList();
  }

  void _updateGrade(String studentId, String score, String comments) {
    setState(() {
      var student = students.firstWhere((s) => s["id"] == studentId);
      student["assignments"][selectedAssignment]["score"] = score;
      student["assignments"][selectedAssignment]["comments"] = comments;
      student["assignments"][selectedAssignment]["graded"] = score.isNotEmpty;
    });
  }

  void _showGradeDialog(Map<String, dynamic> student) {
    String score = student["assignments"][selectedAssignment]["score"] ?? "";
    String comments = student["assignments"][selectedAssignment]["comments"] ?? "";
    int maxScore = student["assignments"][selectedAssignment]["maxScore"] ?? 100;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Grade Entry"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${student["name"]} - ${student["studentNumber"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Assignment: $selectedAssignment",
              style: TextStyle(color: disabledBoldColor),
            ),
            SizedBox(height: spMd),
            QNumberField(
              label: "Score (out of $maxScore)",
              value: score,
              onChanged: (value) {
                score = value;
              },
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Comments",
              value: comments,
              hint: "Enter feedback for the student...",
              onChanged: (value) {
                comments = value;
              },
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Save Grade",
            size: bs.sm,
            onPressed: () {
              _updateGrade(student["id"], score, comments);
              Navigator.pop(context);
              ss("Grade saved successfully");
            },
          ),
        ],
      ),
    );
  }

  Color _getGradeColor(String? score, int maxScore) {
    if (score == null || score.isEmpty) return disabledColor;
    
    double percentage = (double.tryParse(score) ?? 0) / maxScore * 100;
    if (percentage >= 90) return successColor;
    if (percentage >= 80) return primaryColor;
    if (percentage >= 70) return warningColor;
    return dangerColor;
  }

  String _getGradeLetter(String? score, int maxScore) {
    if (score == null || score.isEmpty) return "N/A";
    
    double percentage = (double.tryParse(score) ?? 0) / maxScore * 100;
    if (percentage >= 90) return "A";
    if (percentage >= 80) return "B";
    if (percentage >= 70) return "C";
    if (percentage >= 60) return "D";
    return "F";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grade Entry"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Grades exported successfully");
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to grade analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters Section
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.school, color: primaryColor),
                      SizedBox(width: spXs),
                      Text(
                        "Grade Entry Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Class",
                          items: classOptions,
                          value: selectedClass,
                          onChanged: (value, label) {
                            selectedClass = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Assignment",
                          items: assignmentOptions,
                          value: selectedAssignment,
                          onChanged: (value, label) {
                            selectedAssignment = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search Students",
                          value: searchQuery,
                          hint: "Search by name or student number...",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Show only ungraded",
                              "value": true,
                              "checked": showOnlyUngraded,
                            }
                          ],
                          value: [if (showOnlyUngraded) {"label": "Show only ungraded", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            showOnlyUngraded = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredStudents.length}",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Students",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 40, color: disabledColor),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredStudents.where((s) => s["assignments"][selectedAssignment]["graded"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Graded",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 40, color: disabledColor),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredStudents.where((s) => s["assignments"][selectedAssignment]["graded"] == false).length}",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          textAlign: TextAlign.center,
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

            // Students List
            ...filteredStudents.map((student) {
              var assignment = student["assignments"][selectedAssignment];
              bool isGraded = assignment["graded"];
              String score = assignment["score"] ?? "";
              String comments = assignment["comments"] ?? "";
              int maxScore = assignment["maxScore"];
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: isGraded ? null : Border.all(color: warningColor.withAlpha(100), width: 2),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    // Student Header
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage("${student["avatar"]}"),
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
                                "Student #${student["studentNumber"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isGraded)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getGradeColor(score, maxScore).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(color: _getGradeColor(score, maxScore).withAlpha(50)),
                            ),
                            child: Text(
                              "${_getGradeLetter(score, maxScore)} ($score/$maxScore)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _getGradeColor(score, maxScore),
                              ),
                            ),
                          )
                        else
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(color: warningColor.withAlpha(50)),
                            ),
                            child: Text(
                              "Not Graded",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ),
                      ],
                    ),

                    // Assignment Details
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.assignment, size: 16, color: primaryColor),
                              SizedBox(width: spXs),
                              Text(
                                "Assignment: $selectedAssignment",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          if (comments.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: spXs),
                                Text(
                                  "Comments:",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  comments,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    // Action Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: isGraded ? "Edit Grade" : "Enter Grade",
                        icon: isGraded ? Icons.edit : Icons.grade,
                        size: bs.sm,
                        onPressed: () => _showGradeDialog(student),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Quick grade all functionality
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Quick Actions"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QButton(
                    label: "Grade All Ungraded",
                    icon: Icons.done_all,
                    size: bs.md,
                    onPressed: () {
                      Navigator.pop(context);
                      ss("Quick grading mode activated");
                    },
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Export Grades",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {
                      Navigator.pop(context);
                      ss("Grades exported successfully");
                    },
                  ),
                ],
              ),
            ),
          );
        },
        icon: Icon(Icons.speed),
        label: Text("Quick Actions"),
        backgroundColor: primaryColor,
      ),
    );
  }
}
