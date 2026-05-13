import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaMilestoneView extends StatefulWidget {
  const PmaMilestoneView({super.key});

  @override
  State<PmaMilestoneView> createState() => _PmaMilestoneViewState();
}

class _PmaMilestoneViewState extends State<PmaMilestoneView> {
  String selectedProject = "all";
  String selectedStatus = "all";
  String selectedPriority = "all";

  List<Map<String, dynamic>> projectOptions = [
    {"label": "All Projects", "value": "all"},
    {"label": "E-commerce Platform", "value": "ecommerce"},
    {"label": "Mobile App Development", "value": "mobile"},
    {"label": "Website Redesign", "value": "website"},
    {"label": "CRM System", "value": "crm"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Not Started", "value": "not_started"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "On Hold", "value": "on_hold"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "all"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> milestones = [
    {
      "id": "1",
      "title": "Project Setup & Planning",
      "description": "Initial project setup, requirements gathering, and planning phase",
      "project": "E-commerce Platform",
      "status": "completed",
      "priority": "high",
      "progress": 100,
      "startDate": "2024-05-01",
      "dueDate": "2024-05-15",
      "completedDate": "2024-05-14",
      "assignedTo": "Sarah Johnson",
      "tasks": [
        {"title": "Requirements Gathering", "completed": true},
        {"title": "Technical Specification", "completed": true},
        {"title": "Project Timeline", "completed": true},
        {"title": "Resource Allocation", "completed": true},
      ],
    },
    {
      "id": "2",
      "title": "Frontend Development",
      "description": "Complete frontend development including UI/UX implementation",
      "project": "E-commerce Platform",
      "status": "in_progress",
      "priority": "high",
      "progress": 75,
      "startDate": "2024-05-16",
      "dueDate": "2024-06-30",
      "completedDate": null,
      "assignedTo": "Michael Chen",
      "tasks": [
        {"title": "Homepage Design", "completed": true},
        {"title": "Product Catalog", "completed": true},
        {"title": "Shopping Cart", "completed": true},
        {"title": "Checkout Process", "completed": false},
        {"title": "User Dashboard", "completed": false},
      ],
    },
    {
      "id": "3",
      "title": "Backend API Development",
      "description": "Develop REST APIs and database integration",
      "project": "E-commerce Platform",
      "status": "in_progress",
      "priority": "high",
      "progress": 60,
      "startDate": "2024-05-20",
      "dueDate": "2024-07-15",
      "completedDate": null,
      "assignedTo": "David Wilson",
      "tasks": [
        {"title": "User Authentication", "completed": true},
        {"title": "Product Management", "completed": true},
        {"title": "Order Processing", "completed": false},
        {"title": "Payment Integration", "completed": false},
        {"title": "Inventory Management", "completed": false},
      ],
    },
    {
      "id": "4",
      "title": "Mobile App Beta",
      "description": "Complete beta version of mobile application",
      "project": "Mobile App Development",
      "status": "not_started",
      "priority": "medium",
      "progress": 0,
      "startDate": "2024-07-01",
      "dueDate": "2024-08-15",
      "completedDate": null,
      "assignedTo": "Emma Davis",
      "tasks": [
        {"title": "App Architecture", "completed": false},
        {"title": "Core Features", "completed": false},
        {"title": "UI Implementation", "completed": false},
        {"title": "Testing", "completed": false},
      ],
    },
    {
      "id": "5",
      "title": "Website Launch",
      "description": "Final website deployment and launch activities",
      "project": "Website Redesign",
      "status": "on_hold",
      "priority": "low",
      "progress": 40,
      "startDate": "2024-06-01",
      "dueDate": "2024-07-01",
      "completedDate": null,
      "assignedTo": "Alex Thompson",
      "tasks": [
        {"title": "Content Migration", "completed": true},
        {"title": "SEO Optimization", "completed": true},
        {"title": "Performance Testing", "completed": false},
        {"title": "Go-Live Checklist", "completed": false},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredMilestones {
    List<Map<String, dynamic>> filtered = milestones;
    
    if (selectedProject != "all") {
      filtered = filtered.where((milestone) => 
        (milestone["project"] as String).toLowerCase().contains(selectedProject.toLowerCase())
      ).toList();
    }
    
    if (selectedStatus != "all") {
      filtered = filtered.where((milestone) => milestone["status"] == selectedStatus).toList();
    }
    
    if (selectedPriority != "all") {
      filtered = filtered.where((milestone) => milestone["priority"] == selectedPriority).toList();
    }
    
    return filtered;
  }

  int get completedMilestones => milestones.where((m) => m["status"] == "completed").length;
  int get inProgressMilestones => milestones.where((m) => m["status"] == "in_progress").length;
  int get upcomingMilestones => milestones.where((m) => m["status"] == "not_started").length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Milestone Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createMilestone,
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: _viewCalendar,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildMilestoneOverview(),
            _buildFiltersSection(),
            _buildMilestonesList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createMilestone,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildMilestoneOverview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.flag,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Milestone Overview",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "${milestones.length} Total Milestones",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${inProgressMilestones} Active",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: Colors.white.withAlpha(100)),
          Row(
            children: [
              Expanded(
                child: _buildOverviewStat(
                  "Completed",
                  "$completedMilestones",
                  Icons.check_circle,
                ),
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.white.withAlpha(100),
              ),
              Expanded(
                child: _buildOverviewStat(
                  "In Progress",
                  "$inProgressMilestones",
                  Icons.hourglass_empty,
                ),
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.white.withAlpha(100),
              ),
              Expanded(
                child: _buildOverviewStat(
                  "Upcoming",
                  "$upcomingMilestones",
                  Icons.schedule,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewStat(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withAlpha(200),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
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
            "Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Project",
                  items: projectOptions,
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
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Priority",
            items: priorityOptions,
            value: selectedPriority,
            onChanged: (value, label) {
              selectedPriority = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMilestonesList() {
    if (filteredMilestones.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.flag,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No milestones found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your filters or create a new milestone",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Milestones (${filteredMilestones.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...filteredMilestones.map((milestone) => _buildMilestoneCard(milestone)).toList(),
      ],
    );
  }

  Widget _buildMilestoneCard(Map<String, dynamic> milestone) {
    String status = milestone["status"];
    String priority = milestone["priority"];
    int progress = milestone["progress"] as int;
    
    Color statusColor = _getStatusColor(status);
    Color priorityColor = _getPriorityColor(priority);
    
    List<Map<String, dynamic>> tasks = milestone["tasks"] as List<Map<String, dynamic>>;
    int completedTasks = tasks.where((task) => task["completed"] == true).length;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${milestone["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${milestone["description"]}",
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: priorityColor),
                    ),
                    child: Text(
                      priority.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "$progress%",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.transparent,
              color: statusColor,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.business,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${milestone["project"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${milestone["assignedTo"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Due: ${milestone["dueDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: statusColor),
                ),
                child: Text(
                  status.replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$completedTasks/${tasks.length} Tasks",
                  style: TextStyle(
                    fontSize: 10,
                    color: infoColor,
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _viewMilestoneDetails(milestone),
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.visibility,
                        size: 16,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  GestureDetector(
                    onTap: () => _editMilestone(milestone),
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 16,
                        color: infoColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  GestureDetector(
                    onTap: () => _deleteMilestone(milestone["id"]),
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.delete,
                        size: 16,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return infoColor;
      case "not_started":
        return warningColor;
      case "on_hold":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _createMilestone() {
    si("Create new milestone");
  }

  void _viewCalendar() {
    si("View milestone calendar");
  }

  void _viewMilestoneDetails(Map<String, dynamic> milestone) {
    si("View details for: ${milestone["title"]}");
  }

  void _editMilestone(Map<String, dynamic> milestone) {
    si("Edit milestone: ${milestone["title"]}");
  }

  void _deleteMilestone(String milestoneId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this milestone?");
    if (isConfirmed) {
      setState(() {
        milestones.removeWhere((milestone) => milestone["id"] == milestoneId);
      });
      ss("Milestone deleted successfully");
    }
  }
}
