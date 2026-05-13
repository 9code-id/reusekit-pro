import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaDeadlineView extends StatefulWidget {
  const PmaDeadlineView({super.key});

  @override
  State<PmaDeadlineView> createState() => _PmaDeadlineViewState();
}

class _PmaDeadlineViewState extends State<PmaDeadlineView> {
  String selectedFilter = "all";
  String selectedProject = "all";
  
  List<Map<String, dynamic>> deadlines = [
    {
      "id": 1,
      "title": "Mobile App UI/UX Design",
      "project": "Mobile Banking App",
      "deadline": "2025-06-22",
      "status": "on_track",
      "priority": "high",
      "assignee": "Sarah Wilson",
      "progress": 75,
      "description": "Complete the UI/UX design for the mobile banking application",
      "daysLeft": 3,
      "category": "design"
    },
    {
      "id": 2,
      "title": "API Development",
      "project": "E-commerce Platform",
      "deadline": "2025-06-20",
      "status": "at_risk",
      "priority": "critical",
      "assignee": "John Doe",
      "progress": 45,
      "description": "Develop REST API endpoints for product management",
      "daysLeft": 1,
      "category": "development"
    },
    {
      "id": 3,
      "title": "Database Schema Design",
      "project": "CRM System",
      "deadline": "2025-06-25",
      "status": "on_track",
      "priority": "medium",
      "assignee": "Mike Johnson",
      "progress": 60,
      "description": "Design and implement database schema for customer management",
      "daysLeft": 6,
      "category": "database"
    },
    {
      "id": 4,
      "title": "Security Audit",
      "project": "Financial Dashboard",
      "deadline": "2025-06-18",
      "status": "overdue",
      "priority": "critical",
      "assignee": "Lisa Davis",
      "progress": 30,
      "description": "Conduct comprehensive security audit of the financial dashboard",
      "daysLeft": -1,
      "category": "security"
    },
    {
      "id": 5,
      "title": "Performance Testing",
      "project": "Mobile Banking App",
      "deadline": "2025-06-30",
      "status": "on_track",
      "priority": "medium",
      "assignee": "Tom Brown",
      "progress": 25,
      "description": "Perform load testing and performance optimization",
      "daysLeft": 11,
      "category": "testing"
    },
    {
      "id": 6,
      "title": "User Documentation",
      "project": "E-commerce Platform",
      "deadline": "2025-06-24",
      "status": "completed",
      "priority": "low",
      "assignee": "Emma White",
      "progress": 100,
      "description": "Create comprehensive user documentation and guides",
      "daysLeft": 5,
      "category": "documentation"
    }
  ];

  List<String> projects = ["Mobile Banking App", "E-commerce Platform", "CRM System", "Financial Dashboard"];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "all"},
    {"label": "Overdue", "value": "overdue"},
    {"label": "Due Soon", "value": "due_soon"},
    {"label": "At Risk", "value": "at_risk"},
    {"label": "On Track", "value": "on_track"},
    {"label": "Completed", "value": "completed"}
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "overdue":
        return dangerColor;
      case "at_risk":
        return warningColor;
      case "on_track":
        return successColor;
      case "completed":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> _getFilteredDeadlines() {
    List<Map<String, dynamic>> filtered = deadlines;

    if (selectedProject != "all") {
      filtered = filtered.where((deadline) => deadline["project"] == selectedProject).toList();
    }

    switch (selectedFilter) {
      case "overdue":
        filtered = filtered.where((deadline) => deadline["status"] == "overdue").toList();
        break;
      case "due_soon":
        filtered = filtered.where((deadline) => (deadline["daysLeft"] as int) <= 3 && (deadline["daysLeft"] as int) >= 0).toList();
        break;
      case "at_risk":
        filtered = filtered.where((deadline) => deadline["status"] == "at_risk").toList();
        break;
      case "on_track":
        filtered = filtered.where((deadline) => deadline["status"] == "on_track").toList();
        break;
      case "completed":
        filtered = filtered.where((deadline) => deadline["status"] == "completed").toList();
        break;
    }

    // Sort by days left (overdue first, then ascending)
    filtered.sort((a, b) {
      int aDaysLeft = a["daysLeft"] as int;
      int bDaysLeft = b["daysLeft"] as int;
      
      if (aDaysLeft < 0 && bDaysLeft >= 0) return -1;
      if (aDaysLeft >= 0 && bDaysLeft < 0) return 1;
      if (aDaysLeft < 0 && bDaysLeft < 0) return bDaysLeft.compareTo(aDaysLeft);
      return aDaysLeft.compareTo(bDaysLeft);
    });

    return filtered;
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Deadline Management",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Status",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Project",
                  items: [
                    {"label": "All Projects", "value": "all"},
                    ...projects.map((project) => {"label": project, "value": project}).toList()
                  ],
                  value: selectedProject,
                  onChanged: (value, label) {
                    selectedProject = value;
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

  Widget _buildDeadlineStats() {
    List<Map<String, dynamic>> filtered = _getFilteredDeadlines();
    int totalDeadlines = filtered.length;
    int overdue = deadlines.where((d) => d["status"] == "overdue").length;
    int dueSoon = deadlines.where((d) => (d["daysLeft"] as int) <= 3 && (d["daysLeft"] as int) >= 0).length;
    int atRisk = deadlines.where((d) => d["status"] == "at_risk").length;

    return Container(
      margin: EdgeInsets.all(spSm),
      child: Row(
        children: [
          _buildStatCard("Total", totalDeadlines, primaryColor, Icons.schedule),
          _buildStatCard("Overdue", overdue, dangerColor, Icons.warning),
          _buildStatCard("Due Soon", dueSoon, warningColor, Icons.access_time),
          _buildStatCard("At Risk", atRisk, warningColor, Icons.error_outline),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int value, Color color, IconData icon) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: spSm),
            Text(
              "$value",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeadlinesList() {
    List<Map<String, dynamic>> filtered = _getFilteredDeadlines();

    if (filtered.isEmpty) {
      return Container(
        margin: EdgeInsets.all(spSm),
        padding: EdgeInsets.all(spLg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              Icons.schedule,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No deadlines found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Try adjusting your filters to see more results",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: filtered.map((deadline) => _buildDeadlineItem(deadline)).toList(),
      ),
    );
  }

  Widget _buildDeadlineItem(Map<String, dynamic> deadline) {
    int daysLeft = deadline["daysLeft"] as int;
    String timeLeft = _getTimeLeftText(daysLeft);
    double progress = (deadline["progress"] as int).toDouble();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor, width: 0.5),
          left: BorderSide(color: _getStatusColor(deadline["status"]), width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStatusColor(deadline["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getCategoryIcon(deadline["category"]),
                  color: _getStatusColor(deadline["status"]),
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${deadline["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${deadline["project"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(deadline["priority"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${deadline["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getPriorityColor(deadline["priority"]),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    timeLeft,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: daysLeft < 0 ? dangerColor : 
                             daysLeft <= 3 ? warningColor : disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "${deadline["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${deadline["assignee"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${DateTime.parse(deadline["deadline"]).day}/${DateTime.parse(deadline["deadline"]).month}/${DateTime.parse(deadline["deadline"]).year}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Progress",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${progress.toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusXs),
                child: LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress == 100 ? successColor : primaryColor,
                  ),
                  minHeight: 6,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getTimeLeftText(int daysLeft) {
    if (daysLeft < 0) {
      return "${(-daysLeft)} days overdue";
    } else if (daysLeft == 0) {
      return "Due today";
    } else if (daysLeft == 1) {
      return "Due tomorrow";
    } else {
      return "$daysLeft days left";
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "design":
        return Icons.design_services;
      case "development":
        return Icons.code;
      case "database":
        return Icons.storage;
      case "security":
        return Icons.security;
      case "testing":
        return Icons.bug_report;
      case "documentation":
        return Icons.description;
      default:
        return Icons.task;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildDeadlineStats(),
            _buildDeadlinesList(),
          ],
        ),
      ),
    );
  }
}
