import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmProgressReportsView extends StatefulWidget {
  const TpmProgressReportsView({super.key});

  @override
  State<TpmProgressReportsView> createState() => _TpmProgressReportsViewState();
}

class _TpmProgressReportsViewState extends State<TpmProgressReportsView> {
  String selectedProject = "all";
  String selectedTimeframe = "monthly";
  String selectedView = "overview";
  bool showDetailed = false;

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "Mobile App Development", "value": "mobile_app"},
    {"label": "Web Platform Redesign", "value": "web_platform"},
    {"label": "AI Integration", "value": "ai_integration"},
    {"label": "Cloud Migration", "value": "cloud_migration"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> views = [
    {"label": "Overview", "value": "overview"},
    {"label": "Milestones", "value": "milestones"},
    {"label": "Tasks", "value": "tasks"},
    {"label": "Timeline", "value": "timeline"},
  ];

  List<Map<String, dynamic>> progressData = [
    {
      "project": "Mobile App Development",
      "progress": 75,
      "status": "On Track",
      "dueDate": "2024-04-15",
      "completion": "Expected",
      "milestones": 8,
      "completedMilestones": 6,
      "tasks": 124,
      "completedTasks": 93,
      "team": 12,
      "budget": 180000,
      "spent": 135000,
      "velocity": 8.5,
      "risk": "Low",
      "color": successColor,
    },
    {
      "project": "Web Platform Redesign",
      "progress": 60,
      "status": "Behind Schedule",
      "dueDate": "2024-06-01",
      "completion": "Delayed",
      "milestones": 10,
      "completedMilestones": 5,
      "tasks": 156,
      "completedTasks": 87,
      "team": 15,
      "budget": 250000,
      "spent": 150000,
      "velocity": 6.2,
      "risk": "Medium",
      "color": warningColor,
    },
    {
      "project": "AI Integration",
      "progress": 90,
      "status": "Ahead of Schedule",
      "dueDate": "2024-03-30",
      "completion": "Early",
      "milestones": 6,
      "completedMilestones": 6,
      "tasks": 89,
      "completedTasks": 80,
      "team": 8,
      "budget": 160000,
      "spent": 144000,
      "velocity": 9.8,
      "risk": "Low",
      "color": primaryColor,
    },
    {
      "project": "Cloud Migration",
      "progress": 40,
      "status": "At Risk",
      "dueDate": "2024-08-01",
      "completion": "Critical",
      "milestones": 12,
      "completedMilestones": 4,
      "tasks": 203,
      "completedTasks": 81,
      "team": 20,
      "budget": 350000,
      "spent": 140000,
      "velocity": 4.1,
      "risk": "High",
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> milestoneData = [
    {
      "title": "UI/UX Design Complete",
      "project": "Mobile App Development",
      "dueDate": "2024-02-15",
      "status": "Completed",
      "completion": 100,
      "daysEarly": 3,
    },
    {
      "title": "Backend API Development",
      "project": "Mobile App Development",
      "dueDate": "2024-03-01",
      "status": "Completed",
      "completion": 100,
      "daysEarly": 0,
    },
    {
      "title": "Frontend Implementation",
      "project": "Mobile App Development",
      "dueDate": "2024-03-20",
      "status": "In Progress",
      "completion": 80,
      "daysEarly": null,
    },
    {
      "title": "Testing Phase",
      "project": "Mobile App Development",
      "dueDate": "2024-04-05",
      "status": "Pending",
      "completion": 0,
      "daysEarly": null,
    },
  ];

  List<Map<String, dynamic>> weeklyProgress = [
    {"week": "Week 1", "planned": 85, "actual": 92, "efficiency": 108},
    {"week": "Week 2", "planned": 90, "actual": 88, "efficiency": 98},
    {"week": "Week 3", "planned": 95, "actual": 97, "efficiency": 102},
    {"week": "Week 4", "planned": 100, "actual": 94, "efficiency": 94},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.view_timeline),
            onPressed: () {
              showDetailed = !showDetailed;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Progress reports exported successfully");
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
            _buildProgressOverview(),
            _buildProjectProgress(),
            if (showDetailed) _buildDetailedProgress(),
            _buildMilestoneTracking(),
            _buildProgressTrends(),
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
            "Progress Analysis Filters",
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
                  label: "Project",
                  items: projects,
                  value: selectedProject,
                  onChanged: (value, label) {
                    selectedProject = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Timeframe",
                  items: timeframes,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "View Type",
            items: views,
            value: selectedView,
            onChanged: (value, label) {
              selectedView = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProgressOverview() {
    double avgProgress = progressData.fold(0.0, (sum, item) => sum + (item["progress"] as int)) / progressData.length;
    int onTrackProjects = progressData.where((p) => p["status"] == "On Track" || p["status"] == "Ahead of Schedule").length;
    int totalMilestones = progressData.fold(0, (sum, item) => sum + (item["completedMilestones"] as int));
    double avgVelocity = progressData.fold(0.0, (sum, item) => sum + (item["velocity"] as double)) / progressData.length;

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
                Icon(Icons.trending_up, color: primaryColor, size: 32),
                Text(
                  "Avg Progress",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "${avgProgress.toStringAsFixed(0)}%",
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
                Icon(Icons.check_circle, color: successColor, size: 32),
                Text(
                  "On Track",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "$onTrackProjects/${progressData.length}",
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
                Icon(Icons.flag, color: warningColor, size: 32),
                Text(
                  "Milestones",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "$totalMilestones",
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
                Icon(Icons.speed, color: infoColor, size: 32),
                Text(
                  "Avg Velocity",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "${avgVelocity.toStringAsFixed(1)}",
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

  Widget _buildProjectProgress() {
    List<Map<String, dynamic>> filteredData = selectedProject == "all" 
        ? progressData 
        : progressData.where((p) => p["project"].toLowerCase().contains(selectedProject)).toList();

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: filteredData.map((project) {
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
                  Expanded(
                    child: Text(
                      "${project["project"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: project["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${project["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "Due: ${project["dueDate"]} • ${project["completion"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (project["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Overall Progress",
                          style: TextStyle(fontSize: 12),
                        ),
                        Spacer(),
                        Text(
                          "${project["progress"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: project["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: (project["progress"] as int) / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(project["color"] as Color),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildProgressMetric("Milestones", "${project["completedMilestones"]}/${project["milestones"]}", Icons.flag),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildProgressMetric("Tasks", "${project["completedTasks"]}/${project["tasks"]}", Icons.task),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildProgressMetric("Team", "${project["team"]}", Icons.group),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildProgressMetric("Velocity", "${(project["velocity"] as double).toStringAsFixed(1)}", Icons.speed),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: _getRiskColor(project["risk"] as String).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: _getRiskColor(project["risk"] as String)),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getRiskIcon(project["risk"] as String),
                      size: 16,
                      color: _getRiskColor(project["risk"] as String),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${project["risk"]} Risk",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getRiskColor(project["risk"] as String),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${((project["spent"] as int) / 1000).toStringAsFixed(0)}K / \$${((project["budget"] as int) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View Timeline",
                  size: bs.sm,
                  icon: Icons.timeline,
                  onPressed: () {
                    ss("Viewing timeline for ${project["project"]}");
                  },
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProgressMetric(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: disabledBoldColor),
          SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
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
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedProgress() {
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
            "Detailed Progress Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
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
                  Icons.analytics,
                  size: 64,
                  color: primaryColor.withAlpha(100),
                ),
                SizedBox(height: spSm),
                Text(
                  "Progress Analytics Chart",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Interactive visualization of project progress trends",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneTracking() {
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
            "Milestone Tracking",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...milestoneData.map((milestone) {
            Color statusColor = _getMilestoneStatusColor(milestone["status"] as String);
            IconData statusIcon = _getMilestoneStatusIcon(milestone["status"] as String);

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
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
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
                          "${milestone["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${milestone["project"]} • Due: ${milestone["dueDate"]}",
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${milestone["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (milestone["daysEarly"] != null)
                        Text(
                          "${(milestone["daysEarly"] as int) > 0 ? '${milestone["daysEarly"]} days early' : 'On time'}",
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

  Widget _buildProgressTrends() {
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
                "Weekly Progress Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Export Trends",
                size: bs.sm,
                icon: Icons.download,
                onPressed: () {
                  ss("Progress trends exported");
                },
              ),
            ],
          ),
          ...weeklyProgress.map((week) {
            bool isAboveTarget = (week["efficiency"] as int) >= 100;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: (isAboveTarget ? successColor : warningColor).withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Text(
                        "${week["week"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: isAboveTarget ? successColor : warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${week["efficiency"]}%",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Planned: ${week["planned"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Actual: ${week["actual"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: (week["efficiency"] as int) / 120, // Max 120% for display
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isAboveTarget ? successColor : warningColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Detailed Analysis",
                  size: bs.sm,
                  icon: Icons.analytics,
                  onPressed: () {
                    ss("Opening detailed progress analysis");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Schedule Review",
                  size: bs.sm,
                  icon: Icons.event,
                  onPressed: () {
                    ss("Progress review meeting scheduled");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getRiskColor(String risk) {
    switch (risk) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "High":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getRiskIcon(String risk) {
    switch (risk) {
      case "Low":
        return Icons.check_circle;
      case "Medium":
        return Icons.warning;
      case "High":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  Color _getMilestoneStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return primaryColor;
      case "Pending":
        return warningColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getMilestoneStatusIcon(String status) {
    switch (status) {
      case "Completed":
        return Icons.check_circle;
      case "In Progress":
        return Icons.play_circle;
      case "Pending":
        return Icons.schedule;
      case "Overdue":
        return Icons.error;
      default:
        return Icons.help;
    }
  }
}
