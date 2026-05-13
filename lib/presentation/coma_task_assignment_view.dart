import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaTaskAssignmentView extends StatefulWidget {
  const ComaTaskAssignmentView({super.key});

  @override
  State<ComaTaskAssignmentView> createState() => _ComaTaskAssignmentViewState();
}

class _ComaTaskAssignmentViewState extends State<ComaTaskAssignmentView> {
  String selectedProject = "all";
  String selectedTeam = "all";
  String selectedStatus = "all";
  String selectedSkill = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> projects = [
    {
      "id": "PRJ001",
      "name": "Skyline Tower",
      "status": "active",
    },
    {
      "id": "PRJ002", 
      "name": "Harbor Bridge",
      "status": "active",
    },
    {
      "id": "PRJ003",
      "name": "Metro Station Complex",
      "status": "planning",
    },
  ];

  List<Map<String, dynamic>> teams = [
    {"label": "Construction", "value": "construction"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Safety", "value": "safety"},
    {"label": "Management", "value": "management"},
    {"label": "Quality Control", "value": "quality_control"},
  ];

  List<Map<String, dynamic>> statuses = [
    {"label": "Available", "value": "available"},
    {"label": "Assigned", "value": "assigned"},
    {"label": "Busy", "value": "busy"},
    {"label": "On Leave", "value": "on_leave"},
    {"label": "Training", "value": "training"},
  ];

  List<Map<String, dynamic>> skills = [
    {"label": "Welding", "value": "welding"},
    {"label": "Electrical", "value": "electrical"},
    {"label": "Concrete", "value": "concrete"},
    {"label": "Steel Work", "value": "steel_work"},
    {"label": "Heavy Equipment", "value": "heavy_equipment"},
    {"label": "Safety Inspection", "value": "safety_inspection"},
  ];

  List<Map<String, dynamic>> taskAssignments = [
    {
      "id": "TA001",
      "employeeId": "EMP001",
      "employeeName": "John Smith",
      "position": "Senior Foreman",
      "team": "construction",
      "skills": ["concrete", "steel_work", "heavy_equipment"],
      "certifications": ["OSHA 30", "Crane Operator", "Safety Manager"],
      "currentTask": "Foundation Excavation",
      "taskId": "TSK001",
      "projectId": "PRJ001",
      "projectName": "Skyline Tower",
      "status": "assigned",
      "workload": 85,
      "assignedDate": "2024-01-15",
      "estimatedCompletion": "2024-02-15",
      "hourlyRate": 35.0,
      "experienceYears": 12,
      "availability": [
        {"date": "2024-02-01", "hours": 8},
        {"date": "2024-02-02", "hours": 8},
        {"date": "2024-02-03", "hours": 4},
      ],
      "performance": {
        "rating": 4.8,
        "completedTasks": 45,
        "onTimeCompletion": 92,
      },
      "contactInfo": {
        "phone": "+1-555-0101",
        "email": "john.smith@construction.com",
      },
      "notes": "Experienced in large-scale foundation work. Excellent safety record.",
      "createdAt": "2024-01-15T08:30:00Z",
      "updatedAt": "2024-01-25T14:20:00Z",
    },
    {
      "id": "TA002",
      "employeeId": "EMP002",
      "employeeName": "Sarah Johnson",
      "position": "Structural Engineer",
      "team": "engineering",
      "skills": ["steel_work", "welding", "safety_inspection"],
      "certifications": ["PE License", "AWS Welding", "Structural Design"],
      "currentTask": "Steel Frame Design Review",
      "taskId": "TSK002",
      "projectId": "PRJ001",
      "projectName": "Skyline Tower",
      "status": "assigned",
      "workload": 70,
      "assignedDate": "2024-01-12",
      "estimatedCompletion": "2024-03-20",
      "hourlyRate": 55.0,
      "experienceYears": 8,
      "availability": [
        {"date": "2024-02-01", "hours": 8},
        {"date": "2024-02-02", "hours": 8},
        {"date": "2024-02-03", "hours": 8},
      ],
      "performance": {
        "rating": 4.9,
        "completedTasks": 32,
        "onTimeCompletion": 96,
      },
      "contactInfo": {
        "phone": "+1-555-0102",
        "email": "sarah.johnson@engineering.com",
      },
      "notes": "Specialist in high-rise structural systems. Strong analytical skills.",
      "createdAt": "2024-01-12T10:15:00Z",
      "updatedAt": "2024-01-20T09:45:00Z",
    },
    {
      "id": "TA003",
      "employeeId": "EMP003",
      "employeeName": "Mike Davis",
      "position": "Equipment Operator",
      "team": "construction",
      "skills": ["heavy_equipment", "concrete"],
      "certifications": ["Heavy Equipment License", "CDL Class A", "OSHA 10"],
      "currentTask": null,
      "taskId": null,
      "projectId": null,
      "projectName": null,
      "status": "available",
      "workload": 0,
      "assignedDate": null,
      "estimatedCompletion": null,
      "hourlyRate": 28.0,
      "experienceYears": 15,
      "availability": [
        {"date": "2024-02-01", "hours": 8},
        {"date": "2024-02-02", "hours": 8},
        {"date": "2024-02-03", "hours": 8},
      ],
      "performance": {
        "rating": 4.6,
        "completedTasks": 78,
        "onTimeCompletion": 88,
      },
      "contactInfo": {
        "phone": "+1-555-0103",
        "email": "mike.davis@construction.com",
      },
      "notes": "Expert in crane and excavator operations. Available for immediate assignment.",
      "createdAt": "2024-01-02T07:30:00Z",
      "updatedAt": "2024-01-25T16:45:00Z",
    },
    {
      "id": "TA004",
      "employeeId": "EMP004",
      "employeeName": "Lisa Wilson",
      "position": "Electrical Supervisor",
      "team": "engineering",
      "skills": ["electrical"],
      "certifications": ["Master Electrician", "NECA Certification", "Safety Training"],
      "currentTask": "Electrical System Installation",
      "taskId": "TSK004",
      "projectId": "PRJ002",
      "projectName": "Harbor Bridge",
      "status": "assigned",
      "workload": 90,
      "assignedDate": "2024-01-20",
      "estimatedCompletion": "2024-02-10",
      "hourlyRate": 42.0,
      "experienceYears": 10,
      "availability": [
        {"date": "2024-02-01", "hours": 6},
        {"date": "2024-02-02", "hours": 8},
        {"date": "2024-02-03", "hours": 0},
      ],
      "performance": {
        "rating": 4.7,
        "completedTasks": 38,
        "onTimeCompletion": 94,
      },
      "contactInfo": {
        "phone": "+1-555-0104",
        "email": "lisa.wilson@electrical.com",
      },
      "notes": "Highly skilled in complex electrical systems. Currently managing critical bridge infrastructure.",
      "createdAt": "2024-01-15T11:20:00Z",
      "updatedAt": "2024-01-28T13:30:00Z",
    },
    {
      "id": "TA005",
      "employeeId": "EMP005",
      "employeeName": "Tom Brown",
      "position": "Safety Inspector",
      "team": "safety",
      "skills": ["safety_inspection"],
      "certifications": ["OSHA 30", "Safety Inspector License", "First Aid/CPR"],
      "currentTask": "Safety Compliance Audit",
      "taskId": "TSK006",
      "projectId": "PRJ001",
      "projectName": "Skyline Tower",
      "status": "assigned",
      "workload": 60,
      "assignedDate": "2024-01-22",
      "estimatedCompletion": "2024-01-24",
      "hourlyRate": 38.0,
      "experienceYears": 7,
      "availability": [
        {"date": "2024-02-01", "hours": 8},
        {"date": "2024-02-02", "hours": 8},
        {"date": "2024-02-03", "hours": 8},
      ],
      "performance": {
        "rating": 4.9,
        "completedTasks": 28,
        "onTimeCompletion": 98,
      },
      "contactInfo": {
        "phone": "+1-555-0105",
        "email": "tom.brown@safety.com",
      },
      "notes": "Meticulous attention to safety protocols. Zero safety incidents on assigned projects.",
      "createdAt": "2024-01-18T09:15:00Z",
      "updatedAt": "2024-01-30T10:20:00Z",
    },
    {
      "id": "TA006",
      "employeeId": "EMP006",
      "employeeName": "Rachel Green",
      "position": "Project Coordinator",
      "team": "management",
      "skills": [],
      "certifications": ["PMP", "Construction Management", "LEED AP"],
      "currentTask": null,
      "taskId": null,
      "projectId": null,
      "projectName": null,
      "status": "on_leave",
      "workload": 0,
      "assignedDate": null,
      "estimatedCompletion": null,
      "hourlyRate": 48.0,
      "experienceYears": 6,
      "availability": [],
      "performance": {
        "rating": 4.8,
        "completedTasks": 25,
        "onTimeCompletion": 96,
      },
      "contactInfo": {
        "phone": "+1-555-0106",
        "email": "rachel.green@management.com",
      },
      "notes": "On maternity leave until March 2024. Excellent project coordination skills.",
      "createdAt": "2024-01-20T14:45:00Z",
      "updatedAt": "2024-01-24T17:30:00Z",
    },
  ];

  List<Map<String, dynamic>> get filteredAssignments {
    List<Map<String, dynamic>> filtered = taskAssignments;

    if (selectedProject != "all") {
      filtered = filtered.where((assignment) => 
        assignment["projectId"] == selectedProject || assignment["projectId"] == null).toList();
    }

    if (selectedTeam != "all") {
      filtered = filtered.where((assignment) => assignment["team"] == selectedTeam).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((assignment) => assignment["status"] == selectedStatus).toList();
    }

    if (selectedSkill != "all") {
      filtered = filtered.where((assignment) {
        List skills = assignment["skills"] as List;
        return skills.contains(selectedSkill);
      }).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((assignment) {
        return assignment["employeeName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
            assignment["position"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
            assignment["currentTask"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  int get totalEmployees => filteredAssignments.length;

  int get availableEmployees {
    return filteredAssignments.where((assignment) => assignment["status"] == "available").length;
  }

  int get assignedEmployees {
    return filteredAssignments.where((assignment) => assignment["status"] == "assigned").length;
  }

  double get averageWorkload {
    if (filteredAssignments.isEmpty) return 0.0;
    double totalWorkload = filteredAssignments.fold(0.0, (sum, assignment) => sum + (assignment["workload"] as int));
    return totalWorkload / filteredAssignments.length;
  }

  double get averagePerformance {
    if (filteredAssignments.isEmpty) return 0.0;
    double totalRating = filteredAssignments.fold(0.0, (sum, assignment) {
      Map performance = assignment["performance"] as Map;
      return sum + (performance["rating"] as double);
    });
    return totalRating / filteredAssignments.length;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "available":
        return successColor;
      case "assigned":
        return infoColor;
      case "busy":
        return warningColor;
      case "on_leave":
        return disabledBoldColor;
      case "training":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case "available":
        return "Available";
      case "assigned":
        return "Assigned";
      case "busy":
        return "Busy";
      case "on_leave":
        return "On Leave";
      case "training":
        return "Training";
      default:
        return "Unknown";
    }
  }

  Color getWorkloadColor(int workload) {
    if (workload >= 90) return dangerColor;
    if (workload >= 70) return warningColor;
    if (workload >= 40) return infoColor;
    return successColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Assignment"),
        actions: [
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              si("Employee schedule view opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              si("Task assignment analytics opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Employees",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$totalEmployees",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "across all teams",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Available",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$availableEmployees",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "ready for assignment",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.assignment_ind,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Assigned",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$assignedEmployees",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "${averageWorkload.toStringAsFixed(0)}% avg workload",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Performance",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${averagePerformance.toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "average rating",
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

            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search employees",
                          value: searchQuery,
                          hint: "Search by name, position, or current task",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Project",
                          items: [
                            {"label": "All Projects", "value": "all"},
                            ...projects.map((project) => {
                              "label": "${project["name"]}",
                              "value": "${project["id"]}",
                            }),
                          ],
                          value: selectedProject,
                          onChanged: (value, label) {
                            selectedProject = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Team",
                          items: [
                            {"label": "All Teams", "value": "all"},
                            ...teams,
                          ],
                          value: selectedTeam,
                          onChanged: (value, label) {
                            selectedTeam = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": "all"},
                            ...statuses,
                          ],
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Skill",
                          items: [
                            {"label": "All Skills", "value": "all"},
                            ...skills,
                          ],
                          value: selectedSkill,
                          onChanged: (value, label) {
                            selectedSkill = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Employee Assignments List
            Container(
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
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Employee Task Assignments",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Assign Task",
                          size: bs.sm,
                          onPressed: () {
                            si("Assign new task to employee");
                          },
                        ),
                      ],
                    ),
                  ),
                  if (filteredAssignments.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.assignment_ind,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No employees found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your filters or add new employees",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredAssignments.map((assignment) {
                      Map performance = assignment["performance"] as Map;
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: disabledOutlineBorderColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: primaryColor,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${assignment["employeeName"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: getStatusColor("${assignment["status"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              getStatusText("${assignment["status"]}"),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: getStatusColor("${assignment["status"]}"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${assignment["position"]} • ${assignment["team"].toString().substring(0, 1).toUpperCase()}${assignment["team"].toString().substring(1)} Team",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: warningColor,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "${(performance["rating"] as double).toStringAsFixed(1)}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: warningColor,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "${assignment["experienceYears"]} years exp",
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
                              ],
                            ),

                            // Current Assignment or Availability
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spSm,
                                children: [
                                  if (assignment["currentTask"] != null) ...[
                                    Row(
                                      children: [
                                        Text(
                                          "Current Assignment",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${assignment["workload"]}% workload",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: getWorkloadColor(assignment["workload"] as int),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${assignment["currentTask"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${assignment["projectName"]} • Due: ${assignment["estimatedCompletion"] != null ? DateTime.parse(assignment["estimatedCompletion"]).dMMMy : "TBD"}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ] else ...[
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.schedule,
                                          color: successColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Available for Assignment",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Ready to take on new tasks immediately",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],

                                  // Skills and Certifications
                                  if ((assignment["skills"] as List).isNotEmpty) ...[
                                    Text(
                                      "Skills",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Wrap(
                                      spacing: spXs,
                                      runSpacing: spXs,
                                      children: (assignment["skills"] as List).map((skill) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: secondaryColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${skill}".replaceAll("_", " ").toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: secondaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],

                                  // Performance Stats
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "Completed Tasks",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${performance["completedTasks"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "On-Time Rate",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${performance["onTimeCompletion"]}%",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        spacing: 2,
                                        children: [
                                          Text(
                                            "Hourly Rate",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${(assignment["hourlyRate"] as double).toStringAsFixed(0)}/hr",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  if (assignment["notes"] != null && (assignment["notes"] as String).isNotEmpty)
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(top: spXs),
                                      child: Text(
                                        "${assignment["notes"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),

                                  Row(
                                    spacing: spSm,
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Profile",
                                          size: bs.sm,
                                          onPressed: () {
                                            si("Viewing employee profile for ${assignment["employeeId"]}");
                                          },
                                        ),
                                      ),
                                      if (assignment["status"] == "available")
                                        Expanded(
                                          child: QButton(
                                            label: "Assign Task",
                                            size: bs.sm,
                                            onPressed: () {
                                              si("Assigning task to ${assignment["employeeName"]}");
                                            },
                                          ),
                                        )
                                      else
                                        Expanded(
                                          child: QButton(
                                            label: "Update Assignment",
                                            size: bs.sm,
                                            onPressed: () {
                                              si("Updating assignment for ${assignment["employeeName"]}");
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
