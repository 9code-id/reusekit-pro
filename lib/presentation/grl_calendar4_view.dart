import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCalendar4View extends StatefulWidget {
  @override
  State<GrlCalendar4View> createState() => _GrlCalendar4ViewState();
}

class _GrlCalendar4ViewState extends State<GrlCalendar4View> {
  DateTime selectedDate = DateTime.now();
  
  List<Map<String, dynamic>> workSchedule = [
    {
      "id": 1,
      "shift": "Morning Shift",
      "time": "08:00 - 16:00",
      "department": "Marketing",
      "location": "Floor 3, Room 301",
      "type": "office",
      "status": "scheduled",
    },
    {
      "id": 2,
      "shift": "Client Meeting",
      "time": "10:00 - 11:30",
      "department": "Sales",
      "location": "Conference Room A",
      "type": "meeting",
      "status": "confirmed",
    },
    {
      "id": 3,
      "shift": "Project Review",
      "time": "14:00 - 15:30",
      "department": "Development",
      "location": "Meeting Room B",
      "type": "review",
      "status": "pending",
    },
  ];

  List<Map<String, dynamic>> tasks = [
    {
      "id": 1,
      "title": "Complete quarterly report",
      "priority": "high",
      "deadline": DateTime.now().add(Duration(days: 1)),
      "progress": 75,
      "department": "Finance",
    },
    {
      "id": 2,
      "title": "Review marketing proposals",
      "priority": "medium",
      "deadline": DateTime.now().add(Duration(days: 3)),
      "progress": 45,
      "department": "Marketing",
    },
    {
      "id": 3,
      "title": "Update employee handbook",
      "priority": "low",
      "deadline": DateTime.now().add(Duration(days: 7)),
      "progress": 20,
      "department": "HR",
    },
  ];

  List<Map<String, dynamic>> colleagues = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "department": "Marketing",
      "status": "available",
      "avatar": "https://picsum.photos/100/100?random=1",
    },
    {
      "id": 2,
      "name": "Mike Chen",
      "department": "Development",
      "status": "busy",
      "avatar": "https://picsum.photos/100/100?random=2",
    },
    {
      "id": 3,
      "name": "Emma Wilson",
      "department": "Sales",
      "status": "meeting",
      "avatar": "https://picsum.photos/100/100?random=3",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Work Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats
            Row(
              children: [
                Expanded(
                  child: Container(
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
                        Icon(
                          Icons.today,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${workSchedule.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Today's Schedule",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
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
                      gradient: LinearGradient(
                        colors: [successColor, successColor.withAlpha(180)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.assignment_turned_in,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${tasks.where((t) => (t["progress"] as int) >= 75).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Tasks Done",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Today's Schedule
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Today's Schedule",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // navigateTo(FullScheduleView());
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
            
            ...workSchedule.map((schedule) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getScheduleTypeColor(schedule["type"]),
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
                          "${schedule["shift"]}",
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
                          color: _getStatusColor(schedule["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${schedule["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor(schedule["status"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${schedule["time"]}",
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
                        Icons.business,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${schedule["department"]}",
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
                      Expanded(
                        child: Text(
                          "${schedule["location"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (schedule["type"] == "meeting")
                    Container(
                      margin: EdgeInsets.only(top: spSm),
                      child: Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Join Meeting",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Reschedule",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Task Progress
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Task Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // navigateTo(TasksView());
                  },
                  child: Text(
                    "Manage Tasks",
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
            
            ...tasks.map((task) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${task["title"]}",
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
                          color: _getPriorityColor(task["priority"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${task["priority"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getPriorityColor(task["priority"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.business,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${task["department"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Due: ${(task["deadline"] as DateTime).day}/${(task["deadline"] as DateTime).month}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Progress",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${task["progress"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            LinearProgressIndicator(
                              value: (task["progress"] as int) / 100,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _getProgressColor(task["progress"] as int),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Team Status
            Text(
              "Team Status",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...colleagues.map((colleague) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage("${colleague["avatar"]}"),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _getColleagueStatusColor(colleague["status"]),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${colleague["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${colleague["department"]}",
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
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getColleagueStatusColor(colleague["status"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${colleague["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getColleagueStatusColor(colleague["status"]),
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Color _getScheduleTypeColor(String type) {
    switch (type) {
      case 'office':
        return primaryColor;
      case 'meeting':
        return warningColor;
      case 'review':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return successColor;
      case 'pending':
        return warningColor;
      case 'scheduled':
        return primaryColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getProgressColor(int progress) {
    if (progress >= 75) return successColor;
    if (progress >= 50) return warningColor;
    return dangerColor;
  }

  Color _getColleagueStatusColor(String status) {
    switch (status) {
      case 'available':
        return successColor;
      case 'busy':
        return dangerColor;
      case 'meeting':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}
