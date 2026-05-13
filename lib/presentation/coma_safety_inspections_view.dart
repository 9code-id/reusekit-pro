import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaSafetyInspectionsView extends StatefulWidget {
  const ComaSafetyInspectionsView({Key? key}) : super(key: key);

  @override
  State<ComaSafetyInspectionsView> createState() => _ComaSafetyInspectionsViewState();
}

class _ComaSafetyInspectionsViewState extends State<ComaSafetyInspectionsView> {
  String selectedStatus = "all";
  String selectedPriority = "all";
  String selectedType = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Overdue", "value": "overdue"},
    {"label": "Failed", "value": "failed"},
  ];

  List<Map<String, dynamic>> priorityFilters = [
    {"label": "All Priority", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All Types", "value": "all"},
    {"label": "Daily Safety", "value": "daily_safety"},
    {"label": "Weekly Safety", "value": "weekly_safety"},
    {"label": "Equipment", "value": "equipment"},
    {"label": "PPE", "value": "ppe"},
    {"label": "Site Conditions", "value": "site_conditions"},
    {"label": "Environmental", "value": "environmental"},
  ];

  List<Map<String, dynamic>> safetyInspections = [
    {
      "id": "INS-001",
      "inspection_code": "DSI-2024-001",
      "title": "Daily Safety Inspection - Zone A",
      "type": "daily_safety",
      "description": "Comprehensive daily safety inspection covering all work areas in Zone A",
      "priority": "high",
      "status": "completed",
      "inspector_id": "EMP-001",
      "inspector_name": "Michael Rodriguez",
      "inspector_certification": "Certified Safety Inspector",
      "assigned_date": "2024-06-20",
      "scheduled_date": "2024-06-20",
      "completed_date": "2024-06-20",
      "duration_minutes": 45,
      "location": "Construction Zone A",
      "project_id": "PROJ-001",
      "project_name": "Metro Downtown Complex",
      "checklist_items": [
        {
          "item_id": "CHK-001",
          "category": "Fall Protection",
          "description": "Inspect guardrails and safety barriers",
          "status": "pass",
          "notes": "All guardrails secure and properly installed",
          "photo_required": true,
          "photo_taken": true
        },
        {
          "item_id": "CHK-002",
          "category": "Equipment Safety",
          "description": "Check scaffold stability and safety",
          "status": "pass",
          "notes": "Scaffolding properly erected and tagged",
          "photo_required": true,
          "photo_taken": true
        },
        {
          "item_id": "CHK-003",
          "category": "Housekeeping",
          "description": "Verify clean and organized work areas",
          "status": "fail",
          "notes": "Debris needs to be cleared from walkways",
          "photo_required": true,
          "photo_taken": true
        },
        {
          "item_id": "CHK-004",
          "category": "PPE Compliance",
          "description": "Verify workers wearing required PPE",
          "status": "pass",
          "notes": "All workers properly equipped",
          "photo_required": false,
          "photo_taken": false
        }
      ],
      "findings": [
        {
          "finding_id": "FND-001",
          "severity": "medium",
          "category": "Housekeeping",
          "description": "Construction debris blocking emergency walkway",
          "corrective_action": "Clear debris and establish proper waste disposal protocols",
          "deadline": "2024-06-21",
          "assigned_to": "Site Supervisor",
          "status": "corrected"
        }
      ],
      "overall_score": 85,
      "pass_rate": 75,
      "total_items": 4,
      "passed_items": 3,
      "failed_items": 1,
      "weather_conditions": "Clear, 75°F",
      "hazards_identified": 1,
      "corrective_actions": 1,
      "follow_up_required": false,
      "next_inspection": "2024-06-21"
    },
    {
      "id": "INS-002",
      "inspection_code": "EQI-2024-002",
      "title": "Tower Crane Safety Inspection",
      "type": "equipment",
      "description": "Monthly tower crane inspection including structural integrity and safety systems",
      "priority": "critical",
      "status": "in_progress",
      "inspector_id": "EMP-002",
      "inspector_name": "Sarah Thompson",
      "inspector_certification": "Certified Crane Inspector",
      "assigned_date": "2024-06-15",
      "scheduled_date": "2024-06-21",
      "completed_date": null,
      "duration_minutes": 120,
      "location": "Tower Crane TC-01",
      "project_id": "PROJ-001",
      "project_name": "Metro Downtown Complex",
      "checklist_items": [
        {
          "item_id": "CHK-005",
          "category": "Structural Integrity",
          "description": "Inspect mast sections and connections",
          "status": "in_progress",
          "notes": "Visual inspection started",
          "photo_required": true,
          "photo_taken": false
        },
        {
          "item_id": "CHK-006",
          "category": "Load Testing",
          "description": "Perform load test with certified weights",
          "status": "pending",
          "notes": "",
          "photo_required": true,
          "photo_taken": false
        },
        {
          "item_id": "CHK-007",
          "category": "Safety Systems",
          "description": "Test load moment indicator and alarms",
          "status": "pending",
          "notes": "",
          "photo_required": false,
          "photo_taken": false
        }
      ],
      "findings": [],
      "overall_score": null,
      "pass_rate": null,
      "total_items": 3,
      "passed_items": 0,
      "failed_items": 0,
      "weather_conditions": "Partly cloudy, 72°F",
      "hazards_identified": 0,
      "corrective_actions": 0,
      "follow_up_required": true,
      "next_inspection": "2024-07-21"
    },
    {
      "id": "INS-003",
      "inspection_code": "PPE-2024-003",
      "title": "PPE Compliance Audit",
      "type": "ppe",
      "description": "Comprehensive audit of personal protective equipment usage and compliance",
      "priority": "medium",
      "status": "scheduled",
      "inspector_id": "EMP-003",
      "inspector_name": "James Wilson",
      "inspector_certification": "Safety Officer Level II",
      "assigned_date": "2024-06-18",
      "scheduled_date": "2024-06-25",
      "completed_date": null,
      "duration_minutes": 90,
      "location": "All Work Areas",
      "project_id": "PROJ-002",
      "project_name": "Healthcare Facility Expansion",
      "checklist_items": [
        {
          "item_id": "CHK-008",
          "category": "Head Protection",
          "description": "Verify hard hat usage and condition",
          "status": "pending",
          "notes": "",
          "photo_required": true,
          "photo_taken": false
        },
        {
          "item_id": "CHK-009",
          "category": "Eye Protection",
          "description": "Check safety glasses compliance",
          "status": "pending",
          "notes": "",
          "photo_required": true,
          "photo_taken": false
        },
        {
          "item_id": "CHK-010",
          "category": "Fall Protection",
          "description": "Inspect harnesses and lanyards",
          "status": "pending",
          "notes": "",
          "photo_required": true,
          "photo_taken": false
        }
      ],
      "findings": [],
      "overall_score": null,
      "pass_rate": null,
      "total_items": 3,
      "passed_items": 0,
      "failed_items": 0,
      "weather_conditions": null,
      "hazards_identified": 0,
      "corrective_actions": 0,
      "follow_up_required": false,
      "next_inspection": "2024-07-25"
    },
    {
      "id": "INS-004",
      "inspection_code": "WSI-2024-004",
      "title": "Weekly Site Safety Inspection",
      "type": "weekly_safety",
      "description": "Weekly comprehensive site safety inspection covering all areas and activities",
      "priority": "high",
      "status": "overdue",
      "inspector_id": "EMP-004",
      "inspector_name": "Maria Garcia",
      "inspector_certification": "Construction Safety Specialist",
      "assigned_date": "2024-06-10",
      "scheduled_date": "2024-06-17",
      "completed_date": null,
      "duration_minutes": 180,
      "location": "Entire Construction Site",
      "project_id": "PROJ-003",
      "project_name": "Residential Tower A",
      "checklist_items": [
        {
          "item_id": "CHK-011",
          "category": "Site Security",
          "description": "Check perimeter fencing and access controls",
          "status": "pending",
          "notes": "",
          "photo_required": true,
          "photo_taken": false
        },
        {
          "item_id": "CHK-012",
          "category": "Emergency Preparedness",
          "description": "Verify emergency equipment and procedures",
          "status": "pending",
          "notes": "",
          "photo_required": false,
          "photo_taken": false
        }
      ],
      "findings": [],
      "overall_score": null,
      "pass_rate": null,
      "total_items": 2,
      "passed_items": 0,
      "failed_items": 0,
      "weather_conditions": null,
      "hazards_identified": 0,
      "corrective_actions": 0,
      "follow_up_required": false,
      "next_inspection": "2024-06-24"
    },
    {
      "id": "INS-005",
      "inspection_code": "ENV-2024-005",
      "title": "Environmental Compliance Check",
      "type": "environmental",
      "description": "Environmental impact assessment and compliance verification",
      "priority": "medium",
      "status": "failed",
      "inspector_id": "EMP-005",
      "inspector_name": "David Chen",
      "inspector_certification": "Environmental Safety Inspector",
      "assigned_date": "2024-06-12",
      "scheduled_date": "2024-06-19",
      "completed_date": "2024-06-19",
      "duration_minutes": 60,
      "location": "Site Perimeter",
      "project_id": "PROJ-001",
      "project_name": "Metro Downtown Complex",
      "checklist_items": [
        {
          "item_id": "CHK-013",
          "category": "Waste Management",
          "description": "Check proper waste segregation and disposal",
          "status": "fail",
          "notes": "Hazardous waste not properly separated",
          "photo_required": true,
          "photo_taken": true
        },
        {
          "item_id": "CHK-014",
          "category": "Water Protection",
          "description": "Inspect stormwater management systems",
          "status": "pass",
          "notes": "Stormwater controls functioning properly",
          "photo_required": true,
          "photo_taken": true
        }
      ],
      "findings": [
        {
          "finding_id": "FND-002",
          "severity": "high",
          "category": "Environmental",
          "description": "Improper hazardous waste storage and disposal",
          "corrective_action": "Implement proper hazmat storage and disposal protocols",
          "deadline": "2024-06-26",
          "assigned_to": "Environmental Coordinator",
          "status": "in_progress"
        }
      ],
      "overall_score": 50,
      "pass_rate": 50,
      "total_items": 2,
      "passed_items": 1,
      "failed_items": 1,
      "weather_conditions": "Rainy, 68°F",
      "hazards_identified": 1,
      "corrective_actions": 1,
      "follow_up_required": true,
      "next_inspection": "2024-06-26"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Safety Inspections"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _createInspection(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _viewInspectionAnalytics(),
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
                  _buildInspectionOverview(),
                  _buildFilters(),
                  _buildInspectionMetrics(),
                  _buildPendingInspections(),
                  _buildInspectionsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildInspectionOverview() {
    int totalInspections = safetyInspections.length;
    int completedInspections = safetyInspections.where((i) => i["status"] == "completed").length;
    int overdueInspections = safetyInspections.where((i) => i["status"] == "overdue").length;
    int failedInspections = safetyInspections.where((i) => i["status"] == "failed").length;

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
                child: Icon(Icons.fact_check, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Safety Inspections Overview",
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
              _buildOverviewCard("Total", "$totalInspections", Icons.list_alt, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Completed", "$completedInspections", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Overdue", "$overdueInspections", Icons.schedule, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Failed", "$failedInspections", Icons.error, warningColor),
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
          Row(
            children: [
              Icon(Icons.search, color: disabledBoldColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Search inspections...",
                  value: searchQuery,
                  hint: "Search by title, code, or inspector",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusFilters,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityFilters,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeFilters,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
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

  Widget _buildInspectionMetrics() {
    List<Map<String, dynamic>> completedInspections = safetyInspections
        .where((i) => i["status"] == "completed" && i["overall_score"] != null)
        .toList();
    
    double avgScore = completedInspections.isEmpty ? 0 : 
        completedInspections.fold(0.0, (sum, i) => sum + (i["overall_score"] as int)) / completedInspections.length;
    
    int totalHazards = safetyInspections.fold(0, (sum, i) => sum + (i["hazards_identified"] as int));
    int totalActions = safetyInspections.fold(0, (sum, i) => sum + (i["corrective_actions"] as int));

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
            "Inspection Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.grade, color: successColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "${avgScore.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Avg Score",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.warning, color: warningColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "$totalHazards",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Hazards Found",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.build, color: infoColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "$totalActions",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Actions Taken",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPendingInspections() {
    List<Map<String, dynamic>> pendingInspections = safetyInspections
        .where((i) => i["status"] == "scheduled" || i["status"] == "overdue")
        .toList();

    if (pendingInspections.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Pending Inspections",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          height: 120,
          child: QHorizontalScroll(
            children: pendingInspections.map((inspection) => Container(
              width: 280,
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    color: _getStatusColor(inspection["status"]),
                    width: 4,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${inspection["title"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.person, color: disabledBoldColor, size: 12),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${inspection["inspector_name"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: disabledBoldColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${inspection["scheduled_date"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor(inspection["status"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${inspection["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 8,
                            color: _getStatusColor(inspection["status"]),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(inspection["priority"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${inspection["priority"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 8,
                            color: _getPriorityColor(inspection["priority"]),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildInspectionsList() {
    List<Map<String, dynamic>> filteredInspections = _getFilteredInspections();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Inspections (${filteredInspections.length})",
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
        ...filteredInspections.map((inspection) => _buildInspectionCard(inspection)),
      ],
    );
  }

  Widget _buildInspectionCard(Map<String, dynamic> inspection) {
    Color statusColor = _getStatusColor(inspection["status"]);
    Color priorityColor = _getPriorityColor(inspection["priority"]);

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
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${inspection["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Code: ${inspection["inspection_code"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${inspection["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: priorityColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, color: primaryColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Inspector: ${inspection["inspector_name"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${inspection["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: primaryColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "Scheduled: ${inspection["scheduled_date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    if (inspection["completed_date"] != null) ...[
                      Spacer(),
                      Icon(Icons.check_circle, color: successColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "Completed: ${inspection["completed_date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: primaryColor, size: 14),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${inspection["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Icon(Icons.access_time, color: primaryColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${inspection["duration_minutes"]} min",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (inspection["overall_score"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.grade, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Score: ${inspection["overall_score"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "Pass Rate: ${inspection["pass_rate"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${inspection["passed_items"]}/${inspection["total_items"]} items passed",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          if ((inspection["findings"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Findings: ${(inspection["findings"] as List).length}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  ...(inspection["findings"] as List).take(2).map((finding) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${finding["description"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Action: ${finding["corrective_action"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          Row(
            children: [
              Icon(Icons.business, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Project: ${inspection["project_name"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              if (inspection["next_inspection"] != null)
                Text(
                  "Next: ${inspection["next_inspection"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Type: ${inspection["type"]}".replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewInspectionDetails(inspection["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editInspection(inspection["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showInspectionOptions(inspection),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredInspections() {
    List<Map<String, dynamic>> filtered = safetyInspections;

    if (selectedStatus != "all") {
      filtered = filtered.where((inspection) => inspection["status"] == selectedStatus).toList();
    }

    if (selectedPriority != "all") {
      filtered = filtered.where((inspection) => inspection["priority"] == selectedPriority).toList();
    }

    if (selectedType != "all") {
      filtered = filtered.where((inspection) => inspection["type"] == selectedType).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((inspection) =>
          inspection["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          inspection["inspection_code"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          inspection["inspector_name"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return infoColor;
      case 'scheduled':
        return warningColor;
      case 'overdue':
        return dangerColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _createInspection() {
    ss("Create new safety inspection");
  }

  void _viewInspectionAnalytics() {
    ss("View inspection analytics");
  }

  void _showSortOptions() {
    ss("Inspection sort options");
  }

  void _viewInspectionDetails(String inspectionId) {
    ss("Viewing inspection details $inspectionId");
  }

  void _editInspection(String inspectionId) {
    ss("Editing inspection $inspectionId");
  }

  void _showInspectionOptions(Map<String, dynamic> inspection) {
    ss("Inspection options for ${inspection["title"]}");
  }
}
