import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTeamPerformanceView extends StatefulWidget {
  const TpmTeamPerformanceView({super.key});

  @override
  State<TpmTeamPerformanceView> createState() => _TpmTeamPerformanceViewState();
}

class _TpmTeamPerformanceViewState extends State<TpmTeamPerformanceView> {
  int selectedPeriod = 0;
  String selectedTeam = "all";
  
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
  
  List<Map<String, dynamic>> performanceMetrics = [
    {
      "title": "Tasks Completed",
      "value": 145,
      "target": 160,
      "change": 12.5,
      "icon": Icons.task_alt,
      "color": "success"
    },
    {
      "title": "Average Quality Score",
      "value": 4.7,
      "target": 4.5,
      "change": 8.2,
      "icon": Icons.star,
      "color": "primary"
    },
    {
      "title": "On-Time Delivery",
      "value": 89.5,
      "target": 90.0,
      "change": -2.1,
      "icon": Icons.schedule,
      "color": "warning"
    },
    {
      "title": "Team Utilization",
      "value": 78.3,
      "target": 80.0,
      "change": 5.6,
      "icon": Icons.people,
      "color": "info"
    },
  ];
  
  List<Map<String, dynamic>> teamMembers = [
    {
      "name": "Sarah Johnson",
      "role": "Frontend Developer",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=woman",
      "performance": 94.5,
      "tasksCompleted": 23,
      "hoursWorked": 38.5,
      "efficiency": "Excellent"
    },
    {
      "name": "Mike Chen",
      "role": "Backend Developer", 
      "avatar": "https://picsum.photos/40/40?random=2&keyword=man",
      "performance": 91.2,
      "tasksCompleted": 19,
      "hoursWorked": 41.2,
      "efficiency": "Excellent"
    },
    {
      "name": "Emily Davis",
      "role": "UI/UX Designer",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=woman",
      "performance": 88.7,
      "tasksCompleted": 15,
      "hoursWorked": 35.8,
      "efficiency": "Good"
    },
    {
      "name": "Alex Rodriguez",
      "role": "Project Manager",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=man",
      "performance": 85.3,
      "tasksCompleted": 12,
      "hoursWorked": 42.0,
      "efficiency": "Good"
    },
    {
      "name": "Lisa Wang",
      "role": "QA Engineer",
      "avatar": "https://picsum.photos/40/40?random=5&keyword=woman",
      "performance": 92.8,
      "tasksCompleted": 28,
      "hoursWorked": 39.5,
      "efficiency": "Excellent"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Performance"),
        actions: [
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
            _buildPerformanceMetrics(),
            _buildPerformanceChart(),
            _buildTeamMembersList(),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Performance Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: performanceMetrics.map((metric) {
            Color metricColor = _getMetricColor(metric["color"]);
            bool isPositive = (metric["change"] as double) >= 0;
            
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
                          color: metricColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          metric["icon"],
                          color: metricColor,
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
                    _formatMetricValue(metric["value"]),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Target: ${_formatMetricValue(metric["target"])}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPerformanceChart() {
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
            "Performance Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
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
                    "Performance Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
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

  Widget _buildTeamMembersList() {
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
                "Team Members",
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
          ...teamMembers.map((member) => _buildMemberCard(member)),
        ],
      ),
    );
  }

  Widget _buildMemberCard(Map<String, dynamic> member) {
    Color efficiencyColor = _getEfficiencyColor(member["efficiency"]);
    
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
                backgroundImage: NetworkImage("${member["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${member["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${member["role"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: efficiencyColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${member["efficiency"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: efficiencyColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildMemberStat("Performance", "${(member["performance"] as double).toStringAsFixed(1)}%"),
              ),
              Expanded(
                child: _buildMemberStat("Tasks", "${member["tasksCompleted"]}"),
              ),
              Expanded(
                child: _buildMemberStat("Hours", "${(member["hoursWorked"] as double).toStringAsFixed(1)}h"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemberStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
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

  Color _getMetricColor(String colorType) {
    switch (colorType) {
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "primary":
      default:
        return primaryColor;
    }
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

  String _formatMetricValue(dynamic value) {
    if (value is double) {
      if (value == value.toInt()) {
        return value.toInt().toString();
      }
      return value.toStringAsFixed(1);
    }
    return value.toString();
  }
}
