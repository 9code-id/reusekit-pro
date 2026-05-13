import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProgress3View extends StatefulWidget {
  const GrlProgress3View({Key? key}) : super(key: key);

  @override
  State<GrlProgress3View> createState() => _GrlProgress3ViewState();
}

class _GrlProgress3ViewState extends State<GrlProgress3View> {
  String selectedPeriod = "This Month";
  String selectedCategory = "All Goals";
  bool showCompleted = true;

  List<Map<String, dynamic>> progressCategories = [
    {
      "id": "health",
      "name": "Health & Fitness",
      "icon": Icons.fitness_center,
      "color": const Color(0xFF4CAF50),
      "progress": 78,
      "totalGoals": 12,
      "completedGoals": 9,
      "activeGoals": 3,
    },
    {
      "id": "career",
      "name": "Career Development",
      "icon": Icons.trending_up,
      "color": const Color(0xFF2196F3),
      "progress": 65,
      "totalGoals": 8,
      "completedGoals": 5,
      "activeGoals": 3,
    },
    {
      "id": "personal",
      "name": "Personal Growth",
      "icon": Icons.psychology,
      "color": const Color(0xFF9C27B0),
      "progress": 82,
      "totalGoals": 10,
      "completedGoals": 8,
      "activeGoals": 2,
    },
    {
      "id": "financial",
      "name": "Financial Goals",
      "icon": Icons.savings,
      "color": const Color(0xFFFF9800),
      "progress": 45,
      "totalGoals": 6,
      "completedGoals": 3,
      "activeGoals": 3,
    },
  ];

  List<Map<String, dynamic>> recentGoals = [
    {
      "id": "1",
      "title": "Complete Flutter Course",
      "category": "Career Development",
      "progress": 85,
      "dueDate": "2024-02-15",
      "status": "In Progress",
      "priority": "High",
      "completedTasks": 17,
      "totalTasks": 20,
    },
    {
      "id": "2",
      "title": "Save \$5,000 Emergency Fund",
      "category": "Financial Goals",
      "progress": 60,
      "dueDate": "2024-03-30",
      "status": "In Progress",
      "priority": "Medium",
      "completedTasks": 3,
      "totalTasks": 5,
    },
    {
      "id": "3",
      "title": "Read 24 Books This Year",
      "category": "Personal Growth",
      "progress": 92,
      "dueDate": "2024-12-31",
      "status": "Nearly Complete",
      "priority": "Low",
      "completedTasks": 22,
      "totalTasks": 24,
    },
    {
      "id": "4",
      "title": "Run 500km This Year",
      "category": "Health & Fitness",
      "progress": 73,
      "dueDate": "2024-12-31",
      "status": "In Progress",
      "priority": "Medium",
      "completedTasks": 365,
      "totalTasks": 500,
    },
    {
      "id": "5",
      "title": "Learn Spanish Basics",
      "category": "Personal Growth",
      "progress": 45,
      "dueDate": "2024-04-15",
      "status": "Behind Schedule",
      "priority": "High",
      "completedTasks": 9,
      "totalTasks": 20,
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "Goal Crusher",
      "description": "Completed 50 goals",
      "icon": Icons.emoji_events,
      "color": const Color(0xFFFFD700),
      "unlockedDate": "2024-01-20",
    },
    {
      "title": "Consistent Performer",
      "description": "30-day streak",
      "icon": Icons.local_fire_department,
      "color": const Color(0xFFFF5722),
      "unlockedDate": "2024-01-15",
    },
    {
      "title": "Early Bird",
      "description": "Completed 5 goals ahead of schedule",
      "icon": Icons.schedule,
      "color": const Color(0xFF4CAF50),
      "unlockedDate": "2024-01-10",
    },
  ];

  List<Map<String, dynamic>> get filteredGoals {
    var goals = recentGoals;
    
    if (selectedCategory != "All Goals") {
      goals = goals.where((goal) => goal["category"] == selectedCategory).toList();
    }
    
    if (!showCompleted) {
      goals = goals.where((goal) => goal["status"] != "Completed").toList();
    }
    
    return goals;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return primaryColor;
      case "Nearly Complete":
        return infoColor;
      case "Behind Schedule":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Goal Progress Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to add goal
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Controls
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
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Time Period",
                          items: const [
                            {"label": "This Week", "value": "This Week"},
                            {"label": "This Month", "value": "This Month"},
                            {"label": "This Quarter", "value": "This Quarter"},
                            {"label": "This Year", "value": "This Year"},
                          ],
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: [
                            const {"label": "All Goals", "value": "All Goals"},
                            ...progressCategories.map((cat) => {
                              "label": cat["name"],
                              "value": cat["name"],
                            }),
                          ],
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Show Completed Goals",
                              "value": true,
                              "checked": showCompleted,
                            }
                          ],
                          value: [
                            if (showCompleted)
                              {
                                "label": "Show Completed Goals",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            showCompleted = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Overall Progress Stats
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "36",
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Total Goals",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withAlpha(128),
                      ),
                      Column(
                        children: [
                          Text(
                            "25",
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withAlpha(128),
                      ),
                      Column(
                        children: [
                          Text(
                            "69%",
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Success Rate",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Progress Categories
            Text(
              "Progress by Category",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            ResponsiveGridView(
              padding: EdgeInsets.all(spXs),
              minItemWidth: 200,
              children: progressCategories.map((category) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: (category["color"] as Color).withAlpha(51),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (category["color"] as Color).withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              category["icon"] as IconData,
                              color: category["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${category["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${category["completedGoals"]}/${category["totalGoals"]} goals",
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
                      SizedBox(height: spMd),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${category["progress"]}%",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: category["color"] as Color,
                            ),
                          ),
                          Text(
                            "${category["activeGoals"]} active",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: LinearProgressIndicator(
                          value: (category["progress"] as int) / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            category["color"] as Color,
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Recent Goals
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Goals",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "View All",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to all goals
                  },
                ),
              ],
            ),
            SizedBox(height: spMd),

            ...filteredGoals.map((goal) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(goal["status"]),
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
                                "${goal["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${goal["category"]}",
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
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(goal["status"]).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${goal["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(goal["status"]),
                            ),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Progress",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${goal["progress"]}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusXs),
                                child: LinearProgressIndicator(
                                  value: (goal["progress"] as int) / 100,
                                  backgroundColor: disabledColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    _getStatusColor(goal["status"]),
                                  ),
                                  minHeight: 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${goal["completedTasks"]}/${goal["totalTasks"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "tasks",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 12,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Due: ${goal["dueDate"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: goal["priority"] == "High"
                                ? dangerColor.withAlpha(26)
                                : goal["priority"] == "Medium"
                                    ? warningColor.withAlpha(26)
                                    : successColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${goal["priority"]} Priority",
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: goal["priority"] == "High"
                                  ? dangerColor
                                  : goal["priority"] == "Medium"
                                      ? warningColor
                                      : successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spLg),

            // Achievements Section
            Text(
              "Recent Achievements",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: achievements.map((achievement) {
                  return Container(
                    width: 200,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: (achievement["color"] as Color).withAlpha(51),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: (achievement["color"] as Color).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            achievement["icon"] as IconData,
                            color: achievement["color"] as Color,
                            size: 32,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${achievement["title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${achievement["description"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Unlocked: ${achievement["unlockedDate"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: spXl),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add new goal
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
