import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaDailyTasksView extends StatefulWidget {
  const ComaDailyTasksView({Key? key}) : super(key: key);

  @override
  State<ComaDailyTasksView> createState() => _ComaDailyTasksViewState();
}

class _ComaDailyTasksViewState extends State<ComaDailyTasksView> {
  String selectedDate = "2024-06-17";
  String selectedCrew = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> crews = [
    {"label": "All Crews", "value": "all"},
    {"label": "Foundation Crew", "value": "foundation"},
    {"label": "Framing Crew", "value": "framing"},
    {"label": "Electrical Crew", "value": "electrical"},
    {"label": "Plumbing Crew", "value": "plumbing"},
    {"label": "Finishing Crew", "value": "finishing"},
  ];

  List<Map<String, dynamic>> dailyTasks = [
    {
      "id": "DT-2024-001",
      "task_name": "Foundation Excavation - Zone A",
      "project_name": "Metro Downtown Complex",
      "crew_assigned": "Foundation Crew",
      "crew_id": "foundation",
      "status": "in_progress",
      "priority": "high",
      "planned_start_time": "07:00",
      "planned_end_time": "15:00",
      "actual_start_time": "07:15",
      "actual_end_time": null,
      "progress_percentage": 65,
      "assigned_workers": 8,
      "estimated_hours": 8,
      "actual_hours": 6.5,
      "location": "Building A - North Side",
      "description": "Excavate foundation area for main building structure",
      "materials_required": ["Excavator", "Safety Equipment", "Surveying Tools"],
      "weather_impact": "clear",
      "safety_briefing_completed": true,
      "supervisor": "John Martinez",
      "notes": "Good progress, soil conditions better than expected",
      "quality_check_required": true,
      "equipment_status": "operational",
      "dependencies": [],
      "completion_requirements": ["Safety inspection", "Depth verification", "Clean-up"],
    },
    {
      "id": "DT-2024-002",
      "task_name": "Steel Frame Assembly - Level 2",
      "project_name": "Riverside Office Park",
      "crew_assigned": "Framing Crew",
      "crew_id": "framing",
      "status": "completed",
      "priority": "high",
      "planned_start_time": "06:30",
      "planned_end_time": "14:30",
      "actual_start_time": "06:30",
      "actual_end_time": "14:45",
      "progress_percentage": 100,
      "assigned_workers": 12,
      "estimated_hours": 8,
      "actual_hours": 8.25,
      "location": "Building B - Level 2",
      "description": "Install steel frame structure for second floor",
      "materials_required": ["Steel Beams", "Bolts", "Crane", "Safety Harness"],
      "weather_impact": "clear",
      "safety_briefing_completed": true,
      "supervisor": "Sarah Johnson",
      "notes": "Completed on schedule, quality inspection passed",
      "quality_check_required": true,
      "equipment_status": "operational",
      "dependencies": ["Level 1 completion"],
      "completion_requirements": ["Quality inspection", "Safety check", "Documentation"],
    },
    {
      "id": "DT-2024-003",
      "task_name": "Electrical Rough-In Installation",
      "project_name": "Healthcare Facility Expansion",
      "crew_assigned": "Electrical Crew",
      "crew_id": "electrical",
      "status": "pending",
      "priority": "medium",
      "planned_start_time": "08:00",
      "planned_end_time": "16:00",
      "actual_start_time": null,
      "actual_end_time": null,
      "progress_percentage": 0,
      "assigned_workers": 6,
      "estimated_hours": 8,
      "actual_hours": 0,
      "location": "Patient Wing - Floors 1-3",
      "description": "Install electrical wiring and outlets for patient rooms",
      "materials_required": ["Electrical Wire", "Outlets", "Conduit", "Tools"],
      "weather_impact": "indoor",
      "safety_briefing_completed": false,
      "supervisor": "Michael Chen",
      "notes": "Waiting for structural completion",
      "quality_check_required": true,
      "equipment_status": "ready",
      "dependencies": ["Structural framing completion"],
      "completion_requirements": ["Code inspection", "Testing", "Documentation"],
    },
    {
      "id": "DT-2024-004",
      "task_name": "Plumbing System Installation",
      "project_name": "Residential Tower A",
      "crew_assigned": "Plumbing Crew",
      "crew_id": "plumbing",
      "status": "in_progress",
      "priority": "high",
      "planned_start_time": "07:30",
      "planned_end_time": "15:30",
      "actual_start_time": "07:45",
      "actual_end_time": null,
      "progress_percentage": 40,
      "assigned_workers": 5,
      "estimated_hours": 8,
      "actual_hours": 4.5,
      "location": "Tower A - Floors 5-10",
      "description": "Install water supply and drainage systems",
      "materials_required": ["Pipes", "Fittings", "Valves", "Tools"],
      "weather_impact": "indoor",
      "safety_briefing_completed": true,
      "supervisor": "Emily Rodriguez",
      "notes": "Progressing well, minor delays due to material delivery",
      "quality_check_required": true,
      "equipment_status": "operational",
      "dependencies": ["Structural work"],
      "completion_requirements": ["Pressure testing", "Inspection", "Sign-off"],
    },
    {
      "id": "DT-2024-005",
      "task_name": "Interior Finishing - Lobby Area",
      "project_name": "Metro Downtown Complex",
      "crew_assigned": "Finishing Crew",
      "crew_id": "finishing",
      "status": "on_hold",
      "priority": "low",
      "planned_start_time": "09:00",
      "planned_end_time": "17:00",
      "actual_start_time": null,
      "actual_end_time": null,
      "progress_percentage": 0,
      "assigned_workers": 4,
      "estimated_hours": 8,
      "actual_hours": 0,
      "location": "Main Lobby",
      "description": "Install flooring, painting, and decorative elements",
      "materials_required": ["Flooring", "Paint", "Decorative Materials"],
      "weather_impact": "indoor",
      "safety_briefing_completed": false,
      "supervisor": "David Wilson",
      "notes": "Waiting for material approval from client",
      "quality_check_required": true,
      "equipment_status": "ready",
      "dependencies": ["Client material approval"],
      "completion_requirements": ["Final inspection", "Client approval", "Clean-up"],
    },
    {
      "id": "DT-2024-006",
      "task_name": "HVAC Ductwork Installation",
      "project_name": "Riverside Office Park",
      "crew_assigned": "HVAC Crew",
      "crew_id": "hvac",
      "status": "completed",
      "priority": "medium",
      "planned_start_time": "06:00",
      "planned_end_time": "14:00",
      "actual_start_time": "06:00",
      "actual_end_time": "13:30",
      "progress_percentage": 100,
      "assigned_workers": 7,
      "estimated_hours": 8,
      "actual_hours": 7.5,
      "location": "Office Building - All Floors",
      "description": "Install HVAC ductwork and ventilation systems",
      "materials_required": ["Ductwork", "Insulation", "Mounting Hardware"],
      "weather_impact": "indoor",
      "safety_briefing_completed": true,
      "supervisor": "Jennifer Park",
      "notes": "Completed ahead of schedule, excellent team performance",
      "quality_check_required": true,
      "equipment_status": "operational",
      "dependencies": ["Ceiling framework"],
      "completion_requirements": ["System testing", "Balancing", "Commissioning"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Tasks"),
        actions: [
          QButton(
            icon: Icons.add_task,
            size: bs.sm,
            onPressed: () => _addNewTask(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showTaskAnalytics(),
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
                  _buildTaskOverview(),
                  _buildDateAndCrewFilters(),
                  _buildProgressSummary(),
                  _buildTasksList(),
                ],
              ),
            ),
    );
  }

  Widget _buildTaskOverview() {
    int totalTasks = dailyTasks.length;
    int completedTasks = dailyTasks.where((task) => task["status"] == "completed").length;
    int inProgressTasks = dailyTasks.where((task) => task["status"] == "in_progress").length;
    int pendingTasks = dailyTasks.where((task) => task["status"] == "pending").length;

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
                child: Icon(Icons.task_alt, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Today's Tasks Overview",
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
              _buildOverviewCard("Total Tasks", "$totalTasks", Icons.assignment, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Completed", "$completedTasks", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("In Progress", "$inProgressTasks", Icons.play_circle, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Pending", "$pendingTasks", Icons.pending, dangerColor),
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

  Widget _buildDateAndCrewFilters() {
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
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Task Date",
                  value: DateTime.parse(selectedDate),
                  onChanged: (value) {
                    selectedDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Filter by Crew",
                  items: crews,
                  value: selectedCrew,
                  onChanged: (value, label) {
                    selectedCrew = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.search, color: disabledBoldColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Search tasks...",
                  value: searchQuery,
                  hint: "Search by task name, location, or supervisor",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () => _showAdvancedFilters(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSummary() {
    double totalProgress = dailyTasks.fold(0.0, (sum, task) => sum + (task["progress_percentage"] as int)) / dailyTasks.length;
    double totalEstimatedHours = dailyTasks.fold(0.0, (sum, task) => sum + (task["estimated_hours"] as num));
    double totalActualHours = dailyTasks.fold(0.0, (sum, task) => sum + (task["actual_hours"] as num));

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
            "Daily Progress Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildProgressCard("Overall Progress", "${totalProgress.toInt()}%", Icons.trending_up),
              SizedBox(width: spSm),
              _buildProgressCard("Estimated Hours", "${totalEstimatedHours.toInt()}h", Icons.schedule),
              SizedBox(width: spSm),
              _buildProgressCard("Actual Hours", "${totalActualHours.toInt()}h", Icons.timer),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(String title, String value, IconData icon) {
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
            Icon(icon, color: successColor, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: successColor,
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

  Widget _buildTasksList() {
    List<Map<String, dynamic>> filteredTasks = _getFilteredTasks();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Daily Tasks (${filteredTasks.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredTasks.map((task) => _buildTaskCard(task)),
      ],
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    Color statusColor = _getStatusColor(task["status"]);
    Color priorityColor = _getPriorityColor(task["priority"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${task["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${task["task_name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${task["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: priorityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.location_on, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${task["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Project: ${task["project_name"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${task["description"]}",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Progress: ${task["progress_percentage"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.people, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${task["assigned_workers"]} workers",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (task["progress_percentage"] as int) / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.schedule, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Planned: ${task["planned_start_time"]} - ${task["planned_end_time"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (task["actual_start_time"] != null)
            Row(
              children: [
                Icon(Icons.play_arrow, color: successColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Started: ${task["actual_start_time"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (task["actual_end_time"] != null) ...[
                  SizedBox(width: spMd),
                  Icon(Icons.stop, color: primaryColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Ended: ${task["actual_end_time"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Supervisor: ${task["supervisor"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Crew: ${task["crew_assigned"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (task["notes"] != null && task["notes"].toString().isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${task["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              if (task["safety_briefing_completed"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "SAFETY BRIEFED",
                    style: TextStyle(
                      fontSize: 10,
                      color: successColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (task["quality_check_required"] == true) ...[
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "QUALITY CHECK",
                    style: TextStyle(
                      fontSize: 10,
                      color: warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              Spacer(),
              Text(
                "Est: ${task["estimated_hours"]}h | Act: ${task["actual_hours"]}h",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Equipment: ${task["equipment_status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.play_arrow,
                size: bs.sm,
                onPressed: () => _startTask(task["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editTask(task["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showTaskOptions(task),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredTasks() {
    List<Map<String, dynamic>> filtered = dailyTasks;

    if (selectedCrew != "all") {
      filtered = filtered.where((task) => task["crew_id"] == selectedCrew).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((task) =>
          task["task_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          task["location"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          task["supervisor"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return warningColor;
      case 'pending':
        return dangerColor;
      case 'on_hold':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addNewTask() {
    ss("Add new daily task");
  }

  void _showTaskAnalytics() {
    ss("Task analytics and reports");
  }

  void _showAdvancedFilters() {
    ss("Advanced task filters");
  }

  void _showSortOptions() {
    ss("Task sorting options");
  }

  void _startTask(String taskId) {
    ss("Starting task $taskId");
  }

  void _editTask(String taskId) {
    ss("Editing task $taskId");
  }

  void _showTaskOptions(Map<String, dynamic> task) {
    ss("Task options for ${task["id"]}");
  }
}
