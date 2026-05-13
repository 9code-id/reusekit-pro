import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaProgressTrackingView extends StatefulWidget {
  const ComaProgressTrackingView({super.key});

  @override
  State<ComaProgressTrackingView> createState() => _ComaProgressTrackingViewState();
}

class _ComaProgressTrackingViewState extends State<ComaProgressTrackingView> {
  String selectedProject = "All Projects";
  String selectedStatus = "All Status";
  String selectedTimeframe = "This Month";

  List<Map<String, dynamic>> projectData = [
    {
      "id": "PRJ001",
      "name": "Highway Extension Project",
      "manager": "John Peterson",
      "startDate": "2024-01-15",
      "endDate": "2024-06-30",
      "status": "In Progress",
      "progress": 68.5,
      "budget": 2500000.00,
      "spent": 1710000.00,
      "tasks": {
        "total": 45,
        "completed": 31,
        "inProgress": 8,
        "pending": 6
      },
      "milestones": [
        {"name": "Foundation Work", "status": "Completed", "date": "2024-03-15"},
        {"name": "Structural Framework", "status": "Completed", "date": "2024-05-20"},
        {"name": "Road Surface", "status": "In Progress", "date": "2024-07-10"},
        {"name": "Final Inspection", "status": "Pending", "date": "2024-08-15"}
      ],
      "equipment": ["EQ001", "EQ005", "EQ006"],
      "team": 12,
      "category": "Infrastructure"
    },
    {
      "id": "PRJ002",
      "name": "Shopping Mall Construction",
      "manager": "Sarah Mitchell",
      "startDate": "2024-02-01",
      "endDate": "2024-12-31",
      "status": "In Progress",
      "progress": 42.3,
      "budget": 5800000.00,
      "spent": 2450000.00,
      "tasks": {
        "total": 78,
        "completed": 33,
        "inProgress": 18,
        "pending": 27
      },
      "milestones": [
        {"name": "Site Preparation", "status": "Completed", "date": "2024-03-01"},
        {"name": "Foundation & Basement", "status": "Completed", "date": "2024-06-01"},
        {"name": "Structural Steel", "status": "In Progress", "date": "2024-09-01"},
        {"name": "Interior Finishing", "status": "Pending", "date": "2024-11-01"}
      ],
      "equipment": ["EQ002", "EQ003", "EQ004"],
      "team": 25,
      "category": "Commercial"
    },
    {
      "id": "PRJ003",
      "name": "Residential Complex Phase 1",
      "manager": "Michael Rodriguez",
      "startDate": "2024-03-10",
      "endDate": "2024-10-15",
      "status": "In Progress",
      "progress": 75.8,
      "budget": 3200000.00,
      "spent": 2426000.00,
      "tasks": {
        "total": 52,
        "completed": 39,
        "inProgress": 7,
        "pending": 6
      },
      "milestones": [
        {"name": "Site Development", "status": "Completed", "date": "2024-04-15"},
        {"name": "Building Construction", "status": "Completed", "date": "2024-07-30"},
        {"name": "Utilities Installation", "status": "In Progress", "date": "2024-09-15"},
        {"name": "Landscaping", "status": "Pending", "date": "2024-10-10"}
      ],
      "equipment": ["EQ001", "EQ006"],
      "team": 18,
      "category": "Residential"
    },
    {
      "id": "PRJ004",
      "name": "Industrial Warehouse",
      "manager": "Emma Thompson",
      "startDate": "2024-04-20",
      "endDate": "2025-02-28",
      "status": "In Progress",
      "progress": 28.7,
      "budget": 1800000.00,
      "spent": 516600.00,
      "tasks": {
        "total": 35,
        "completed": 10,
        "inProgress": 12,
        "pending": 13
      },
      "milestones": [
        {"name": "Ground Preparation", "status": "Completed", "date": "2024-05-30"},
        {"name": "Foundation Pouring", "status": "In Progress", "date": "2024-07-15"},
        {"name": "Steel Structure", "status": "Pending", "date": "2024-10-01"},
        {"name": "Roofing & Siding", "status": "Pending", "date": "2024-12-15"}
      ],
      "equipment": ["EQ002", "EQ004", "EQ005"],
      "team": 15,  
      "category": "Industrial"
    }
  ];

  List<Map<String, dynamic>> projectOptions = [
    {"label": "All Projects", "value": "All Projects"},
    {"label": "Highway Extension Project", "value": "PRJ001"},
    {"label": "Shopping Mall Construction", "value": "PRJ002"},
    {"label": "Residential Complex Phase 1", "value": "PRJ003"},
    {"label": "Industrial Warehouse", "value": "PRJ004"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "On Hold", "value": "On Hold"},
    {"label": "Delayed", "value": "Delayed"}
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"}
  ];

  List<Map<String, dynamic>> get filteredProjects {
    return projectData.where((project) {
      bool matchesProject = selectedProject == "All Projects" || 
          "${project["id"]}" == selectedProject;
      
      bool matchesStatus = selectedStatus == "All Status" ||
          "${project["status"]}" == selectedStatus;
      
      return matchesProject && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Progress":
        return primaryColor;
      case "Completed":
        return successColor;
      case "On Hold":
        return warningColor;
      case "Delayed":
        return dangerColor;
      case "Pending":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getMilestoneStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return primaryColor;
      case "Pending":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
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
              child: Column(
                spacing: spSm,
                children: [
                  QDropdownField(
                    label: "Project",
                    items: projectOptions,
                    value: selectedProject,
                    onChanged: (value, label) {
                      selectedProject = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Timeframe",
                          items: timeframeOptions,
                          value: selectedTimeframe,
                          onChanged: (value, label) {
                            selectedTimeframe = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Overall Progress Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Overall Progress Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${filteredProjects.length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Active Projects",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${((filteredProjects.fold(0.0, (sum, p) => sum + (p["progress"] as num).toDouble())) / filteredProjects.length).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Average Progress",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${((filteredProjects.fold(0.0, (sum, p) => sum + (p["budget"] as num).toDouble())) / 1000000).toStringAsFixed(1)}M",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Total Budget",
                              textAlign: TextAlign.center,
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

            // Project Progress Cards
            ...filteredProjects.map((project) {
              final tasks = project["tasks"] as Map<String, dynamic>;
              final milestones = project["milestones"] as List;
              double progressPercentage = (project["progress"] as num).toDouble();
              double budgetUsage = ((project["spent"] as num).toDouble() / (project["budget"] as num).toDouble()) * 100;

              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor("${project["status"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Header
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${project["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.person, size: 12, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${project["manager"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(Icons.group, size: 12, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${project["team"]} members",
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${project["status"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${project["status"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: _getStatusColor("${project["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Overall Progress",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${progressPercentage.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: progressPercentage / 100,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: progressPercentage > 75 
                                    ? successColor 
                                    : progressPercentage > 50 
                                        ? primaryColor 
                                        : progressPercentage > 25 
                                            ? warningColor 
                                            : dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Tasks Summary
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${tasks["completed"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Completed",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${tasks["inProgress"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "In Progress",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${tasks["pending"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Pending",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${tasks["total"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "Total Tasks",
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
                    ),

                    SizedBox(height: spSm),

                    // Budget Information
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Budget Usage",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${((project["spent"] as num).toDouble()).currency} / \$${((project["budget"] as num).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${budgetUsage.toStringAsFixed(1)}% used",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: budgetUsage > 80 ? dangerColor : successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Timeline",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${project["startDate"]} - ${project["endDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Milestones
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Milestones",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        ...milestones.take(3).map((milestone) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: _getMilestoneStatusColor("${milestone["status"]}"),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${milestone["name"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${milestone["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getMilestoneStatusColor("${milestone["status"]}"),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Action Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
