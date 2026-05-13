import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaInspectionChecklistView extends StatefulWidget {
  const ComaInspectionChecklistView({Key? key}) : super(key: key);

  @override
  State<ComaInspectionChecklistView> createState() => _ComaInspectionChecklistViewState();
}

class _ComaInspectionChecklistViewState extends State<ComaInspectionChecklistView> {
  String selectedTemplate = "all";
  String selectedStatus = "all";
  String selectedProject = "all";
  bool loading = false;

  List<Map<String, dynamic>> templates = [
    {"label": "All Templates", "value": "all"},
    {"label": "Foundation Inspection", "value": "foundation"},
    {"label": "Structural Framework", "value": "structural"},
    {"label": "Electrical Systems", "value": "electrical"},
    {"label": "Plumbing Systems", "value": "plumbing"},
    {"label": "HVAC Systems", "value": "hvac"},
    {"label": "Safety Compliance", "value": "safety"},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Draft", "value": "draft"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Approved", "value": "approved"},
  ];

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "Metro Downtown Complex", "value": "PRJ-001"},
    {"label": "Riverside Office Park", "value": "PRJ-002"},
    {"label": "Healthcare Facility", "value": "PRJ-003"},
    {"label": "Residential Tower A", "value": "PRJ-004"},
  ];

  List<Map<String, dynamic>> inspectionChecklists = [
    {
      "id": "ICL-2024-001",
      "checklist_name": "Foundation Pour Inspection",
      "template_type": "foundation",
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "location": "Building A - Foundation Level",
      "inspector": "Sarah Johnson",
      "created_date": "2024-06-15",
      "inspection_date": "2024-06-15",
      "status": "completed",
      "completion_percentage": 100,
      "total_items": 25,
      "completed_items": 25,
      "passed_items": 23,
      "failed_items": 2,
      "na_items": 0,
      "critical_failures": 0,
      "notes": "Foundation meets specifications with minor formwork adjustments",
      "items": [
        {
          "id": "F001",
          "category": "Preparation",
          "description": "Excavation depth verification",
          "status": "pass",
          "required": true,
          "notes": "Depth confirmed at 8 feet as per design",
          "photo_required": true,
          "photos": ["https://picsum.photos/200/150?random=1&keyword=excavation"]
        },
        {
          "id": "F002", 
          "category": "Preparation",
          "description": "Soil compaction test",
          "status": "pass",
          "required": true,
          "notes": "95% compaction achieved",
          "photo_required": false,
          "photos": []
        },
        {
          "id": "F003",
          "category": "Formwork",
          "description": "Form alignment and bracing",
          "status": "fail",
          "required": true,
          "notes": "Minor misalignment on north wall - corrected",
          "photo_required": true,
          "photos": ["https://picsum.photos/200/150?random=2&keyword=formwork"]
        },
        {
          "id": "F004",
          "category": "Reinforcement",
          "description": "Rebar placement and spacing",
          "status": "pass",
          "required": true,
          "notes": "All rebar properly placed per drawings",
          "photo_required": true,
          "photos": ["https://picsum.photos/200/150?random=3&keyword=rebar"]
        },
        {
          "id": "F005",
          "category": "Concrete",
          "description": "Concrete slump test",
          "status": "pass",
          "required": true,
          "notes": "4 inch slump within acceptable range",
          "photo_required": false,
          "photos": []
        }
      ],
      "contractor": "Foundation Masters Inc",
      "approved_by": "Michael Chen",
      "approval_date": "2024-06-15",
    },
    {
      "id": "ICL-2024-002",
      "checklist_name": "Electrical Rough-In Inspection",
      "template_type": "electrical",
      "project_id": "PRJ-003",
      "project_name": "Healthcare Facility Expansion",
      "location": "Patient Wing - Floors 1-3",
      "inspector": "Emily Rodriguez",
      "created_date": "2024-06-14",
      "inspection_date": "2024-06-16",
      "status": "in_progress",
      "completion_percentage": 75,
      "total_items": 32,
      "completed_items": 24,
      "passed_items": 20,
      "failed_items": 4,
      "na_items": 0,
      "critical_failures": 2,
      "notes": "Multiple code violations found, requires rework before approval",
      "items": [
        {
          "id": "E001",
          "category": "Wiring",
          "description": "Wire gauge compliance",
          "status": "pass",
          "required": true,
          "notes": "All wire gauges match specifications",
          "photo_required": false,
          "photos": []
        },
        {
          "id": "E002",
          "category": "Wiring", 
          "description": "Insulation resistance test",
          "status": "fail",
          "required": true,
          "notes": "Below minimum 20 MΩ requirement - needs investigation",
          "photo_required": true,
          "photos": ["https://picsum.photos/200/150?random=4&keyword=electrical"]
        },
        {
          "id": "E003",
          "category": "Grounding",
          "description": "Equipment grounding verification",
          "status": "fail",
          "required": true,
          "notes": "Critical: Improper grounding on circuits 12-15",
          "photo_required": true,
          "photos": ["https://picsum.photos/200/150?random=5&keyword=grounding"]
        },
        {
          "id": "E004",
          "category": "Safety",
          "description": "GFCI outlet installation",
          "status": "pass",
          "required": true,
          "notes": "All GFCI outlets properly installed and tested",
          "photo_required": false,
          "photos": []
        }
      ],
      "contractor": "Power Systems Inc",
      "approved_by": null,
      "approval_date": null,
    },
    {
      "id": "ICL-2024-003",
      "checklist_name": "HVAC System Pre-Installation",
      "template_type": "hvac",
      "project_id": "PRJ-002",
      "project_name": "Riverside Office Park",
      "location": "Mechanical Room - All Floors",
      "inspector": "David Wilson",
      "created_date": "2024-06-16",
      "inspection_date": null,
      "status": "draft",
      "completion_percentage": 0,
      "total_items": 28,
      "completed_items": 0,
      "passed_items": 0,
      "failed_items": 0,
      "na_items": 0,
      "critical_failures": 0,
      "notes": "Checklist prepared for upcoming HVAC installation inspection",
      "items": [
        {
          "id": "H001",
          "category": "Preparation",
          "description": "Equipment delivery verification",
          "status": "pending",
          "required": true,
          "notes": "",
          "photo_required": true,
          "photos": []
        },
        {
          "id": "H002",
          "category": "Preparation",
          "description": "Workspace safety setup",
          "status": "pending",
          "required": true,
          "notes": "",
          "photo_required": false,
          "photos": []
        },
        {
          "id": "H003",
          "category": "Installation",
          "description": "Unit placement and alignment",
          "status": "pending",
          "required": true,
          "notes": "",
          "photo_required": true,
          "photos": []
        }
      ],
      "contractor": "Climate Control Experts",
      "approved_by": null,
      "approval_date": null,
    },
    {
      "id": "ICL-2024-004",
      "checklist_name": "Safety Compliance Review",
      "template_type": "safety",
      "project_id": "PRJ-004",
      "project_name": "Residential Tower A",
      "location": "Entire Site",
      "inspector": "Jennifer Park",
      "created_date": "2024-06-17",
      "inspection_date": "2024-06-17",
      "status": "approved",
      "completion_percentage": 100,
      "total_items": 20,
      "completed_items": 20,
      "passed_items": 19,
      "failed_items": 1,
      "na_items": 0,
      "critical_failures": 0,
      "notes": "Excellent safety compliance, minor issue with hard hat storage",
      "items": [
        {
          "id": "S001",
          "category": "PPE",
          "description": "Hard hat availability and condition",
          "status": "fail",
          "required": true,
          "notes": "Storage area needs better organization",
          "photo_required": true,
          "photos": ["https://picsum.photos/200/150?random=6&keyword=safety"]
        },
        {
          "id": "S002",
          "category": "PPE",
          "description": "Safety vest visibility standards",
          "status": "pass",
          "required": true,
          "notes": "All vests meet ANSI standards",
          "photo_required": false,
          "photos": []
        },
        {
          "id": "S003",
          "category": "Scaffolding",
          "description": "Scaffold stability and guards",
          "status": "pass",
          "required": true,
          "notes": "All scaffolds properly secured with guardrails",
          "photo_required": true,
          "photos": ["https://picsum.photos/200/150?random=7&keyword=scaffold"]
        }
      ],
      "contractor": "All Contractors",
      "approved_by": "Thomas Anderson",
      "approval_date": "2024-06-17",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inspection Checklists"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _createNewChecklist(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.library_books,
            size: bs.sm,
            onPressed: () => _manageTemplates(),
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
                  _buildChecklistOverview(),
                  _buildFilters(),
                  _buildCompletionSummary(),
                  _buildChecklistsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildChecklistOverview() {
    int totalChecklists = inspectionChecklists.length;
    int completedChecklists = inspectionChecklists.where((c) => c["status"] == "completed" || c["status"] == "approved").length;
    int inProgressChecklists = inspectionChecklists.where((c) => c["status"] == "in_progress").length;
    int draftChecklists = inspectionChecklists.where((c) => c["status"] == "draft").length;

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
                "Inspection Checklists Overview",
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
              _buildOverviewCard("Total", "$totalChecklists", Icons.assignment, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Completed", "$completedChecklists", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("In Progress", "$inProgressChecklists", Icons.play_circle, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Draft", "$draftChecklists", Icons.edit_note, dangerColor),
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
            "Filter Checklists",
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
                  label: "Template Type",
                  items: templates,
                  value: selectedTemplate,
                  onChanged: (value, label) {
                    selectedTemplate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
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
                  label: "Project",
                  items: projects,
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

  Widget _buildCompletionSummary() {
    double avgCompletion = inspectionChecklists.fold(0.0, (sum, c) => sum + (c["completion_percentage"] as int)) / inspectionChecklists.length;
    int totalItems = inspectionChecklists.fold(0, (sum, c) => sum + (c["total_items"] as int));
    int totalPassedItems = inspectionChecklists.fold(0, (sum, c) => sum + (c["passed_items"] as int));
    int totalCriticalFailures = inspectionChecklists.fold(0, (sum, c) => sum + (c["critical_failures"] as int));

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
            "Completion Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildSummaryCard("Avg Completion", "${avgCompletion.toInt()}%", Icons.trending_up, successColor),
              SizedBox(width: spSm),
              _buildSummaryCard("Total Items", "$totalItems", Icons.list, primaryColor),
              SizedBox(width: spSm),
              _buildSummaryCard("Passed Items", "$totalPassedItems", Icons.check, successColor),
              SizedBox(width: spSm),
              _buildSummaryCard("Critical Failures", "$totalCriticalFailures", Icons.error, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
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

  Widget _buildChecklistsList() {
    List<Map<String, dynamic>> filteredChecklists = _getFilteredChecklists();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Inspection Checklists (${filteredChecklists.length})",
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
        ...filteredChecklists.map((checklist) => _buildChecklistCard(checklist)),
      ],
    );
  }

  Widget _buildChecklistCard(Map<String, dynamic> checklist) {
    Color statusColor = _getStatusColor(checklist["status"]);

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
                      "${checklist["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${checklist["checklist_name"]}",
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
                  "${checklist["completion_percentage"]}%",
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${checklist["status"]}".toUpperCase(),
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
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${checklist["template_type"]}".toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                color: infoColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            "Project: ${checklist["project_name"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Icon(Icons.location_on, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${checklist["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
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
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "Progress: ${checklist["completion_percentage"]}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${checklist["completed_items"]}/${checklist["total_items"]} items",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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
                    widthFactor: (checklist["completion_percentage"] as int) / 100,
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
          Row(
            children: [
              _buildItemStatusCard("Passed", "${checklist["passed_items"]}", successColor),
              SizedBox(width: spSm),
              _buildItemStatusCard("Failed", "${checklist["failed_items"]}", dangerColor),
              SizedBox(width: spSm),
              _buildItemStatusCard("Critical", "${checklist["critical_failures"]}", dangerColor),
              SizedBox(width: spSm),
              _buildItemStatusCard("N/A", "${checklist["na_items"]}", disabledBoldColor),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Inspector: ${checklist["inspector"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (checklist["inspection_date"] != null)
                Text(
                  "Date: ${checklist["inspection_date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
            ],
          ),
          Text(
            "Contractor: ${checklist["contractor"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          if (checklist["notes"] != null && checklist["notes"].toString().isNotEmpty)
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
                      "${checklist["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (checklist["approved_by"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.verified, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Approved by: ${checklist["approved_by"]} on ${checklist["approval_date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Created: ${checklist["created_date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewChecklistDetails(checklist["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editChecklist(checklist["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showChecklistOptions(checklist),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemStatusCard(String title, String value, Color color) {
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

  List<Map<String, dynamic>> _getFilteredChecklists() {
    List<Map<String, dynamic>> filtered = inspectionChecklists;

    if (selectedTemplate != "all") {
      filtered = filtered.where((checklist) => checklist["template_type"] == selectedTemplate).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((checklist) => checklist["status"] == selectedStatus).toList();
    }

    if (selectedProject != "all") {
      filtered = filtered.where((checklist) => checklist["project_id"] == selectedProject).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return successColor;
      case 'completed':
        return infoColor;
      case 'in_progress':
        return warningColor;
      case 'draft':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _createNewChecklist() {
    ss("Create new inspection checklist");
  }

  void _manageTemplates() {
    ss("Manage checklist templates");
  }

  void _showSortOptions() {
    ss("Checklist sort options");
  }

  void _viewChecklistDetails(String checklistId) {
    ss("Viewing checklist details $checklistId");
  }

  void _editChecklist(String checklistId) {
    ss("Editing checklist $checklistId");
  }

  void _showChecklistOptions(Map<String, dynamic> checklist) {
    ss("Checklist options for ${checklist["id"]}");
  }
}
