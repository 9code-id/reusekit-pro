import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaTaskProgressView extends StatefulWidget {
  const ComaTaskProgressView({Key? key}) : super(key: key);

  @override
  State<ComaTaskProgressView> createState() => _ComaTaskProgressViewState();
}

class _ComaTaskProgressViewState extends State<ComaTaskProgressView> {
  String selectedProject = "all";
  String selectedTimeframe = "week";
  String selectedPhase = "all";
  bool loading = false;

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "Metro Downtown Complex", "value": "PRJ-001"},
    {"label": "Riverside Office Park", "value": "PRJ-002"},
    {"label": "Healthcare Facility", "value": "PRJ-003"},
    {"label": "Residential Tower A", "value": "PRJ-004"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "All Time", "value": "all"},
  ];

  List<Map<String, dynamic>> phases = [
    {"label": "All Phases", "value": "all"},
    {"label": "Foundation", "value": "foundation"},
    {"label": "Structure", "value": "structure"},
    {"label": "MEP Systems", "value": "mep"},
    {"label": "Finishing", "value": "finishing"},
  ];

  List<Map<String, dynamic>> projectProgress = [
    {
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "overall_progress": 75,
      "phases": [
        {"name": "Foundation", "progress": 100, "status": "completed", "start_date": "2024-01-15", "end_date": "2024-03-30"},
        {"name": "Structure", "progress": 85, "status": "in_progress", "start_date": "2024-03-01", "end_date": "2024-07-15"},
        {"name": "MEP Systems", "progress": 45, "status": "in_progress", "start_date": "2024-06-01", "end_date": "2024-09-30"},
        {"name": "Finishing", "progress": 0, "status": "pending", "start_date": "2024-09-01", "end_date": "2024-12-15"},
      ],
      "total_tasks": 245,
      "completed_tasks": 184,
      "in_progress_tasks": 38,
      "pending_tasks": 23,
      "budget_allocated": 1250000.0,
      "budget_spent": 937500.0,
      "timeline_variance": -3,
      "quality_score": 92,
      "safety_incidents": 2,
      "weather_delays": 5,
      "change_orders": 3,
      "critical_path_status": "on_track",
    },
    {
      "project_id": "PRJ-002",
      "project_name": "Riverside Office Park",
      "overall_progress": 60,
      "phases": [
        {"name": "Foundation", "progress": 100, "status": "completed", "start_date": "2024-02-01", "end_date": "2024-04-15"},
        {"name": "Structure", "progress": 70, "status": "in_progress", "start_date": "2024-04-01", "end_date": "2024-08-30"},
        {"name": "MEP Systems", "progress": 20, "status": "in_progress", "start_date": "2024-07-01", "end_date": "2024-11-15"},
        {"name": "Finishing", "progress": 0, "status": "pending", "start_date": "2024-10-01", "end_date": "2025-01-30"},
      ],
      "total_tasks": 189,
      "completed_tasks": 113,
      "in_progress_tasks": 45,
      "pending_tasks": 31,
      "budget_allocated": 850000.0,
      "budget_spent": 510000.0,
      "timeline_variance": 2,
      "quality_score": 88,
      "safety_incidents": 1,
      "weather_delays": 3,
      "change_orders": 2,
      "critical_path_status": "at_risk",
    },
    {
      "project_id": "PRJ-003",
      "project_name": "Healthcare Facility Expansion",
      "overall_progress": 42,
      "phases": [
        {"name": "Foundation", "progress": 100, "status": "completed", "start_date": "2024-03-01", "end_date": "2024-05-15"},
        {"name": "Structure", "progress": 30, "status": "in_progress", "start_date": "2024-05-01", "end_date": "2024-09-30"},
        {"name": "MEP Systems", "progress": 10, "status": "in_progress", "start_date": "2024-08-01", "end_date": "2024-12-15"},
        {"name": "Finishing", "progress": 0, "status": "pending", "start_date": "2024-11-01", "end_date": "2025-03-30"},
      ],
      "total_tasks": 312,
      "completed_tasks": 131,
      "in_progress_tasks": 67,
      "pending_tasks": 114,
      "budget_allocated": 1580000.0,
      "budget_spent": 663600.0,
      "timeline_variance": 7,
      "quality_score": 95,
      "safety_incidents": 0,
      "weather_delays": 2,
      "change_orders": 5,
      "critical_path_status": "delayed",
    },
    {
      "project_id": "PRJ-004",
      "project_name": "Residential Tower A",
      "overall_progress": 88,
      "phases": [
        {"name": "Foundation", "progress": 100, "status": "completed", "start_date": "2024-01-01", "end_date": "2024-02-28"},
        {"name": "Structure", "progress": 100, "status": "completed", "start_date": "2024-02-15", "end_date": "2024-05-30"},
        {"name": "MEP Systems", "progress": 90, "status": "in_progress", "start_date": "2024-05-01", "end_date": "2024-07-15"},
        {"name": "Finishing", "progress": 65, "status": "in_progress", "start_date": "2024-06-01", "end_date": "2024-08-30"},
      ],
      "total_tasks": 156,
      "completed_tasks": 137,
      "in_progress_tasks": 15,
      "pending_tasks": 4,
      "budget_allocated": 720000.0,
      "budget_spent": 633600.0,
      "timeline_variance": -5,
      "quality_score": 91,
      "safety_incidents": 1,
      "weather_delays": 1,
      "change_orders": 1,
      "critical_path_status": "ahead",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Progress"),
        actions: [
          QButton(
            icon: Icons.bar_chart,
            size: bs.sm,
            onPressed: () => _showDetailedAnalytics(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.file_download,
            size: bs.sm,
            onPressed: () => _exportProgressReport(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildProgressOverview(),
                  _buildFilters(),
                  _buildPerformanceMetrics(),
                  _buildProjectProgressList(),
                ],
              ),
            ),
    );
  }

  Widget _buildProgressOverview() {
    double totalProgress = projectProgress.fold(0.0, (sum, project) => sum + (project["overall_progress"] as int)) / projectProgress.length;
    int totalTasks = projectProgress.fold(0, (sum, project) => sum + (project["total_tasks"] as int));
    int completedTasks = projectProgress.fold(0, (sum, project) => sum + (project["completed_tasks"] as int));
    double avgQualityScore = projectProgress.fold(0.0, (sum, project) => sum + (project["quality_score"] as int)) / projectProgress.length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.trending_up, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Overall Progress Overview",
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
              _buildOverviewCard("Avg Progress", "${totalProgress.toInt()}%", Icons.analytics, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Total Tasks", "$totalTasks", Icons.assignment, infoColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Completed", "$completedTasks", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Quality Score", "${avgQualityScore.toInt()}%", Icons.star, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
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
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
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
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Filter Progress View",
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
              SizedBox(width: spMd),
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
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Phase",
                  items: phases,
                  value: selectedPhase,
                  onChanged: (value, label) {
                    selectedPhase = value;
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
    int onTrackProjects = projectProgress.where((p) => p["critical_path_status"] == "on_track" || p["critical_path_status"] == "ahead").length;
    int delayedProjects = projectProgress.where((p) => p["critical_path_status"] == "delayed" || p["critical_path_status"] == "at_risk").length;
    int totalSafetyIncidents = projectProgress.fold(0, (sum, project) => sum + (project["safety_incidents"] as int));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildMetricCard("On Track", "$onTrackProjects projects", Icons.trending_up, successColor),
              SizedBox(width: spSm),
              _buildMetricCard("At Risk/Delayed", "$delayedProjects projects", Icons.warning, dangerColor),
              SizedBox(width: spSm),
              _buildMetricCard("Safety Incidents", "$totalSafetyIncidents total", Icons.security, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectProgressList() {
    List<Map<String, dynamic>> filteredProjects = _getFilteredProjects();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Project Progress (${filteredProjects.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.timeline,
              size: bs.sm,
              onPressed: () => _showGanttChart(),
            ),
          ],
        ),
        ...filteredProjects.map((project) => _buildProjectCard(project)),
      ],
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    Color statusColor = _getCriticalPathColor(project["critical_path_status"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: statusColor,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${project["project_id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${project["project_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Text(
                  "${project["overall_progress"]}%",
                  style: TextStyle(
                    fontSize: 18,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Overall Progress",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${project["overall_progress"]}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (project["overall_progress"] as int) / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Phase Progress",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...(project["phases"] as List).map((phase) => _buildPhaseProgress(phase)),
          Row(
            children: [
              _buildTaskSummaryCard("Total", "${project["total_tasks"]}", Icons.assignment, primaryColor),
              SizedBox(width: spSm),
              _buildTaskSummaryCard("Completed", "${project["completed_tasks"]}", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildTaskSummaryCard("In Progress", "${project["in_progress_tasks"]}", Icons.play_circle, warningColor),
              SizedBox(width: spSm),
              _buildTaskSummaryCard("Pending", "${project["pending_tasks"]}", Icons.pending, dangerColor),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.monetization_on, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Budget: \$${((project["budget_spent"] as double)).currency} / \$${((project["budget_allocated"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(((project["budget_spent"] as double) / (project["budget_allocated"] as double)) * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.schedule, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Timeline Variance: ${project["timeline_variance"]} days",
                      style: TextStyle(
                        fontSize: 12,
                        color: (project["timeline_variance"] as int) <= 0 ? successColor : dangerColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.star, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Quality: ${project["quality_score"]}%",
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${project["critical_path_status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "Safety: ${project["safety_incidents"]} incidents",
                style: TextStyle(
                  fontSize: 12,
                  color: (project["safety_incidents"] as int) == 0 ? successColor : dangerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Change Orders: ${project["change_orders"]} | Weather Delays: ${project["weather_delays"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewProjectDetails(project["project_id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.timeline,
                size: bs.sm,
                onPressed: () => _viewProjectTimeline(project["project_id"]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseProgress(Map<String, dynamic> phase) {
    Color statusColor = _getPhaseStatusColor(phase["status"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "${phase["name"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${phase["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${phase["progress"]}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (phase["progress"] as int) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "Start: ${phase["start_date"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "End: ${phase["end_date"]}",
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
  }

  Widget _buildTaskSummaryCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 16),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredProjects() {
    List<Map<String, dynamic>> filtered = projectProgress;

    if (selectedProject != "all") {
      filtered = filtered.where((project) => project["project_id"] == selectedProject).toList();
    }

    return filtered;
  }

  Color _getCriticalPathColor(String status) {
    switch (status.toLowerCase()) {
      case 'on_track':
        return successColor;
      case 'ahead':
        return infoColor;
      case 'at_risk':
        return warningColor;
      case 'delayed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPhaseStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return warningColor;
      case 'pending':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showDetailedAnalytics() {
    ss("Detailed progress analytics");
  }

  void _exportProgressReport() {
    ss("Exporting progress report");
  }

  void _showGanttChart() {
    ss("Showing Gantt chart view");
  }

  void _viewProjectDetails(String projectId) {
    ss("Viewing project details $projectId");
  }

  void _viewProjectTimeline(String projectId) {
    ss("Viewing project timeline $projectId");
  }
}
