import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaProgressReportView extends StatefulWidget {
  const ElaProgressReportView({super.key});

  @override
  State<ElaProgressReportView> createState() => _ElaProgressReportViewState();
}

class _ElaProgressReportViewState extends State<ElaProgressReportView> {
  String selectedPeriod = "Fall 2024";
  String selectedStudent = "Current Student";
  
  Map<String, dynamic> progressData = {
    "student_name": "Alex Johnson",
    "student_id": "ELA001",
    "grade_level": "10th Grade",
    "teacher": "Ms. Johnson",
    "period": "Fall 2024",
    "overall_grade": 87.5,
    "letter_grade": "B+",
    "gpa": 3.3,
    "class_rank": "15 of 48",
    "attendance_rate": 95.5,
    "assignments_completed": 12,
    "assignments_total": 15,
    "improvement_trend": "Improving"
  };

  List<Map<String, dynamic>> skillAreas = [
    {
      "skill": "Reading Comprehension",
      "current_score": 92,
      "previous_score": 88,
      "target_score": 95,
      "trend": "Improving",
      "level": "Proficient",
      "assignments_count": 5,
      "description": "Strong ability to understand and analyze text meaning"
    },
    {
      "skill": "Writing Mechanics",
      "current_score": 85,
      "previous_score": 83,
      "target_score": 90,
      "trend": "Improving",
      "level": "Approaching Proficiency",
      "assignments_count": 4,
      "description": "Good grasp of grammar, punctuation, and sentence structure"
    },
    {
      "skill": "Literary Analysis",
      "current_score": 89,
      "previous_score": 91,
      "target_score": 93,
      "trend": "Declining",
      "level": "Proficient",
      "assignments_count": 3,
      "description": "Ability to analyze themes, characters, and literary devices"
    },
    {
      "skill": "Vocabulary",
      "current_score": 82,
      "previous_score": 79,
      "target_score": 88,
      "trend": "Improving",
      "level": "Approaching Proficiency",
      "assignments_count": 6,
      "description": "Understanding and use of academic and literary vocabulary"
    },
    {
      "skill": "Critical Thinking",
      "current_score": 87,
      "previous_score": 84,
      "target_score": 92,
      "trend": "Improving",
      "level": "Proficient",
      "assignments_count": 4,
      "description": "Ability to analyze, evaluate, and synthesize information"
    }
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "Perfect Attendance - October",
      "description": "Attended all classes in October 2024",
      "date": "2024-10-31",
      "type": "Attendance",
      "icon": Icons.event_available
    },
    {
      "title": "Outstanding Essay - Poetry Analysis",
      "description": "Received highest score on Robert Frost analysis",
      "date": "2024-11-15",
      "type": "Academic",
      "icon": Icons.star
    },
    {
      "title": "Reading Challenge Completed",
      "description": "Read 5 books this semester ahead of schedule",
      "date": "2024-11-20",
      "type": "Reading",
      "icon": Icons.book
    }
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "area": "Literary Analysis",
      "suggestion": "Practice identifying themes in contemporary literature",
      "priority": "Medium",
      "resources": ["Modern poetry anthology", "Online literary analysis tools"],
      "timeline": "Next 2 weeks"
    },
    {
      "area": "Vocabulary",
      "suggestion": "Use vocabulary in creative writing assignments",
      "priority": "High",
      "resources": ["Academic word list", "Vocabulary journal"],
      "timeline": "Ongoing"
    },
    {
      "area": "Writing Mechanics",
      "suggestion": "Review comma usage and complex sentence structure",
      "priority": "Low",
      "resources": ["Grammar workbook", "Writing center tutoring"],
      "timeline": "Next month"
    }
  ];

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "Improving":
        return successColor;
      case "Declining":
        return dangerColor;
      case "Stable":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "Proficient":
        return successColor;
      case "Approaching Proficiency":
        return warningColor;
      case "Below Basic":
        return dangerColor;
      case "Advanced":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "Improving":
        return Icons.trending_up;
      case "Declining":
        return Icons.trending_down;
      case "Stable":
        return Icons.trending_flat;
      default:
        return Icons.remove;
    }
  }

  void _exportReport() {
    ss("Progress report exported successfully!");
  }

  void _shareReport() {
    ss("Progress report shared with parents!");
  }

  void _scheduleConference() {
    // navigateTo(ScheduleConferenceView())
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress Report"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareReport(),
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () => _exportReport(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period selector
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Select Period",
                    items: [
                      {"label": "Fall 2024", "value": "Fall 2024"},
                      {"label": "Spring 2024", "value": "Spring 2024"},
                      {"label": "Fall 2023", "value": "Fall 2023"},
                    ],
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Student overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Text(
                      "${progressData["student_name"].split(" ").map((n) => n[0]).join("")}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${progressData["student_name"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${progressData["grade_level"]} • ${progressData["teacher"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${progressData["letter_grade"]}",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Overall Grade",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${progressData["gpa"]}",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "GPA",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${progressData["class_rank"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Class Rank",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(220),
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
            
            SizedBox(height: spLg),
            
            // Key metrics
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Key Metrics",
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
                        child: _buildMetricItem(
                          "Attendance",
                          "${(progressData["attendance_rate"] as num).toStringAsFixed(1)}%",
                          Icons.event_available,
                          successColor,
                        ),
                      ),
                      Expanded(
                        child: _buildMetricItem(
                          "Assignments",
                          "${progressData["assignments_completed"]}/${progressData["assignments_total"]}",
                          Icons.assignment,
                          infoColor,
                        ),
                      ),
                      Expanded(
                        child: _buildMetricItem(
                          "Trend",
                          "${progressData["improvement_trend"]}",
                          _getTrendIcon(progressData["improvement_trend"]),
                          _getTrendColor(progressData["improvement_trend"]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Skill areas
            Text(
              "Skill Area Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...skillAreas.map((skill) {
              final currentScore = skill["current_score"] as int;
              final previousScore = skill["previous_score"] as int;
              final targetScore = skill["target_score"] as int;
              final progress = currentScore / targetScore;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
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
                          child: Text(
                            "${skill["skill"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getLevelColor(skill["level"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${skill["level"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getLevelColor(skill["level"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "${skill["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Progress bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Current: $currentScore%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Target: $targetScore%",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          width: double.infinity,
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progress.clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: progress >= 0.9 ? successColor : progress >= 0.7 ? warningColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Icon(
                          _getTrendIcon(skill["trend"]),
                          color: _getTrendColor(skill["trend"]),
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${skill["trend"]} (${currentScore - previousScore > 0 ? '+' : ''}${currentScore - previousScore})",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getTrendColor(skill["trend"]),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${skill["assignments_count"]} assignments",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            
            SizedBox(height: spLg),
            
            // Achievements
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Achievements",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...achievements.map((achievement) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(
                          color: successColor.withAlpha(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            achievement["icon"],
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${achievement["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${achievement["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  DateTime.parse(achievement["date"]).dMMMy,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledColor,
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
            
            SizedBox(height: spLg),
            
            // Recommendations
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recommendations for Improvement",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...recommendations.map((rec) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(
                          color: infoColor.withAlpha(50),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${rec["area"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor(rec["priority"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${rec["priority"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getPriorityColor(rec["priority"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${rec["suggestion"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Timeline: ${rec["timeline"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Action button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Schedule Parent Conference",
                size: bs.md,
                onPressed: () => _scheduleConference(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
