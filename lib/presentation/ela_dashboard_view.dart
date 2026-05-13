import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaDashboardView extends StatefulWidget {
  const ElaDashboardView({super.key});

  @override
  State<ElaDashboardView> createState() => _ElaDashboardViewState();
}

class _ElaDashboardViewState extends State<ElaDashboardView> {
  String selectedPeriod = "this_month";
  int currentTab = 0;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "this_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "This Year", "value": "this_year"},
    {"label": "All Time", "value": "all_time"}
  ];

  Map<String, dynamic> learningStats = {
    "totalHours": 47.5,
    "coursesCompleted": 8,
    "coursesInProgress": 3,
    "certificates": 5,
    "averageScore": 88.5,
    "streak": 15,
    "weeklyGoal": 10,
    "weeklyProgress": 7.5
  };

  List<Map<String, dynamic>> recentActivity = [
    {
      "type": "course_completed",
      "title": "Completed Python Fundamentals",
      "date": "2024-12-10 09:30:00",
      "icon": Icons.check_circle,
      "color": successColor
    },
    {
      "type": "lesson_watched",
      "title": "Watched: Introduction to Machine Learning",
      "date": "2024-12-10 08:15:00",
      "icon": Icons.play_circle,
      "color": primaryColor
    },
    {
      "type": "quiz_passed",
      "title": "Passed React Basics Quiz (Score: 95%)",
      "date": "2024-12-09 16:45:00",
      "icon": Icons.quiz,
      "color": infoColor
    },
    {
      "type": "certificate_earned",
      "title": "Earned Web Development Certificate",
      "date": "2024-12-09 14:20:00",
      "icon": Icons.workspace_premium,
      "color": warningColor
    },
    {
      "type": "course_started",
      "title": "Started Data Science Course",
      "date": "2024-12-08 10:00:00",
      "icon": Icons.play_arrow,
      "color": primaryColor
    }
  ];

  List<Map<String, dynamic>> upcomingDeadlines = [
    {
      "course": "React Native Development",
      "assignment": "Final Project Submission",
      "dueDate": "2024-12-15",
      "timeLeft": "5 days",
      "priority": "high"
    },
    {
      "course": "Business Analytics",
      "assignment": "Quiz 3: Data Visualization",
      "dueDate": "2024-12-18",
      "timeLeft": "8 days",
      "priority": "medium"
    },
    {
      "course": "Digital Marketing",
      "assignment": "Case Study Analysis",
      "dueDate": "2024-12-22",
      "timeLeft": "12 days",
      "priority": "low"
    }
  ];

  List<Map<String, dynamic>> skillProgress = [
    {"skill": "JavaScript", "level": 85, "color": warningColor},
    {"skill": "Python", "level": 78, "color": successColor},
    {"skill": "React", "level": 72, "color": infoColor},
    {"skill": "SQL", "level": 65, "color": primaryColor},
    {"skill": "Machine Learning", "level": 45, "color": dangerColor}
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "First Course Completed",
      "description": "Completed your first online course",
      "icon": Icons.school,
      "earned": true,
      "earnedDate": "2024-11-15"
    },
    {
      "title": "Week Warrior",
      "description": "7 consecutive days of learning",
      "icon": Icons.local_fire_department,
      "earned": true,
      "earnedDate": "2024-12-01"
    },
    {
      "title": "Quiz Master",
      "description": "Achieved 90%+ in 5 quizzes",
      "icon": Icons.quiz,
      "earned": true,
      "earnedDate": "2024-12-05"
    },
    {
      "title": "Course Collector",
      "description": "Complete 10 courses",
      "icon": Icons.collections_bookmark,
      "earned": false,
      "progress": 8,
      "target": 10
    },
    {
      "title": "Speed Learner",
      "description": "Complete a course in under 24 hours",
      "icon": Icons.speed,
      "earned": false,
      "progress": 0,
      "target": 1
    }
  ];

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      spacing: spMd,
      children: [
        // Quick Stats
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(Icons.schedule, color: primaryColor, size: 32),
                  Text(
                    "${learningStats["totalHours"]}h",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Total Learning Hours",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(Icons.check_circle, color: successColor, size: 32),
                  Text(
                    "${learningStats["coursesCompleted"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "Courses Completed",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(Icons.workspace_premium, color: warningColor, size: 32),
                  Text(
                    "${learningStats["certificates"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                  Text(
                    "Certificates Earned",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(Icons.trending_up, color: infoColor, size: 32),
                  Text(
                    "${learningStats["averageScore"]}%",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  Text(
                    "Average Score",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),

        // Weekly Progress
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Weekly Learning Goal",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Icon(Icons.local_fire_department, color: warningColor, size: 20),
                  SizedBox(width: spXs),
                  Text(
                    "${learningStats["streak"]} day streak",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              Text(
                "${learningStats["weeklyProgress"]}h of ${learningStats["weeklyGoal"]}h goal",
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                ),
              ),
              LinearProgressIndicator(
                value: (learningStats["weeklyProgress"] as double) / (learningStats["weeklyGoal"] as int),
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
              Text(
                "${((learningStats["weeklyProgress"] as double) / (learningStats["weeklyGoal"] as int) * 100).toInt()}% complete",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),

        // Recent Activity
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...recentActivity.take(5).map((activity) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (activity["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          activity["icon"] as IconData,
                          color: activity["color"] as Color,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${activity["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${DateTime.parse("${activity["date"]}").dMMMy}",
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
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressTab() {
    return Column(
      spacing: spMd,
      children: [
        // Skill Progress
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Skill Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...skillProgress.map((skill) {
                return Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${skill["skill"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${skill["level"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: skill["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: (skill["level"] as int) / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(skill["color"] as Color),
                    ),
                    SizedBox(height: spSm),
                  ],
                );
              }).toList(),
            ],
          ),
        ),

        // Upcoming Deadlines
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upcoming Deadlines",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              if (upcomingDeadlines.isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  alignment: Alignment.center,
                  child: Column(
                    spacing: spSm,
                    children: [
                      Icon(Icons.event_available, size: 48, color: successColor),
                      Text(
                        "No upcoming deadlines",
                        style: TextStyle(
                          fontSize: 16,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...upcomingDeadlines.map((deadline) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getPriorityColor("${deadline["priority"]}"),
                        ),
                      ),
                      color: _getPriorityColor("${deadline["priority"]}").withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${deadline["course"]}",
                                style: TextStyle(
                                  fontSize: 14,
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
                                color: _getPriorityColor("${deadline["priority"]}"),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${deadline["timeLeft"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${deadline["assignment"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Due: ${DateTime.parse("${deadline["dueDate"]}").dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
    );
  }

  Widget _buildAchievementsTab() {
    return Column(
      spacing: spMd,
      children: [
        // Achievement Stats
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(Icons.emoji_events, color: warningColor, size: 32),
                  Text(
                    "${achievements.where((a) => a["earned"] == true).length}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                  Text(
                    "Achievements Earned",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(Icons.timeline, color: primaryColor, size: 32),
                  Text(
                    "${achievements.where((a) => a["earned"] == false).length}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "In Progress",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),

        // Achievement List
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Achievements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...achievements.map((achievement) {
                bool earned = achievement["earned"] == true;
                return Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: earned ? successColor.withAlpha(10) : disabledColor.withAlpha(10),
                    border: Border.all(
                      color: earned ? successColor.withAlpha(50) : disabledOutlineBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: earned ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          achievement["icon"] as IconData,
                          color: earned ? successColor : disabledColor,
                          size: 24,
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
                                    "${achievement["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: earned ? primaryColor : disabledBoldColor,
                                    ),
                                  ),
                                ),
                                if (earned)
                                  Icon(Icons.check_circle, color: successColor, size: 20),
                              ],
                            ),
                            Text(
                              "${achievement["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: earned ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            if (!earned && achievement.containsKey("progress")) ...[
                              SizedBox(height: spXs),
                              LinearProgressIndicator(
                                value: (achievement["progress"] as int) / (achievement["target"] as int),
                                backgroundColor: disabledColor,
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${achievement["progress"]}/${achievement["target"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                            if (earned && achievement.containsKey("earnedDate"))
                              Text(
                                "Earned on ${DateTime.parse("${achievement["earnedDate"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                          ],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Progress", icon: Icon(Icons.trending_up)),
        Tab(text: "Achievements", icon: Icon(Icons.emoji_events)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Period Filter
              QDropdownField(
                label: "Period",
                items: periodOptions,
                value: selectedPeriod,
                onChanged: (value, label) {
                  selectedPeriod = value;
                  setState(() {});
                },
              ),
              _buildOverviewTab(),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildProgressTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildAchievementsTab(),
        ),
      ],
    );
  }
}
