import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSummary6View extends StatefulWidget {
  @override
  State<GrlSummary6View> createState() => _GrlSummary6ViewState();
}

class _GrlSummary6ViewState extends State<GrlSummary6View> {
  List<Map<String, dynamic>> teamMetrics = [
    {
      "team": "Development",
      "members": 12,
      "productivity": 92.5,
      "projects": 8,
      "completed": 6,
      "manager": "Sarah Johnson",
      "color": primaryColor,
    },
    {
      "team": "Design",
      "members": 6,
      "productivity": 88.3,
      "projects": 5,
      "completed": 4,
      "manager": "Mike Chen",
      "color": infoColor,
    },
    {
      "team": "Marketing",
      "members": 9,
      "productivity": 85.7,
      "projects": 12,
      "completed": 9,
      "manager": "Emma Wilson",
      "color": successColor,
    },
    {
      "team": "Sales",
      "members": 15,
      "productivity": 91.2,
      "projects": 6,
      "completed": 5,
      "manager": "David Lee",
      "color": warningColor,
    },
    {
      "team": "Operations",
      "members": 8,
      "productivity": 89.4,
      "projects": 4,
      "completed": 3,
      "manager": "Lisa Brown",
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> performanceIndicators = [
    {
      "metric": "Team Satisfaction",
      "current": 4.2,
      "target": 4.5,
      "unit": "/5.0",
      "trend": "up",
      "change": 0.3,
    },
    {
      "metric": "Project Delivery",
      "current": 87.5,
      "target": 90.0,
      "unit": "%",
      "trend": "up",
      "change": 5.2,
    },
    {
      "metric": "Code Quality",
      "current": 94.8,
      "target": 95.0,
      "unit": "%",
      "trend": "up",
      "change": 2.1,
    },
    {
      "metric": "Client Satisfaction",
      "current": 4.6,
      "target": 4.8,
      "unit": "/5.0",
      "trend": "up",
      "change": 0.4,
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "activity": "Sprint Review Meeting",
      "team": "Development",
      "time": "2 hours ago",
      "status": "completed",
      "participants": 8,
    },
    {
      "activity": "Design System Update",
      "team": "Design",
      "time": "4 hours ago", 
      "status": "in_progress",
      "participants": 4,
    },
    {
      "activity": "Q4 Planning Session",
      "team": "Marketing",
      "time": "6 hours ago",
      "status": "completed",
      "participants": 12,
    },
    {
      "activity": "Client Presentation",
      "team": "Sales",
      "time": "1 day ago",
      "status": "completed",
      "participants": 6,
    },
    {
      "activity": "Process Optimization",
      "team": "Operations",
      "time": "2 days ago",
      "status": "pending",
      "participants": 5,
    },
  ];

  String selectedMetric = "productivity";

  @override
  Widget build(BuildContext context) {
    final totalMembers = teamMetrics.fold(0, (sum, team) => sum + (team["members"] as int));
    final avgProductivity = teamMetrics.fold(0.0, (sum, team) => sum + (team["productivity"] as double)) / teamMetrics.length;
    final totalProjects = teamMetrics.fold(0, (sum, team) => sum + (team["projects"] as int));
    final completedProjects = teamMetrics.fold(0, (sum, team) => sum + (team["completed"] as int));

    return Scaffold(
      appBar: AppBar(
        title: Text("Team Performance Summary"),
        actions: [
          Icon(Icons.analytics, color: primaryColor),
          SizedBox(width: spSm),
          Icon(Icons.people, color: primaryColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(179)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.groups, color: Colors.white, size: 28),
                      SizedBox(width: spSm),
                      Text(
                        "Team Overview",
                        style: TextStyle(
                          fontSize: fsH5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                              "Total Members",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "$totalMembers",
                              style: TextStyle(
                                fontSize: fsH4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                              "Avg Productivity",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "${avgProductivity.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: fsH4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                              "Project Success",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "${((completedProjects / totalProjects) * 100).toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: fsH4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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

            QCategoryPicker(
              items: [
                {"label": "Productivity", "value": "productivity"},
                {"label": "Projects", "value": "projects"},
                {"label": "Performance", "value": "performance"},
              ],
              value: selectedMetric,
              onChanged: (index, label, value, item) {
                selectedMetric = value;
                setState(() {});
              },
            ),

            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: performanceIndicators.map((indicator) {
                final isOnTarget = (indicator["current"] as double) >= (indicator["target"] as double);
                final progressPercent = ((indicator["current"] as double) / (indicator["target"] as double)).clamp(0.0, 1.0);
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${indicator["metric"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Icon(
                            indicator["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                            color: indicator["trend"] == "up" ? successColor : dangerColor,
                            size: 16,
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${indicator["current"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${indicator["unit"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progressPercent,
                          child: Container(
                            decoration: BoxDecoration(
                              color: isOnTarget ? successColor : warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Target: ${indicator["target"]}${indicator["unit"]}",
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

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Team Performance Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: teamMetrics.map((team) {
                      final completionRate = ((team["completed"] as int) / (team["projects"] as int)) * 100;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: (team["color"] as Color).withAlpha(26),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    Icons.groups,
                                    color: team["color"] as Color,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spSm),
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
                                        "Manager: ${team["manager"]}",
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
                                      "${team["productivity"]}%",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: team["color"] as Color,
                                      ),
                                    ),
                                    Text(
                                      "Productivity",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.people, color: disabledBoldColor, size: 14),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${team["members"]} members",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.assignment, color: disabledBoldColor, size: 14),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${team["completed"]}/${team["projects"]} projects",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${completionRate.toStringAsFixed(0)}% complete",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: completionRate >= 80 ? successColor : warningColor,
                                    fontWeight: FontWeight.w600,
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
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Team Activities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Icon(Icons.history, color: primaryColor, size: 20),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: recentActivities.map((activity) {
                      Color statusColor = successColor;
                      IconData statusIcon = Icons.check_circle;
                      
                      switch (activity["status"]) {
                        case "in_progress":
                          statusColor = warningColor;
                          statusIcon = Icons.access_time;
                          break;
                        case "pending":
                          statusColor = infoColor;
                          statusIcon = Icons.schedule;
                          break;
                        case "completed":
                          statusColor = successColor;
                          statusIcon = Icons.check_circle;
                          break;
                      }
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                statusIcon,
                                color: statusColor,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${activity["activity"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${activity["team"]} Team",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        " • ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${activity["participants"]} participants",
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
                            Text(
                              "${activity["time"]}",
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
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Team Reports",
                    icon: Icons.assessment,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Schedule 1:1s",
                    icon: Icons.calendar_today,
                    size: bs.md,
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
}
