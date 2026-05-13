import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaParentDashboardView extends StatefulWidget {
  const ElaParentDashboardView({super.key});

  @override
  State<ElaParentDashboardView> createState() => _ElaParentDashboardViewState();
}

class _ElaParentDashboardViewState extends State<ElaParentDashboardView> {
  int selectedChild = 0;

  List<Map<String, dynamic>> children = [
    {
      "id": 1,
      "name": "Emma Johnson",
      "grade": "Grade 3",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=child",
      "current_level": "Intermediate",
      "overall_progress": 78,
      "weekly_hours": 8.5,
      "achievements_this_month": 5,
    },
    {
      "id": 2,
      "name": "Liam Johnson",
      "grade": "Grade 1",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=child",
      "current_level": "Beginner",
      "overall_progress": 65,
      "weekly_hours": 6.2,
      "achievements_this_month": 3,
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "title": "Phonics Matching Game",
      "category": "Reading",
      "completed_at": "2025-06-14 15:30",
      "score": 92,
      "duration": "12 minutes",
      "status": "Completed",
    },
    {
      "title": "Creative Writing: My Pet Story",
      "category": "Writing",
      "completed_at": "2025-06-14 10:15",
      "score": 88,
      "duration": "25 minutes",
      "status": "Completed",
    },
    {
      "title": "Reading Comprehension Quiz",
      "category": "Reading",
      "completed_at": "2025-06-13 16:45",
      "score": 85,
      "duration": "18 minutes",
      "status": "Completed",
    },
    {
      "title": "Vocabulary Builder",
      "category": "Language",
      "completed_at": "2025-06-13 14:20",
      "score": 95,
      "duration": "15 minutes",
      "status": "Completed",
    },
  ];

  List<Map<String, dynamic>> weeklyProgress = [
    {"day": "Mon", "reading": 45, "writing": 30, "speaking": 20},
    {"day": "Tue", "reading": 60, "writing": 25, "speaking": 35},
    {"day": "Wed", "reading": 55, "writing": 40, "speaking": 25},
    {"day": "Thu", "reading": 70, "writing": 35, "speaking": 40},
    {"day": "Fri", "reading": 65, "writing": 50, "speaking": 30},
    {"day": "Sat", "reading": 40, "writing": 20, "speaking": 15},
    {"day": "Sun", "reading": 35, "writing": 15, "speaking": 10},
  ];

  List<Map<String, dynamic>> upcomingAssignments = [
    {
      "title": "Reading Journal Entry",
      "subject": "Reading",
      "due_date": "2025-06-18",
      "status": "Not Started",
      "priority": "High",
    },
    {
      "title": "Descriptive Writing Exercise",
      "subject": "Writing",
      "due_date": "2025-06-20",
      "status": "In Progress",
      "priority": "Medium",
    },
    {
      "title": "Presentation Practice",
      "subject": "Speaking",
      "due_date": "2025-06-22",
      "status": "Not Started",
      "priority": "Low",
    },
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "title": "Summer Reading List",
      "description": "Recommended books for continued learning",
      "type": "Reading List",
      "icon": Icons.menu_book,
    },
    {
      "title": "Family Story Time",
      "description": "Interactive reading activities for family time",
      "type": "Activity Guide",
      "icon": Icons.family_restroom,
    },
    {
      "title": "Writing Journal",
      "description": "Daily writing prompts for practice",
      "type": "Practice Tool",
      "icon": Icons.edit,
    },
  ];

  Map<String, dynamic> get currentChild => children[selectedChild];

  Color getCategoryColor(String category) {
    switch (category) {
      case "Reading":
        return successColor;
      case "Writing":
        return infoColor;
      case "Speaking":
        return warningColor;
      case "Language":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parent Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              //navigateTo('notifications')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('parent_settings')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Child Selector
            if (children.length > 1)
              Container(
                padding: EdgeInsets.all(spSm),
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
                      "Select Child",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QHorizontalScroll(
                      children: children.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> child = entry.value;
                        bool isSelected = selectedChild == index;
                        
                        return GestureDetector(
                          onTap: () {
                            selectedChild = index;
                            setState(() {});
                          },
                          child: Container(
                            width: 120,
                            margin: EdgeInsets.only(
                              right: index < children.length - 1 ? spSm : 0,
                            ),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledColor,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  child: Image.network(
                                    "${child["avatar"]}",
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${child["name"]}".split(' ')[0],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : primaryColor,
                                  ),
                                ),
                                Text(
                                  "${child["grade"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
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
              ),

            // Child Overview Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "${currentChild["avatar"]}",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${currentChild["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${currentChild["grade"]} • ${currentChild["current_level"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${currentChild["overall_progress"]}%",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Overall Progress",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withAlpha(200),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${(currentChild["weekly_hours"] as double).toStringAsFixed(1)}h",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "This Week",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withAlpha(200),
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
                ],
              ),
            ),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.emoji_events,
                          color: warningColor,
                          size: 28,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${currentChild["achievements_this_month"]}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Achievements",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: successColor,
                          size: 28,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${recentActivities.length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Activities",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.assignment,
                          color: dangerColor,
                          size: 28,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${upcomingAssignments.length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Assignments",
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

            // Weekly Progress Chart
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Weekly Activity (minutes)",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: weeklyProgress.map((day) {
                        double maxValue = 70;
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Reading bar
                              Container(
                                width: 20,
                                height: ((day["reading"] as int) / maxValue) * 80,
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusXs),
                                    topRight: Radius.circular(radiusXs),
                                  ),
                                ),
                              ),
                              // Writing bar
                              Container(
                                width: 20,
                                height: ((day["writing"] as int) / maxValue) * 80,
                                color: infoColor,
                              ),
                              // Speaking bar
                              Container(
                                width: 20,
                                height: ((day["speaking"] as int) / maxValue) * 80,
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(radiusXs),
                                    bottomRight: Radius.circular(radiusXs),
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${day["day"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Reading",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Writing",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            color: warningColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Speaking",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Recent Activities
            Container(
              padding: EdgeInsets.all(spSm),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Activities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('all_activities')
                        },
                      ),
                    ],
                  ),
                  ...recentActivities.take(3).map((activity) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: getCategoryColor("${activity["category"]}").withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: getCategoryColor("${activity["category"]}"),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${activity["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${activity["category"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: getCategoryColor("${activity["category"]}"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      " • ${activity["duration"]}",
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${activity["score"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${activity["completed_at"]}".split(' ')[0],
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
                ],
              ),
            ),

            // Upcoming Assignments
            Container(
              padding: EdgeInsets.all(spSm),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Upcoming Assignments",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('all_assignments')
                        },
                      ),
                    ],
                  ),
                  ...upcomingAssignments.map((assignment) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: getPriorityColor("${assignment["priority"]}").withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: getPriorityColor("${assignment["priority"]}"),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${assignment["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${assignment["subject"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: getCategoryColor("${assignment["subject"]}"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      " • Due ${assignment["due_date"]}",
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: getPriorityColor("${assignment["priority"]}"),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${assignment["priority"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${assignment["status"]}",
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
                ],
              ),
            ),

            // Parent Recommendations
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Recommendations for Parents",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...recommendations.map((rec) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              rec["icon"] as IconData,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${rec["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${rec["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "View",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('recommendation_detail')
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
