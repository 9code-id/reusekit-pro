import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaProjectStatusView extends StatefulWidget {
  const ComaProjectStatusView({Key? key}) : super(key: key);

  @override
  State<ComaProjectStatusView> createState() => _ComaProjectStatusViewState();
}

class _ComaProjectStatusViewState extends State<ComaProjectStatusView> {
  String selectedStatusFilter = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Projects", "value": "all", "count": 24},
    {"label": "Active", "value": "active", "count": 12},
    {"label": "On Hold", "value": "on_hold", "count": 3},
    {"label": "Delayed", "value": "delayed", "count": 4},
    {"label": "Completed", "value": "completed", "count": 5},
  ];

  List<Map<String, dynamic>> projectStatuses = [
    {
      "id": "PRJ-2024-001",
      "project_name": "Metro Downtown Complex",
      "client_name": "Metro Development Corp",
      "status": "active",
      "priority": "high",
      "overall_progress": 68,
      "start_date": "2024-03-15",
      "end_date": "2024-12-30",
      "project_manager": "Sarah Johnson",
      "total_budget": 2500000.0,
      "budget_spent": 1700000.0,
      "team_size": 45,
      "phases_total": 8,
      "phases_completed": 3,
      "current_phase": "Foundation & Structural Steel",
      "next_milestone": "Structural Steel Completion",
      "milestone_date": "2024-09-30",
      "health_score": 8.5,
      "risk_level": "medium",
      "weather_impact": true,
      "permit_status": "approved",
      "safety_incidents": 1,
      "quality_issues": 0,
      "change_orders": 2,
      "location": "Downtown Metro City",
      "project_type": "Commercial",
      "contract_type": "Fixed Price",
      "completion_percentage": 68,
    },
    {
      "id": "PRJ-2024-002",
      "project_name": "Riverside Office Park",
      "client_name": "Riverside Properties LLC",
      "status": "completed",
      "priority": "medium",
      "overall_progress": 100,
      "start_date": "2024-01-10",
      "end_date": "2024-06-15",
      "project_manager": "Michael Chen",
      "total_budget": 1800000.0,
      "budget_spent": 1750000.0,
      "team_size": 32,
      "phases_total": 6,
      "phases_completed": 6,
      "current_phase": "Project Closeout",
      "next_milestone": "Final Inspection",
      "milestone_date": "2024-06-20",
      "health_score": 9.2,
      "risk_level": "low",
      "weather_impact": false,
      "permit_status": "approved",
      "safety_incidents": 0,
      "quality_issues": 0,
      "change_orders": 1,
      "location": "Riverside District",
      "project_type": "Commercial",
      "contract_type": "Cost Plus",
      "completion_percentage": 100,
    },
    {
      "id": "PRJ-2024-003",
      "project_name": "Healthcare Facility Expansion",
      "client_name": "Metro Health System",
      "status": "delayed",
      "priority": "critical",
      "overall_progress": 35,
      "start_date": "2024-02-01",
      "end_date": "2024-11-30",
      "project_manager": "Emily Rodriguez",
      "total_budget": 3200000.0,
      "budget_spent": 1120000.0,
      "team_size": 52,
      "phases_total": 10,
      "phases_completed": 2,
      "current_phase": "Electrical & Plumbing Rough-in",
      "next_milestone": "MEP Systems Testing",
      "milestone_date": "2024-08-15",
      "health_score": 6.8,
      "risk_level": "high",
      "weather_impact": false,
      "permit_status": "pending",
      "safety_incidents": 2,
      "quality_issues": 3,
      "change_orders": 5,
      "location": "Medical District",
      "project_type": "Healthcare",
      "contract_type": "Fixed Price",
      "completion_percentage": 35,
    },
    {
      "id": "PRJ-2024-004",
      "project_name": "Residential Tower A",
      "client_name": "Urban Living Solutions",
      "status": "active",
      "priority": "high",
      "overall_progress": 72,
      "start_date": "2024-01-20",
      "end_date": "2024-10-15",
      "project_manager": "David Wilson",
      "total_budget": 4500000.0,
      "budget_spent": 3240000.0,
      "team_size": 38,
      "phases_total": 9,
      "phases_completed": 5,
      "current_phase": "Interior Finishing",
      "next_milestone": "Exterior Completion",
      "milestone_date": "2024-08-30",
      "health_score": 8.1,
      "risk_level": "low",
      "weather_impact": true,
      "permit_status": "approved",
      "safety_incidents": 0,
      "quality_issues": 1,
      "change_orders": 3,
      "location": "Uptown District",
      "project_type": "Residential",
      "contract_type": "Cost Plus",
      "completion_percentage": 72,
    },
    {
      "id": "PRJ-2024-005",
      "project_name": "Industrial Warehouse Complex",
      "client_name": "LogiTech Distribution",
      "status": "on_hold",
      "priority": "medium",
      "overall_progress": 25,
      "start_date": "2024-04-01",
      "end_date": "2024-12-15",
      "project_manager": "Jennifer Park",
      "total_budget": 2100000.0,
      "budget_spent": 525000.0,
      "team_size": 28,
      "phases_total": 7,
      "phases_completed": 1,
      "current_phase": "Site Preparation",
      "next_milestone": "Foundation Pour",
      "milestone_date": "2024-09-01",
      "health_score": 7.3,
      "risk_level": "medium",
      "weather_impact": true,
      "permit_status": "pending",
      "safety_incidents": 0,
      "quality_issues": 0,
      "change_orders": 0,
      "location": "Industrial Zone",
      "project_type": "Industrial",
      "contract_type": "Fixed Price",
      "completion_percentage": 25,
    },
    {
      "id": "PRJ-2024-006",
      "project_name": "Municipal Library Renovation",
      "client_name": "City of Metro",
      "status": "active",
      "priority": "medium",
      "overall_progress": 45,
      "start_date": "2024-05-01",
      "end_date": "2024-11-30",
      "project_manager": "Thomas Anderson",
      "total_budget": 1200000.0,
      "budget_spent": 540000.0,
      "team_size": 22,
      "phases_total": 6,
      "phases_completed": 2,
      "current_phase": "Interior Renovation",
      "next_milestone": "Technology Installation",
      "milestone_date": "2024-08-15",
      "health_score": 8.7,
      "risk_level": "low",
      "weather_impact": false,
      "permit_status": "approved",
      "safety_incidents": 0,
      "quality_issues": 0,
      "change_orders": 1,
      "location": "Downtown Metro City",
      "project_type": "Public",
      "contract_type": "Fixed Price",
      "completion_percentage": 45,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Status"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addNewProject(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.dashboard,
            size: bs.sm,
            onPressed: () => _showProjectDashboard(),
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
                  _buildProjectOverview(),
                  _buildSearchAndFilter(),
                  _buildStatusFilters(),
                  _buildHealthMetrics(),
                  _buildProjectsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildProjectOverview() {
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
                child: Icon(Icons.assignment, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Project Portfolio Status",
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
              _buildOverviewCard("Total Projects", "24", Icons.folder, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Active", "12", Icons.play_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Delayed", "4", Icons.warning, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("On Hold", "3", Icons.pause_circle, warningColor),
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
              label: "Search projects...",
              value: searchQuery,
              hint: "Search by project name, client, or manager",
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

  Widget _buildStatusFilters() {
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
            "Filter by Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: statusFilters.map((filter) {
              bool isSelected = selectedStatusFilter == filter["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedStatusFilter = filter["value"];
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

  Widget _buildHealthMetrics() {
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
            "Portfolio Health",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildHealthCard("Avg. Health", "8.1", Icons.favorite),
              SizedBox(width: spSm),
              _buildHealthCard("On Budget", "18", Icons.account_balance_wallet),
              SizedBox(width: spSm),
              _buildHealthCard("On Time", "20", Icons.schedule),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHealthCard(String title, String value, IconData icon) {
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

  Widget _buildProjectsList() {
    List<Map<String, dynamic>> filteredProjects = _getFilteredProjects();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Projects (${filteredProjects.length})",
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
        ...filteredProjects.map((project) => _buildProjectCard(project)),
      ],
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    Color statusColor = _getStatusColor(project["status"]);
    Color riskColor = _getRiskColor(project["risk_level"]);
    double progress = (project["overall_progress"] as num).toDouble();
    double budgetUsage = ((project["budget_spent"] as double) / (project["total_budget"] as double)) * 100;

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
                      "${project["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${project["project_name"]}",
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
                  "${project["status"]}".replaceAll("_", " ").toUpperCase(),
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
                  "${project["project_type"]}".toUpperCase(),
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
                  color: riskColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${project["risk_level"]} RISK".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: riskColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.business, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Client: ${project["client_name"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
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
                      "Health: ${(project["health_score"] as double).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: _getHealthColor(project["health_score"] as double),
                        fontWeight: FontWeight.bold,
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
              Text(
                "Phase: ${project["current_phase"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Budget: \$${((project["budget_spent"] as double)).currency} / \$${((project["total_budget"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: budgetUsage > 90 ? dangerColor : primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "${budgetUsage.toInt()}% used",
                style: TextStyle(
                  fontSize: 12,
                  color: budgetUsage > 90 ? dangerColor : disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "PM: ${project["project_manager"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.group, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${project["team_size"]} team",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              if (project["weather_impact"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "WEATHER SENSITIVE",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Spacer(),
              Text(
                "Next: ${project["next_milestone"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: warningColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              if ((project["safety_incidents"] as int) > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${project["safety_incidents"]} SAFETY INCIDENTS",
                    style: TextStyle(
                      fontSize: 10,
                      color: dangerColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if ((project["change_orders"] as int) > 0) ...[
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${project["change_orders"]} CHANGE ORDERS",
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
                "${project["start_date"]} - ${project["end_date"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Location: ${project["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewProjectDetails(project["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editProject(project["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showProjectOptions(project),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredProjects() {
    List<Map<String, dynamic>> filtered = projectStatuses;

    if (selectedStatusFilter != "all") {
      filtered = filtered.where((p) => p["status"] == selectedStatusFilter).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((p) =>
          p["project_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          p["client_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          p["project_manager"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'active':
        return warningColor;
      case 'delayed':
        return dangerColor;
      case 'on_hold':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getRiskColor(String risk) {
    switch (risk.toLowerCase()) {
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

  Color _getHealthColor(double score) {
    if (score >= 8.0) return successColor;
    if (score >= 6.0) return warningColor;
    return dangerColor;
  }

  void _addNewProject() {
    ss("Add new project");
  }

  void _showProjectDashboard() {
    ss("Project dashboard");
  }

  void _showAdvancedFilters() {
    ss("Advanced project filters");
  }

  void _showSortOptions() {
    ss("Project sort options");
  }

  void _viewProjectDetails(String projectId) {
    ss("Viewing project details $projectId");
  }

  void _editProject(String projectId) {
    ss("Editing project $projectId");
  }

  void _showProjectOptions(Map<String, dynamic> project) {
    ss("Project options for ${project["id"]}");
  }
}
