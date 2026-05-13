import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaLiveClassesView extends StatefulWidget {
  const ElaLiveClassesView({super.key});

  @override
  State<ElaLiveClassesView> createState() => _ElaLiveClassesViewState();
}

class _ElaLiveClassesViewState extends State<ElaLiveClassesView> {
  int currentTab = 0;
  String selectedSubject = "All Subjects";
  String selectedTimeFilter = "Today";

  List<Map<String, dynamic>> subjectFilters = [
    {"label": "All Subjects", "value": "All Subjects"},
    {"label": "Mathematics", "value": "Mathematics"},
    {"label": "Physics", "value": "Physics"},
    {"label": "Chemistry", "value": "Chemistry"},
    {"label": "Biology", "value": "Biology"},
    {"label": "English", "value": "English"},
    {"label": "History", "value": "History"},
  ];

  List<Map<String, dynamic>> timeFilters = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "Next Week", "value": "Next Week"},
    {"label": "This Month", "value": "This Month"},
  ];

  List<Map<String, dynamic>> liveClasses = [
    {
      "id": 1,
      "title": "Advanced Calculus - Integration Techniques",
      "subject": "Mathematics",
      "instructor": "Dr. Sarah Chen",
      "startTime": DateTime.now().add(Duration(hours: 1)),
      "duration": 90,
      "participants": 45,
      "maxParticipants": 60,
      "status": "Starting Soon",
      "thumbnailUrl": "https://picsum.photos/300/200?random=1&keyword=math",
      "instructorAvatar": "https://picsum.photos/100/100?random=1",
      "grade": "Grade 12",
      "level": "Advanced",
      "isLive": false,
      "canJoin": true,
      "description": "Learn advanced integration techniques including substitution, integration by parts, and partial fractions",
    },
    {
      "id": 2,
      "title": "Quantum Physics - Wave-Particle Duality",
      "subject": "Physics",
      "instructor": "Prof. Michael Johnson",
      "startTime": DateTime.now().subtract(Duration(minutes: 30)),
      "duration": 120,
      "participants": 38,
      "maxParticipants": 50,
      "status": "Live Now",
      "thumbnailUrl": "https://picsum.photos/300/200?random=2&keyword=physics",
      "instructorAvatar": "https://picsum.photos/100/100?random=2",
      "grade": "Grade 11",
      "level": "Intermediate",
      "isLive": true,
      "canJoin": true,
      "description": "Explore the fundamental concepts of quantum mechanics and wave-particle duality",
    },
    {
      "id": 3,
      "title": "Organic Chemistry - Reaction Mechanisms",
      "subject": "Chemistry",
      "instructor": "Dr. Emily Rodriguez",
      "startTime": DateTime.now().add(Duration(hours: 3)),
      "duration": 75,
      "participants": 28,
      "maxParticipants": 40,
      "status": "Upcoming",
      "thumbnailUrl": "https://picsum.photos/300/200?random=3&keyword=chemistry",
      "instructorAvatar": "https://picsum.photos/100/100?random=3",
      "grade": "Grade 12",
      "level": "Advanced",
      "isLive": false,
      "canJoin": true,
      "description": "Understanding reaction mechanisms and predicting organic compound behavior",
    },
    {
      "id": 4,
      "title": "Cell Biology - Mitosis and Meiosis",
      "subject": "Biology",
      "instructor": "Dr. David Kim",
      "startTime": DateTime.now().subtract(Duration(hours: 2)),
      "duration": 60,
      "participants": 52,
      "maxParticipants": 55,
      "status": "Ended",
      "thumbnailUrl": "https://picsum.photos/300/200?random=4&keyword=biology",
      "instructorAvatar": "https://picsum.photos/100/100?random=4",
      "grade": "Grade 10",
      "level": "Beginner",
      "isLive": false,
      "canJoin": false,
      "description": "Detailed study of cell division processes including mitosis and meiosis",
    },
    {
      "id": 5,
      "title": "Shakespeare's Hamlet - Literary Analysis",
      "subject": "English",
      "instructor": "Prof. Amanda Wilson",
      "startTime": DateTime.now().add(Duration(days: 1)),
      "duration": 90,
      "participants": 25,
      "maxParticipants": 35,
      "status": "Scheduled",
      "thumbnailUrl": "https://picsum.photos/300/200?random=5&keyword=literature",
      "instructorAvatar": "https://picsum.photos/100/100?random=5",
      "grade": "Grade 11",
      "level": "Intermediate",
      "isLive": false,
      "canJoin": true,
      "description": "In-depth analysis of Hamlet's characters, themes, and literary techniques",
    },
  ];

  List<Map<String, dynamic>> scheduledClasses = [
    {
      "id": 1,
      "title": "Linear Algebra - Matrices",
      "subject": "Mathematics",
      "instructor": "Dr. John Davis",
      "scheduledTime": DateTime.now().add(Duration(days: 2, hours: 2)),
      "duration": 75,
      "enrolled": true,
      "thumbnailUrl": "https://picsum.photos/300/200?random=6&keyword=matrix",
      "instructorAvatar": "https://picsum.photos/100/100?random=6",
      "grade": "Grade 12",
      "reminder": true,
    },
    {
      "id": 2,
      "title": "Thermodynamics - Heat Transfer",
      "subject": "Physics",
      "instructor": "Prof. Lisa Thompson",
      "scheduledTime": DateTime.now().add(Duration(days: 3, hours: 1)),
      "duration": 90,
      "enrolled": false,
      "thumbnailUrl": "https://picsum.photos/300/200?random=7&keyword=thermodynamics",
      "instructorAvatar": "https://picsum.photos/100/100?random=7",
      "grade": "Grade 11",
      "reminder": false,
    },
    {
      "id": 3,
      "title": "Electrochemistry - Galvanic Cells",
      "subject": "Chemistry",
      "instructor": "Dr. Robert Martinez",
      "scheduledTime": DateTime.now().add(Duration(days: 4, hours: 3)),
      "duration": 60,
      "enrolled": true,
      "thumbnailUrl": "https://picsum.photos/300/200?random=8&keyword=electrochemistry",
      "instructorAvatar": "https://picsum.photos/100/100?random=8",
      "grade": "Grade 12",
      "reminder": true,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Live Now":
        return dangerColor;
      case "Starting Soon":
        return warningColor;
      case "Upcoming":
        case "Scheduled":
        return infoColor;
      case "Ended":
        return disabledColor;
      default:
        return primaryColor;
    }
  }

  String _formatDuration(int minutes) {
    if (minutes < 60) {
      return "${minutes}min";
    } else {
      int hours = (minutes / 60).floor();
      int remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return "${hours}h";
      }
      return "${hours}h ${remainingMinutes}min";
    }
  }

  String _getTimeUntilClass(DateTime startTime) {
    final now = DateTime.now();
    final difference = startTime.difference(now);
    
    if (difference.isNegative) {
      return "Started";
    } else if (difference.inMinutes < 60) {
      return "in ${difference.inMinutes}min";
    } else if (difference.inHours < 24) {
      return "in ${difference.inHours}h";
    } else {
      return "in ${difference.inDays}d";
    }
  }

  Widget _buildLiveClassCard(Map<String, dynamic> classData) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  image: DecorationImage(
                    image: NetworkImage("${classData["thumbnailUrl"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(127),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor("${classData["status"]}"),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if ("${classData["status"]}" == "Live Now")
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          margin: EdgeInsets.only(right: 4),
                        ),
                      Text(
                        "${classData["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(127),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    _formatDuration(classData["duration"] as int),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${classData["subject"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${classData["grade"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${classData["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${classData["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
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
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${classData["participants"]}/${classData["maxParticipants"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      _getTimeUntilClass(classData["startTime"] as DateTime),
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if (classData["canJoin"] as bool)
                      QButton(
                        label: "${classData["isLive"]}" == "true" ? "Join Now" : "Schedule",
                        size: bs.sm,
                        onPressed: () {
                          if ("${classData["isLive"]}" == "true") {
                            ss("Joining live class...");
                          } else {
                            ss("Class scheduled successfully!");
                          }
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledClassCard(Map<String, dynamic> classData) {
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
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${classData["thumbnailUrl"]}"),
                fit: BoxFit.cover,
              ),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                    SizedBox(width: 4),
                    Text(
                      "${classData["instructor"]}",
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
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${(classData["scheduledTime"] as DateTime).dMMMy} • ${_formatDuration(classData["duration"] as int)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: (classData["enrolled"] as bool) ? successColor.withAlpha(25) : infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
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
              QButton(
                icon: (classData["enrolled"] as bool) ? Icons.notifications : Icons.add,
                size: bs.sm,
                onPressed: () {
                  if (classData["enrolled"] as bool) {
                    sw("Reminder ${(classData["reminder"] as bool) ? "disabled" : "enabled"}!");
                  } else {
                    ss("Enrolled in class successfully!");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Live Classes",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Live & Upcoming", icon: Icon(Icons.live_tv)),
        Tab(text: "My Schedule", icon: Icon(Icons.event)),
      ],
      tabChildren: [
        // Live & Upcoming Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
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
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Time",
                      items: timeFilters,
                      value: selectedTimeFilter,
                      onChanged: (value, label) {
                        selectedTimeFilter = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.live_tv,
                      color: dangerColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Join live classes or schedule upcoming sessions",
                        style: TextStyle(
                          fontSize: 14,
                          color: dangerColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              ...liveClasses.map((classData) => _buildLiveClassCard(classData)),
            ],
          ),
        ),
        // My Schedule Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.event,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Manage your enrolled classes and set reminders",
                        style: TextStyle(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              ...scheduledClasses.map((classData) => _buildScheduledClassCard(classData)),
            ],
          ),
        ),
      ],
    );
  }
}
