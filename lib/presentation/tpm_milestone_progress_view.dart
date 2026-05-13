import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmMilestoneProgressView extends StatefulWidget {
  const TpmMilestoneProgressView({super.key});

  @override
  State<TpmMilestoneProgressView> createState() => _TpmMilestoneProgressViewState();
}

class _TpmMilestoneProgressViewState extends State<TpmMilestoneProgressView> {
  String selectedTimeRange = "30";
  String selectedProject = "";
  
  List<Map<String, dynamic>> timeRangeOptions = [
    {"label": "Last 7 Days", "value": "7"},
    {"label": "Last 30 Days", "value": "30"},
    {"label": "Last 90 Days", "value": "90"},
    {"label": "This Year", "value": "365"},
  ];

  List<Map<String, dynamic>> projectOptions = [
    {"label": "All Projects", "value": ""},
    {"label": "Mobile App Development", "value": "mobile_app"},
    {"label": "Website Redesign", "value": "website_redesign"},
    {"label": "Backend System", "value": "backend_system"},
    {"label": "Documentation Portal", "value": "documentation"},
  ];

  List<Map<String, dynamic>> milestones = [
    {
      "id": 1,
      "title": "Phase 1 Completion",
      "project": "Mobile App Development",
      "status": "completed",
      "progress": 100,
      "dueDate": "2025-05-15",
      "completedDate": "2025-05-12",
      "budget": 50000.0,
      "spent": 48000.0,
      "tasks": 12,
      "completedTasks": 12,
      "onTime": true,
      "color": successColor,
    },
    {
      "id": 2,
      "title": "UI/UX Design Review",
      "project": "Website Redesign",
      "status": "in_progress",
      "progress": 75,
      "dueDate": "2025-06-20",
      "budget": 25000.0,
      "spent": 18000.0,
      "tasks": 8,
      "completedTasks": 6,
      "onTime": true,
      "color": warningColor,
    },
    {
      "id": 3,
      "title": "API Integration",
      "project": "Backend System",
      "status": "in_progress",
      "progress": 45,
      "dueDate": "2025-07-10",
      "budget": 75000.0,
      "spent": 35000.0,
      "tasks": 15,
      "completedTasks": 7,
      "onTime": false,
      "color": dangerColor,
    },
    {
      "id": 4,
      "title": "Testing & QA",
      "project": "Mobile App Development",
      "status": "in_progress",
      "progress": 30,
      "dueDate": "2025-06-25",
      "budget": 30000.0,
      "spent": 12000.0,
      "tasks": 20,
      "completedTasks": 6,
      "onTime": true,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> progressHistory = [
    {"date": "2025-06-01", "completed": 1, "inProgress": 2, "pending": 3},
    {"date": "2025-06-05", "completed": 1, "inProgress": 3, "pending": 2},
    {"date": "2025-06-10", "completed": 2, "inProgress": 2, "pending": 2},
    {"date": "2025-06-15", "completed": 2, "inProgress": 3, "pending": 1},
    {"date": "2025-06-19", "completed": 2, "inProgress": 3, "pending": 1},
  ];

  List<Map<String, dynamic>> get filteredMilestones {
    return milestones.where((milestone) {
      bool matchesProject = selectedProject.isEmpty || milestone["project"].toString().contains(selectedProject);
      return matchesProject;
    }).toList();
  }

  Map<String, dynamic> get overallStats {
    List<Map<String, dynamic>> filtered = filteredMilestones;
    int total = filtered.length;
    int completed = filtered.where((m) => m["status"] == "completed").length;
    int inProgress = filtered.where((m) => m["status"] == "in_progress").length;
    int pending = filtered.where((m) => m["status"] == "pending").length;
    int onTime = filtered.where((m) => m["onTime"] == true).length;
    
    double totalBudget = filtered.fold(0.0, (sum, m) => sum + (m["budget"] as double));
    double totalSpent = filtered.fold(0.0, (sum, m) => sum + (m["spent"] as double));
    
    int totalTasks = filtered.fold(0, (sum, m) => sum + (m["tasks"] as int));
    int totalCompletedTasks = filtered.fold(0, (sum, m) => sum + (m["completedTasks"] as int));
    
    return {
      "total": total,
      "completed": completed,
      "inProgress": inProgress,
      "pending": pending,
      "onTime": onTime,
      "completionRate": total > 0 ? (completed / total * 100).round() : 0,
      "taskCompletionRate": totalTasks > 0 ? (totalCompletedTasks / totalTasks * 100).round() : 0,
      "budgetUtilization": totalBudget > 0 ? (totalSpent / totalBudget * 100).round() : 0,
      "totalBudget": totalBudget,
      "totalSpent": totalSpent,
    };
  }

  String getStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "in_progress":
        return "In Progress";
      case "pending":
        return "Pending";
      default:
        return "Unknown";
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "pending":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildStatCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          top: BorderSide(width: 3, color: color),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressChart() {
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
            "Progress Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: progressHistory.map((data) {
                int total = (data["completed"] as int) + (data["inProgress"] as int) + (data["pending"] as int);
                int completed = data["completed"] as int;
                int inProgress = data["inProgress"] as int;
                
                double completedHeight = total > 0 ? (completed / total) * 150 : 0;
                double inProgressHeight = total > 0 ? (inProgress / total) * 150 : 0;
                double pendingHeight = 150 - completedHeight - inProgressHeight;
                
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (pendingHeight > 0)
                      Container(
                        width: 30,
                        height: pendingHeight,
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(100),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXs)),
                        ),
                      ),
                    if (inProgressHeight > 0)
                      Container(
                        width: 30,
                        height: inProgressHeight,
                        color: warningColor.withAlpha(100),
                      ),
                    if (completedHeight > 0)
                      Container(
                        width: 30,
                        height: completedHeight,
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(100),
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusXs)),
                        ),
                      ),
                    SizedBox(height: spXs),
                    Text(
                      "${DateTime.parse(data["date"]).day}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(100),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Completed",
                    style: TextStyle(fontSize: 10, color: disabledBoldColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(100),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "In Progress",
                    style: TextStyle(fontSize: 10, color: disabledBoldColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(100),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Pending",
                    style: TextStyle(fontSize: 10, color: disabledBoldColor),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneProgress(Map<String, dynamic> milestone) {
    double budgetProgress = ((milestone["spent"] as double) / (milestone["budget"] as double)) * 100;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: milestone["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${milestone["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: getStatusColor(milestone["status"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  getStatusText(milestone["status"]),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: getStatusColor(milestone["status"]),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${milestone["project"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          
          // Progress Metrics
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Overall Progress",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: (milestone["progress"] as int) / 100,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              milestone["color"] as Color,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${milestone["progress"]}%",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Tasks and Budget
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Tasks",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${milestone["completedTasks"]}/${milestone["tasks"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Budget Used",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${budgetProgress.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: budgetProgress > 80 ? dangerColor : warningColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Timeline",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          milestone["onTime"] ? Icons.check_circle : Icons.warning,
                          size: 14,
                          color: milestone["onTime"] ? successColor : dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          milestone["onTime"] ? "On Track" : "At Risk",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: milestone["onTime"] ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 12,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Due: ${DateTime.parse(milestone["dueDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              if (milestone["status"] == "completed") ...[
                Spacer(),
                Icon(
                  Icons.check_circle,
                  size: 12,
                  color: successColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Completed: ${DateTime.parse(milestone["completedDate"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 11,
                    color: successColor,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> stats = overallStats;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Milestone Progress"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo detailed analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Time Range",
                      items: timeRangeOptions,
                      value: selectedTimeRange,
                      onChanged: (value, label) {
                        selectedTimeRange = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Project Filter",
                      items: projectOptions,
                      value: selectedProject,
                      onChanged: (value, label) {
                        selectedProject = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Overall Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard(
                  "Completion Rate",
                  "${stats["completionRate"]}%",
                  "${stats["completed"]} of ${stats["total"]} milestones",
                  successColor,
                  Icons.check_circle,
                ),
                _buildStatCard(
                  "Task Progress",
                  "${stats["taskCompletionRate"]}%",
                  "Overall task completion",
                  infoColor,
                  Icons.task_alt,
                ),
                _buildStatCard(
                  "Budget Usage",
                  "${stats["budgetUtilization"]}%",
                  "\$${(stats["totalSpent"] as double).currency} spent",
                  warningColor,
                  Icons.account_balance_wallet,
                ),
                _buildStatCard(
                  "On Time",
                  "${stats["onTime"]}",
                  "Milestones on track",
                  primaryColor,
                  Icons.schedule,
                ),
              ],
            ),

            // Progress Chart
            _buildProgressChart(),

            // Status Distribution
            Container(
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
                    "Status Distribution",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: stats["completed"] as int,
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusXs)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: stats["inProgress"] as int,
                        child: Container(
                          height: 8,
                          color: warningColor,
                        ),
                      ),
                      Expanded(
                        flex: stats["pending"] as int,
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(radiusXs)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Completed (${stats["completed"]})",
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
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "In Progress (${stats["inProgress"]})",
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
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Pending (${stats["pending"]})",
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
                ],
              ),
            ),

            // Individual Milestone Progress
            Text(
              "Milestone Details",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredMilestones.map((milestone) {
              return _buildMilestoneProgress(milestone);
            }).toList(),

            if (filteredMilestones.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.analytics,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No milestones found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Adjust your filters to view milestone progress",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
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
