import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaHazardIdentificationView extends StatefulWidget {
  const ComaHazardIdentificationView({Key? key}) : super(key: key);

  @override
  State<ComaHazardIdentificationView> createState() => _ComaHazardIdentificationViewState();
}

class _ComaHazardIdentificationViewState extends State<ComaHazardIdentificationView> {
  String selectedStatus = "all";
  String selectedSeverity = "all";
  String selectedCategory = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Open", "value": "open"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Resolved", "value": "resolved"},
    {"label": "Closed", "value": "closed"},
    {"label": "Escalated", "value": "escalated"},
  ];

  List<Map<String, dynamic>> severityFilters = [
    {"label": "All Severity", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> categoryFilters = [
    {"label": "All Categories", "value": "all"},
    {"label": "Fall Hazards", "value": "fall_hazards"},
    {"label": "Electrical", "value": "electrical"},
    {"label": "Chemical", "value": "chemical"},
    {"label": "Mechanical", "value": "mechanical"},
    {"label": "Environmental", "value": "environmental"},
    {"label": "Fire Safety", "value": "fire_safety"},
    {"label": "Ergonomic", "value": "ergonomic"},
  ];

  List<Map<String, dynamic>> hazardReports = [
    {
      "id": "HAZ-001",
      "hazard_code": "FALL-2024-001",
      "title": "Unguarded Roof Edge",
      "category": "fall_hazards",
      "description": "Roof edge on Building B lacks proper guardrails, creating fall hazard for workers",
      "severity": "critical",
      "status": "open",
      "priority": "immediate",
      "reported_by": "Michael Rodriguez",
      "reporter_id": "EMP-001",
      "reported_date": "2024-06-20",
      "assigned_to": "Safety Team",
      "assignee_id": "TEAM-001",
      "due_date": "2024-06-22",
      "location": "Building B - Roof Level",
      "project_id": "PROJ-001",
      "project_name": "Metro Downtown Complex",
      "potential_consequences": [
        "Fatal fall injury",
        "Serious injury requiring hospitalization",
        "Project delays due to safety incidents",
        "Legal liability and fines"
      ],
      "affected_workers": 8,
      "exposure_frequency": "daily",
      "risk_score": 95,
      "immediate_actions": [
        "Install temporary guardrails",
        "Restrict access to roof area",
        "Post warning signs"
      ],
      "corrective_actions": [
        {
          "action": "Install permanent guardrail system",
          "assigned_to": "Construction Supervisor",
          "due_date": "2024-06-22",
          "status": "pending",
          "estimated_cost": 2500.00
        },
        {
          "action": "Conduct safety training for roof workers",
          "assigned_to": "Safety Officer",
          "due_date": "2024-06-25",
          "status": "pending",
          "estimated_cost": 500.00
        }
      ],
      "photo_urls": [
        "https://picsum.photos/400/300?random=1&keyword=roof",
        "https://picsum.photos/400/300?random=2&keyword=construction"
      ],
      "witness_statements": [
        {
          "witness_name": "John Smith",
          "statement": "Observed workers working near unprotected roof edge without fall protection",
          "date": "2024-06-20"
        }
      ],
      "regulatory_references": [
        "OSHA 1926.501(b)(1) - Fall protection requirements",
        "ANSI Z359 - Fall Protection Code"
      ],
      "follow_up_date": "2024-06-23",
      "estimated_resolution_cost": 3000.00,
      "lessons_learned": null,
      "prevention_measures": [
        "Regular safety inspections",
        "Pre-work hazard assessments",
        "Fall protection training program"
      ]
    },
    {
      "id": "HAZ-002",
      "hazard_code": "ELEC-2024-002",
      "title": "Exposed Electrical Wiring",
      "category": "electrical",
      "description": "Temporary electrical installation with exposed conductors in wet area",
      "severity": "high",
      "status": "in_progress",
      "priority": "urgent",
      "reported_by": "Sarah Thompson",
      "reporter_id": "EMP-002",
      "reported_date": "2024-06-19",
      "assigned_to": "Electrical Contractor",
      "assignee_id": "CONT-001",
      "due_date": "2024-06-21",
      "location": "Building A - Basement Level",
      "project_id": "PROJ-001",
      "project_name": "Metro Downtown Complex",
      "potential_consequences": [
        "Electrical shock or electrocution",
        "Electrical fires",
        "Equipment damage",
        "Work area shutdown"
      ],
      "affected_workers": 12,
      "exposure_frequency": "frequent",
      "risk_score": 85,
      "immediate_actions": [
        "De-energize affected circuits",
        "Install temporary barriers",
        "Post electrical hazard warnings"
      ],
      "corrective_actions": [
        {
          "action": "Install proper electrical enclosures",
          "assigned_to": "Licensed Electrician",
          "due_date": "2024-06-21",
          "status": "in_progress",
          "estimated_cost": 800.00
        },
        {
          "action": "Install GFCI protection",
          "assigned_to": "Licensed Electrician",
          "due_date": "2024-06-21",
          "status": "pending",
          "estimated_cost": 400.00
        }
      ],
      "photo_urls": [
        "https://picsum.photos/400/300?random=3&keyword=electrical",
        "https://picsum.photos/400/300?random=4&keyword=wiring"
      ],
      "witness_statements": [
        {
          "witness_name": "James Wilson",
          "statement": "Noticed sparking from exposed junction box during rain",
          "date": "2024-06-19"
        }
      ],
      "regulatory_references": [
        "OSHA 1926.404 - Wiring design and protection",
        "NEC Article 590 - Temporary installations"
      ],
      "follow_up_date": "2024-06-22",
      "estimated_resolution_cost": 1200.00,
      "lessons_learned": null,
      "prevention_measures": [
        "Proper temporary electrical installation procedures",
        "Regular electrical system inspections",
        "Weather protection for electrical equipment"
      ]
    },
    {
      "id": "HAZ-003",
      "hazard_code": "CHEM-2024-003",
      "title": "Improper Chemical Storage",
      "category": "chemical",
      "description": "Incompatible chemicals stored together without proper separation",
      "severity": "medium",
      "status": "resolved",
      "priority": "high",
      "reported_by": "Maria Garcia",
      "reporter_id": "EMP-003",
      "reported_date": "2024-06-15",
      "assigned_to": "Environmental Coordinator",
      "assignee_id": "EMP-004",
      "due_date": "2024-06-18",
      "location": "Chemical Storage Area",
      "project_id": "PROJ-002",
      "project_name": "Healthcare Facility Expansion",
      "potential_consequences": [
        "Chemical reactions and fires",
        "Toxic gas generation",
        "Environmental contamination",
        "Worker exposure to hazardous materials"
      ],
      "affected_workers": 5,
      "exposure_frequency": "occasional",
      "risk_score": 70,
      "immediate_actions": [
        "Separate incompatible chemicals",
        "Improve ventilation",
        "Post chemical hazard signs"
      ],
      "corrective_actions": [
        {
          "action": "Install proper chemical storage cabinets",
          "assigned_to": "Facility Manager",
          "due_date": "2024-06-18",
          "status": "completed",
          "estimated_cost": 1500.00
        },
        {
          "action": "Train workers on chemical storage procedures",
          "assigned_to": "Safety Officer",
          "due_date": "2024-06-20",
          "status": "completed",
          "estimated_cost": 300.00
        }
      ],
      "photo_urls": [
        "https://picsum.photos/400/300?random=5&keyword=chemicals",
        "https://picsum.photos/400/300?random=6&keyword=storage"
      ],
      "witness_statements": [],
      "regulatory_references": [
        "OSHA 1926.95 - Personal protective equipment",
        "EPA 40 CFR - Chemical storage requirements"
      ],
      "follow_up_date": "2024-06-25",
      "estimated_resolution_cost": 1800.00,
      "lessons_learned": "Regular chemical inventory and compatibility checks prevent storage hazards",
      "prevention_measures": [
        "Chemical compatibility training",
        "Regular storage area inspections",
        "Proper labeling and segregation procedures"
      ]
    },
    {
      "id": "HAZ-004",
      "hazard_code": "MECH-2024-004",
      "title": "Unguarded Machinery",
      "category": "mechanical",
      "description": "Concrete mixer operating without proper safety guards on rotating parts",
      "severity": "high",
      "status": "escalated",
      "priority": "immediate",
      "reported_by": "David Chen",
      "reporter_id": "EMP-005",
      "reported_date": "2024-06-18",
      "assigned_to": "Equipment Manager",
      "assignee_id": "EMP-006",
      "due_date": "2024-06-19",
      "location": "Equipment Yard",
      "project_id": "PROJ-003",
      "project_name": "Residential Tower A",
      "potential_consequences": [
        "Caught-in or struck-by injuries",
        "Amputation or crushing injuries",
        "Equipment damage",
        "Production delays"
      ],
      "affected_workers": 3,
      "exposure_frequency": "daily",
      "risk_score": 90,
      "immediate_actions": [
        "Tag out equipment",
        "Restrict access to machinery",
        "Install temporary barriers"
      ],
      "corrective_actions": [
        {
          "action": "Install proper machine guards",
          "assigned_to": "Maintenance Team",
          "due_date": "2024-06-19",
          "status": "overdue",
          "estimated_cost": 600.00
        },
        {
          "action": "Conduct lockout/tagout training",
          "assigned_to": "Safety Officer",
          "due_date": "2024-06-22",
          "status": "pending",
          "estimated_cost": 200.00
        }
      ],
      "photo_urls": [
        "https://picsum.photos/400/300?random=7&keyword=machinery",
        "https://picsum.photos/400/300?random=8&keyword=equipment"
      ],
      "witness_statements": [
        {
          "witness_name": "Kevin Johnson",
          "statement": "Saw worker's clothing get caught in unguarded rotating shaft",
          "date": "2024-06-18"
        }
      ],
      "regulatory_references": [
        "OSHA 1926.300 - General requirements for tools",
        "OSHA 1926.307 - Mechanical power-transmission apparatus"
      ],
      "follow_up_date": "2024-06-20",
      "estimated_resolution_cost": 800.00,
      "lessons_learned": null,
      "prevention_measures": [
        "Pre-use equipment inspections",
        "Proper machine guarding standards",
        "Regular maintenance procedures"
      ]
    },
    {
      "id": "HAZ-005",
      "hazard_code": "ENV-2024-005",
      "title": "Noise Exposure Exceeding Limits",
      "category": "environmental",
      "description": "Construction activities generating noise levels above 85 dB without hearing protection",
      "severity": "medium",
      "status": "closed",
      "priority": "medium",
      "reported_by": "Amanda Foster",
      "reporter_id": "EMP-007",
      "reported_date": "2024-06-12",
      "assigned_to": "Safety Coordinator",
      "assignee_id": "EMP-008",
      "due_date": "2024-06-15",
      "location": "Construction Site - All Areas",
      "project_id": "PROJ-001",
      "project_name": "Metro Downtown Complex",
      "potential_consequences": [
        "Hearing loss or damage",
        "Communication difficulties",
        "Increased accident risk",
        "Worker fatigue and stress"
      ],
      "affected_workers": 25,
      "exposure_frequency": "continuous",
      "risk_score": 65,
      "immediate_actions": [
        "Distribute hearing protection",
        "Post noise hazard warnings",
        "Schedule noise-intensive work during limited hours"
      ],
      "corrective_actions": [
        {
          "action": "Implement hearing conservation program",
          "assigned_to": "Safety Coordinator",
          "due_date": "2024-06-15",
          "status": "completed",
          "estimated_cost": 1000.00
        },
        {
          "action": "Conduct audiometric testing",
          "assigned_to": "Occupational Health Nurse",
          "due_date": "2024-06-20",
          "status": "completed",
          "estimated_cost": 1500.00
        }
      ],
      "photo_urls": [
        "https://picsum.photos/400/300?random=9&keyword=noise",
        "https://picsum.photos/400/300?random=10&keyword=construction"
      ],
      "witness_statements": [],
      "regulatory_references": [
        "OSHA 1926.52 - Occupational noise exposure",
        "NIOSH Criteria Document - Noise exposure"
      ],
      "follow_up_date": "2024-07-12",
      "estimated_resolution_cost": 2500.00,
      "lessons_learned": "Regular noise monitoring and PPE compliance prevents hearing damage",
      "prevention_measures": [
        "Regular noise level monitoring",
        "Hearing protection training",
        "Equipment maintenance to reduce noise"
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hazard Identification"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _reportHazard(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _viewHazardAnalytics(),
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
                  _buildHazardOverview(),
                  _buildFilters(),
                  _buildRiskMetrics(),
                  _buildCriticalHazards(),
                  _buildHazardsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildHazardOverview() {
    int totalHazards = hazardReports.length;
    int openHazards = hazardReports.where((h) => h["status"] == "open").length;
    int criticalHazards = hazardReports.where((h) => h["severity"] == "critical").length;
    int resolvedHazards = hazardReports.where((h) => h["status"] == "resolved" || h["status"] == "closed").length;

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
                child: Icon(Icons.warning, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Hazard Identification Overview",
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
              _buildOverviewCard("Total Hazards", "$totalHazards", Icons.report_problem, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Open", "$openHazards", Icons.error, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Critical", "$criticalHazards", Icons.priority_high, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Resolved", "$resolvedHazards", Icons.check_circle, successColor),
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
                  label: "Search hazards...",
                  value: searchQuery,
                  hint: "Search by title, code, or location",
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
                  label: "Severity",
                  items: severityFilters,
                  value: selectedSeverity,
                  onChanged: (value, label) {
                    selectedSeverity = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryFilters,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
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

  Widget _buildRiskMetrics() {
    double avgRiskScore = hazardReports.fold(0.0, (sum, h) => sum + (h["risk_score"] as int)) / hazardReports.length;
    int totalWorkers = hazardReports.fold(0, (sum, h) => sum + (h["affected_workers"] as int));
    double totalCost = hazardReports.fold(0.0, (sum, h) => sum + (h["estimated_resolution_cost"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: warningColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Risk Assessment Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: warningColor,
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
                      Icon(Icons.speed, color: warningColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "${avgRiskScore.toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Avg Risk Score",
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
                      Icon(Icons.people, color: infoColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "$totalWorkers",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Workers at Risk",
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
                      Icon(Icons.attach_money, color: dangerColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalCost.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Resolution Cost",
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

  Widget _buildCriticalHazards() {
    List<Map<String, dynamic>> criticalHazards = hazardReports
        .where((h) => h["severity"] == "critical" && (h["status"] == "open" || h["status"] == "escalated"))
        .toList();

    if (criticalHazards.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(Icons.priority_high, color: dangerColor, size: 20),
            SizedBox(width: spSm),
            Text(
              "Critical Hazards Requiring Immediate Action",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
          ],
        ),
        Container(
          height: 140,
          child: QHorizontalScroll(
            children: criticalHazards.map((hazard) => Container(
              width: 300,
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${hazard["title"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${hazard["location"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.people, color: dangerColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${hazard["affected_workers"]} workers affected",
                        style: TextStyle(
                          fontSize: 10,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: dangerColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "Due: ${hazard["due_date"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: dangerColor,
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
                          color: dangerColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Risk: ${hazard["risk_score"]}",
                          style: TextStyle(
                            fontSize: 8,
                            color: dangerColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${hazard["priority"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 8,
                          color: dangerColor,
                          fontWeight: FontWeight.bold,
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

  Widget _buildHazardsList() {
    List<Map<String, dynamic>> filteredHazards = _getFilteredHazards();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Hazard Reports (${filteredHazards.length})",
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
        ...filteredHazards.map((hazard) => _buildHazardCard(hazard)),
      ],
    );
  }

  Widget _buildHazardCard(Map<String, dynamic> hazard) {
    Color statusColor = _getStatusColor(hazard["status"]);
    Color severityColor = _getSeverityColor(hazard["severity"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: severityColor,
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
                      "${hazard["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Code: ${hazard["hazard_code"]}",
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
                  color: severityColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${hazard["severity"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: severityColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${hazard["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.person, color: primaryColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Reported by: ${hazard["reported_by"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${hazard["status"]}".toUpperCase(),
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
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.speed, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Risk Score: ${hazard["risk_score"]}/100",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.people, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${hazard["affected_workers"]} workers affected",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${hazard["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
                      ),
                    ),
                    Icon(Icons.schedule, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Due: ${hazard["due_date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if ((hazard["potential_consequences"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Potential Consequences:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  ...(hazard["potential_consequences"] as List).take(2).map((consequence) => Row(
                    children: [
                      Icon(Icons.circle, color: dangerColor, size: 6),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "$consequence",
                          style: TextStyle(
                            fontSize: 11,
                            color: dangerColor,
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          if ((hazard["corrective_actions"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Corrective Actions:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  ...(hazard["corrective_actions"] as List).take(2).map((action) => Container(
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
                          "${action["action"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: successColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Due: ${action["due_date"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getActionStatusColor(action["status"]).withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${action["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 8,
                                  color: _getActionStatusColor(action["status"]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
                  "Project: ${hazard["project_name"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Icon(Icons.attach_money, color: successColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Cost: \$${(hazard["estimated_resolution_cost"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Category: ${hazard["category"]}".replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewHazardDetails(hazard["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editHazard(hazard["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showHazardOptions(hazard),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredHazards() {
    List<Map<String, dynamic>> filtered = hazardReports;

    if (selectedStatus != "all") {
      filtered = filtered.where((hazard) => hazard["status"] == selectedStatus).toList();
    }

    if (selectedSeverity != "all") {
      filtered = filtered.where((hazard) => hazard["severity"] == selectedSeverity).toList();
    }

    if (selectedCategory != "all") {
      filtered = filtered.where((hazard) => hazard["category"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((hazard) =>
          hazard["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          hazard["hazard_code"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          hazard["location"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'resolved':
      case 'closed':
        return successColor;
      case 'in_progress':
        return infoColor;
      case 'open':
        return warningColor;
      case 'escalated':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
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

  Color _getActionStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return infoColor;
      case 'pending':
        return warningColor;
      case 'overdue':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _reportHazard() {
    ss("Report new hazard");
  }

  void _viewHazardAnalytics() {
    ss("View hazard analytics");
  }

  void _showSortOptions() {
    ss("Hazard sort options");
  }

  void _viewHazardDetails(String hazardId) {
    ss("Viewing hazard details $hazardId");
  }

  void _editHazard(String hazardId) {
    ss("Editing hazard $hazardId");
  }

  void _showHazardOptions(Map<String, dynamic> hazard) {
    ss("Hazard options for ${hazard["title"]}");
  }
}
