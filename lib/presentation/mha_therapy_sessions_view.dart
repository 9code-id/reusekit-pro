import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaTherapySessionsView extends StatefulWidget {
  const MhaTherapySessionsView({super.key});

  @override
  State<MhaTherapySessionsView> createState() => _MhaTherapySessionsViewState();
}

class _MhaTherapySessionsViewState extends State<MhaTherapySessionsView> {
  int currentTab = 0;

  // Upcoming sessions
  List<Map<String, dynamic>> upcomingSessions = [
    {
      "id": 1,
      "therapistName": "Dr. Sarah Johnson",
      "specialty": "Clinical Psychologist",
      "date": "2024-03-20",
      "time": "2:00 PM",
      "duration": "50 min",
      "type": "Individual Therapy",
      "sessionType": "In-Person",
      "location": "Room 205, Wellness Center",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=doctor",
      "notes": "Continue working on anxiety management techniques"
    },
    {
      "id": 2,
      "therapistName": "Dr. Michael Chen",
      "specialty": "Cognitive Behavioral Therapist",
      "date": "2024-03-22",
      "time": "10:30 AM",
      "duration": "45 min",
      "type": "CBT Session",
      "sessionType": "Video Call",
      "location": "Online",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=therapist",
      "notes": "Review homework assignments and practice exercises"
    },
    {
      "id": 3,
      "therapistName": "Dr. Emily Rodriguez",
      "specialty": "Family Therapist",
      "date": "2024-03-25",
      "time": "4:30 PM",
      "duration": "60 min",
      "type": "Family Counseling",
      "sessionType": "In-Person",
      "location": "Conference Room A",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=counselor",
      "notes": "Family communication strategies session"
    },
  ];

  // Session history
  List<Map<String, dynamic>> sessionHistory = [
    {
      "id": 1,
      "therapistName": "Dr. Sarah Johnson",
      "date": "2024-03-15",
      "time": "2:00 PM",
      "duration": "50 min",
      "type": "Individual Therapy",
      "status": "Completed",
      "rating": 5,
      "notes": "Made good progress with breathing exercises",
      "homework": "Practice mindfulness meditation daily",
      "nextGoals": "Continue anxiety management techniques"
    },
    {
      "id": 2,
      "therapistName": "Dr. Michael Chen",
      "date": "2024-03-13",
      "time": "10:30 AM",
      "duration": "45 min",
      "type": "CBT Session",
      "status": "Completed",
      "rating": 4,
      "notes": "Discussed cognitive restructuring methods",
      "homework": "Complete thought record worksheet",
      "nextGoals": "Apply CBT techniques in daily situations"
    },
    {
      "id": 3,
      "therapistName": "Dr. Sarah Johnson",
      "date": "2024-03-08",
      "time": "2:00 PM",
      "duration": "50 min",
      "type": "Individual Therapy",
      "status": "Completed",
      "rating": 5,
      "notes": "Explored coping mechanisms for work stress",
      "homework": "Practice progressive muscle relaxation",
      "nextGoals": "Develop workplace stress management plan"
    },
    {
      "id": 4,
      "therapistName": "Dr. Emily Rodriguez",
      "date": "2024-03-06",
      "time": "4:30 PM",
      "duration": "60 min",
      "type": "Family Counseling",
      "status": "Completed",
      "rating": 4,
      "notes": "Worked on family communication patterns",
      "homework": "Practice active listening exercises",
      "nextGoals": "Improve conflict resolution skills"
    },
  ];

  // Progress tracking
  Map<String, dynamic> progressData = {
    "totalSessions": 24,
    "completedSessions": 18,
    "averageRating": 4.6,
    "currentStreak": 6,
    "monthlyGoal": 8,
    "sessionsThisMonth": 6,
    "improvement": 85, // percentage
  };

  // Session types
  List<Map<String, dynamic>> sessionTypes = [
    {
      "name": "Individual Therapy",
      "duration": "50 min",
      "price": 150,
      "description": "One-on-one sessions with a licensed therapist",
      "icon": Icons.person,
    },
    {
      "name": "Group Therapy",
      "duration": "90 min",
      "price": 80,
      "description": "Therapy sessions with a small group of participants",
      "icon": Icons.group,
    },
    {
      "name": "Couples Therapy",
      "duration": "60 min",
      "price": 180,
      "description": "Relationship counseling for couples",
      "icon": Icons.favorite,
    },
    {
      "name": "Family Therapy",
      "duration": "75 min",
      "price": 200,
      "description": "Family counseling sessions",
      "icon": Icons.family_restroom,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Therapy Sessions",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Upcoming", icon: Icon(Icons.schedule)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Progress", icon: Icon(Icons.trending_up)),
        Tab(text: "Book", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        _buildUpcomingTab(),
        _buildHistoryTab(),
        _buildProgressTab(),
        _buildBookingTab(),
      ],
    );
  }

  Widget _buildUpcomingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Quick Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Next Session",
                  "Tomorrow",
                  "2:00 PM",
                  Icons.schedule,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "This Month",
                  "${progressData["sessionsThisMonth"]}",
                  "Sessions",
                  Icons.calendar_month,
                  successColor,
                ),
              ),
            ],
          ),

          // Emergency Support
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [dangerColor.withAlpha(20), dangerColor.withAlpha(5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.emergency, color: dangerColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Crisis Support",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "If you're in crisis or need immediate support, contact emergency services or use the crisis hotline.",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Crisis Hotline",
                        size: bs.sm,
                        onPressed: () {
                          // Call crisis hotline
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Emergency",
                      size: bs.sm,
                      onPressed: () {
                        // Call emergency services
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Upcoming Sessions List
          Text(
            "Upcoming Sessions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...upcomingSessions.map((session) => Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("${session["avatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${session["therapistName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${session["specialty"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: session["sessionType"] == "Video Call" 
                          ? infoColor.withAlpha(20)
                          : successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${session["sessionType"]}",
                        style: TextStyle(
                          color: session["sessionType"] == "Video Call" 
                            ? infoColor
                            : successColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${session["date"]} at ${session["time"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${session["duration"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${session["location"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.psychology, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${session["type"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (session["notes"] != null && (session["notes"] as String).isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(30)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.note, size: 16, color: infoColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${session["notes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Join Session",
                        size: bs.sm,
                        onPressed: () {
                          // Join session
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        // Edit session
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.cancel,
                      size: bs.sm,
                      onPressed: () {
                        // Cancel session
                      },
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // History Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                  "Session History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${progressData["completedSessions"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Sessions",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${progressData["averageRating"]}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Icon(Icons.star, color: successColor, size: 20),
                            ],
                          ),
                          Text(
                            "Average Rating",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
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

          // Session History List
          Text(
            "Recent Sessions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...sessionHistory.map((session) => Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${session["therapistName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${session["type"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) => Icon(
                        Icons.star,
                        size: 16,
                        color: index < (session["rating"] as int) 
                          ? successColor 
                          : disabledColor,
                      )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${session["date"]} at ${session["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${session["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                if (session["notes"] != null && (session["notes"] as String).isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Session Notes:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${session["notes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (session["homework"] != null && (session["homework"] as String).isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Homework Assigned:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "${session["homework"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (session["nextGoals"] != null && (session["nextGoals"] as String).isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Next Goals:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "${session["nextGoals"]}",
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
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Progress Overview
          Text(
            "Therapy Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildProgressCard(
                "Total Sessions",
                "${progressData["completedSessions"]}",
                "${progressData["totalSessions"]}",
                (progressData["completedSessions"] as int) / (progressData["totalSessions"] as int),
                primaryColor,
                Icons.psychology,
              ),
              _buildProgressCard(
                "This Month",
                "${progressData["sessionsThisMonth"]}",
                "${progressData["monthlyGoal"]}",
                (progressData["sessionsThisMonth"] as int) / (progressData["monthlyGoal"] as int),
                successColor,
                Icons.calendar_month,
              ),
              _buildProgressCard(
                "Current Streak",
                "${progressData["currentStreak"]}",
                "sessions",
                1.0,
                infoColor,
                Icons.local_fire_department,
              ),
              _buildProgressCard(
                "Improvement",
                "${progressData["improvement"]}%",
                "overall",
                (progressData["improvement"] as int) / 100,
                warningColor,
                Icons.trending_up,
              ),
            ],
          ),

          // Monthly Goals
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                  "Monthly Goal Progress",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${progressData["sessionsThisMonth"]} of ${progressData["monthlyGoal"]} sessions",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (progressData["sessionsThisMonth"] as int) / (progressData["monthlyGoal"] as int),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "${((progressData["sessionsThisMonth"] as int) / (progressData["monthlyGoal"] as int) * 100).round()}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Improvement Areas
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                  "Areas of Improvement",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildImprovementItem("Anxiety Management", 85, successColor),
                _buildImprovementItem("Stress Reduction", 72, warningColor),
                _buildImprovementItem("Sleep Quality", 68, infoColor),
                _buildImprovementItem("Communication Skills", 90, successColor),
                _buildImprovementItem("Coping Strategies", 78, warningColor),
              ],
            ),
          ),

          // Session Feedback
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                  "Session Ratings Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Average Rating",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${progressData["averageRating"]}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              ...List.generate(5, (index) => Icon(
                                Icons.star,
                                size: 20,
                                color: index < (progressData["averageRating"] as double).round() 
                                  ? successColor 
                                  : disabledColor,
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: successColor.withAlpha(20),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.sentiment_very_satisfied,
                          size: 50,
                          color: successColor,
                        ),
                      ),
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

  Widget _buildBookingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Booking Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Book New Session",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Schedule your next therapy session with our licensed professionals.",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Find Therapist",
                    size: bs.sm,
                    onPressed: () {
                      // Navigate to therapist list
                    },
                  ),
                ),
              ],
            ),
          ),

          // Session Types
          Text(
            "Session Types",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...sessionTypes.map((type) => Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    type["icon"] as IconData,
                    color: primaryColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${type["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "\$${type["price"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${type["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Duration: ${type["duration"]}",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spMd),
                QButton(
                  label: "Book",
                  size: bs.sm,
                  onPressed: () {
                    // Book session type
                  },
                ),
              ],
            ),
          )).toList(),

          // Quick Booking Options
          Text(
            "Quick Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildQuickBookingCard(
                "Emergency Session",
                "Same day booking",
                Icons.emergency,
                dangerColor,
                () {
                  // Book emergency session
                },
              ),
              _buildQuickBookingCard(
                "Video Call",
                "Online therapy",
                Icons.video_call,
                infoColor,
                () {
                  // Book video session
                },
              ),
              _buildQuickBookingCard(
                "Follow-up",
                "Continue treatment",
                Icons.refresh,
                successColor,
                () {
                  // Book follow-up
                },
              ),
              _buildQuickBookingCard(
                "Group Session",
                "Join a group",
                Icons.group,
                warningColor,
                () {
                  // Book group session
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(String title, String value, String total, double progress, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            total,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImprovementItem(String area, int progress, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  area,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spMd),
          Text(
            "$progress%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickBookingCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spSm,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
