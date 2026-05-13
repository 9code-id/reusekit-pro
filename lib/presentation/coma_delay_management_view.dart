import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaDelayManagementView extends StatefulWidget {
  const ComaDelayManagementView({super.key});

  @override
  State<ComaDelayManagementView> createState() => _ComaDelayManagementViewState();
}

class _ComaDelayManagementViewState extends State<ComaDelayManagementView> {
  String searchQuery = "";
  String selectedProject = "All";
  String selectedSeverity = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> projectItems = [
    {"label": "All Projects", "value": "All"},
    {"label": "Downtown Office", "value": "Downtown Office"},
    {"label": "Residential Complex", "value": "Residential Complex"},
    {"label": "Shopping Mall", "value": "Shopping Mall"},
    {"label": "Hospital Wing", "value": "Hospital Wing"},
  ];

  List<Map<String, dynamic>> severityItems = [
    {"label": "All Severities", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "Major", "value": "Major"},
    {"label": "Minor", "value": "Minor"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Mitigating", "value": "Mitigating"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Escalated", "value": "Escalated"},
  ];

  List<Map<String, dynamic>> delays = [
    {
      "id": "DEL001",
      "title": "Material Delivery Delay",
      "description": "Steel beam delivery delayed by 5 days due to supplier issues",
      "project": "Downtown Office",
      "severity": "Major",
      "status": "Active",
      "delayDays": 5,
      "costImpact": 25000,
      "category": "Material",
      "reportedDate": "2024-01-10",
      "expectedResolution": "2024-01-25",
      "reportedBy": "John Smith",
      "assignedTo": "Sarah Johnson",
      "rootCause": "Supplier production delays",
      "impact": "Foundation work cannot proceed",
      "mitigationActions": [
        "Source alternative supplier",
        "Reschedule related tasks",
        "Notify client of delay"
      ],
      "affectedTasks": ["Foundation pour", "Steel installation", "Concrete work"],
      "progress": 30,
    },
    {
      "id": "DEL002", 
      "title": "Weather-Related Delays",
      "description": "Continuous rain for 3 days stopped all outdoor work",
      "project": "Residential Complex",
      "severity": "Major",
      "status": "Mitigating",
      "delayDays": 3,
      "costImpact": 18000,
      "category": "Weather",
      "reportedDate": "2024-01-12",
      "expectedResolution": "2024-01-20",
      "reportedBy": "Mike Davis",
      "assignedTo": "Lisa Brown",
      "rootCause": "Unexpected heavy rainfall",
      "impact": "Excavation and concrete work halted",
      "mitigationActions": [
        "Focus on indoor activities",
        "Prepare drainage systems",
        "Schedule catch-up work"
      ],
      "affectedTasks": ["Excavation", "Site preparation", "Outdoor concrete"],
      "progress": 60,
    },
    {
      "id": "DEL003",
      "title": "Equipment Breakdown",
      "description": "Main excavator broke down and requires major repairs",
      "project": "Shopping Mall",
      "severity": "Critical",
      "status": "Escalated",
      "delayDays": 7,
      "costImpact": 35000,
      "category": "Equipment",
      "reportedDate": "2024-01-08",
      "expectedResolution": "2024-01-28",
      "reportedBy": "Robert Wilson",
      "assignedTo": "Equipment Manager",
      "rootCause": "Hydraulic system failure",
      "impact": "All excavation work stopped",
      "mitigationActions": [
        "Rent replacement equipment",
        "Expedite repair process",
        "Adjust project timeline"
      ],
      "affectedTasks": ["Site excavation", "Foundation prep", "Utility installation"],
      "progress": 45,
    },
    {
      "id": "DEL004",
      "title": "Permit Approval Delay",
      "description": "Building permit approval taking longer than expected",
      "project": "Hospital Wing",
      "severity": "Major",
      "status": "Active",
      "delayDays": 10,
      "costImpact": 40000,
      "category": "Regulatory",
      "reportedDate": "2024-01-05",
      "expectedResolution": "2024-01-30",
      "reportedBy": "Jennifer Lee",
      "assignedTo": "Legal Team",
      "rootCause": "Additional documentation requirements",
      "impact": "Cannot start construction activities",
      "mitigationActions": [
        "Submit additional documents",
        "Schedule meeting with authorities",
        "Prepare alternative plans"
      ],
      "affectedTasks": ["Construction start", "Site mobilization", "Initial work"],
      "progress": 20,
    },
    {
      "id": "DEL005",
      "title": "Labor Shortage",
      "description": "Skilled electricians unavailable due to competing projects",
      "project": "Downtown Office",
      "severity": "Minor",
      "status": "Resolved",
      "delayDays": 2,
      "costImpact": 8000,
      "category": "Labor",
      "reportedDate": "2024-01-11",
      "expectedResolution": "2024-01-15",
      "reportedBy": "David Chen",
      "assignedTo": "HR Manager",
      "rootCause": "Market competition for skilled workers",
      "impact": "Electrical work delayed",
      "mitigationActions": [
        "Hire subcontractors",
        "Offer overtime rates",
        "Adjust work schedule"
      ],
      "affectedTasks": ["Electrical installation", "Wiring work", "System testing"],
      "progress": 100,
    },
  ];

  List<Map<String, dynamic>> get filteredDelays {
    return delays.where((delay) {
      bool matchesSearch = delay["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          delay["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          delay["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesProject = selectedProject == "All" || delay["project"] == selectedProject;
      bool matchesSeverity = selectedSeverity == "All" || delay["severity"] == selectedSeverity;
      bool matchesStatus = selectedStatus == "All" || delay["status"] == selectedStatus;
      
      return matchesSearch && matchesProject && matchesSeverity && matchesStatus;
    }).toList();
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Critical":
        return dangerColor;
      case "Major":
        return warningColor;
      case "Minor":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return dangerColor;
      case "Mitigating":
        return warningColor;
      case "Resolved":
        return successColor;
      case "Escalated":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Material":
        return primaryColor;
      case "Weather":
        return infoColor;
      case "Equipment":
        return warningColor;
      case "Regulatory":
        return dangerColor;
      case "Labor":
        return successColor;
      default:
        return disabledColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Material":
        return Icons.inventory;
      case "Weather":
        return Icons.cloud;
      case "Equipment":
        return Icons.construction;
      case "Regulatory":
        return Icons.gavel;
      case "Labor":
        return Icons.people;
      default:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalDelays = delays.length;
    int activeDelays = delays.where((d) => d["status"] == "Active").length;
    int criticalDelays = delays.where((d) => d["severity"] == "Critical").length;
    double totalCostImpact = delays.fold(0.0, (sum, delay) => sum + (delay["costImpact"] as int).toDouble());
    int totalDelayDays = delays.fold(0, (sum, delay) => sum + (delay["delayDays"] as int));

    return Scaffold(
      appBar: AppBar(
        title: Text("Delay Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {
              ss("Report new delay functionality would open here");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.error_outline, color: primaryColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Total Delays",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$totalDelays",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning, color: dangerColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Active Delays",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$activeDelays",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.schedule, color: warningColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Total Delay Days",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$totalDelayDays days",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.monetization_on, color: dangerColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Cost Impact",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(totalCostImpact / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search Delays",
                    value: searchQuery,
                    hint: "Search by title, description, or category",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Project",
                          items: projectItems,
                          value: selectedProject,
                          onChanged: (value, label) {
                            selectedProject = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Severity",
                          items: severityItems,
                          value: selectedSeverity,
                          onChanged: (value, label) {
                            selectedSeverity = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusItems,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Delays List
            Text(
              "Delays (${filteredDelays.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredDelays.map((delay) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getSeverityColor("${delay["severity"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: _getCategoryColor("${delay["category"]}").withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            _getCategoryIcon("${delay["category"]}"),
                            size: 20,
                            color: _getCategoryColor("${delay["category"]}"),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${delay["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${delay["project"]} • ID: ${delay["id"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getSeverityColor("${delay["severity"]}").withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(
                              color: _getSeverityColor("${delay["severity"]}"),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "${delay["severity"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getSeverityColor("${delay["severity"]}"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Status and Category
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${delay["status"]}").withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(
                              color: _getStatusColor("${delay["status"]}"),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "${delay["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor("${delay["status"]}"),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getCategoryColor("${delay["category"]}").withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${delay["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getCategoryColor("${delay["category"]}"),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${delay["delayDays"]} days",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Description
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Text(
                        "${delay["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Key Information Grid
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Root Cause",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${delay["rootCause"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Impact",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "${delay["impact"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Cost Impact",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "\$${((delay["costImpact"] as int) / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Progress",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "${delay["progress"]}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
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
                              "Resolution Progress",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${delay["progress"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: (delay["progress"] as int) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: _getStatusColor("${delay["status"]}"),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Affected Tasks
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Affected Tasks:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (delay["affectedTasks"] as List).map((task) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: warningColor.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$task",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: warningColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Mitigation Actions
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: successColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mitigation Actions:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          ...(delay["mitigationActions"] as List).map((action) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle, size: 12, color: successColor),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "$action",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Team Information
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Reported by: ${delay["reportedBy"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.assignment_ind, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Assigned to: ${delay["assignedTo"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Reported: ${delay["reportedDate"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Expected: ${delay["expectedResolution"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Action Buttons
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Update Progress",
                            size: bs.sm,
                            onPressed: () {
                              ss("Update progress for ${delay["title"]}");
                            },
                          ),
                        ),
                        QButton(
                          icon: Icons.message,
                          size: bs.sm,
                          onPressed: () {
                            ss("Add comment to ${delay["title"]}");
                          },
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            ss("More options for ${delay["title"]}");
                          },
                        ),
                      ],
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
