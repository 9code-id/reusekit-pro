import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmPerformanceMetricsView extends StatefulWidget {
  const FsmPerformanceMetricsView({super.key});

  @override
  State<FsmPerformanceMetricsView> createState() => _FsmPerformanceMetricsViewState();
}

class _FsmPerformanceMetricsViewState extends State<FsmPerformanceMetricsView> {
  int currentTab = 0;
  String selectedPeriod = "this_month";
  String selectedMetric = "all";
  String selectedTechnician = "all";
  bool enableBenchmarking = true;
  bool showTargets = true;
  double performanceThreshold = 85.0;

  List<Map<String, dynamic>> kpiMetrics = [
    {
      "name": "First Call Resolution",
      "current": 87.3,
      "target": 90.0,
      "previous": 84.1,
      "trend": "increasing",
      "unit": "%",
      "category": "quality",
      "benchmark": 88.5
    },
    {
      "name": "Average Response Time",
      "current": 2.4,
      "target": 2.0,
      "previous": 2.8,
      "trend": "improving",
      "unit": "hours",
      "category": "efficiency",
      "benchmark": 2.2
    },
    {
      "name": "Customer Satisfaction",
      "current": 4.3,
      "target": 4.5,
      "previous": 4.1,
      "trend": "increasing",
      "unit": "stars",
      "category": "satisfaction",
      "benchmark": 4.4
    },
    {
      "name": "Job Completion Rate",
      "current": 94.7,
      "target": 96.0,
      "previous": 93.2,
      "trend": "increasing",
      "unit": "%",
      "category": "productivity",
      "benchmark": 95.5
    },
    {
      "name": "Technician Utilization",
      "current": 78.9,
      "target": 85.0,
      "previous": 76.3,
      "trend": "increasing",
      "unit": "%",
      "category": "efficiency",
      "benchmark": 82.1
    },
    {
      "name": "Revenue per Job",
      "current": 245.80,
      "target": 260.0,
      "previous": 232.50,
      "trend": "increasing",
      "unit": "\$",
      "category": "financial",
      "benchmark": 251.20
    }
  ];

  List<Map<String, dynamic>> technicianMetrics = [
    {
      "name": "Mike Chen",
      "efficiency": 96.5,
      "quality": 94.2,
      "satisfaction": 4.8,
      "utilization": 89.2,
      "jobs_completed": 67,
      "avg_time_per_job": 2.1,
      "revenue_generated": 8940.0,
      "target_achievement": 108.3,
      "ranking": 1,
      "specialization": "HVAC"
    },
    {
      "name": "Lisa Wang",
      "efficiency": 98.1,
      "quality": 96.8,
      "satisfaction": 4.9,
      "utilization": 92.4,
      "jobs_completed": 72,
      "avg_time_per_job": 1.9,
      "revenue_generated": 9860.0,
      "target_achievement": 112.7,
      "ranking": 1,
      "specialization": "Electrical"
    },
    {
      "name": "Alex Rodriguez",
      "efficiency": 91.3,
      "quality": 88.7,
      "satisfaction": 4.4,
      "utilization": 85.7,
      "jobs_completed": 58,
      "avg_time_per_job": 2.3,
      "revenue_generated": 7120.0,
      "target_achievement": 95.8,
      "ranking": 3,
      "specialization": "General"
    },
    {
      "name": "John Smith",
      "efficiency": 78.9,
      "quality": 72.4,
      "satisfaction": 3.2,
      "utilization": 73.6,
      "jobs_completed": 45,
      "avg_time_per_job": 3.1,
      "revenue_generated": 5230.0,
      "target_achievement": 68.9,
      "ranking": 4,
      "specialization": "Plumbing"
    }
  ];

  List<Map<String, dynamic>> departmentMetrics = [
    {
      "department": "HVAC Services",
      "efficiency": 89.3,
      "quality": 91.2,
      "satisfaction": 4.4,
      "revenue": 67890.0,
      "jobs": 276,
      "technicians": 12,
      "avg_job_duration": 2.8,
      "target_achievement": 94.7,
      "trend": "stable"
    },
    {
      "department": "Electrical Services",
      "efficiency": 92.1,
      "quality": 94.5,
      "satisfaction": 4.6,
      "revenue": 58340.0,
      "jobs": 238,
      "technicians": 10,
      "avg_job_duration": 2.2,
      "target_achievement": 103.2,
      "trend": "increasing"
    },
    {
      "department": "Plumbing Services",
      "efficiency": 82.7,
      "quality": 79.3,
      "satisfaction": 3.9,
      "revenue": 45670.0,
      "jobs": 186,
      "technicians": 8,
      "avg_job_duration": 3.4,
      "target_achievement": 78.1,
      "trend": "decreasing"
    },
    {
      "department": "General Maintenance",
      "efficiency": 85.9,
      "quality": 87.1,
      "satisfaction": 4.2,
      "revenue": 34120.0,
      "jobs": 139,
      "technicians": 6,
      "avg_job_duration": 2.6,
      "target_achievement": 88.4,
      "trend": "stable"
    }
  ];

  List<Map<String, dynamic>> performanceGoals = [
    {
      "metric": "Customer Satisfaction",
      "current": 4.3,
      "target": 4.5,
      "deadline": "End of Q1",
      "progress": 75.6,
      "initiatives": ["Training program", "Process improvement", "Quality audits"]
    },
    {
      "metric": "First Call Resolution",
      "current": 87.3,
      "target": 90.0,
      "deadline": "End of Q2",
      "progress": 83.2,
      "initiatives": ["Better diagnostic tools", "Enhanced training", "Knowledge base"]
    },
    {
      "metric": "Response Time",
      "current": 2.4,
      "target": 2.0,
      "deadline": "End of Q1",
      "progress": 60.0,
      "initiatives": ["Route optimization", "Staff scheduling", "Emergency protocols"]
    }
  ];

  Color _getPerformanceColor(double value, double target) {
    double percentage = (value / target) * 100;
    if (percentage >= 100) return successColor;
    if (percentage >= 80) return warningColor;
    return dangerColor;
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "increasing":
      case "improving": return successColor;
      case "decreasing": return dangerColor;
      default: return warningColor;
    }
  }

  Widget _buildKPIOverview() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Period Filter
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: [
                    {"label": "This Week", "value": "this_week"},
                    {"label": "This Month", "value": "this_month"},
                    {"label": "Last Quarter", "value": "last_quarter"},
                    {"label": "This Year", "value": "this_year"},
                  ],
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // KPI Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: kpiMetrics.map((kpi) {
              double current = kpi["current"] as double;
              double target = kpi["target"] as double;
              double previous = kpi["previous"] as double;
              double benchmark = kpi["benchmark"] as double;
              
              Color performanceColor = _getPerformanceColor(current, target);
              Color trendColor = _getTrendColor("${kpi["trend"]}");
              
              double change = current - previous;
              String changeText = kpi["trend"] == "improving" && kpi["unit"] == "hours" 
                  ? "${change.toStringAsFixed(1)}h"
                  : "+${change.toStringAsFixed(1)}${kpi["unit"]}";
              
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: performanceColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${kpi["name"]}",
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
                            color: trendColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            changeText,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: trendColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Text(
                          "${kpi["unit"] == "\$" ? "\$" : ""}${current.toStringAsFixed(kpi["unit"] == "\$" ? 2 : 1)}${kpi["unit"] != "\$" && kpi["unit"] != "stars" ? kpi["unit"] : ""}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: performanceColor,
                          ),
                        ),
                        if (kpi["unit"] == "stars")
                          Text(
                            " ⭐",
                            style: TextStyle(fontSize: fsH4),
                          ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    // Progress Bar
                    LinearProgressIndicator(
                      value: kpi["unit"] == "hours" 
                          ? (target / current).clamp(0.0, 1.0)
                          : (current / target).clamp(0.0, 1.0),
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation(performanceColor),
                    ),
                    SizedBox(height: spXs),
                    
                    Row(
                      children: [
                        Text(
                          "Target: ${kpi["unit"] == "\$" ? "\$" : ""}${target.toStringAsFixed(kpi["unit"] == "\$" ? 0 : 1)}${kpi["unit"] != "\$" && kpi["unit"] != "stars" ? kpi["unit"] : ""}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        if (enableBenchmarking)
                          Text(
                            "Industry: ${benchmark.toStringAsFixed(1)}${kpi["unit"] != "\$" && kpi["unit"] != "stars" ? kpi["unit"] : ""}",
                            style: TextStyle(
                              fontSize: 11,
                              color: infoColor,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Performance Goals
          Container(
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
                  "Performance Goals",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                ...performanceGoals.map((goal) {
                  double progress = goal["progress"] as double;
                  Color progressColor = progress >= 80 ? successColor : 
                                       progress >= 60 ? warningColor : dangerColor;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: progressColor.withAlpha(15),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${goal["metric"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "${goal["deadline"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        
                        Row(
                          children: [
                            Text(
                              "Current: ${goal["current"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Target: ${goal["target"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${progress.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: progressColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        
                        LinearProgressIndicator(
                          value: progress / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation(progressColor),
                        ),
                        SizedBox(height: spSm),
                        
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (goal["initiatives"] as List).map((initiative) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$initiative",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
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
    );
  }

  Widget _buildTeamPerformance() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Team Leaderboard
          Container(
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
                  "Team Performance Rankings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                ...technicianMetrics.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> tech = entry.value;
                  
                  Color rankColor = index == 0 ? Colors.amber :
                                   index == 1 ? Colors.grey[400]! :
                                   index == 2 ? Colors.brown[300]! : primaryColor;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: rankColor.withAlpha(15),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: rankColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: rankColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                                "${tech["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${tech["specialization"]} • ${tech["jobs_completed"]} jobs",
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
                              "${(tech["target_achievement"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: (tech["target_achievement"] as double) >= 100 ? successColor : warningColor,
                              ),
                            ),
                            Text(
                              "\$${((tech["revenue_generated"] as double) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
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

          // Individual Performance Details
          ...technicianMetrics.map((tech) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Header
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColor.withAlpha(25),
                        child: Text(
                          "${tech["name"]}".split(" ").map((n) => n[0]).join(""),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${tech["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${tech["specialization"]} Specialist",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: (tech["target_achievement"] as double) >= 100 ? successColor.withAlpha(25) : warningColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Rank #${tech["ranking"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: (tech["target_achievement"] as double) >= 100 ? successColor : warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Performance Metrics
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildMetricCard("Efficiency", "${(tech["efficiency"] as double).toStringAsFixed(1)}%", successColor),
                      _buildMetricCard("Quality", "${(tech["quality"] as double).toStringAsFixed(1)}%", infoColor),
                      _buildMetricCard("Satisfaction", "${(tech["satisfaction"] as double).toStringAsFixed(1)} ⭐", warningColor),
                      _buildMetricCard("Utilization", "${(tech["utilization"] as double).toStringAsFixed(1)}%", primaryColor),
                    ],
                  ),
                  SizedBox(height: spSm),

                  // Additional Stats
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Avg Time/Job: ${(tech["avg_time_per_job"] as double).toStringAsFixed(1)}h",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "Revenue: \$${((tech["revenue_generated"] as double) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
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
    );
  }

  Widget _buildDepartmentAnalytics() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Department Performance Cards
          ...departmentMetrics.map((dept) {
            Color trendColor = _getTrendColor("${dept["trend"]}");
            double achievement = dept["target_achievement"] as double;
            Color achievementColor = achievement >= 100 ? successColor :
                                   achievement >= 80 ? warningColor : dangerColor;
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: achievementColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${dept["department"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${dept["technicians"]} technicians • ${dept["jobs"]} jobs",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: achievementColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${achievement.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: achievementColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Key Metrics
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildDeptMetric("Efficiency", "${(dept["efficiency"] as double).toStringAsFixed(1)}%", successColor),
                      _buildDeptMetric("Quality", "${(dept["quality"] as double).toStringAsFixed(1)}%", infoColor),
                      _buildDeptMetric("Satisfaction", "${(dept["satisfaction"] as double).toStringAsFixed(1)} ⭐", warningColor),
                      _buildDeptMetric("Revenue", "\$${((dept["revenue"] as double) / 1000).toStringAsFixed(0)}K", primaryColor),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Additional Info
                  Row(
                    children: [
                      Icon(
                        dept["trend"] == "increasing" ? Icons.trending_up :
                        dept["trend"] == "decreasing" ? Icons.trending_down : Icons.trending_flat,
                        color: trendColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Trend: ${dept["trend"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: trendColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Avg Duration: ${(dept["avg_job_duration"] as double).toStringAsFixed(1)}h",
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

          // Performance Settings
          Container(
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
                  "Performance Settings",
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
                      child: Text(
                        "Enable Benchmarking",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Switch(
                      value: enableBenchmarking,
                      onChanged: (value) {
                        enableBenchmarking = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Show Target Lines",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Switch(
                      value: showTargets,
                      onChanged: (value) {
                        showTargets = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),

                Text(
                  "Performance Threshold (%)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Slider(
                  value: performanceThreshold,
                  min: 50,
                  max: 100,
                  divisions: 50,
                  label: "${performanceThreshold.round()}%",
                  onChanged: (value) {
                    performanceThreshold = value;
                    setState(() {});
                  },
                ),
                Text(
                  "Performance below ${performanceThreshold.round()}% will be flagged",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Export Metrics",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Schedule Report",
                        icon: Icons.schedule,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeptMetric(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Performance Metrics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "KPIs", icon: Icon(Icons.dashboard)),
        Tab(text: "Team", icon: Icon(Icons.people)),
        Tab(text: "Departments", icon: Icon(Icons.business)),
      ],
      tabChildren: [
        _buildKPIOverview(),
        _buildTeamPerformance(),
        _buildDepartmentAnalytics(),
      ],
    );
  }
}
