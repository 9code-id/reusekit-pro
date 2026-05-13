import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMeditation3View extends StatefulWidget {
  @override
  State<GrlMeditation3View> createState() => _GrlMeditation3ViewState();
}

class _GrlMeditation3ViewState extends State<GrlMeditation3View> {
  int selectedTab = 0;
  String selectedPeriod = "This Week";

  List<String> periods = ["This Week", "This Month", "This Year", "All Time"];

  Map<String, dynamic> meditationStats = {
    "totalSessions": 127,
    "totalMinutes": 2580,
    "currentStreak": 12,
    "longestStreak": 28,
    "averageSession": 18,
    "level": "Mindful Explorer",
    "nextLevelProgress": 0.65,
    "weeklyGoal": 5,
    "weeklyCompleted": 4,
  };

  List<Map<String, dynamic>> weeklyProgress = [
    {"day": "Mon", "minutes": 20, "sessions": 1, "completed": true},
    {"day": "Tue", "minutes": 15, "sessions": 1, "completed": true},
    {"day": "Wed", "minutes": 0, "sessions": 0, "completed": false},
    {"day": "Thu", "minutes": 25, "sessions": 2, "completed": true},
    {"day": "Fri", "minutes": 18, "sessions": 1, "completed": true},
    {"day": "Sat", "minutes": 0, "sessions": 0, "completed": false},
    {"day": "Sun", "minutes": 0, "sessions": 0, "completed": false},
  ];

  List<Map<String, dynamic>> recentSessions = [
    {
      "title": "Morning Mindfulness",
      "date": "Today",
      "duration": 15,
      "category": "Mindfulness",
      "mood": "Calm",
      "notes": "Felt very centered and focused"
    },
    {
      "title": "Deep Sleep Journey",
      "date": "Yesterday",
      "duration": 25,
      "category": "Sleep",
      "mood": "Relaxed",
      "notes": "Helped me fall asleep quickly"
    },
    {
      "title": "Anxiety Relief",
      "date": "2 days ago",
      "duration": 12,
      "category": "Anxiety",
      "mood": "Peaceful",
      "notes": "Great for managing stress"
    },
    {
      "title": "Focus Enhancement",
      "date": "3 days ago",
      "duration": 20,
      "category": "Focus",
      "mood": "Alert",
      "notes": "Improved concentration at work"
    },
    {
      "title": "Body Scan Relaxation",
      "date": "4 days ago",
      "duration": 18,
      "category": "Mindfulness",
      "mood": "Restored",
      "notes": "Released tension from shoulders"
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "First Steps",
      "description": "Complete your first meditation",
      "icon": Icons.self_improvement,
      "unlocked": true,
      "date": "2 months ago"
    },
    {
      "title": "Week Warrior",
      "description": "Meditate for 7 days straight",
      "icon": Icons.calendar_view_week,
      "unlocked": true,
      "date": "3 weeks ago"
    },
    {
      "title": "Hour Hero",
      "description": "Accumulate 60 minutes of meditation",
      "icon": Icons.schedule,
      "unlocked": true,
      "date": "1 month ago"
    },
    {
      "title": "Streak Master",
      "description": "Maintain a 30-day streak",
      "icon": Icons.local_fire_department,
      "unlocked": false,
      "progress": 0.4
    },
    {
      "title": "Century Club",
      "description": "Complete 100 meditation sessions",
      "icon": Icons.emoji_events,
      "unlocked": true,
      "date": "1 week ago"
    },
    {
      "title": "Mindful Master",
      "description": "Reach 1000 minutes of meditation",
      "icon": Icons.stars,
      "unlocked": false,
      "progress": 0.75
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusLg)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${meditationStats["level"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Level 5 • ${((meditationStats["nextLevelProgress"] as double) * 100).toInt()}% to next level",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.psychology,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: meditationStats["nextLevelProgress"] as double,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spLg),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${meditationStats["totalSessions"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Sessions",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${((meditationStats["totalMinutes"] as int) / 60).toStringAsFixed(1)}h",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Meditated",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${meditationStats["currentStreak"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Day Streak",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
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
          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 0;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == 0 ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Progress",
                          style: TextStyle(
                            color: selectedTab == 0 ? primaryColor : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 1;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == 1 ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Sessions",
                          style: TextStyle(
                            color: selectedTab == 1 ? primaryColor : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 2;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == 2 ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Achievements",
                          style: TextStyle(
                            color: selectedTab == 2 ? primaryColor : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildProgressTab();
      case 1:
        return _buildSessionsTab();
      case 2:
        return _buildAchievementsTab();
      default:
        return _buildProgressTab();
    }
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      Icon(Icons.local_fire_department, color: dangerColor, size: 24),
                      SizedBox(height: spSm),
                      Text(
                        "${meditationStats["currentStreak"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Current Streak",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
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
                      Icon(Icons.star, color: warningColor, size: 24),
                      SizedBox(height: spSm),
                      Text(
                        "${meditationStats["longestStreak"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Best Streak",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Text(
            "This Week",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Weekly Goal",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${meditationStats["weeklyCompleted"]}/${meditationStats["weeklyGoal"]} sessions",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  height: 150,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(weeklyProgress.length, (index) {
                      final data = weeklyProgress[index];
                      final maxMinutes = weeklyProgress.map((d) => d["minutes"] as int).reduce((a, b) => a > b ? a : b);
                      final height = maxMinutes > 0 ? ((data["minutes"] as int) / maxMinutes) * 100 : 0.0;
                      
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: spXs),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${data["minutes"]}m",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: (data["minutes"] as int) > 0 ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                width: double.infinity,
                                height: height,
                                decoration: BoxDecoration(
                                  color: (data["minutes"] as int) > 0 ? primaryColor : disabledColor,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                                ),
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${data["day"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: (data["minutes"] as int) > 0 ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spLg),
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
                      Icon(Icons.schedule, color: infoColor, size: 24),
                      SizedBox(height: spSm),
                      Text(
                        "${meditationStats["averageSession"]} min",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Average Session",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
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
                      Icon(Icons.timer, color: successColor, size: 24),
                      SizedBox(height: spSm),
                      Text(
                        "${((meditationStats["totalMinutes"] as int) / (meditationStats["totalSessions"] as int)).toStringAsFixed(0)} min",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Average",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSessionsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: recentSessions.length,
      itemBuilder: (context, index) {
        final session = recentSessions[index];
        return Container(
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
                      "${session["title"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(session["category"] as String).withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${session["category"]}",
                      style: TextStyle(
                        color: _getCategoryColor(session["category"] as String),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Text(
                    "${session["date"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "${session["duration"]} minutes",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "Mood: ${session["mood"]}",
                    style: TextStyle(
                      color: successColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (session["notes"] != null && (session["notes"] as String).isNotEmpty) ...[
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${session["notes"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildAchievementsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        final isUnlocked = achievement["unlocked"] as bool;
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
            border: isUnlocked 
                ? Border.all(color: successColor.withAlpha(50))
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isUnlocked 
                      ? successColor.withAlpha(25)
                      : disabledColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  achievement["icon"] as IconData,
                  color: isUnlocked ? successColor : disabledBoldColor,
                  size: 28,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${achievement["title"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isUnlocked ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${achievement["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    if (isUnlocked && achievement["date"] != null) ...[
                      SizedBox(height: spXs),
                      Text(
                        "Unlocked ${achievement["date"]}",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    if (!isUnlocked && achievement["progress"] != null) ...[
                      SizedBox(height: spSm),
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: achievement["progress"] as double,
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${((achievement["progress"] as double) * 100).toInt()}% Complete",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (isUnlocked)
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 24,
                ),
            ],
          ),
        );
      },
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'sleep':
        return infoColor;
      case 'anxiety':
        return dangerColor;
      case 'focus':
        return warningColor;
      case 'mindfulness':
        return successColor;
      default:
        return primaryColor;
    }
  }
}
