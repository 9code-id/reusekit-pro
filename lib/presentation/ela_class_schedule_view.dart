import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaClassScheduleView extends StatefulWidget {
  const ElaClassScheduleView({super.key});

  @override
  State<ElaClassScheduleView> createState() => _ElaClassScheduleViewState();
}

class _ElaClassScheduleViewState extends State<ElaClassScheduleView> {
  DateTime selectedDate = DateTime.now();
  String selectedView = "Week";
  String selectedSubject = "All Subjects";

  List<Map<String, dynamic>> viewOptions = [
    {"label": "Day", "value": "Day"},
    {"label": "Week", "value": "Week"},
    {"label": "Month", "value": "Month"},
  ];

  List<Map<String, dynamic>> subjectFilters = [
    {"label": "All Subjects", "value": "All Subjects"},
    {"label": "Mathematics", "value": "Mathematics"},
    {"label": "Physics", "value": "Physics"},
    {"label": "Chemistry", "value": "Chemistry"},
    {"label": "Biology", "value": "Biology"},
    {"label": "English", "value": "English"},
  ];

  List<Map<String, dynamic>> weekDays = [
    {"day": "Mon", "date": 15, "isToday": false},
    {"day": "Tue", "date": 16, "isToday": false},
    {"day": "Wed", "date": 17, "isToday": true},
    {"day": "Thu", "date": 18, "isToday": false},
    {"day": "Fri", "date": 19, "isToday": false},
    {"day": "Sat", "date": 20, "isToday": false},
    {"day": "Sun", "date": 21, "isToday": false},
  ];

  List<Map<String, dynamic>> todaySchedule = [
    {
      "id": 1,
      "title": "Advanced Calculus",
      "subject": "Mathematics",
      "instructor": "Dr. Sarah Chen",
      "startTime": "09:00",
      "endTime": "10:30",
      "type": "Live Class",
      "location": "Virtual Room A",
      "status": "Scheduled",
      "participants": 45,
      "canJoin": false,
      "color": primaryColor,
      "instructorAvatar": "https://picsum.photos/100/100?random=1",
    },
    {
      "id": 2,
      "title": "Quantum Physics Lab",
      "subject": "Physics",
      "instructor": "Prof. Michael Johnson",
      "startTime": "11:00",
      "endTime": "12:30",
      "type": "Live Class",
      "location": "Virtual Room B",
      "status": "Live Now",
      "participants": 32,
      "canJoin": true,
      "color": dangerColor,
      "instructorAvatar": "https://picsum.photos/100/100?random=2",
    },
    {
      "id": 3,
      "title": "Study Group - Organic Chemistry",
      "subject": "Chemistry",
      "instructor": "Student Group",
      "startTime": "14:00",
      "endTime": "15:00",
      "type": "Study Group",
      "location": "Virtual Room C",
      "status": "Scheduled",
      "participants": 8,
      "canJoin": false,
      "color": warningColor,
      "instructorAvatar": "https://picsum.photos/100/100?random=3",
    },
    {
      "id": 4,
      "title": "Homework Help Session",
      "subject": "Biology",
      "instructor": "Dr. Emily Rodriguez",
      "startTime": "16:00",
      "endTime": "17:00",
      "type": "Help Session",
      "location": "Virtual Room D",
      "status": "Scheduled",
      "participants": 12,
      "canJoin": false,
      "color": successColor,
      "instructorAvatar": "https://picsum.photos/100/100?random=4",
    },
    {
      "id": 5,
      "title": "English Literature Review",
      "subject": "English",
      "instructor": "Prof. Amanda Wilson",
      "startTime": "19:00",
      "endTime": "20:30",
      "type": "Review Session",
      "location": "Virtual Room E",
      "status": "Scheduled",
      "participants": 28,
      "canJoin": false,
      "color": infoColor,
      "instructorAvatar": "https://picsum.photos/100/100?random=5",
    },
  ];

  List<Map<String, dynamic>> upcomingClasses = [
    {
      "title": "Linear Algebra",
      "subject": "Mathematics",
      "instructor": "Dr. John Davis",
      "date": "Tomorrow",
      "time": "10:00 - 11:30",
      "type": "Live Class",
      "enrolled": true,
      "reminder": true,
    },
    {
      "title": "Thermodynamics",
      "subject": "Physics",
      "instructor": "Prof. Lisa Thompson",
      "date": "Friday",
      "time": "14:00 - 15:30",
      "type": "Live Class",
      "enrolled": true,
      "reminder": false,
    },
    {
      "title": "Electrochemistry",
      "subject": "Chemistry",
      "instructor": "Dr. Robert Martinez",
      "date": "Next Monday",
      "time": "09:00 - 10:00",
      "type": "Lab Session",
      "enrolled": false,
      "reminder": false,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Live Now":
        return dangerColor;
      case "Starting Soon":
        return warningColor;
      case "Scheduled":
        return infoColor;
      case "Ended":
        return disabledColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildTimeSlot(String time) {
    return Container(
      width: 60,
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Text(
        time,
        style: TextStyle(
          fontSize: 12,
          color: disabledBoldColor,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> classData) {
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
            color: classData["color"] as Color,
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
                      "${classData["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${classData["subject"]} • ${classData["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor("${classData["status"]}").withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${classData["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${classData["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: 4),
              Text(
                "${classData["startTime"]} - ${classData["endTime"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.location_on,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: 4),
              Text(
                "${classData["location"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${classData["instructorAvatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "${classData["instructor"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.people,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: 4),
              Text(
                "${classData["participants"]} participants",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: (classData["canJoin"] as bool) ? "Join Now" : "View Details",
                  size: bs.sm,
                  onPressed: () {
                    if (classData["canJoin"] as bool) {
                      ss("Joining class...");
                    } else {
                      si("Class details opened");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.notifications,
                size: bs.sm,
                onPressed: () {
                  ss("Reminder set for this class");
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {
                  ss("Class link shared");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingClassCard(Map<String, dynamic> classData) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${classData["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${classData["instructor"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${classData["date"]} • ${classData["time"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: (classData["enrolled"] as bool) ? successColor.withAlpha(25) : infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  (classData["enrolled"] as bool) ? "Enrolled" : "Available",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: (classData["enrolled"] as bool) ? successColor : infoColor,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QButton(
                    icon: (classData["reminder"] as bool) ? Icons.notifications_active : Icons.notifications,
                    size: bs.sm,
                    onPressed: () {
                      sw("Reminder toggled");
                    },
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: (classData["enrolled"] as bool) ? Icons.remove : Icons.add,
                    size: bs.sm,
                    onPressed: () {
                      if (classData["enrolled"] as bool) {
                        sw("Unenrolled from class");
                      } else {
                        ss("Enrolled in class");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QButton(
                icon: Icons.chevron_left,
                size: bs.sm,
                onPressed: () {},
              ),
              Text(
                "June 2025",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              QButton(
                icon: Icons.chevron_right,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: weekDays.map((day) {
              return Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  decoration: BoxDecoration(
                    color: (day["isToday"] as bool) ? primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${day["day"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: (day["isToday"] as bool) ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${day["date"]}",
                        style: TextStyle(
                          fontSize: 16,
                          color: (day["isToday"] as bool) ? Colors.white : primaryColor,
                          fontWeight: FontWeight.bold,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Class Schedule"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              ss("Add new class to schedule");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "View",
                    items: viewOptions,
                    value: selectedView,
                    onChanged: (value, label) {
                      selectedView = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Subject",
                    items: subjectFilters,
                    value: selectedSubject,
                    onChanged: (value, label) {
                      selectedSubject = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            _buildCalendarHeader(),
            SizedBox(height: spMd),
            Text(
              "Today's Schedule",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ...todaySchedule.map((classData) => _buildClassCard(classData)),
            SizedBox(height: spMd),
            Text(
              "Upcoming Classes",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ...upcomingClasses.map((classData) => _buildUpcomingClassCard(classData)),
          ],
        ),
      ),
    );
  }
}
