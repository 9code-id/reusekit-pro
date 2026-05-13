import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCalendar3View extends StatefulWidget {
  @override
  State<GrlCalendar3View> createState() => _GrlCalendar3ViewState();
}

class _GrlCalendar3ViewState extends State<GrlCalendar3View> {
  DateTime selectedDate = DateTime.now();
  
  List<Map<String, dynamic>> schedules = [
    {
      "id": 1,
      "subject": "Mathematics",
      "teacher": "Mr. John Smith",
      "time": "08:00 - 09:30",
      "room": "Room 101",
      "type": "lecture",
      "color": Colors.blue,
    },
    {
      "id": 2,
      "subject": "Physics Lab",
      "teacher": "Dr. Sarah Johnson",
      "time": "10:00 - 11:30",
      "room": "Lab 203",
      "type": "lab",
      "color": Colors.green,
    },
    {
      "id": 3,
      "subject": "English Literature",
      "teacher": "Mrs. Emily Davis",
      "time": "13:00 - 14:30",
      "room": "Room 205",
      "type": "lecture",
      "color": Colors.orange,
    },
    {
      "id": 4,
      "subject": "Chemistry",
      "teacher": "Dr. Michael Chen",
      "time": "15:00 - 16:30",
      "room": "Lab 301",
      "type": "lab",
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> assignments = [
    {
      "id": 1,
      "title": "Math Assignment #5",
      "subject": "Mathematics",
      "dueDate": DateTime.now().add(Duration(days: 2)),
      "status": "pending",
    },
    {
      "id": 2,
      "title": "Physics Report",
      "subject": "Physics",
      "dueDate": DateTime.now().add(Duration(days: 5)),
      "status": "in_progress",
    },
    {
      "id": 3,
      "title": "Literature Essay",
      "subject": "English",
      "dueDate": DateTime.now().add(Duration(days: 7)),
      "status": "not_started",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("School Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
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
                    "Good Morning, Student!",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Today is ${_getDayName(DateTime.now().weekday)}, ${DateTime.now().day} ${_getMonthName(DateTime.now().month)}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "You have ${schedules.length} classes today",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Today's Schedule
            Text(
              "Today's Schedule",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...schedules.map((schedule) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 80,
                    decoration: BoxDecoration(
                      color: schedule["color"] as Color,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        bottomLeft: Radius.circular(radiusLg),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${schedule["subject"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: (schedule["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${schedule["type"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: schedule["color"] as Color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${schedule["teacher"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${schedule["time"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${schedule["room"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Upcoming Assignments
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Upcoming Assignments",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // navigateTo(AssignmentsView());
                  },
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
            
            SizedBox(height: spMd),
            
            ...assignments.map((assignment) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getAssignmentStatusColor(assignment["status"]),
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
                          "${assignment["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getAssignmentStatusColor(assignment["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${assignment["status"]}".replaceAll('_', ' ').toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getAssignmentStatusColor(assignment["status"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.subject,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${assignment["subject"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Due: ${(assignment["dueDate"] as DateTime).day}/${(assignment["dueDate"] as DateTime).month}/${(assignment["dueDate"] as DateTime).year}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${_getDaysUntilDue(assignment["dueDate"] as DateTime)} days left",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getDaysUntilDue(assignment["dueDate"] as DateTime) <= 2 
                              ? dangerColor : warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Quick Actions
            Text(
              "Quick Actions",
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
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 32,
                          color: primaryColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Timetable",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.assignment,
                          size: 32,
                          color: successColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Assignments",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.grade,
                          size: 32,
                          color: warningColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Grades",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
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
    );
  }

  String _getMonthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }

  String _getDayName(int weekday) {
    const days = [
      '', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    return days[weekday];
  }

  Color _getAssignmentStatusColor(String status) {
    switch (status) {
      case 'pending':
        return warningColor;
      case 'in_progress':
        return infoColor;
      case 'not_started':
        return dangerColor;
      case 'completed':
        return successColor;
      default:
        return primaryColor;
    }
  }

  int _getDaysUntilDue(DateTime dueDate) {
    return dueDate.difference(DateTime.now()).inDays;
  }
}
