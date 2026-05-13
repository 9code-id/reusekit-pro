import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmPerformanceMetricsView extends StatefulWidget {
  const CrmPerformanceMetricsView({super.key});

  @override
  State<CrmPerformanceMetricsView> createState() => _CrmPerformanceMetricsViewState();
}

class _CrmPerformanceMetricsViewState extends State<CrmPerformanceMetricsView> {
  String selectedPeriod = "30_days";
  String selectedDepartment = "all";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "Last 7 Days", "value": "7_days"},
    {"label": "Last 30 Days", "value": "30_days"},
    {"label": "Last 90 Days", "value": "90_days"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": "all"},
    {"label": "Sales", "value": "sales"},
    {"label": "Support", "value": "support"},
    {"label": "Marketing", "value": "marketing"},
  ];

  List<Map<String, dynamic>> kpiMetrics = [
    {
      "title": "Revenue Growth",
      "value": 18.5,
      "target": 15.0,
      "change": 3.5,
      "icon": Icons.trending_up,
      "color": Colors.green,
      "isPercentage": true,
    },
    {
      "title": "Customer Acquisition Cost",
      "value": 85.50,
      "target": 95.0,
      "change": -10.0,
      "icon": Icons.person_add,
      "color": Colors.blue,
      "prefix": "\$",
    },
    {
      "title": "Customer Lifetime Value",
      "value": 2850.0,
      "target": 2500.0,
      "change": 14.0,
      "icon": Icons.monetization_on,
      "color": Colors.purple,
      "prefix": "\$",
    },
    {
      "title": "Churn Rate",
      "value": 3.2,
      "target": 5.0,
      "change": -36.0,
      "icon": Icons.trending_down,
      "color": Colors.red,
      "isPercentage": true,
    },
  ];

  List<Map<String, dynamic>> departmentPerformance = [
    {
      "department": "Sales",
      "kpi": "Revenue Target",
      "current": 1285000.0,
      "target": 1200000.0,
      "progress": 107.1,
      "color": Colors.green,
      "icon": Icons.monetization_on,
    },
    {
      "department": "Support",
      "kpi": "Response Time",
      "current": 2.4,
      "target": 4.0,
      "progress": 60.0,
      "color": Colors.blue,
      "icon": Icons.support_agent,
      "unit": "hours",
    },
    {
      "department": "Marketing",
      "kpi": "Lead Generation",
      "current": 2450.0,
      "target": 2000.0,
      "progress": 122.5,
      "color": Colors.orange,
      "icon": Icons.campaign,
      "unit": "leads",
    },
    {
      "department": "Customer Success",
      "kpi": "Satisfaction Score",
      "current": 94.5,
      "target": 90.0,
      "progress": 105.0,
      "color": Colors.purple,
      "icon": Icons.sentiment_very_satisfied,
      "unit": "%",
    },
  ];

  List<Map<String, dynamic>> teamLeaderboard = [
    {
      "rank": 1,
      "name": "Sarah Johnson",
      "avatar": "SJ",
      "department": "Sales",
      "score": 98.5,
      "achievements": 12,
      "trend": "up",
    },
    {
      "rank": 2,
      "name": "Michael Chen",
      "avatar": "MC",
      "department": "Marketing",
      "score": 96.8,
      "achievements": 10,
      "trend": "up",
    },
    {
      "rank": 3,
      "name": "Emma Williams",
      "avatar": "EW",
      "department": "Support",
      "score": 95.2,
      "achievements": 9,
      "trend": "stable",
    },
    {
      "rank": 4,
      "name": "David Rodriguez",
      "avatar": "DR",
      "department": "Sales",
      "score": 93.7,
      "achievements": 8,
      "trend": "down",
    },
    {
      "rank": 5,
      "name": "Lisa Anderson",
      "avatar": "LA",
      "department": "Support",
      "score": 92.4,
      "achievements": 7,
      "trend": "up",
    },
  ];

  List<Map<String, dynamic>> performanceGoals = [
    {
      "goal": "Increase Monthly Revenue",
      "target": 1500000.0,
      "current": 1285000.0,
      "progress": 85.7,
      "deadline": "Dec 31, 2024",
      "status": "on_track",
    },
    {
      "goal": "Reduce Customer Churn",
      "target": 2.5,
      "current": 3.2,
      "progress": 78.1,
      "deadline": "Nov 30, 2024",
      "status": "behind",
      "isPercentage": true,
    },
    {
      "goal": "Improve Response Time",
      "target": 2.0,
      "current": 2.4,
      "progress": 83.3,
      "deadline": "Oct 31, 2024",
      "status": "on_track",
      "unit": "hours",
    },
    {
      "goal": "Customer Satisfaction Score",
      "target": 95.0,
      "current": 94.5,
      "progress": 99.5,
      "deadline": "Dec 31, 2024",
      "status": "ahead",
      "isPercentage": true,
    },
  ];

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Jul", "performance": 82.5},
    {"month": "Aug", "performance": 85.2},
    {"month": "Sep", "performance": 88.7},
    {"month": "Oct", "performance": 91.3},
    {"month": "Nov", "performance": 89.8},
    {"month": "Dec", "performance": 94.1},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "ahead":
        return Colors.green;
      case "on_track":
        return Colors.blue;
      case "behind":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      default:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up":
        return Colors.green;
      case "down":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildRankBadge(int rank) {
    Color badgeColor;
    switch (rank) {
      case 1:
        badgeColor = Colors.amber;
        break;
      case 2:
        badgeColor = Colors.grey.shade400;
        break;
      case 3:
        badgeColor = Colors.orange.shade400;
        break;
      default:
        badgeColor = Colors.blue;
    }

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          "$rank",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Performance Metrics"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Performance report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: periodItems,
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
                    items: departmentItems,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Key Performance Indicators
            Text(
              "Key Performance Indicators",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: kpiMetrics.map((kpi) {
                double progressPercentage = (kpi["value"] as double) / (kpi["target"] as double);
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
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (kpi["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              kpi["icon"] as IconData,
                              color: kpi["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: (kpi["change"] as double) > 0
                                  ? Colors.green.withAlpha(51)
                                  : Colors.red.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(kpi["change"] as double) >= 0 ? '+' : ''}${(kpi["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (kpi["change"] as double) > 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${kpi["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      RichText(
                        text: TextSpan(
                          children: [
                            if (kpi["prefix"] != null)
                              TextSpan(
                                text: "${kpi["prefix"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            TextSpan(
                              text: kpi["isPercentage"] == true
                                  ? "${(kpi["value"] as double).toStringAsFixed(1)}%"
                                  : kpi["prefix"] != null
                                      ? "${((kpi["value"] as double).toDouble()).currency}"
                                      : "${(kpi["value"] as double).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: progressPercentage > 1.0 ? 1.0 : progressPercentage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kpi["color"] as Color,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${(progressPercentage * 100).toStringAsFixed(0)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: kpi["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Department Performance
            Text(
              "Department Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: departmentPerformance.map((dept) {
                double progressPercentage = (dept["progress"] as double) / 100.0;
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (dept["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              dept["icon"] as IconData,
                              color: dept["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${dept["department"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${dept["kpi"]}",
                                  style: TextStyle(
                                    fontSize: 14,
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
                                dept["unit"] == "hours"
                                    ? "${(dept["current"] as double).toStringAsFixed(1)}h"
                                    : dept["unit"] == "%"
                                        ? "${(dept["current"] as double).toStringAsFixed(1)}%"
                                        : dept["unit"] == "leads"
                                            ? "${(dept["current"] as double).toInt()} leads"
                                            : "\$${((dept["current"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${(dept["progress"] as double).toStringAsFixed(0)}% of target",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: progressPercentage > 1.0 ? 1.0 : progressPercentage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: dept["color"] as Color,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${(dept["progress"] as double).toStringAsFixed(0)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: dept["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Team Leaderboard
            Text(
              "Team Leaderboard",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: teamLeaderboard.map((member) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      _buildRankBadge(member["rank"] as int),
                      SizedBox(width: spSm),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: primaryColor.withAlpha(51),
                        child: Text(
                          "${member["avatar"]}",
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
                              "${member["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${member["department"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(member["achievements"] as int)} achievements",
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
                          Row(
                            children: [
                              Text(
                                "${(member["score"] as double).toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Icon(
                                _getTrendIcon("${member["trend"]}"),
                                size: 16,
                                color: _getTrendColor("${member["trend"]}"),
                              ),
                            ],
                          ),
                          Text(
                            "Performance Score",
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
            ),
            SizedBox(height: spLg),

            // Performance Goals
            Text(
              "Performance Goals",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: performanceGoals.map((goal) {
                double progressPercentage = (goal["progress"] as double) / 100.0;
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${goal["goal"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Deadline: ${goal["deadline"]}",
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
                              color: _getStatusColor("${goal["status"]}").withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${goal["status"]}".replaceAll("_", " ").toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${goal["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "Current: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            goal["isPercentage"] == true
                                ? "${(goal["current"] as double).toStringAsFixed(1)}%"
                                : goal["unit"] == "hours"
                                    ? "${(goal["current"] as double).toStringAsFixed(1)} hours"
                                    : "\$${((goal["current"] as double).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Target: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            goal["isPercentage"] == true
                                ? "${(goal["target"] as double).toStringAsFixed(1)}%"
                                : goal["unit"] == "hours"
                                    ? "${(goal["target"] as double).toStringAsFixed(1)} hours"
                                    : "\$${((goal["target"] as double).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: progressPercentage > 1.0 ? 1.0 : progressPercentage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _getStatusColor("${goal["status"]}"),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${(goal["progress"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor("${goal["status"]}"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Monthly Performance Trends
            Text(
              "Monthly Performance Trends",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Overall Performance Score",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spLg),
                  QHorizontalScroll(
                    children: monthlyTrends.map((trend) {
                      return Container(
                        width: 80,
                        margin: EdgeInsets.only(right: spSm),
                        child: Column(
                          children: [
                            Text(
                              "${trend["month"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Container(
                              height: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 20,
                                    height: (trend["performance"] as double) * 0.6,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${(trend["performance"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
