import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaProjectPhasesView extends StatefulWidget {
  const ComaProjectPhasesView({Key? key}) : super(key: key);

  @override
  State<ComaProjectPhasesView> createState() => _ComaProjectPhasesViewState();
}

class _ComaProjectPhasesViewState extends State<ComaProjectPhasesView> {
  String selectedPhaseFilter = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> phaseFilters = [
    {"label": "All Phases", "value": "all", "count": 28},
    {"label": "Planning", "value": "planning", "count": 3},
    {"label": "Design", "value": "design", "count": 4},
    {"label": "Pre-Construction", "value": "pre_construction", "count": 2},
    {"label": "Construction", "value": "construction", "count": 12},
    {"label": "Finishing", "value": "finishing", "count": 5},
    {"label": "Closeout", "value": "closeout", "count": 2},
  ];

  List<Map<String, dynamic>> projectPhases = [
    {
      "id": "PH-2024-001",
      "phase_name": "Site Preparation & Excavation",
      "project_name": "Metro Downtown Complex",
      "phase_type": "construction",
      "status": "in_progress",
      "priority": "high",
      "start_date": "2024-06-01",
      "end_date": "2024-07-15",
      "progress_percentage": 75,
      "budget_allocated": 450000.0,
      "budget_spent": 337500.0,
      "team_lead": "Robert Chen",
      "crew_size": 12,
      "equipment_required": ["Excavator", "Dump Trucks", "Compactor"],
      "weather_dependent": true,
      "permits_required": true,
      "safety_incidents": 0,
      "quality_score": 9.2,
      "dependencies": ["Survey Completion", "Permit Approval"],
      "milestones_completed": 3,
      "milestones_total": 4,
      "notes": "Excavation proceeding ahead of schedule. Weather conditions favorable.",
    },
    {
      "id": "PH-2024-002", 
      "phase_name": "Foundation & Structural Steel",
      "project_name": "Metro Downtown Complex",
      "phase_type": "construction",
      "status": "upcoming",
      "priority": "critical",
      "start_date": "2024-07-16",
      "end_date": "2024-09-30",
      "progress_percentage": 0,
      "budget_allocated": 1200000.0,
      "budget_spent": 0.0,
      "team_lead": "Maria Rodriguez",
      "crew_size": 18,
      "equipment_required": ["Crane", "Concrete Mixer", "Rebar Tools"],
      "weather_dependent": true,
      "permits_required": true,
      "safety_incidents": 0,
      "quality_score": 0.0,
      "dependencies": ["Site Preparation Complete"],
      "milestones_completed": 0,
      "milestones_total": 6,
      "notes": "Awaiting site preparation completion. Materials ordered and scheduled.",
    },
    {
      "id": "PH-2024-003",
      "phase_name": "HVAC System Installation", 
      "project_name": "Metro Downtown Complex",
      "phase_type": "construction",
      "status": "delayed",
      "priority": "medium",
      "start_date": "2024-08-01",
      "end_date": "2024-10-15",
      "progress_percentage": 15,
      "budget_allocated": 380000.0,
      "budget_spent": 57000.0,
      "team_lead": "David Kim",
      "crew_size": 8,
      "equipment_required": ["Lifts", "Ductwork Tools", "Testing Equipment"],
      "weather_dependent": false,
      "permits_required": false,
      "safety_incidents": 1,
      "quality_score": 8.5,
      "dependencies": ["Structural Steel 50% Complete"],
      "milestones_completed": 1,
      "milestones_total": 5,
      "notes": "Delayed due to material delivery issues. Alternative suppliers sourced.",
    },
    {
      "id": "PH-2024-004",
      "phase_name": "Electrical Rough-in",
      "project_name": "Riverside Office Park",
      "phase_type": "construction", 
      "status": "completed",
      "priority": "medium",
      "start_date": "2024-05-01",
      "end_date": "2024-06-30",
      "progress_percentage": 100,
      "budget_allocated": 275000.0,
      "budget_spent": 268000.0,
      "team_lead": "Jennifer Park",
      "crew_size": 6,
      "equipment_required": ["Wire Pullers", "Conduit Benders", "Testing Meters"],
      "weather_dependent": false,
      "permits_required": true,
      "safety_incidents": 0,
      "quality_score": 9.8,
      "dependencies": ["Framing Complete"],
      "milestones_completed": 4,
      "milestones_total": 4,
      "notes": "Phase completed successfully under budget with high quality ratings.",
    },
    {
      "id": "PH-2024-005",
      "phase_name": "Interior Finishing",
      "project_name": "Residential Tower A",
      "phase_type": "finishing",
      "status": "in_progress",
      "priority": "high",
      "start_date": "2024-06-15",
      "end_date": "2024-08-30",
      "progress_percentage": 60,
      "budget_allocated": 520000.0,
      "budget_spent": 312000.0,
      "team_lead": "Sandra Wilson",
      "crew_size": 15,
      "equipment_required": ["Paint Sprayers", "Floor Sanders", "Trim Tools"],
      "weather_dependent": false,
      "permits_required": false,
      "safety_incidents": 0,
      "quality_score": 9.1,
      "dependencies": ["Drywall Complete", "Flooring Delivered"],
      "milestones_completed": 4,
      "milestones_total": 7,
      "notes": "Quality inspections passing. On track for early completion.",
    },
    {
      "id": "PH-2024-006",
      "phase_name": "Architectural Design Review",
      "project_name": "Healthcare Facility Expansion",
      "phase_type": "design",
      "status": "in_progress",
      "priority": "critical",
      "start_date": "2024-06-01",
      "end_date": "2024-07-30",
      "progress_percentage": 45,
      "budget_allocated": 85000.0,
      "budget_spent": 38250.0,
      "team_lead": "Thomas Anderson",
      "crew_size": 4,
      "equipment_required": ["Design Software", "3D Modeling Tools"],
      "weather_dependent": false,
      "permits_required": false,
      "safety_incidents": 0,
      "quality_score": 8.9,
      "dependencies": ["Client Requirements Finalized"],
      "milestones_completed": 2,
      "milestones_total": 5,
      "notes": "Design revisions requested by client. Adjusting timeline accordingly.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Phases"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addNewPhase(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.timeline,
            size: bs.sm,
            onPressed: () => _showPhaseTimeline(),
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
                  _buildPhaseOverview(),
                  _buildSearchAndFilter(),
                  _buildPhaseFilters(),
                  _buildPhaseProgress(),
                  _buildPhasesList(),
                ],
              ),
            ),
    );
  }

  Widget _buildPhaseOverview() {
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
                child: Icon(Icons.timeline, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Project Phases Overview",
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
              _buildOverviewCard("Total Phases", "28", Icons.view_timeline, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("In Progress", "12", Icons.play_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Delayed", "3", Icons.warning, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Completed", "13", Icons.check_circle, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String count, IconData icon, Color color) {
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
              count,
              style: TextStyle(
                fontSize: 16,
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

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: disabledBoldColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: QTextField(
              label: "Search project phases...",
              value: searchQuery,
              hint: "Search by phase name, project, or team lead",
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
    );
  }

  Widget _buildPhaseFilters() {
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
            "Filter by Phase Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: phaseFilters.map((filter) {
              bool isSelected = selectedPhaseFilter == filter["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedPhaseFilter = filter["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? primaryColor.withAlpha(30)
                          : Colors.grey.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      "${filter["label"]} (${filter["count"]})",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseProgress() {
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
            "Overall Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildProgressCard("Avg. Progress", "68%", Icons.trending_up),
              SizedBox(width: spSm),
              _buildProgressCard("On Schedule", "24", Icons.schedule),
              SizedBox(width: spSm),
              _buildProgressCard("Budget Usage", "72%", Icons.account_balance_wallet),
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

  Widget _buildPhasesList() {
    List<Map<String, dynamic>> filteredPhases = _getFilteredPhases();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Project Phases (${filteredPhases.length})",
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
        ...filteredPhases.map((phase) => _buildPhaseCard(phase)),
      ],
    );
  }

  Widget _buildPhaseCard(Map<String, dynamic> phase) {
    Color statusColor = _getStatusColor(phase["status"]);
    double progress = (phase["progress_percentage"] as num).toDouble();

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
                      "${phase["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${phase["phase_name"]}",
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
                  "${phase["status"]}".replaceAll("_", " ").toUpperCase(),
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
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${phase["phase_type"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor(phase["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${phase["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: _getPriorityColor(phase["priority"]),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Project: ${phase["project_name"]}",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Progress: ${progress.toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Milestones: ${phase["milestones_completed"]}/${phase["milestones_total"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: successColor,
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
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Lead: ${phase["team_lead"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.group, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${phase["crew_size"]} crew",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Budget: \$${((phase["budget_spent"] as double)).currency} / \$${((phase["budget_allocated"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              if ((phase["quality_score"] as double) > 0)
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${(phase["quality_score"] as double).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Row(
            children: [
              if (phase["weather_dependent"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "WEATHER DEPENDENT",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (phase["permits_required"] == true) ...[
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "PERMITS REQUIRED",
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
                "${phase["start_date"]} - ${phase["end_date"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (phase["notes"] != null && (phase["notes"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${phase["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Equipment: ${(phase["equipment_required"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewPhaseDetails(phase["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editPhase(phase["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showPhaseOptions(phase),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredPhases() {
    List<Map<String, dynamic>> filtered = projectPhases;

    if (selectedPhaseFilter != "all") {
      filtered = filtered.where((p) => p["phase_type"] == selectedPhaseFilter).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((p) =>
          p["phase_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          p["project_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          p["team_lead"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return warningColor;
      case 'upcoming':
        return infoColor;
      case 'delayed':
        return dangerColor;
      case 'on_hold':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return primaryColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addNewPhase() {
    ss("Add new project phase");
  }

  void _showPhaseTimeline() {
    ss("Phase timeline view");
  }

  void _showAdvancedFilters() {
    ss("Advanced phase filters");
  }

  void _showSortOptions() {
    ss("Phase sort options");
  }

  void _viewPhaseDetails(String phaseId) {
    ss("Viewing phase details $phaseId");
  }

  void _editPhase(String phaseId) {
    ss("Editing phase $phaseId");
  }

  void _showPhaseOptions(Map<String, dynamic> phase) {
    ss("Phase options for ${phase["id"]}");
  }
}
