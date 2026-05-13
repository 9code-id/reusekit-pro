import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaHealthScoreView extends StatefulWidget {
  const MhaHealthScoreView({super.key});

  @override
  State<MhaHealthScoreView> createState() => _MhaHealthScoreViewState();
}

class _MhaHealthScoreViewState extends State<MhaHealthScoreView> {
  int selectedTabIndex = 0;
  String selectedPeriod = "This Month";

  // Overall health score
  double overallScore = 78.5;
  
  // Individual health metrics
  Map<String, dynamic> healthMetrics = {
    "physical": {
      "score": 82,
      "trend": "up",
      "description": "Good cardiovascular health",
      "color": "success"
    },
    "mental": {
      "score": 74,
      "trend": "stable",
      "description": "Manage stress levels",
      "color": "warning"
    },
    "nutrition": {
      "score": 85,
      "trend": "up",
      "description": "Excellent dietary habits",
      "color": "success"
    },
    "sleep": {
      "score": 69,
      "trend": "down",
      "description": "Improve sleep quality",
      "color": "danger"
    },
    "social": {
      "score": 80,
      "trend": "up",
      "description": "Strong social connections",
      "color": "success"
    },
    "preventive": {
      "score": 90,
      "trend": "stable",
      "description": "Up to date with checkups",
      "color": "success"
    }
  };

  List<Map<String, dynamic>> weeklyScores = [
    {"week": "Week 1", "score": 75, "date": "Dec 1-7"},
    {"week": "Week 2", "score": 78, "date": "Dec 8-14"},
    {"week": "Week 3", "score": 80, "date": "Dec 15-21"},
    {"week": "Week 4", "score": 79, "date": "Dec 22-28"},
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "title": "Improve Sleep Quality",
      "description": "Your sleep score is below optimal. Consider establishing a bedtime routine.",
      "category": "Sleep",
      "priority": "high",
      "icon": Icons.bedtime,
      "color": "danger",
      "actions": ["Set bedtime", "Limit screen time", "Create sleep environment"]
    },
    {
      "title": "Stress Management",
      "description": "Mental health score could benefit from stress reduction techniques.",
      "category": "Mental Health",
      "priority": "medium",
      "icon": Icons.psychology,
      "color": "warning",
      "actions": ["Try meditation", "Practice deep breathing", "Schedule relaxation time"]
    },
    {
      "title": "Maintain Physical Activity",
      "description": "Keep up the great work with your exercise routine!",
      "category": "Physical",
      "priority": "low",
      "icon": Icons.fitness_center,
      "color": "success",
      "actions": ["Continue current routine", "Add variety", "Track progress"]
    },
    {
      "title": "Nutrition Optimization",
      "description": "Excellent nutrition habits. Consider adding more variety.",
      "category": "Nutrition",
      "priority": "low",
      "icon": Icons.restaurant,
      "color": "success",
      "actions": ["Try new healthy recipes", "Add more vegetables", "Stay hydrated"]
    }
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "7-Day Exercise Streak",
      "description": "Completed exercise routine for 7 consecutive days",
      "icon": Icons.emoji_events,
      "date": "Dec 28, 2024",
      "points": 50
    },
    {
      "title": "Nutrition Champion",
      "description": "Maintained healthy eating for 2 weeks",
      "icon": Icons.restaurant_menu,
      "date": "Dec 25, 2024",
      "points": 30
    },
    {
      "title": "Wellness Check Complete",
      "description": "Completed annual health checkup",
      "icon": Icons.medical_services,
      "date": "Dec 20, 2024",
      "points": 100
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Score"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: _showScoreHistory,
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showScoreInfo,
          ),
        ],
      ),
      body: Column(
        children: [
          // Overall Score Header
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Text(
                  "Overall Health Score",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${overallScore.toStringAsFixed(1)}",
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "out of 100",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(180),
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.trending_up,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "+2.3 from last week",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Period Selection
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            child: QDropdownField(
              label: "Time Period",
              items: [
                {"label": "This Week", "value": "This Week"},
                {"label": "This Month", "value": "This Month"},
                {"label": "Last 3 Months", "value": "Last 3 Months"},
                {"label": "This Year", "value": "This Year"},
              ],
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),
          ),

          SizedBox(height: spMd),

          // Tab Selection
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton("Metrics", 0),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildTabButton("Trends", 1),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildTabButton("Recommendations", 2),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Content based on selected tab
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        selectedTabIndex = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledBoldColor,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : disabledBoldColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return _buildMetricsTab();
      case 1:
        return _buildTrendsTab();
      case 2:
        return _buildRecommendationsTab();
      default:
        return _buildMetricsTab();
    }
  }

  Widget _buildMetricsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Health Metrics Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: healthMetrics.entries.map((entry) {
              final key = entry.key;
              final data = entry.value as Map<String, dynamic>;
              final score = data["score"] as int;
              final trend = data["trend"] as String;
              final description = data["description"] as String;
              final colorName = data["color"] as String;
              final color = _getColorByName(colorName);

              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            _getMetricTitle(key),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Icon(
                          _getTrendIcon(trend),
                          size: 16,
                          color: _getTrendColor(trend),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$score",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      "/100",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    LinearProgressIndicator(
                      value: score / 100,
                      backgroundColor: color.withAlpha(20),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
          
          // Recent Achievements
          Text(
            "Recent Achievements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...achievements.take(3).map((achievement) {
            return Container(
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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      achievement["icon"] as IconData,
                      color: warningColor,
                      size: 20,
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
                          "${achievement["date"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: spXs / 2,
                    ),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "+${achievement["points"]} pts",
                      style: TextStyle(
                        fontSize: 10,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Score Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          // Weekly Scores Chart Placeholder
          Container(
            height: 200,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Weekly Progress",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: weeklyScores.map((week) {
                      final score = week["score"] as int;
                      final height = (score / 100) * 120;
                      
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: spXs),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "$score",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                width: double.infinity,
                                height: height,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${week["week"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Metric Trends
          Text(
            "Individual Metric Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ...healthMetrics.entries.map((entry) {
            final key = entry.key;
            final data = entry.value as Map<String, dynamic>;
            final score = data["score"] as int;
            final trend = data["trend"] as String;
            final colorName = data["color"] as String;
            final color = _getColorByName(colorName);
            
            return Container(
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
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      _getMetricTitle(key),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    "$score/100",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Icon(
                    _getTrendIcon(trend),
                    size: 20,
                    color: _getTrendColor(trend),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRecommendationsTab() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      itemCount: recommendations.length,
      itemBuilder: (context, index) {
        final recommendation = recommendations[index];
        final priority = recommendation["priority"] as String;
        final colorName = recommendation["color"] as String;
        final color = _getColorByName(colorName);
        final actions = recommendation["actions"] as List;

        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border.all(
              color: color.withAlpha(30),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      recommendation["icon"] as IconData,
                      color: color,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${recommendation["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: spXs / 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getPriorityColor(priority).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                priority.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getPriorityColor(priority),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${recommendation["category"]}",
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
              
              SizedBox(height: spSm),
              
              Text(
                "${recommendation["description"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Text(
                "Suggested Actions:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              
              ...actions.map((action) {
                return Padding(
                  padding: EdgeInsets.only(bottom: spXs / 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "$action",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Start Action",
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to action plan
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Learn More",
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to detailed info
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _getMetricTitle(String key) {
    switch (key) {
      case "physical":
        return "Physical Health";
      case "mental":
        return "Mental Health";
      case "nutrition":
        return "Nutrition";
      case "sleep":
        return "Sleep Quality";
      case "social":
        return "Social Wellness";
      case "preventive":
        return "Preventive Care";
      default:
        return key;
    }
  }

  Color _getColorByName(String colorName) {
    switch (colorName) {
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "danger":
        return dangerColor;
      case "info":
        return infoColor;
      case "primary":
        return primaryColor;
      case "secondary":
        return secondaryColor;
      default:
        return primaryColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      case "stable":
        return Icons.trending_flat;
      default:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up":
        return successColor;
      case "down":
        return dangerColor;
      case "stable":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  void _showScoreHistory() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Score History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...weeklyScores.map((week) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Text(
                      "${week["week"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${week["score"]}/100",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showScoreInfo() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Health Score",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Your health score is calculated based on multiple factors including physical activity, sleep quality, nutrition, mental health, social wellness, and preventive care.",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Score Ranges:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "• 90-100: Excellent\n• 80-89: Good\n• 70-79: Fair\n• 60-69: Needs Improvement\n• Below 60: Poor",
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
