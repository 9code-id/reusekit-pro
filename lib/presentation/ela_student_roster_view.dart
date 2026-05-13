import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaStudentRosterView extends StatefulWidget {
  const ElaStudentRosterView({super.key});

  @override
  State<ElaStudentRosterView> createState() => _ElaStudentRosterViewState();
}

class _ElaStudentRosterViewState extends State<ElaStudentRosterView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedSort = "Name";

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All", "value": "All"},
    {"label": "Advanced", "value": "Advanced"},
    {"label": "On Track", "value": "On Track"},
    {"label": "Needs Support", "value": "Needs Support"},
    {"label": "At Risk", "value": "At Risk"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "Name"},
    {"label": "Reading Level", "value": "Reading Level"},
    {"label": "Overall Score", "value": "Overall Score"},
    {"label": "Last Activity", "value": "Last Activity"},
  ];

  List<Map<String, dynamic>> students = [
    {
      "id": 1,
      "name": "Emma Johnson",
      "email": "emma.johnson@school.edu",
      "student_id": "STU001",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=student",
      "grade": "3A",
      "reading_level": "3.2",
      "overall_score": 88,
      "assignments_completed": 12,
      "assignments_total": 15,
      "last_activity": "2025-06-14",
      "status": "On Track",
      "strengths": ["Reading Comprehension", "Vocabulary", "Critical Thinking"],
      "needs_help": ["Writing Structure"],
      "parent_email": "parent.johnson@email.com",
      "attendance_rate": 96,
      "participation_score": 92,
      "recent_scores": [88, 92, 85, 90, 87],
    },
    {
      "id": 2,
      "name": "Liam Chen",
      "email": "liam.chen@school.edu",
      "student_id": "STU002",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=student",
      "grade": "3A",
      "reading_level": "2.8",
      "overall_score": 76,
      "assignments_completed": 10,
      "assignments_total": 15,
      "last_activity": "2025-06-13",
      "status": "Needs Support",
      "strengths": ["Creative Writing", "Participation", "Speaking"],
      "needs_help": ["Reading Fluency", "Phonics"],
      "parent_email": "parent.chen@email.com",
      "attendance_rate": 94,
      "participation_score": 88,
      "recent_scores": [72, 78, 74, 80, 76],
    },
    {
      "id": 3,
      "name": "Sofia Martinez",
      "email": "sofia.martinez@school.edu",
      "student_id": "STU003",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=student",
      "grade": "3A",
      "reading_level": "3.5",
      "overall_score": 94,
      "assignments_completed": 15,
      "assignments_total": 15,
      "last_activity": "2025-06-14",
      "status": "Advanced",
      "strengths": ["Reading Comprehension", "Critical Thinking", "Writing", "Analysis"],
      "needs_help": [],
      "parent_email": "parent.martinez@email.com",
      "attendance_rate": 100,
      "participation_score": 95,
      "recent_scores": [94, 96, 92, 98, 93],
    },
    {
      "id": 4,
      "name": "Marcus Wilson",
      "email": "marcus.wilson@school.edu",
      "student_id": "STU004",
      "avatar": "https://picsum.photos/80/80?random=4&keyword=student",
      "grade": "3A",
      "reading_level": "3.0",
      "overall_score": 82,
      "assignments_completed": 11,
      "assignments_total": 15,
      "last_activity": "2025-06-12",
      "status": "On Track",
      "strengths": ["Speaking", "Listening", "Collaboration"],
      "needs_help": ["Writing Mechanics", "Grammar"],
      "parent_email": "parent.wilson@email.com",
      "attendance_rate": 92,
      "participation_score": 90,
      "recent_scores": [82, 80, 85, 84, 81],
    },
    {
      "id": 5,
      "name": "Zoe Davis",
      "email": "zoe.davis@school.edu",
      "student_id": "STU005",
      "avatar": "https://picsum.photos/80/80?random=5&keyword=student",
      "grade": "3A",
      "reading_level": "2.5",
      "overall_score": 68,
      "assignments_completed": 8,
      "assignments_total": 15,
      "last_activity": "2025-06-11",
      "status": "At Risk",
      "strengths": ["Art Integration", "Visual Learning"],
      "needs_help": ["Reading Comprehension", "Vocabulary", "Writing"],
      "parent_email": "parent.davis@email.com",
      "attendance_rate": 88,
      "participation_score": 75,
      "recent_scores": [65, 70, 68, 72, 66],
    },
    {
      "id": 6,
      "name": "Alex Thompson",
      "email": "alex.thompson@school.edu",
      "student_id": "STU006",
      "avatar": "https://picsum.photos/80/80?random=6&keyword=student",
      "grade": "3A",
      "reading_level": "3.1",
      "overall_score": 85,
      "assignments_completed": 13,
      "assignments_total": 15,
      "last_activity": "2025-06-14",
      "status": "On Track",
      "strengths": ["Research Skills", "Technology", "Presentation"],
      "needs_help": ["Handwriting", "Spelling"],
      "parent_email": "parent.thompson@email.com",
      "attendance_rate": 98,
      "participation_score": 87,
      "recent_scores": [85, 88, 83, 87, 84],
    },
  ];

  List<Map<String, dynamic>> get filteredStudents {
    List<Map<String, dynamic>> filtered = students.where((student) {
      bool matchesSearch = searchQuery.isEmpty ||
          (student["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (student["student_id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" ||
          (student["status"] as String) == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();

    // Sort students
    filtered.sort((a, b) {
      switch (selectedSort) {
        case "Name":
          return (a["name"] as String).compareTo(b["name"] as String);
        case "Reading Level":
          return (double.parse(b["reading_level"] as String))
              .compareTo(double.parse(a["reading_level"] as String));
        case "Overall Score":
          return (b["overall_score"] as int).compareTo(a["overall_score"] as int);
        case "Last Activity":
          return (b["last_activity"] as String).compareTo(a["last_activity"] as String);
        default:
          return 0;
      }
    });

    return filtered;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Advanced":
        return successColor;
      case "On Track":
        return infoColor;
      case "Needs Support":
        return warningColor;
      case "At Risk":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Roster"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              //navigateTo('add_student')
            },
          ),
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () {
              //navigateTo('import_students')
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
            // Class Info Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.groups,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Grade 3A ELA Class",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${students.length} students • Room 205",
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
            ),

            // Search and Filters
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
                    "Search and Filter",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search by name or ID",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
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
                          label: "Status",
                          items: statusFilters,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Sort by",
                          items: sortOptions,
                          value: selectedSort,
                          onChanged: (value, label) {
                            selectedSort = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Class Statistics
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${((students.map((s) => s["overall_score"] as int).reduce((a, b) => a + b)) / students.length).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Class Average",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${((students.map((s) => s["attendance_rate"] as int).reduce((a, b) => a + b)) / students.length).toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Attendance",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${students.where((s) => s["status"] == "Advanced").length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Advanced",
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

            // Students List
            Text(
              "Students (${filteredStudents.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredStudents.map((student) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: getStatusColor("${student["status"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${student["avatar"]}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${student["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: getStatusColor("${student["status"]}"),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${student["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "ID: ${student["student_id"]} • ${student["email"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Reading Level: ${student["reading_level"]} • Overall Score: ${student["overall_score"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: getStatusColor("${student["status"]}"),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Performance Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${student["assignments_completed"]}/${student["assignments_total"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Assignments",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                                "${student["attendance_rate"]}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Attendance",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                                "${student["participation_score"]}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Participation",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                                "${student["last_activity"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Last Activity",
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

                    // Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Assignment Progress",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${(((student["assignments_completed"] as int) / (student["assignments_total"] as int)) * 100).toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: getStatusColor("${student["status"]}"),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (student["assignments_completed"] as int) / (student["assignments_total"] as int),
                            child: Container(
                              decoration: BoxDecoration(
                                color: getStatusColor("${student["status"]}"),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Strengths and Needs Help
                    if ((student["strengths"] as List).isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Strengths:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (student["strengths"] as List).map((strength) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$strength",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                    if ((student["needs_help"] as List).isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Needs Help With:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (student["needs_help"] as List).map((need) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$need",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                    // Recent Scores Trend
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Recent Scores Trend:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: (student["recent_scores"] as List).asMap().entries.map((entry) {
                            int index = entry.key;
                            int score = entry.value;
                            return Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: index < (student["recent_scores"] as List).length - 1 ? spXs : 0,
                                ),
                                padding: EdgeInsets.symmetric(vertical: spXs),
                                decoration: BoxDecoration(
                                  color: score >= 85 ? successColor.withAlpha(50) :
                                         score >= 75 ? warningColor.withAlpha(50) :
                                         dangerColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$score",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: score >= 85 ? successColor :
                                           score >= 75 ? warningColor :
                                           dangerColor,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Parent: ${student["parent_email"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                //navigateToStudentDetail(student)
                              },
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.email,
                              size: bs.sm,
                              onPressed: () {
                                //sendEmailToParent(student)
                              },
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {
                                //showStudentMenu(student)
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredStudents.isEmpty)
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
                      "No students found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter settings",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('add_student')
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}
