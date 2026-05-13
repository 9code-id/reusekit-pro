import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSchedule3View extends StatefulWidget {
  @override
  State<GrlSchedule3View> createState() => _GrlSchedule3ViewState();
}

class _GrlSchedule3ViewState extends State<GrlSchedule3View> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedClass = "All";
  String selectedSubject = "All";
  bool showFilters = false;
  
  List<Map<String, dynamic>> classes = [
    {"label": "All", "value": "All"},
    {"label": "Class 10A", "value": "10A"},
    {"label": "Class 10B", "value": "10B"},
    {"label": "Class 11A", "value": "11A"},
    {"label": "Class 11B", "value": "11B"},
    {"label": "Class 12A", "value": "12A"},
    {"label": "Class 12B", "value": "12B"},
  ];

  List<Map<String, dynamic>> subjects = [
    {"label": "All", "value": "All"},
    {"label": "Mathematics", "value": "Math"},
    {"label": "Physics", "value": "Physics"},
    {"label": "Chemistry", "value": "Chemistry"},
    {"label": "Biology", "value": "Biology"},
    {"label": "English", "value": "English"},
    {"label": "History", "value": "History"},
  ];

  List<Map<String, dynamic>> todaySchedule = [
    {
      "id": 1,
      "time": "08:00 - 09:30",
      "subject": "Mathematics",
      "class": "Class 10A",
      "teacher": "Dr. Sarah Johnson",
      "room": "Room 101",
      "status": "ongoing",
      "studentsPresent": 28,
      "totalStudents": 30,
      "type": "lecture",
      "avatar": "https://picsum.photos/40/40?random=1",
    },
    {
      "id": 2,
      "time": "09:45 - 11:15",
      "subject": "Physics",
      "class": "Class 11B",
      "teacher": "Prof. Michael Chen",
      "room": "Lab 205",
      "status": "upcoming",
      "studentsPresent": 0,
      "totalStudents": 25,
      "type": "lab",
      "avatar": "https://picsum.photos/40/40?random=2",
    },
    {
      "id": 3,
      "time": "11:30 - 13:00",
      "subject": "Chemistry",
      "class": "Class 12A",
      "teacher": "Dr. Emily Rodriguez",
      "room": "Lab 301",
      "status": "completed",
      "studentsPresent": 22,
      "totalStudents": 24,
      "type": "lab",
      "avatar": "https://picsum.photos/40/40?random=3",
    },
    {
      "id": 4,
      "time": "14:00 - 15:30",
      "subject": "Biology",
      "class": "Class 11A",
      "teacher": "Dr. James Wilson",
      "room": "Room 203",
      "status": "upcoming",
      "studentsPresent": 0,
      "totalStudents": 27,
      "type": "lecture",
      "avatar": "https://picsum.photos/40/40?random=4",
    },
  ];

  List<Map<String, dynamic>> weekSchedule = [
    {
      "day": "Monday",
      "date": "Dec 18",
      "classes": 6,
      "completed": 4,
      "ongoing": 1,
      "upcoming": 1,
      "subjects": ["Math", "Physics", "Chemistry", "Biology", "English", "History"],
    },
    {
      "day": "Tuesday",
      "date": "Dec 19",
      "classes": 5,
      "completed": 5,
      "ongoing": 0,
      "upcoming": 0,
      "subjects": ["Math", "Physics", "Chemistry", "English", "History"],
    },
    {
      "day": "Wednesday",
      "date": "Dec 20",
      "classes": 7,
      "completed": 0,
      "ongoing": 0,
      "upcoming": 7,
      "subjects": ["Math", "Physics", "Chemistry", "Biology", "English", "History", "PE"],
    },
    {
      "day": "Thursday",
      "date": "Dec 21",
      "classes": 6,
      "completed": 0,
      "ongoing": 0,
      "upcoming": 6,
      "subjects": ["Math", "Physics", "Chemistry", "Biology", "English", "History"],
    },
    {
      "day": "Friday",
      "date": "Dec 22",
      "classes": 4,
      "completed": 0,
      "ongoing": 0,
      "upcoming": 4,
      "subjects": ["Math", "Physics", "English", "History"],
    },
  ];

  List<Map<String, dynamic>> teachers = [
    {
      "id": 1,
      "name": "Dr. Sarah Johnson",
      "subject": "Mathematics",
      "todayClasses": 3,
      "totalHours": 24,
      "avatar": "https://picsum.photos/50/50?random=11",
      "status": "teaching",
      "currentClass": "Class 10A",
      "nextClass": "Class 11B",
      "nextTime": "10:00",
    },
    {
      "id": 2,
      "name": "Prof. Michael Chen",
      "subject": "Physics",
      "todayClasses": 2,
      "totalHours": 18,
      "avatar": "https://picsum.photos/50/50?random=12",
      "status": "available",
      "currentClass": "",
      "nextClass": "Class 11B",
      "nextTime": "09:45",
    },
    {
      "id": 3,
      "name": "Dr. Emily Rodriguez",
      "subject": "Chemistry",
      "todayClasses": 2,
      "totalHours": 20,
      "avatar": "https://picsum.photos/50/50?random=13",
      "status": "break",
      "currentClass": "",
      "nextClass": "Class 10B",
      "nextTime": "14:30",
    },
    {
      "id": 4,
      "name": "Dr. James Wilson",
      "subject": "Biology",
      "todayClasses": 3,
      "totalHours": 22,
      "avatar": "https://picsum.photos/50/50?random=14",
      "status": "available",
      "currentClass": "",
      "nextClass": "Class 11A",
      "nextTime": "14:00",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'ongoing':
        return successColor;
      case 'upcoming':
        return warningColor;
      case 'completed':
        return disabledBoldColor;
      case 'teaching':
        return successColor;
      case 'available':
        return infoColor;
      case 'break':
        return warningColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'ongoing':
        return 'In Progress';
      case 'upcoming':
        return 'Upcoming';
      case 'completed':
        return 'Completed';
      case 'teaching':
        return 'Teaching';
      case 'available':
        return 'Available';
      case 'break':
        return 'On Break';
      default:
        return status;
    }
  }

  void _showScheduleDetails(Map<String, dynamic> schedule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${schedule["subject"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text("${schedule["time"]}", style: TextStyle(color: disabledBoldColor)),
              ],
            ),
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.class_, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text("${schedule["class"]}", style: TextStyle(color: disabledBoldColor)),
              ],
            ),
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.person, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text("${schedule["teacher"]}", style: TextStyle(color: disabledBoldColor)),
              ],
            ),
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.room, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text("${schedule["room"]}", style: TextStyle(color: disabledBoldColor)),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.group, size: 16, color: primaryColor),
                SizedBox(width: spXs),
                Text(
                  "${schedule["studentsPresent"]}/${schedule["totalStudents"]} Students",
                  style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Manage",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Managing class session");
            },
          ),
        ],
      ),
    );
  }

  void _showTeacherDetails(Map<String, dynamic> teacher) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("${teacher["avatar"]}"),
              radius: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${teacher["name"]}", style: TextStyle(fontSize: fsH6)),
                  Text("${teacher["subject"]}", style: TextStyle(color: disabledBoldColor, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text("Today: ${teacher["todayClasses"]} classes", style: TextStyle(color: disabledBoldColor)),
              ],
            ),
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text("Total: ${teacher["totalHours"]} hours/week", style: TextStyle(color: disabledBoldColor)),
              ],
            ),
            if (teacher["nextClass"].toString().isNotEmpty) ...[
              SizedBox(height: spXs),
              Row(
                children: [
                  Icon(Icons.next_plan, size: 16, color: primaryColor),
                  SizedBox(width: spXs),
                  Text(
                    "Next: ${teacher["nextClass"]} at ${teacher["nextTime"]}",
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Contact",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Contacting ${teacher["name"]}");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTodayTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filter
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search classes...",
                      prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(spSm),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () {
                  showFilters = !showFilters;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: showFilters ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Icon(
                    Icons.filter_list,
                    color: showFilters ? Colors.white : disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          
          // Filters
          if (showFilters) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Class",
                          items: classes,
                          value: selectedClass,
                          onChanged: (value, label) {
                            selectedClass = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Subject",
                          items: subjects,
                          value: selectedSubject,
                          onChanged: (value, label) {
                            selectedSubject = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          
          SizedBox(height: spMd),
          
          // Quick Stats
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${todaySchedule.where((s) => s["status"] == "completed").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text("Completed", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${todaySchedule.where((s) => s["status"] == "ongoing").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text("Ongoing", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${todaySchedule.where((s) => s["status"] == "upcoming").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text("Upcoming", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${todaySchedule.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text("Total", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "Today's Schedule",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          // Schedule List
          ...todaySchedule.map((schedule) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor("${schedule["status"]}"),
                  ),
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(spSm),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage("${schedule["avatar"]}"),
                  radius: 20,
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${schedule["subject"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fsH6,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${schedule["status"]}").withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        _getStatusText("${schedule["status"]}"),
                        style: TextStyle(
                          color: _getStatusColor("${schedule["status"]}"),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text("${schedule["time"]}", style: TextStyle(color: disabledBoldColor)),
                        SizedBox(width: spSm),
                        Icon(Icons.class_, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text("${schedule["class"]}", style: TextStyle(color: disabledBoldColor)),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.person, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text("${schedule["teacher"]}", style: TextStyle(color: disabledBoldColor)),
                        ),
                        Icon(Icons.room, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text("${schedule["room"]}", style: TextStyle(color: disabledBoldColor)),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.group, size: 14, color: primaryColor),
                        SizedBox(width: spXs),
                        Text(
                          "${schedule["studentsPresent"]}/${schedule["totalStudents"]} students",
                          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: schedule["type"] == "lab" ? warningColor.withAlpha(30) : infoColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${schedule["type"]}".toUpperCase(),
                            style: TextStyle(
                              color: schedule["type"] == "lab" ? warningColor : infoColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () => _showScheduleDetails(schedule),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildWeekTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weekly Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ...weekSchedule.map((day) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${day["day"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${day["date"]}",
                              style: TextStyle(color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${day["classes"]} Classes",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  // Progress indicators
                  Row(
                    children: [
                      if ((day["completed"] as int) > 0) ...[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${day["completed"]} Completed",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                      ],
                      if ((day["ongoing"] as int) > 0) ...[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${day["ongoing"]} Ongoing",
                            style: TextStyle(
                              color: warningColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                      ],
                      if ((day["upcoming"] as int) > 0) ...[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${day["upcoming"]} Upcoming",
                            style: TextStyle(
                              color: infoColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  // Subject chips
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (day["subjects"] as List).map((subject) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$subject",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 10,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTeachersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Teachers Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          // Teachers List
          ...teachers.map((teacher) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor("${teacher["status"]}"),
                  ),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("${teacher["avatar"]}"),
                    radius: 25,
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
                                "${teacher["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fsH6,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${teacher["status"]}").withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                _getStatusText("${teacher["status"]}"),
                                style: TextStyle(
                                  color: _getStatusColor("${teacher["status"]}"),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${teacher["subject"]}",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Today: ${teacher["todayClasses"]} classes",
                              style: TextStyle(color: disabledBoldColor, fontSize: 12),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${teacher["totalHours"]}h/week",
                              style: TextStyle(color: disabledBoldColor, fontSize: 12),
                            ),
                          ],
                        ),
                        if (teacher["nextClass"].toString().isNotEmpty) ...[
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.next_plan, size: 14, color: primaryColor),
                              SizedBox(width: spXs),
                              Text(
                                "Next: ${teacher["nextClass"]} at ${teacher["nextTime"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showTeacherDetails(teacher),
                    child: Icon(
                      Icons.more_vert,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "Class Schedule",
      selectedIndex: currentTab,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.today),
          label: "Today",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_week),
          label: "Week",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: "Teachers",
        ),
      ],
      children: [
        _buildTodayTab(),
        _buildWeekTab(),
        _buildTeachersTab(),
      ],
      onTap: (index) {
        currentTab = index;
        setState(() {});
      },
    );
  }
}
