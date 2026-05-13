import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMeditation8View extends StatefulWidget {
  @override
  State<GrlMeditation8View> createState() => _GrlMeditation8ViewState();
}

class _GrlMeditation8ViewState extends State<GrlMeditation8View> {
  String selectedPeriod = "week";
  int currentStreak = 7;
  int totalMinutes = 145;
  int sessionsCompleted = 12;

  List<Map<String, dynamic>> weeklyData = [
    {"day": "Mon", "minutes": 15, "completed": true},
    {"day": "Tue", "minutes": 20, "completed": true},
    {"day": "Wed", "minutes": 10, "completed": true},
    {"day": "Thu", "minutes": 25, "completed": true},
    {"day": "Fri", "minutes": 15, "completed": true},
    {"day": "Sat", "minutes": 30, "completed": true},
    {"day": "Sun", "minutes": 18, "completed": true},
  ];

  List<Map<String, dynamic>> monthlyStats = [
    {"week": "Week 1", "sessions": 5, "minutes": 75},
    {"week": "Week 2", "sessions": 6, "minutes": 90},
    {"week": "Week 3", "sessions": 4, "minutes": 60},
    {"week": "Week 4", "sessions": 7, "minutes": 105},
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "First Step",
      "description": "Complete your first meditation",
      "icon": Icons.play_circle,
      "earned": true,
      "date": "2 weeks ago",
      "color": successColor,
    },
    {
      "title": "Consistency",
      "description": "Meditate 7 days in a row",
      "icon": Icons.local_fire_department,
      "earned": true,
      "date": "Today",
      "color": warningColor,
    },
    {
      "title": "Mindful Hour",
      "description": "Complete 60 minutes total",
      "icon": Icons.timer,
      "earned": true,
      "date": "3 days ago",
      "color": infoColor,
    },
    {
      "title": "Early Bird",
      "description": "Morning meditation 10 times",
      "icon": Icons.wb_sunny,
      "earned": false,
      "progress": 6,
      "target": 10,
      "color": warningColor,
    },
    {
      "title": "Night Owl",
      "description": "Evening meditation 15 times",
      "icon": Icons.bedtime,
      "earned": false,
      "progress": 3,
      "target": 15,
      "color": primaryColor,
    },
    {
      "title": "Zen Master",
      "description": "Complete 100 sessions",
      "icon": Icons.self_improvement,
      "earned": false,
      "progress": 12,
      "target": 100,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> recentSessions = [
    {
      "title": "Morning Awakening",
      "date": "Today, 7:00 AM",
      "duration": 15,
      "type": "Mindfulness",
      "mood_before": "Anxious",
      "mood_after": "Calm",
    },
    {
      "title": "Lunch Break Reset",
      "date": "Today, 12:30 PM",
      "duration": 10,
      "type": "Breathing",
      "mood_before": "Stressed",
      "mood_after": "Focused",
    },
    {
      "title": "Evening Wind Down",
      "date": "Yesterday, 9:00 PM",
      "duration": 20,
      "type": "Sleep",
      "mood_before": "Restless",
      "mood_after": "Peaceful",
    },
    {
      "title": "Deep Focus Session",
      "date": "Yesterday, 2:00 PM",
      "duration": 25,
      "type": "Concentration",
      "mood_before": "Distracted",
      "mood_after": "Alert",
    },
  ];

  Color _getMoodColor(String mood) {
    switch (mood.toLowerCase()) {
      case 'anxious':
      case 'stressed':
      case 'restless':
      case 'distracted':
        return dangerColor;
      case 'calm':
      case 'peaceful':
      case 'focused':
      case 'alert':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meditation Progress"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Overview Stats
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withAlpha(20),
                    primaryColor.withAlpha(5),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Your Meditation Journey",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
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
                                Icons.local_fire_department,
                                color: warningColor,
                                size: 28,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "$currentStreak",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Day Streak",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
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
                                Icons.timer,
                                color: infoColor,
                                size: 28,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "$totalMinutes",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Total Minutes",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
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
                                Icons.check_circle,
                                color: successColor,
                                size: 28,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "$sessionsCompleted",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Sessions",
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
                ],
              ),
            ),

            // Weekly Progress Chart
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "This Week",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${weeklyData.fold(0, (sum, day) => sum + (day["minutes"] as int))} min total",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: weeklyData.map((day) {
                      bool isCompleted = day["completed"] as bool;
                      int minutes = day["minutes"] as int;
                      double height = (minutes / 30) * 80; // Max height 80
                      
                      return Column(
                        spacing: spXs,
                        children: [
                          Container(
                            width: 30,
                            height: 80,
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                height: height,
                                decoration: BoxDecoration(
                                  color: isCompleted ? primaryColor : disabledColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "${day["day"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                          Text(
                            "${minutes}m",
                            style: TextStyle(
                              fontSize: 10,
                              color: isCompleted ? primaryColor : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Achievements
            Text(
              "Achievements",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: achievements.map((achievement) {
                bool isEarned = achievement["earned"] as bool;
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isEarned 
                        ? (achievement["color"] as Color).withAlpha(10)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: isEarned 
                          ? (achievement["color"] as Color).withAlpha(30)
                          : disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: (achievement["color"] as Color).withAlpha(
                                isEarned ? 40 : 20
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              achievement["icon"] as IconData,
                              color: isEarned 
                                  ? achievement["color"] as Color
                                  : disabledBoldColor,
                              size: 24,
                            ),
                          ),
                          if (isEarned)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: successColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 8,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        "${achievement["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isEarned 
                              ? achievement["color"] as Color
                              : disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${achievement["description"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (isEarned)
                        Text(
                          "${achievement["date"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: achievement["color"] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      else
                        Column(
                          spacing: spXs,
                          children: [
                            Text(
                              "${achievement["progress"]}/${achievement["target"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            LinearProgressIndicator(
                              value: (achievement["progress"] as int) / 
                                     (achievement["target"] as int),
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                achievement["color"] as Color
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Sessions
            Text(
              "Recent Sessions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Column(
              spacing: spSm,
              children: recentSessions.map((session) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.self_improvement,
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
                                Text(
                                  "${session["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${session["date"]} • ${session["duration"]} min",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${session["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: successColor.withAlpha(30),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "Mood Change",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getMoodColor(session["mood_before"]).withAlpha(10),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${session["mood_before"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: _getMoodColor(session["mood_before"]),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 12,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getMoodColor(session["mood_after"]).withAlpha(10),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${session["mood_after"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: _getMoodColor(session["mood_after"]),
                                            fontWeight: FontWeight.w600,
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
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Action Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start New Session",
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
