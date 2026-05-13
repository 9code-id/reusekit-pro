import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaAssessmentAnalyticsView extends StatefulWidget {
  const RhaAssessmentAnalyticsView({super.key});

  @override
  State<RhaAssessmentAnalyticsView> createState() => _RhaAssessmentAnalyticsViewState();
}

class _RhaAssessmentAnalyticsViewState extends State<RhaAssessmentAnalyticsView> {
  int currentTab = 0;
  String selectedPeriod = "30days";
  String selectedDepartment = "all";
  bool loading = false;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 7 Days", "value": "7days"},
    {"label": "Last 30 Days", "value": "30days"},
    {"label": "Last 3 Months", "value": "3months"},
    {"label": "Last 6 Months", "value": "6months"},
    {"label": "Last Year", "value": "1year"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Sales", "value": "sales"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "HR", "value": "hr"},
    {"label": "Finance", "value": "finance"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Assessment Analytics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Performance", icon: Icon(Icons.trending_up)),
        Tab(text: "Insights", icon: Icon(Icons.psychology)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildPerformanceTab(),
        _buildInsightsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFilters(),
          _buildKPICards(),
          _buildAssessmentVolume(),
          _buildDepartmentComparison(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.tune, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Analytics Filters",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: periodOptions,
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
                  label: "Department",
                  items: departmentOptions,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKPICards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildKPICard("Total Assessments", "2,847", "+12.5%", Icons.quiz, primaryColor),
        _buildKPICard("Average Score", "82.7%", "+3.2%", Icons.trending_up, successColor),
        _buildKPICard("Completion Rate", "94.3%", "+1.8%", Icons.check_circle, infoColor),
        _buildKPICard("Average Duration", "47 min", "-5.1%", Icons.timer, warningColor),
      ],
    );
  }

  Widget _buildKPICard(String title, String value, String change, IconData icon, Color color) {
    bool isPositive = change.startsWith("+");
    
    return Container(
      padding: EdgeInsets.all(spSm),
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
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: (isPositive ? successColor : dangerColor).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 12,
                      color: isPositive ? successColor : dangerColor,
                    ),
                    SizedBox(width: 2),
                    Text(
                      change,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isPositive ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentVolume() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Text(
                "Assessment Volume Trend",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Export",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.trending_up, size: 48, color: disabledBoldColor),
                  SizedBox(height: spSm),
                  Text(
                    "Assessment Volume Chart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Showing daily assessment completions",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentComparison() {
    List<Map<String, dynamic>> departments = [
      {"name": "Engineering", "assessments": 567, "avgScore": 87.2, "completion": 96.1},
      {"name": "Sales", "assessments": 423, "avgScore": 81.5, "completion": 92.8},
      {"name": "Marketing", "assessments": 298, "avgScore": 78.9, "completion": 89.4},
      {"name": "HR", "assessments": 245, "avgScore": 84.3, "completion": 95.7},
      {"name": "Finance", "assessments": 189, "avgScore": 82.1, "completion": 91.2},
    ];

    return Container(
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
            "Department Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...departments.map((dept) => _buildDepartmentItem(dept)),
        ],
      ),
    );
  }

  Widget _buildDepartmentItem(Map<String, dynamic> dept) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${dept["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${dept["assessments"]} assessments",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Average Score",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(dept["avgScore"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: (dept["avgScore"] as double) >= 85 ? successColor : warningColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Completion Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(dept["completion"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: (dept["completion"] as double) >= 90 ? successColor : warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildScoreDistribution(),
          _buildSkillAnalysis(),
          _buildTimeAnalysis(),
        ],
      ),
    );
  }

  Widget _buildScoreDistribution() {
    List<Map<String, dynamic>> scoreRanges = [
      {"range": "90-100%", "count": 425, "percentage": 23.7, "grade": "A+"},
      {"range": "80-89%", "count": 687, "percentage": 38.2, "grade": "A"},
      {"range": "70-79%", "count": 456, "percentage": 25.4, "grade": "B"},
      {"range": "60-69%", "count": 189, "percentage": 10.5, "grade": "C"},
      {"range": "Below 60%", "count": 40, "percentage": 2.2, "grade": "D"},
    ];

    return Container(
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
            "Score Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...scoreRanges.map((range) => Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getGradeColor(range["grade"]).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${range["grade"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getGradeColor(range["grade"]),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${range["range"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${range["count"]} employees (${(range["percentage"] as double).toStringAsFixed(1)}%)",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (range["percentage"] as double) / 40,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _getGradeColor(range["grade"]),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case "A+":
        return successColor;
      case "A":
        return infoColor;
      case "B":
        return warningColor;
      case "C":
        return dangerColor.withAlpha(150);
      case "D":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildSkillAnalysis() {
    List<Map<String, dynamic>> skills = [
      {"name": "Problem Solving", "avgScore": 85.2, "trend": "+2.3"},
      {"name": "Communication", "avgScore": 78.9, "trend": "+1.7"},
      {"name": "Technical Knowledge", "avgScore": 87.6, "trend": "+0.8"},
      {"name": "Leadership", "avgScore": 73.4, "trend": "-1.2"},
      {"name": "Teamwork", "avgScore": 81.1, "trend": "+3.1"},
      {"name": "Time Management", "avgScore": 76.8, "trend": "+0.5"},
    ];

    return Container(
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
            "Skill Performance Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: skills.map((skill) => Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${skill["name"]}",
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
                        "${(skill["avgScore"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: (skill["avgScore"] as double) >= 80 ? successColor : warningColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: (skill["trend"].toString().startsWith("+") ? successColor : dangerColor).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${skill["trend"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: skill["trend"].toString().startsWith("+") ? successColor : dangerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeAnalysis() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Time Performance Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time, size: 48, color: disabledBoldColor),
                  SizedBox(height: spSm),
                  Text(
                    "Assessment Duration Chart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Average time spent per assessment type",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPredictiveInsights(),
          _buildRecommendations(),
          _buildAIAnalysis(),
        ],
      ),
    );
  }

  Widget _buildPredictiveInsights() {
    List<Map<String, dynamic>> insights = [
      {
        "title": "Skill Gap Prediction",
        "description": "Based on current trends, technical skills will require additional focus in Q1 2025",
        "impact": "High",
        "confidence": 87,
        "icon": Icons.trending_down,
        "color": warningColor,
      },
      {
        "title": "Performance Improvement",
        "description": "Leadership assessments show 15% improvement potential with targeted training",
        "impact": "Medium",
        "confidence": 73,
        "icon": Icons.trending_up,
        "color": successColor,
      },
      {
        "title": "Assessment Optimization",
        "description": "Reducing assessment duration by 10-15% could improve completion rates",
        "impact": "Medium",
        "confidence": 65,
        "icon": Icons.speed,
        "color": infoColor,
      },
    ];

    return Container(
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
            children: [
              Icon(Icons.psychology, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Predictive Insights",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...insights.map((insight) => Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (insight["color"] as Color).withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border(
                left: BorderSide(color: insight["color"] as Color, width: 3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      insight["icon"] as IconData,
                      color: insight["color"] as Color,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${insight["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: (insight["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${insight["impact"]} Impact",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: insight["color"] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${insight["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Confidence: ${insight["confidence"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: insight["color"] as Color,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    List<Map<String, dynamic>> recommendations = [
      {
        "title": "Implement Adaptive Testing",
        "description": "Reduce assessment time while maintaining accuracy",
        "priority": "High",
        "effort": "Medium",
        "roi": "85%",
      },
      {
        "title": "Enhanced Skill Tracking",
        "description": "Develop longitudinal skill development metrics",
        "priority": "Medium",
        "effort": "High",
        "roi": "72%",
      },
      {
        "title": "Department-Specific Assessments",
        "description": "Create tailored assessments for each department",
        "priority": "Medium",
        "effort": "Medium",
        "roi": "68%",
      },
    ];

    return Container(
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
            children: [
              Icon(Icons.lightbulb, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "AI Recommendations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...recommendations.map((rec) => Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${rec["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(rec["priority"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${rec["priority"]} Priority",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getPriorityColor(rec["priority"]),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${rec["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Effort: ${rec["effort"]} • ROI: ${rec["roi"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Implement",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildAIAnalysis() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(Icons.auto_awesome, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "AI Performance Analysis",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome, size: 48, color: disabledBoldColor),
                  SizedBox(height: spSm),
                  Text(
                    "AI Analysis Dashboard",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Machine learning insights and patterns",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
