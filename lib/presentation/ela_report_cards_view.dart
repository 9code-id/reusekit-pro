import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaReportCardsView extends StatefulWidget {
  const ElaReportCardsView({super.key});

  @override
  State<ElaReportCardsView> createState() => _ElaReportCardsViewState();
}

class _ElaReportCardsViewState extends State<ElaReportCardsView> {
  String selectedClass = "Grade 3A";
  String selectedTerm = "Term 1";
  String selectedStudent = "All Students";
  String searchQuery = "";
  bool showFinalizedOnly = false;

  List<Map<String, dynamic>> classOptions = [
    {"label": "All Classes", "value": "All Classes"},
    {"label": "Grade 3A", "value": "Grade 3A"},
    {"label": "Grade 3B", "value": "Grade 3B"},
    {"label": "Grade 4A", "value": "Grade 4A"},
    {"label": "Grade 4B", "value": "Grade 4B"},
    {"label": "Grade 5A", "value": "Grade 5A"},
  ];

  List<Map<String, dynamic>> termOptions = [
    {"label": "Term 1", "value": "Term 1"},
    {"label": "Term 2", "value": "Term 2"},
    {"label": "Term 3", "value": "Term 3"},
    {"label": "Term 4", "value": "Term 4"},
  ];

  List<Map<String, dynamic>> studentOptions = [
    {"label": "All Students", "value": "All Students"},
    {"label": "Alice Johnson", "value": "Alice Johnson"},
    {"label": "Bob Smith", "value": "Bob Smith"},
    {"label": "Carol Brown", "value": "Carol Brown"},
    {"label": "David Wilson", "value": "David Wilson"},
    {"label": "Emma Davis", "value": "Emma Davis"},
  ];

  List<Map<String, dynamic>> reportCards = [
    {
      "id": "RC001",
      "studentId": "STU001",
      "studentName": "Alice Johnson",
      "studentNumber": "2024001",
      "class": "Grade 3A",
      "term": "Term 1",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=girl",
      "isFinalized": true,
      "finalizedDate": "2024-01-20",
      "generatedDate": "2024-01-18",
      "overallGrade": "A",
      "overallPercentage": 89.5,
      "gpa": 3.8,
      "rank": 2,
      "totalStudents": 25,
      "attendance": {"present": 38, "absent": 2, "total": 40},
      "subjects": [
        {
          "name": "Reading",
          "grade": "A",
          "percentage": 92,
          "comments": "Excellent reading comprehension and fluency. Shows strong analytical skills.",
          "competencies": [
            {"name": "Phonemic Awareness", "level": "Advanced"},
            {"name": "Reading Fluency", "level": "Proficient"},
            {"name": "Comprehension", "level": "Advanced"},
          ]
        },
        {
          "name": "Writing",
          "grade": "B+",
          "percentage": 88,
          "comments": "Creative writer with good story structure. Focus on grammar and punctuation.",
          "competencies": [
            {"name": "Narrative Writing", "level": "Proficient"},
            {"name": "Grammar Usage", "level": "Developing"},
            {"name": "Vocabulary", "level": "Proficient"},
          ]
        },
        {
          "name": "Speaking",
          "grade": "A-",
          "percentage": 87,
          "comments": "Confident speaker with clear articulation. Engages well in discussions.",
          "competencies": [
            {"name": "Oral Presentation", "level": "Proficient"},
            {"name": "Class Participation", "level": "Advanced"},
            {"name": "Voice Projection", "level": "Proficient"},
          ]
        },
        {
          "name": "Listening",
          "grade": "A",
          "percentage": 91,
          "comments": "Excellent listening skills and follows directions accurately.",
          "competencies": [
            {"name": "Active Listening", "level": "Advanced"},
            {"name": "Following Directions", "level": "Advanced"},
            {"name": "Comprehension", "level": "Proficient"},
          ]
        },
      ],
      "teacherComments": "Alice is an exceptional student who consistently demonstrates strong academic performance across all ELA domains. She is a natural leader in group discussions and helps her peers. Continue to challenge her with advanced reading materials.",
      "areasOfStrength": ["Reading comprehension", "Vocabulary", "Class participation"],
      "areasForImprovement": ["Grammar mechanics", "Handwriting neatness"],
      "nextTermGoals": ["Master advanced grammar rules", "Develop research skills", "Lead book club discussions"],
    },
    {
      "id": "RC002",
      "studentId": "STU002",
      "studentName": "Bob Smith",
      "studentNumber": "2024002",
      "class": "Grade 3A",
      "term": "Term 1",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=boy",
      "isFinalized": false,
      "finalizedDate": null,
      "generatedDate": "2024-01-18",
      "overallGrade": "C+",
      "overallPercentage": 74.2,
      "gpa": 2.5,
      "rank": 18,
      "totalStudents": 25,
      "attendance": {"present": 35, "absent": 5, "total": 40},
      "subjects": [
        {
          "name": "Reading",
          "grade": "C",
          "percentage": 72,
          "comments": "Making steady progress. Needs additional support with comprehension strategies.",
          "competencies": [
            {"name": "Phonemic Awareness", "level": "Developing"},
            {"name": "Reading Fluency", "level": "Beginning"},
            {"name": "Comprehension", "level": "Developing"},
          ]
        },
        {
          "name": "Writing",
          "grade": "C+",
          "percentage": 76,
          "comments": "Shows improvement in story ideas. Focus on sentence structure and organization.",
          "competencies": [
            {"name": "Narrative Writing", "level": "Developing"},
            {"name": "Grammar Usage", "level": "Beginning"},
            {"name": "Vocabulary", "level": "Developing"},
          ]
        },
        {
          "name": "Speaking",
          "grade": "B-",
          "percentage": 78,
          "comments": "Participates willingly but needs confidence building for presentations.",
          "competencies": [
            {"name": "Oral Presentation", "level": "Beginning"},
            {"name": "Class Participation", "level": "Developing"},
            {"name": "Voice Projection", "level": "Developing"},
          ]
        },
        {
          "name": "Listening",
          "grade": "C+",
          "percentage": 71,
          "comments": "Easily distracted. Work on attention and focus during lessons.",
          "competencies": [
            {"name": "Active Listening", "level": "Developing"},
            {"name": "Following Directions", "level": "Developing"},
            {"name": "Comprehension", "level": "Beginning"},
          ]
        },
      ],
      "teacherComments": "Bob is a hardworking student who shows improvement with consistent support. He benefits from small group instruction and hands-on activities. Continue encouraging his efforts and celebrating small victories.",
      "areasOfStrength": ["Creative thinking", "Willingness to participate", "Helps classmates"],
      "areasForImprovement": ["Reading fluency", "Attention span", "Following multi-step directions"],
      "nextTermGoals": ["Improve reading speed", "Build vocabulary", "Develop focus strategies"],
    },
    {
      "id": "RC003",
      "studentId": "STU003",
      "studentName": "Carol Brown",
      "studentNumber": "2024003",
      "class": "Grade 3A",
      "term": "Term 1",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=girl",
      "isFinalized": true,
      "finalizedDate": "2024-01-20",
      "generatedDate": "2024-01-18",
      "overallGrade": "A+",
      "overallPercentage": 95.8,
      "gpa": 4.0,
      "rank": 1,
      "totalStudents": 25,
      "attendance": {"present": 40, "absent": 0, "total": 40},
      "subjects": [
        {
          "name": "Reading",
          "grade": "A+",
          "percentage": 98,
          "comments": "Outstanding reader with exceptional comprehension. Ready for advanced materials.",
          "competencies": [
            {"name": "Phonemic Awareness", "level": "Advanced"},
            {"name": "Reading Fluency", "level": "Advanced"},
            {"name": "Comprehension", "level": "Advanced"},
          ]
        },
        {
          "name": "Writing",
          "grade": "A",
          "percentage": 94,
          "comments": "Excellent writer with creativity and technical skill. Stories are engaging and well-structured.",
          "competencies": [
            {"name": "Narrative Writing", "level": "Advanced"},
            {"name": "Grammar Usage", "level": "Advanced"},
            {"name": "Vocabulary", "level": "Advanced"},
          ]
        },
        {
          "name": "Speaking",
          "grade": "A+",
          "percentage": 96,
          "comments": "Exceptional public speaker. Clear, confident, and engaging presentations.",
          "competencies": [
            {"name": "Oral Presentation", "level": "Advanced"},
            {"name": "Class Participation", "level": "Advanced"},
            {"name": "Voice Projection", "level": "Advanced"},
          ]
        },
        {
          "name": "Listening",
          "grade": "A",
          "percentage": 95,
          "comments": "Excellent listener who grasps concepts quickly and asks thoughtful questions.",
          "competencies": [
            {"name": "Active Listening", "level": "Advanced"},
            {"name": "Following Directions", "level": "Advanced"},
            {"name": "Comprehension", "level": "Advanced"},
          ]
        },
      ],
      "teacherComments": "Carol is an exceptional student who exceeds expectations in all areas. She demonstrates leadership qualities and serves as a positive role model for her peers. She would benefit from enrichment activities and advanced challenges.",
      "areasOfStrength": ["Advanced reading level", "Creative writing", "Leadership skills", "Analytical thinking"],
      "areasForImprovement": ["Continue challenging herself", "Develop patience with struggling peers"],
      "nextTermGoals": ["Mentor other students", "Explore advanced literature", "Develop presentation technology skills"],
    },
  ];

  List<Map<String, dynamic>> get filteredReportCards {
    return reportCards.where((report) {
      bool matchesClass = selectedClass == "All Classes" || report["class"] == selectedClass;
      bool matchesTerm = report["term"] == selectedTerm;
      bool matchesStudent = selectedStudent == "All Students" || report["studentName"] == selectedStudent;
      bool matchesSearch = searchQuery.isEmpty || 
          report["studentName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          report["studentNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFinalized = !showFinalizedOnly || report["isFinalized"];
      
      return matchesClass && matchesTerm && matchesStudent && matchesSearch && matchesFinalized;
    }).toList();
  }

  Color _getGradeColor(String grade) {
    if (grade.startsWith('A')) return successColor;
    if (grade.startsWith('B')) return primaryColor;
    if (grade.startsWith('C')) return warningColor;
    if (grade.startsWith('D')) return dangerColor;
    return dangerColor;
  }

  Color _getCompetencyColor(String level) {
    switch (level) {
      case "Advanced":
        return successColor;
      case "Proficient":
        return primaryColor;
      case "Developing":
        return warningColor;
      case "Beginning":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void _showReportCardDetail(Map<String, dynamic> report) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: EdgeInsets.symmetric(vertical: spSm),
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
            ),
            // Header
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${report["studentName"]} - ${report["term"]} Report Card",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Divider(),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Student Summary
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getGradeColor(report["overallGrade"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: _getGradeColor(report["overallGrade"]).withAlpha(50)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage("${report["avatar"]}"),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${report["studentName"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text("Student #${report["studentNumber"]}", style: TextStyle(color: disabledBoldColor)),
                                Text("${report["class"]} • ${report["term"]}", style: TextStyle(color: disabledBoldColor)),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "${report["overallGrade"]}",
                                style: TextStyle(
                                  fontSize: fsH2,
                                  fontWeight: FontWeight.bold,
                                  color: _getGradeColor(report["overallGrade"]),
                                ),
                              ),
                              Text(
                                "${report["overallPercentage"]}%",
                                style: TextStyle(color: disabledBoldColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Subjects
                    ...((report["subjects"] as List).map((subject) => Container(
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
                              Expanded(
                                child: Text(
                                  "${subject["name"]}",
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
                                  color: _getGradeColor(subject["grade"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Text(
                                  "${subject["grade"]} (${subject["percentage"]}%)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _getGradeColor(subject["grade"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${subject["comments"]}",
                            style: TextStyle(color: disabledBoldColor),
                          ),
                          Wrap(
                            spacing: spXs,
                            children: (subject["competencies"] as List).map((comp) => Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getCompetencyColor(comp["level"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "${comp["name"]}: ${comp["level"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getCompetencyColor(comp["level"]),
                                ),
                              ),
                            )).toList(),
                          ),
                        ],
                      ),
                    ))),

                    // Teacher Comments
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
                            "Teacher Comments",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${report["teacherComments"]}",
                            style: TextStyle(color: disabledBoldColor),
                          ),
                        ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Cards"),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              ss("Report cards sent to printer");
            },
          ),
          IconButton(
            icon: Icon(Icons.email),
            onPressed: () {
              ss("Report cards emailed to parents");
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
                      Icon(Icons.filter_alt, color: primaryColor),
                      SizedBox(width: spXs),
                      Text(
                        "Report Card Filters",
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
                          label: "Term",
                          items: termOptions,
                          value: selectedTerm,
                          onChanged: (value, label) {
                            selectedTerm = value;
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
                              "label": "Finalized only",
                              "value": true,
                              "checked": showFinalizedOnly,
                            }
                          ],
                          value: [if (showFinalizedOnly) {"label": "Finalized only", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            showFinalizedOnly = values.isNotEmpty;
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
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredReportCards.length}",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Reports",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredReportCards.where((r) => r["isFinalized"]).length}",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Finalized",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${((filteredReportCards.fold(0.0, (sum, item) => sum + (item["overallPercentage"] as double))) / filteredReportCards.length).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Avg Grade",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Report Cards List
            ...filteredReportCards.map((report) => Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: report["isFinalized"] ? null : Border.all(color: warningColor.withAlpha(100), width: 2),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  // Student Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("${report["avatar"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${report["studentName"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${report["class"]} • Student #${report["studentNumber"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getGradeColor(report["overallGrade"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(color: _getGradeColor(report["overallGrade"]).withAlpha(50)),
                            ),
                            child: Text(
                              "${report["overallGrade"]} (${report["overallPercentage"]}%)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _getGradeColor(report["overallGrade"]),
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: report["isFinalized"] ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(color: report["isFinalized"] ? successColor.withAlpha(50) : warningColor.withAlpha(50)),
                            ),
                            child: Text(
                              report["isFinalized"] ? "Finalized" : "Draft",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: report["isFinalized"] ? successColor : warningColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Quick Stats
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Rank ${report["rank"]}/${report["totalStudents"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Class Rank",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, height: 30, color: disabledColor),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${report["gpa"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "GPA",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, height: 30, color: disabledColor),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${report["attendance"]["present"]}/${report["attendance"]["total"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Attendance",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Subject Grades Preview
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (report["subjects"] as List).map((subject) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getGradeColor(subject["grade"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: _getGradeColor(subject["grade"]).withAlpha(50)),
                      ),
                      child: Text(
                        "${subject["name"]}: ${subject["grade"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getGradeColor(subject["grade"]),
                        ),
                      ),
                    )).toList(),
                  ),

                  // Action Buttons
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Report",
                          icon: Icons.visibility,
                          size: bs.sm,
                          onPressed: () => _showReportCardDetail(report),
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: report["isFinalized"] ? "Print" : "Finalize",
                          icon: report["isFinalized"] ? Icons.print : Icons.done,
                          size: bs.sm,
                          onPressed: () {
                            if (report["isFinalized"]) {
                              ss("Report card sent to printer");
                            } else {
                              setState(() {
                                report["isFinalized"] = true;
                                report["finalizedDate"] = DateTime.now().toString().split(' ')[0];
                              });
                              ss("Report card finalized");
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  // Dates
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Generated: ${report["generatedDate"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                      if (report["finalizedDate"] != null)
                        Text(
                          "Finalized: ${report["finalizedDate"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledColor,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Bulk Actions"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QButton(
                    label: "Generate All Reports",
                    icon: Icons.auto_awesome,
                    size: bs.md,
                    onPressed: () {
                      Navigator.pop(context);
                      ss("Generating all report cards...");
                    },
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Email All Parents",
                    icon: Icons.email,
                    size: bs.md,
                    onPressed: () {
                      Navigator.pop(context);
                      ss("Emailing all finalized reports to parents");
                    },
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Export to PDF",
                    icon: Icons.picture_as_pdf,
                    size: bs.md,
                    onPressed: () {
                      Navigator.pop(context);
                      ss("Exporting all reports to PDF");
                    },
                  ),
                ],
              ),
            ),
          );
        },
        icon: Icon(Icons.batch_prediction),
        label: Text("Bulk Actions"),
        backgroundColor: primaryColor,
      ),
    );
  }
}
