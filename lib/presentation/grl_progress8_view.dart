import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProgress8View extends StatefulWidget {
  @override
  State<GrlProgress8View> createState() => _GrlProgress8ViewState();
}

class _GrlProgress8ViewState extends State<GrlProgress8View> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  String selectedView = "monthly";

  List<Map<String, dynamic>> viewTypes = [
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  Map<String, List<Map<String, dynamic>>> progressData = {
    "monthly": [
      {
        "category": "Work Projects",
        "items": [
          {"name": "Website Redesign", "progress": 85, "target": 100, "deadline": "2024-02-28"},
          {"name": "Mobile App Development", "progress": 60, "target": 100, "deadline": "2024-03-15"},
          {"name": "Client Presentation", "progress": 95, "target": 100, "deadline": "2024-02-20"},
        ]
      },
      {
        "category": "Personal Development",
        "items": [
          {"name": "Online Course Completion", "progress": 75, "target": 100, "deadline": "2024-02-25"},
          {"name": "Reading Goals", "progress": 40, "target": 100, "deadline": "2024-02-29"},
          {"name": "Exercise Routine", "progress": 80, "target": 100, "deadline": "2024-02-29"},
        ]
      },
      {
        "category": "Financial Goals",
        "items": [
          {"name": "Monthly Savings", "progress": 70, "target": 100, "deadline": "2024-02-29"},
          {"name": "Investment Portfolio", "progress": 55, "target": 100, "deadline": "2024-02-29"},
          {"name": "Budget Management", "progress": 90, "target": 100, "deadline": "2024-02-29"},
        ]
      },
    ],
    "quarterly": [
      {
        "category": "Business Growth",
        "items": [
          {"name": "Revenue Target", "progress": 68, "target": 100, "deadline": "2024-03-31"},
          {"name": "Client Acquisition", "progress": 45, "target": 100, "deadline": "2024-03-31"},
          {"name": "Market Expansion", "progress": 30, "target": 100, "deadline": "2024-03-31"},
        ]
      },
      {
        "category": "Team Development",
        "items": [
          {"name": "Skill Training", "progress": 80, "target": 100, "deadline": "2024-03-31"},
          {"name": "Team Building", "progress": 65, "target": 100, "deadline": "2024-03-31"},
          {"name": "Performance Reviews", "progress": 90, "target": 100, "deadline": "2024-03-31"},
        ]
      },
    ],
    "yearly": [
      {
        "category": "Strategic Goals",
        "items": [
          {"name": "Annual Revenue", "progress": 42, "target": 100, "deadline": "2024-12-31"},
          {"name": "Product Launch", "progress": 35, "target": 100, "deadline": "2024-12-31"},
          {"name": "Market Position", "progress": 28, "target": 100, "deadline": "2024-12-31"},
        ]
      },
      {
        "category": "Personal Achievements",
        "items": [
          {"name": "Career Advancement", "progress": 50, "target": 100, "deadline": "2024-12-31"},
          {"name": "Health & Wellness", "progress": 60, "target": 100, "deadline": "2024-12-31"},
          {"name": "Learning Goals", "progress": 45, "target": 100, "deadline": "2024-12-31"},
        ]
      },
    ],
  };

  List<Map<String, dynamic>> recentActivities = [
    {
      "title": "Website Redesign",
      "action": "Progress updated to 85%",
      "time": "2 hours ago",
      "type": "progress",
      "color": successColor,
    },
    {
      "title": "Mobile App Development",
      "action": "Added new feature milestone",
      "time": "4 hours ago",
      "type": "milestone",
      "color": infoColor,
    },
    {
      "title": "Client Presentation",
      "action": "Marked as 95% complete",
      "time": "1 day ago",
      "type": "progress",
      "color": warningColor,
    },
    {
      "title": "Online Course",
      "action": "Module 8 completed",
      "time": "2 days ago",
      "type": "achievement",
      "color": primaryColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentData = progressData[selectedView] ?? [];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // View Type Selector
            QCategoryPicker(
              items: viewTypes,
              value: selectedView,
              onChanged: (index, label, value, item) {
                selectedView = value;
                setState(() {});
              },
            ),

            // Overall Statistics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Overall Progress Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Total Goals",
                          "${_getTotalGoals()}",
                          Icons.flag,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Completed",
                          "${_getCompletedGoals()}",
                          Icons.check_circle,
                          successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "In Progress",
                          "${_getInProgressGoals()}",
                          Icons.schedule,
                          warningColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "At Risk",
                          "${_getAtRiskGoals()}",
                          Icons.warning,
                          dangerColor,
                        ),
                      ),
                    ],
                  ),

                  // Overall Progress Circle
                  Container(
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: CircularProgressIndicator(
                            value: _getOverallProgress() / 100,
                            strokeWidth: 12,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${_getOverallProgress().toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Overall",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
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

            // Progress Categories
            Column(
              spacing: spSm,
              children: List.generate(
                currentData.length,
                (index) => _buildCategoryCard(currentData[index]),
              ),
            ),

            // Progress Chart
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
                  Text(
                    "Progress Trends",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Container(
                    height: 200,
                    child: _buildProgressChart(),
                  ),
                ],
              ),
            ),

            // Recent Activities
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
                        "Recent Activities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  
                  Column(
                    spacing: spSm,
                    children: List.generate(
                      recentActivities.length,
                      (index) => _buildActivityItem(recentActivities[index]),
                    ),
                  ),
                ],
              ),
            ),

            // Recommendations
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [infoColor, infoColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.lightbulb,
                    size: 48,
                    color: Colors.white,
                  ),
                  Text(
                    "Smart Recommendations",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Focus on Mobile App Development this week to stay on track. Consider allocating more time to Investment Portfolio to meet your financial goals.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "View Detailed Plan",
                    icon: Icons.arrow_forward,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Quick Actions
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Add Goal",
                    icon: Icons.add,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.download,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    final items = category["items"] as List<Map<String, dynamic>>;
    final avgProgress = items.map((item) => item["progress"] as num).fold(0.0, (sum, progress) => sum + progress) / items.length;
    
    return Container(
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
                "${category["category"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getProgressColor(avgProgress).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${avgProgress.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getProgressColor(avgProgress),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          
          LinearProgressIndicator(
            value: avgProgress / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(_getProgressColor(avgProgress)),
            minHeight: 6,
          ),
          
          Column(
            spacing: spSm,
            children: List.generate(
              items.length,
              (index) => _buildProgressItem(items[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem(Map<String, dynamic> item) {
    final progress = item["progress"] as num;
    final isCompleted = progress >= 100;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: isCompleted ? Border.all(color: successColor, width: 1) : null,
      ),
      child: Row(
        children: [
          if (isCompleted)
            Icon(
              Icons.check_circle,
              color: successColor,
              size: 20,
            )
          else
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _getProgressColor(progress).withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "${progress.toInt()}",
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: _getProgressColor(progress),
                  ),
                ),
              ),
            ),
          
          SizedBox(width: spSm),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                Text(
                  "Due: ${DateTime.parse(item["deadline"]).day}/${DateTime.parse(item["deadline"]).month}/${DateTime.parse(item["deadline"]).year}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          Text(
            "${progress}%",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _getProgressColor(progress),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: activity["color"],
            shape: BoxShape.circle,
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
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                "${activity["action"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Text(
          "${activity["time"]}",
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressChart() {
    final currentData = progressData[selectedView] ?? [];
    final allItems = currentData.expand((category) => category["items"] as List<Map<String, dynamic>>).toList();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(allItems.length, (index) {
          final item = allItems[index];
          final progress = item["progress"] as num;
          final height = (progress / 100 * 150).toDouble();
          
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 25,
                height: height,
                decoration: BoxDecoration(
                  color: _getProgressColor(progress),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${progress.toInt()}%",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Color _getProgressColor(num progress) {
    if (progress >= 90) return successColor;
    if (progress >= 70) return infoColor;
    if (progress >= 50) return warningColor;
    return dangerColor;
  }

  int _getTotalGoals() {
    final currentData = progressData[selectedView] ?? [];
    return currentData.fold(0, (sum, category) => sum + (category["items"] as List).length);
  }

  int _getCompletedGoals() {
    final currentData = progressData[selectedView] ?? [];
    return currentData.fold(0, (sum, category) {
      final items = category["items"] as List<Map<String, dynamic>>;
      return sum + items.where((item) => (item["progress"] as num) >= 100).length;
    });
  }

  int _getInProgressGoals() {
    final currentData = progressData[selectedView] ?? [];
    return currentData.fold(0, (sum, category) {
      final items = category["items"] as List<Map<String, dynamic>>;
      return sum + items.where((item) => (item["progress"] as num) > 0 && (item["progress"] as num) < 100).length;
    });
  }

  int _getAtRiskGoals() {
    final currentData = progressData[selectedView] ?? [];
    return currentData.fold(0, (sum, category) {
      final items = category["items"] as List<Map<String, dynamic>>;
      return sum + items.where((item) => (item["progress"] as num) < 50).length;
    });
  }

  double _getOverallProgress() {
    final currentData = progressData[selectedView] ?? [];
    if (currentData.isEmpty) return 0.0;
    
    final allItems = currentData.expand((category) => category["items"] as List<Map<String, dynamic>>).toList();
    if (allItems.isEmpty) return 0.0;
    
    final totalProgress = allItems.map((item) => item["progress"] as num).fold(0.0, (sum, progress) => sum + progress.toDouble());
    return totalProgress / allItems.length;
  }
}
