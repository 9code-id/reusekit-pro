import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOverview8View extends StatefulWidget {
  @override
  State<GrlOverview8View> createState() => _GrlOverview8ViewState();
}

class _GrlOverview8ViewState extends State<GrlOverview8View> {
  List<Map<String, dynamic>> academicStats = [
    {
      "title": "Current GPA",
      "value": 3.85,
      "subtitle": "Excellent",
      "color": Colors.green,
      "icon": Icons.school,
      "change": 0.15
    },
    {
      "title": "Completed Credits",
      "value": 96,
      "subtitle": "of 120 required",
      "color": Colors.blue,
      "icon": Icons.assignment_turned_in,
      "change": 12.0
    },
    {
      "title": "Current Courses",
      "value": 6,
      "subtitle": "Active Enrollment",
      "color": Colors.purple,
      "icon": Icons.book,
      "change": 0.0
    },
    {
      "title": "Attendance Rate",
      "value": 94.5,
      "subtitle": "Percentage",
      "color": Colors.orange,
      "icon": Icons.check_circle,
      "change": 2.3
    },
  ];

  List<Map<String, dynamic>> currentCourses = [
    {
      "name": "Advanced Mathematics",
      "code": "MATH 401",
      "instructor": "Dr. Sarah Johnson",
      "credits": 4,
      "grade": "A",
      "progress": 75,
      "nextClass": "Mon 9:00 AM",
      "color": Colors.blue
    },
    {
      "name": "Computer Science",
      "code": "CS 305",
      "instructor": "Prof. Michael Brown",
      "credits": 3,
      "grade": "A-",
      "progress": 60,
      "nextClass": "Tue 2:00 PM",
      "color": Colors.green
    },
    {
      "name": "Physics Laboratory",
      "code": "PHYS 201",
      "instructor": "Dr. Emily Davis",
      "credits": 2,
      "grade": "B+",
      "progress": 80,
      "nextClass": "Wed 10:30 AM",
      "color": Colors.purple
    },
    {
      "name": "English Literature",
      "code": "ENG 250",
      "instructor": "Prof. James Wilson",
      "credits": 3,
      "grade": "A",
      "progress": 45,
      "nextClass": "Thu 1:00 PM",
      "color": Colors.orange
    },
  ];

  List<Map<String, dynamic>> upcomingEvents = [
    {
      "title": "Midterm Exam - Mathematics",
      "date": "Tomorrow",
      "time": "9:00 AM",
      "location": "Room 203",
      "type": "exam"
    },
    {
      "title": "Project Presentation - CS",
      "date": "Feb 20",
      "time": "2:00 PM",
      "location": "Lab 101",
      "type": "presentation"
    },
    {
      "title": "Physics Lab Report Due",
      "date": "Feb 22",
      "time": "11:59 PM",
      "location": "Online Submit",
      "type": "assignment"
    },
    {
      "title": "Study Group - Literature",
      "date": "Feb 25",
      "time": "4:00 PM",
      "location": "Library",
      "type": "study"
    },
  ];

  List<Map<String, dynamic>> recentGrades = [
    {
      "course": "Advanced Mathematics",
      "assignment": "Quiz 3",
      "grade": "A",
      "points": "95/100",
      "date": "Feb 10"
    },
    {
      "course": "Computer Science",
      "assignment": "Programming Assignment 2",
      "grade": "A-",
      "points": "88/100",
      "date": "Feb 8"
    },
    {
      "course": "Physics Laboratory",
      "assignment": "Lab Report 4",
      "grade": "B+",
      "points": "85/100",
      "date": "Feb 6"
    },
    {
      "course": "English Literature",
      "assignment": "Essay Analysis",
      "grade": "A",
      "points": "92/100",
      "date": "Feb 5"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Academic Overview"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student Welcome Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome, Alex!",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Spring 2024 Semester",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Dean's List - Fall 2023",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),

            // Academic Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: academicStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          if ((stat["change"] as double) != 0.0)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: (stat["change"] as double) >= 0 
                                    ? successColor.withAlpha(50)
                                    : dangerColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                (stat["change"] as double) >= 0 ? "+${(stat["change"] as double).toStringAsFixed(1)}" : "${(stat["change"] as double).toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: (stat["change"] as double) >= 0 
                                      ? successColor 
                                      : dangerColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        stat["title"] == "Current GPA" || stat["title"] == "Attendance Rate"
                            ? "${(stat["value"] as double).toStringAsFixed(stat["title"] == "Current GPA" ? 2 : 1)}${stat["title"] == "Attendance Rate" ? "%" : ""}"
                            : "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["subtitle"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Current Courses
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.book,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Current Courses",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: currentCourses.map((course) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: (course["color"] as Color).withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${course["code"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: course["color"] as Color,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${course["name"]}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${course["instructor"]}",
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
                                        color: _getGradeColor("${course["grade"]}").withAlpha(50),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${course["grade"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: _getGradeColor("${course["grade"]}"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${course["credits"]} credits",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
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
                                        "Progress: ${course["progress"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Container(
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: disabledColor.withAlpha(100),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: (course["progress"] as int) / 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: course["color"] as Color,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Next Class",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${course["nextClass"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Upcoming Events
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.event,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Upcoming Events",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: upcomingEvents.map((event) {
                      Color eventColor = _getEventColor("${event["type"]}");
                      IconData eventIcon = _getEventIcon("${event["type"]}");
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: eventColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: eventColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                eventIcon,
                                color: eventColor,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${event["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${event["location"]}",
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
                                Text(
                                  "${event["date"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${event["time"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Grades",
                    icon: Icons.grade,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Schedule",
                    icon: Icons.calendar_today,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
      case 'A+':
        return successColor;
      case 'A-':
      case 'B+':
        return infoColor;
      case 'B':
      case 'B-':
        return warningColor;
      default:
        return dangerColor;
    }
  }

  Color _getEventColor(String type) {
    switch (type) {
      case 'exam':
        return dangerColor;
      case 'assignment':
        return warningColor;
      case 'presentation':
        return infoColor;
      case 'study':
        return successColor;
      default:
        return primaryColor;
    }
  }

  IconData _getEventIcon(String type) {
    switch (type) {
      case 'exam':
        return Icons.quiz;
      case 'assignment':
        return Icons.assignment;
      case 'presentation':
        return Icons.slideshow;
      case 'study':
        return Icons.group_work;
      default:
        return Icons.event;
    }
  }
}
