import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaClassManagementView extends StatefulWidget {
  const ElaClassManagementView({super.key});

  @override
  State<ElaClassManagementView> createState() => _ElaClassManagementViewState();
}

class _ElaClassManagementViewState extends State<ElaClassManagementView> {
  int selectedClass = 0;
  String selectedView = "Overview";

  List<Map<String, dynamic>> classes = [
    {
      "id": 1,
      "name": "Grade 3A",
      "subject": "ELA",
      "students": 24,
      "schedule": "Mon-Fri 9:00-10:30",
      "room": "Room 205",
      "active_assignments": 3,
      "average_score": 85.2,
    },
    {
      "id": 2,
      "name": "Grade 3B",
      "subject": "ELA",
      "students": 22,
      "schedule": "Mon-Fri 10:45-12:15",
      "room": "Room 205",
      "active_assignments": 2,
      "average_score": 78.9,
    },
    {
      "id": 3,
      "name": "Grade 3C",
      "subject": "ELA",
      "students": 26,
      "schedule": "Mon-Fri 1:30-3:00",
      "room": "Room 205",
      "active_assignments": 4,
      "average_score": 82.7,
    },
  ];

  List<Map<String, dynamic>> views = [
    {"label": "Overview", "value": "Overview"},
    {"label": "Students", "value": "Students"},
    {"label": "Assignments", "value": "Assignments"},
    {"label": "Progress", "value": "Progress"},
  ];

  List<Map<String, dynamic>> students = [
    {
      "id": 1,
      "name": "Emma Johnson",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=student",
      "reading_level": "3.2",
      "overall_score": 88,
      "assignments_completed": 12,
      "assignments_total": 15,
      "last_activity": "2025-06-14",
      "status": "On Track",
      "strengths": ["Reading Comprehension", "Vocabulary"],
      "needs_help": ["Writing Structure"],
    },
    {
      "id": 2,
      "name": "Liam Chen",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=student",
      "reading_level": "2.8",
      "overall_score": 76,
      "assignments_completed": 10,
      "assignments_total": 15,
      "last_activity": "2025-06-13",
      "status": "Needs Support",
      "strengths": ["Creative Writing", "Participation"],
      "needs_help": ["Reading Fluency", "Phonics"],
    },
    {
      "id": 3,
      "name": "Sofia Martinez",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=student",
      "reading_level": "3.5",
      "overall_score": 94,
      "assignments_completed": 15,
      "assignments_total": 15,
      "last_activity": "2025-06-14",
      "status": "Advanced",
      "strengths": ["Reading Comprehension", "Critical Thinking", "Writing"],
      "needs_help": [],
    },
    {
      "id": 4,
      "name": "Marcus Wilson",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=student",
      "reading_level": "3.0",
      "overall_score": 82,
      "assignments_completed": 11,
      "assignments_total": 15,
      "last_activity": "2025-06-12",
      "status": "On Track",
      "strengths": ["Speaking", "Listening"],
      "needs_help": ["Writing Mechanics"],
    },
  ];

  List<Map<String, dynamic>> assignments = [
    {
      "id": 1,
      "title": "Character Analysis Essay",
      "type": "Writing",
      "due_date": "2025-06-20",
      "assigned_date": "2025-06-10",
      "status": "Active",
      "completed": 8,
      "total": 24,
      "average_score": 84.5,
      "description": "Analyze the main character from our current novel",
    },
    {
      "id": 2,
      "title": "Reading Comprehension Quiz - Chapter 5",
      "type": "Assessment",
      "due_date": "2025-06-18",
      "assigned_date": "2025-06-12",
      "status": "Active",
      "completed": 18,
      "total": 24,
      "average_score": 88.2,
      "description": "Questions about plot, character, and vocabulary",
    },
    {
      "id": 3,
      "title": "Vocabulary Journal - Week 3",
      "type": "Practice",
      "due_date": "2025-06-17",
      "assigned_date": "2025-06-08",
      "status": "Active",
      "completed": 22,
      "total": 24,
      "average_score": 91.7,
      "description": "Record and use 10 new vocabulary words",
    },
    {
      "id": 4,
      "title": "Poetry Recitation",
      "type": "Presentation",
      "due_date": "2025-06-15",
      "assigned_date": "2025-06-05",
      "status": "Completed",
      "completed": 24,
      "total": 24,
      "average_score": 86.3,
      "description": "Memorize and recite a poem with expression",
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "student": "Emma Johnson",
      "action": "Submitted Character Analysis Essay",
      "timestamp": "2025-06-14 15:30",
      "score": 92,
    },
    {
      "student": "Sofia Martinez",
      "action": "Completed Reading Quiz with perfect score",
      "timestamp": "2025-06-14 14:20",
      "score": 100,
    },
    {
      "student": "Liam Chen",
      "action": "Turned in Vocabulary Journal",
      "timestamp": "2025-06-14 10:15",
      "score": 85,
    },
    {
      "student": "Marcus Wilson",
      "action": "Participated in class discussion",
      "timestamp": "2025-06-13 16:45",
      "score": null,
    },
  ];

  Map<String, dynamic> get currentClass => classes[selectedClass];

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

  Color getAssignmentTypeColor(String type) {
    switch (type) {
      case "Writing":
        return infoColor;
      case "Assessment":
        return warningColor;
      case "Practice":
        return successColor;
      case "Presentation":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Class Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              //navigateTo('add_student')
            },
          ),
          IconButton(
            icon: Icon(Icons.assignment_add),
            onPressed: () {
              //navigateTo('create_assignment')
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
            // Class Selector
            if (classes.length > 1)
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
                      "Select Class",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QHorizontalScroll(
                      children: classes.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> classInfo = entry.value;
                        bool isSelected = selectedClass == index;
                        
                        return GestureDetector(
                          onTap: () {
                            selectedClass = index;
                            setState(() {});
                          },
                          child: Container(
                            width: 160,
                            margin: EdgeInsets.only(
                              right: index < classes.length - 1 ? spSm : 0,
                            ),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledColor,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${classInfo["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : primaryColor,
                                  ),
                                ),
                                Text(
                                  "${classInfo["students"]} students",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${classInfo["room"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

            // Class Overview Card
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentClass["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${currentClass["subject"]} • ${currentClass["schedule"]}",
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
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentClass["students"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Students",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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
                              "${(currentClass["average_score"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Class Average",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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
                              "${currentClass["active_assignments"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Active Assignments",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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

            // View Selector
            QCategoryPicker(
              label: "View",
              items: views,
              value: selectedView,
              onChanged: (index, label, value, item) {
                selectedView = value;
                setState(() {});
              },
            ),

            // Overview View
            if (selectedView == "Overview") ...[
              // Quick Stats
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
                          Icon(
                            Icons.trending_up,
                            color: successColor,
                            size: 28,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${students.where((s) => s["status"] == "Advanced").length}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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
                          Icon(
                            Icons.check_circle,
                            color: infoColor,
                            size: 28,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${students.where((s) => s["status"] == "On Track").length}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "On Track",
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
                          Icon(
                            Icons.support,
                            color: warningColor,
                            size: 28,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${students.where((s) => s["status"] == "Needs Support").length}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Need Help",
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

              // Recent Activity
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Activity",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        QButton(
                          label: "View All",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('activity_log')
                          },
                        ),
                      ],
                    ),
                    ...recentActivity.take(4).map((activity) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${activity["student"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${activity["action"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${activity["timestamp"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (activity["score"] != null)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${activity["score"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],

            // Students View
            if (selectedView == "Students") ...[
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Class Roster",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        QButton(
                          label: "Add Student",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('add_student')
                          },
                        ),
                      ],
                    ),
                    ...students.map((student) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: getStatusColor("${student["status"]}").withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: getStatusColor("${student["status"]}"),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusLg),
                              child: Image.network(
                                "${student["avatar"]}",
                                width: 50,
                                height: 50,
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
                                  Row(
                                    children: [
                                      Text(
                                        "Reading Level: ${student["reading_level"]} • ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "Score: ${student["overall_score"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: getStatusColor("${student["status"]}"),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Progress: ${student["assignments_completed"]}/${student["assignments_total"]} assignments",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if ((student["strengths"] as List).isNotEmpty)
                                    Text(
                                      "Strengths: ${(student["strengths"] as List).join(', ')}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: successColor,
                                      ),
                                    ),
                                  if ((student["needs_help"] as List).isNotEmpty)
                                    Text(
                                      "Needs help: ${(student["needs_help"] as List).join(', ')}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: warningColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {
                                //showStudentMenu(student)
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],

            // Assignments View
            if (selectedView == "Assignments") ...[
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Class Assignments",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        QButton(
                          label: "Create Assignment",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('create_assignment')
                          },
                        ),
                      ],
                    ),
                    ...assignments.map((assignment) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: getAssignmentTypeColor("${assignment["type"]}").withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: getAssignmentTypeColor("${assignment["type"]}"),
                            ),
                          ),
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
                                    children: [
                                      Text(
                                        "${assignment["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${assignment["description"]}",
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
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: getAssignmentTypeColor("${assignment["type"]}"),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${assignment["type"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Due: ${assignment["due_date"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: warningColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Assigned: ${assignment["assigned_date"]}",
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
                                        "${assignment["completed"]}/${assignment["total"]} completed",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (assignment["status"] == "Completed")
                                        Text(
                                          "Avg: ${(assignment["average_score"] as double).toStringAsFixed(1)}%",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: successColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigateToAssignment(assignment)
                                  },
                                ),
                              ],
                            ),
                            // Progress Bar
                            if (assignment["status"] == "Active")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "Completion Progress",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: (assignment["completed"] as int) / (assignment["total"] as int),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: getAssignmentTypeColor("${assignment["type"]}"),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
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
            ],

            // Progress View
            if (selectedView == "Progress") ...[
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
                      "Class Progress Overview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Coming soon: Detailed progress analytics and reporting",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
