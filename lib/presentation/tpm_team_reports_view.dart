import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTeamReportsView extends StatefulWidget {
  const TpmTeamReportsView({super.key});

  @override
  State<TpmTeamReportsView> createState() => _TpmTeamReportsViewState();
}

class _TpmTeamReportsViewState extends State<TpmTeamReportsView> {
  String selectedTeam = "all";
  String selectedPeriod = "this_month";
  String selectedMetric = "productivity";
  bool showIndividualStats = false;

  List<Map<String, dynamic>> teams = [
    {"label": "All Teams", "value": "all"},
    {"label": "Development Team", "value": "development"},
    {"label": "Design Team", "value": "design"},
    {"label": "QA Team", "value": "qa"},
    {"label": "DevOps Team", "value": "devops"},
    {"label": "Product Team", "value": "product"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "This Week", "value": "this_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "This Quarter", "value": "this_quarter"},
    {"label": "This Year", "value": "this_year"},
  ];

  List<Map<String, dynamic>> metrics = [
    {"label": "Productivity", "value": "productivity"},
    {"label": "Attendance", "value": "attendance"},
    {"label": "Performance", "value": "performance"},
    {"label": "Collaboration", "value": "collaboration"},
  ];

  List<Map<String, dynamic>> teamData = [
    {
      "id": "dev_team",
      "name": "Development Team",
      "members": 15,
      "lead": "Sarah Johnson",
      "productivity": 92,
      "attendance": 96,
      "performance": 4.6,
      "collaboration": 4.4,
      "tasksCompleted": 187,
      "totalTasks": 203,
      "averageHours": 42.5,
      "overtimeHours": 8.5,
      "projectsActive": 5,
      "satisfaction": 4.3,
      "color": primaryColor,
    },
    {
      "id": "design_team",
      "name": "Design Team",
      "members": 8,
      "lead": "Mike Chen",
      "productivity": 88,
      "attendance": 94,
      "performance": 4.5,
      "collaboration": 4.7,
      "tasksCompleted": 95,
      "totalTasks": 108,
      "averageHours": 40.2,
      "overtimeHours": 4.2,
      "projectsActive": 3,
      "satisfaction": 4.5,
      "color": successColor,
    },
    {
      "id": "qa_team",
      "name": "QA Team",
      "members": 6,
      "lead": "Alex Rodriguez",
      "productivity": 95,
      "attendance": 98,
      "performance": 4.7,
      "collaboration": 4.2,
      "tasksCompleted": 142,
      "totalTasks": 150,
      "averageHours": 41.8,
      "overtimeHours": 6.8,
      "projectsActive": 4,
      "satisfaction": 4.1,
      "color": warningColor,
    },
    {
      "id": "devops_team",
      "name": "DevOps Team",
      "members": 4,
      "lead": "Emma Wilson",
      "productivity": 90,
      "attendance": 97,
      "performance": 4.8,
      "collaboration": 4.3,
      "tasksCompleted": 68,
      "totalTasks": 75,
      "averageHours": 44.3,
      "overtimeHours": 12.3,
      "projectsActive": 6,
      "satisfaction": 4.0,
      "color": infoColor,
    },
    {
      "id": "product_team",
      "name": "Product Team",
      "members": 5,
      "lead": "James Brown",
      "productivity": 85,
      "attendance": 95,
      "performance": 4.4,
      "collaboration": 4.6,
      "tasksCompleted": 52,
      "totalTasks": 61,
      "averageHours": 43.1,
      "overtimeHours": 7.1,
      "projectsActive": 3,
      "satisfaction": 4.2,
      "color": secondaryColor,
    },
  ];

  List<Map<String, dynamic>> individualMembers = [
    {
      "name": "Sarah Johnson",
      "role": "Senior Developer",
      "team": "Development",
      "productivity": 95,
      "tasksCompleted": 24,
      "hoursWorked": 168,
      "performance": 4.8,
      "avatar": "SJ",
    },
    {
      "name": "Mike Chen",
      "role": "UI/UX Designer",
      "team": "Design",
      "productivity": 92,
      "tasksCompleted": 18,
      "hoursWorked": 160,
      "performance": 4.6,
      "avatar": "MC",
    },
    {
      "name": "Alex Rodriguez",
      "role": "QA Engineer",
      "team": "QA",
      "productivity": 98,
      "tasksCompleted": 32,
      "hoursWorked": 172,
      "performance": 4.9,
      "avatar": "AR",
    },
    {
      "name": "Emma Wilson",
      "role": "DevOps Engineer",
      "team": "DevOps",
      "productivity": 93,
      "tasksCompleted": 21,
      "hoursWorked": 176,
      "performance": 4.7,
      "avatar": "EW",
    },
    {
      "name": "James Brown",
      "role": "Product Manager",
      "team": "Product",
      "productivity": 87,
      "tasksCompleted": 16,
      "hoursWorked": 164,
      "performance": 4.5,
      "avatar": "JB",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              showIndividualStats = !showIndividualStats;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Team reports exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildFilters(),
            _buildTeamOverview(),
            if (showIndividualStats) _buildIndividualStats() else _buildTeamStats(),
            _buildPerformanceMetrics(),
            _buildProductivityChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Team Analysis Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
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
                  label: "Period",
                  items: periods,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Primary Metric",
            items: metrics,
            value: selectedMetric,
            onChanged: (value, label) {
              selectedMetric = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeamOverview() {
    int totalMembers = teamData.fold(0, (sum, team) => sum + (team["members"] as int));
    double avgProductivity = teamData.fold(0.0, (sum, team) => sum + (team["productivity"] as int)) / teamData.length;
    int totalTasks = teamData.fold(0, (sum, team) => sum + (team["tasksCompleted"] as int));
    double avgSatisfaction = teamData.fold(0.0, (sum, team) => sum + (team["satisfaction"] as double)) / teamData.length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spXs,
              children: [
                Icon(Icons.people, color: primaryColor, size: 32),
                Text(
                  "Total Members",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "$totalMembers",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spXs,
              children: [
                Icon(Icons.trending_up, color: successColor, size: 32),
                Text(
                  "Avg Productivity",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "${avgProductivity.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spXs,
              children: [
                Icon(Icons.task, color: warningColor, size: 32),
                Text(
                  "Tasks Completed",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "$totalTasks",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spXs,
              children: [
                Icon(Icons.star, color: infoColor, size: 32),
                Text(
                  "Avg Satisfaction",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "${avgSatisfaction.toStringAsFixed(1)}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTeamStats() {
    List<Map<String, dynamic>> filteredTeams = selectedTeam == "all" 
        ? teamData 
        : teamData.where((team) => team["id"] == selectedTeam).toList();

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: filteredTeams.map((team) {
        return Container(
          padding: EdgeInsets.all(spMd),
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
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (team["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.group,
                      color: team["color"] as Color,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${team["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Lead: ${team["lead"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${team["members"]} members",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: team["color"] as Color,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTeamMetric("Productivity", "${team["productivity"]}%", team["color"] as Color),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildTeamMetric("Attendance", "${team["attendance"]}%", successColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTeamMetric("Performance", "${(team["performance"] as double).toStringAsFixed(1)}/5", warningColor),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildTeamMetric("Satisfaction", "${(team["satisfaction"] as double).toStringAsFixed(1)}/5", infoColor),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (team["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Tasks: ${team["tasksCompleted"]}/${team["totalTasks"]}",
                          style: TextStyle(fontSize: 12),
                        ),
                        Spacer(),
                        Text(
                          "${(((team["tasksCompleted"] as int) / (team["totalTasks"] as int)) * 100).toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: team["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: (team["tasksCompleted"] as int) / (team["totalTasks"] as int),
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(team["color"] as Color),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Active Projects: ${team["projectsActive"]}",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                  Spacer(),
                  Text(
                    "${(team["averageHours"] as double).toStringAsFixed(1)}h avg",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    ss("Viewing details for ${team["name"]}");
                  },
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTeamMetric(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
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
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndividualStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Individual Team Member Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...individualMembers.map((member) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Center(
                      child: Text(
                        "${member["avatar"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                          "${member["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${member["role"]} • ${member["team"]} Team",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "Productivity: ${member["productivity"]}%",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Tasks: ${member["tasksCompleted"]}",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${member["hoursWorked"]}h",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 12,
                            color: index < (member["performance"] as double).floor()
                                ? warningColor
                                : disabledColor,
                          );
                        }),
                      ),
                      Text(
                        "${(member["performance"] as double).toStringAsFixed(1)}/5",
                        style: TextStyle(
                          fontSize: 10,
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
    );
  }

  Widget _buildPerformanceMetrics() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Team Performance Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...teamData.map((team) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: (team["color"] as Color).withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: team["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${team["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "${team["productivity"]}%",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: team["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: (team["productivity"] as int) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(team["color"] as Color),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildProductivityChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                label: "Generate Report",
                size: bs.sm,
                icon: Icons.analytics,
                onPressed: () {
                  ss("Generating detailed productivity report");
                },
              ),
            ],
          ),
          Container(
            height: 200,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.show_chart,
                  size: 64,
                  color: primaryColor.withAlpha(100),
                ),
                SizedBox(height: spSm),
                Text(
                  "Team Productivity Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Interactive chart showing productivity metrics over time",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Export Data",
                  size: bs.sm,
                  icon: Icons.download,
                  onPressed: () {
                    ss("Team productivity data exported");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Schedule Review",
                  size: bs.sm,
                  icon: Icons.schedule,
                  onPressed: () {
                    ss("Team review meeting scheduled");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
