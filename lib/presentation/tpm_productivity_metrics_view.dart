import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmProductivityMetricsView extends StatefulWidget {
  const TpmProductivityMetricsView({super.key});

  @override
  State<TpmProductivityMetricsView> createState() => _TpmProductivityMetricsViewState();
}

class _TpmProductivityMetricsViewState extends State<TpmProductivityMetricsView> {
  int selectedPeriod = 0;
  String selectedTeam = "all";
  String selectedMetricType = "overview";
  
  List<Map<String, dynamic>> periods = [
    {"label": "This Week", "value": 0},
    {"label": "This Month", "value": 1},
    {"label": "This Quarter", "value": 2},
    {"label": "This Year", "value": 3},
  ];
  
  List<Map<String, dynamic>> teams = [
    {"label": "All Teams", "value": "all"},
    {"label": "Development", "value": "dev"},
    {"label": "Design", "value": "design"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
  ];
  
  List<Map<String, dynamic>> metricTypes = [
    {"label": "Overview", "value": "overview"},
    {"label": "Task Efficiency", "value": "tasks"},
    {"label": "Time Efficiency", "value": "time"},
    {"label": "Quality Metrics", "value": "quality"},
  ];
  
  List<Map<String, dynamic>> productivityMetrics = [
    {
      "title": "Overall Productivity",
      "value": "94.2%",
      "subtitle": "Team average",
      "icon": Icons.trending_up,
      "color": successColor,
      "change": 8.5,
      "target": 90.0
    },
    {
      "title": "Task Completion Rate",
      "value": "87.5%",
      "subtitle": "On-time delivery",
      "icon": Icons.task_alt,
      "color": primaryColor,
      "change": 12.3,
      "target": 85.0
    },
    {
      "title": "Quality Score",
      "value": "4.8/5.0",
      "subtitle": "Average rating",
      "icon": Icons.star,
      "color": warningColor,
      "change": 5.2,
      "target": 4.5
    },
    {
      "title": "Efficiency Index",
      "value": "92.1",
      "subtitle": "Composite score",
      "icon": Icons.speed,
      "color": infoColor,
      "change": -2.3,
      "target": 95.0
    },
  ];
  
  List<Map<String, dynamic>> teamProductivity = [
    {
      "team": "Development",
      "members": 12,
      "productivity": 96.5,
      "tasks_completed": 145,
      "avg_completion_time": 2.3,
      "quality_score": 4.9,
      "efficiency_trend": 8.2,
      "top_performers": 4
    },
    {
      "team": "Design",
      "members": 6,
      "productivity": 91.8,
      "tasks_completed": 89,
      "avg_completion_time": 3.1,
      "quality_score": 4.7,
      "efficiency_trend": 12.1,
      "top_performers": 2
    },
    {
      "team": "Marketing",
      "members": 8,
      "productivity": 88.9,
      "tasks_completed": 112,
      "avg_completion_time": 2.8,
      "quality_score": 4.6,
      "efficiency_trend": -3.5,
      "top_performers": 3
    },
    {
      "team": "Sales",
      "members": 10,
      "productivity": 93.2,
      "tasks_completed": 156,
      "avg_completion_time": 1.9,
      "quality_score": 4.8,
      "efficiency_trend": 6.7,
      "top_performers": 5
    },
  ];
  
  List<Map<String, dynamic>> individualMetrics = [
    {
      "name": "Sarah Johnson",
      "role": "Frontend Developer",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=woman",
      "productivity": 98.5,
      "tasks_completed": 28,
      "avg_completion_time": 1.8,
      "quality_score": 4.9,
      "efficiency_rating": "Excellent",
      "focus_time": 6.5,
      "distractions": 3
    },
    {
      "name": "Mike Chen",
      "role": "Backend Developer",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=man",
      "productivity": 95.2,
      "tasks_completed": 24,
      "avg_completion_time": 2.1,
      "quality_score": 4.8,
      "efficiency_rating": "Excellent",
      "focus_time": 7.2,
      "distractions": 2
    },
    {
      "name": "Emily Davis",
      "role": "UI/UX Designer",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=woman",
      "productivity": 92.1,
      "tasks_completed": 18,
      "avg_completion_time": 3.5,
      "quality_score": 4.7,
      "efficiency_rating": "Good",
      "focus_time": 5.8,
      "distractions": 5
    },
    {
      "name": "Alex Rodriguez",
      "role": "Project Manager",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=man",
      "productivity": 89.3,
      "tasks_completed": 15,
      "avg_completion_time": 2.9,
      "quality_score": 4.6,
      "efficiency_rating": "Good",
      "focus_time": 4.9,
      "distractions": 8
    },
    {
      "name": "Lisa Wang",
      "role": "QA Engineer",
      "avatar": "https://picsum.photos/40/40?random=5&keyword=woman",
      "productivity": 96.8,
      "tasks_completed": 32,
      "avg_completion_time": 1.6,
      "quality_score": 4.9,
      "efficiency_rating": "Excellent",
      "focus_time": 6.8,
      "distractions": 2
    },
  ];
  
  List<Map<String, dynamic>> productivityTrends = [
    {"period": "Week 1", "productivity": 91.2, "tasks": 142, "quality": 4.6},
    {"period": "Week 2", "productivity": 93.5, "tasks": 156, "quality": 4.7},
    {"period": "Week 3", "productivity": 95.8, "tasks": 168, "quality": 4.8},
    {"period": "Week 4", "productivity": 94.2, "tasks": 145, "quality": 4.8},
  ];
  
  List<Map<String, dynamic>> focusTimeData = [
    {"day": "Monday", "focus_hours": 6.5, "distractions": 8, "productivity": 92.3},
    {"day": "Tuesday", "focus_hours": 7.2, "distractions": 5, "productivity": 95.1},
    {"day": "Wednesday", "focus_hours": 6.8, "distractions": 6, "productivity": 93.7},
    {"day": "Thursday", "focus_hours": 7.0, "distractions": 4, "productivity": 96.2},
    {"day": "Friday", "focus_hours": 5.9, "distractions": 9, "productivity": 89.5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Productivity Metrics"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.download),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            _buildProductivityMetrics(),
            _buildProductivityChart(),
            _buildTeamProductivity(),
            _buildIndividualMetrics(),
            _buildFocusTimeAnalysis(),
          ],
        ),
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
              Expanded(
                child: QCategoryPicker(
                  label: "Time Period",
                  items: periods,
                  value: selectedPeriod,
                  onChanged: (index, label, value, item) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Team",
                  items: teams,
                  value: selectedTeam,
                  onChanged: (value, label) {
                    selectedTeam = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Metric Type",
                  items: metricTypes,
                  value: selectedMetricType,
                  onChanged: (value, label) {
                    selectedMetricType = value;
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

  Widget _buildProductivityMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Productivity Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: productivityMetrics.map((metric) => _buildMetricCard(metric)).toList(),
        ),
      ],
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    bool isPositive = (metric["change"] as double) >= 0;
    double currentValue = double.tryParse(metric["value"].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
    double targetValue = metric["target"] as double;
    bool meetsTarget = currentValue >= targetValue;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (metric["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"],
                  color: metric["color"],
                  size: 20,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: isPositive ? successColor : dangerColor,
                      size: 12,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${isPositive ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isPositive ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${metric["title"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${metric["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Text(
                "${metric["subtitle"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: meetsTarget ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  meetsTarget ? "TARGET MET" : "BELOW TARGET",
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: meetsTarget ? successColor : warningColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductivityChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Text(
                "Productivity Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.show_chart,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Productivity Trends Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              ...productivityTrends.map((trend) => Expanded(
                child: _buildTrendSummary(trend),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendSummary(Map<String, dynamic> trend) {
    return Container(
      padding: EdgeInsets.all(spXs),
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Text(
            "${trend["period"]}",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${(trend["productivity"] as double).toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Text(
            "${trend["tasks"]} tasks",
            style: TextStyle(
              fontSize: 9,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamProductivity() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Team Productivity Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...teamProductivity.map((team) => _buildTeamCard(team)),
        ],
      ),
    );
  }

  Widget _buildTeamCard(Map<String, dynamic> team) {
    bool isPositiveTrend = (team["efficiency_trend"] as double) >= 0;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${team["team"]} Team",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${team["members"]} members • ${team["top_performers"]} top performers",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${(team["productivity"] as double).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _getProductivityColor(team["productivity"] as double),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: isPositiveTrend ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${isPositiveTrend ? '+' : ''}${(team["efficiency_trend"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isPositiveTrend ? successColor : dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTeamStat("Tasks", "${team["tasks_completed"]}", primaryColor),
              ),
              Expanded(
                child: _buildTeamStat("Avg Time", "${(team["avg_completion_time"] as double).toStringAsFixed(1)}d", warningColor),
              ),
              Expanded(
                child: _buildTeamStat("Quality", "${(team["quality_score"] as double).toStringAsFixed(1)}/5", successColor),
              ),
              Expanded(
                child: _buildTeamStat("Productivity", "${(team["productivity"] as double).toStringAsFixed(1)}%", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildIndividualMetrics() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Text(
                "Individual Performance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...individualMetrics.take(3).map((individual) => _buildIndividualCard(individual)),
        ],
      ),
    );
  }

  Widget _buildIndividualCard(Map<String, dynamic> individual) {
    Color efficiencyColor = _getEfficiencyColor(individual["efficiency_rating"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${individual["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${individual["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${individual["role"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${(individual["productivity"] as double).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _getProductivityColor(individual["productivity"] as double),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: efficiencyColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${individual["efficiency_rating"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: efficiencyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildIndividualStat("Tasks", "${individual["tasks_completed"]}", primaryColor),
              ),
              Expanded(
                child: _buildIndividualStat("Avg Time", "${(individual["avg_completion_time"] as double).toStringAsFixed(1)}d", warningColor),
              ),
              Expanded(
                child: _buildIndividualStat("Quality", "${(individual["quality_score"] as double).toStringAsFixed(1)}/5", successColor),
              ),
              Expanded(
                child: _buildIndividualStat("Focus", "${(individual["focus_time"] as double).toStringAsFixed(1)}h", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIndividualStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFocusTimeAnalysis() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Focus Time Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...focusTimeData.map((focus) => _buildFocusTimeCard(focus)),
          _buildFocusTimeSummary(),
        ],
      ),
    );
  }

  Widget _buildFocusTimeCard(Map<String, dynamic> focus) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            child: Text(
              "${focus["day"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildFocusStat("Focus", "${(focus["focus_hours"] as double).toStringAsFixed(1)}h", successColor),
                ),
                Expanded(
                  child: _buildFocusStat("Distractions", "${focus["distractions"]}", dangerColor),
                ),
                Expanded(
                  child: _buildFocusStat("Productivity", "${(focus["productivity"] as double).toStringAsFixed(1)}%", primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFocusTimeSummary() {
    double avgFocusTime = focusTimeData.fold(0.0, (sum, item) => sum + (item["focus_hours"] as double)) / focusTimeData.length;
    double avgDistractions = focusTimeData.fold(0.0, (sum, item) => sum + (item["distractions"] as int)) / focusTimeData.length;
    double avgProductivity = focusTimeData.fold(0.0, (sum, item) => sum + (item["productivity"] as double)) / focusTimeData.length;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Text(
            "Weekly Average:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Spacer(),
          _buildFocusStat("Focus", "${avgFocusTime.toStringAsFixed(1)}h", successColor),
          SizedBox(width: spSm),
          _buildFocusStat("Distractions", "${avgDistractions.toStringAsFixed(0)}", dangerColor),
          SizedBox(width: spSm),
          _buildFocusStat("Productivity", "${avgProductivity.toStringAsFixed(1)}%", primaryColor),
        ],
      ),
    );
  }

  Color _getProductivityColor(double productivity) {
    if (productivity >= 95) return successColor;
    if (productivity >= 85) return warningColor;
    return dangerColor;
  }

  Color _getEfficiencyColor(String efficiency) {
    switch (efficiency.toLowerCase()) {
      case "excellent":
        return successColor;
      case "good":
        return warningColor;
      case "poor":
        return dangerColor;
      default:
        return infoColor;
    }
  }
}
