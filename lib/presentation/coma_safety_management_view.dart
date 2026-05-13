import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaSafetyManagementView extends StatefulWidget {
  const ComaSafetyManagementView({Key? key}) : super(key: key);

  @override
  State<ComaSafetyManagementView> createState() => _ComaSafetyManagementViewState();
}

class _ComaSafetyManagementViewState extends State<ComaSafetyManagementView> {
  String selectedPriority = "all";
  String selectedStatus = "all";
  String selectedType = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> priorityFilters = [
    {"label": "All Priorities", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Open", "value": "open"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Resolved", "value": "resolved"},
    {"label": "Closed", "value": "closed"},
    {"label": "Escalated", "value": "escalated"},
  ];

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All Types", "value": "all"},
    {"label": "Safety Issue", "value": "safety_issue"},
    {"label": "Hazard Report", "value": "hazard_report"},
    {"label": "Equipment Issue", "value": "equipment_issue"},
    {"label": "Training Need", "value": "training_need"},
    {"label": "Policy Violation", "value": "policy_violation"},
    {"label": "Near Miss", "value": "near_miss"},
  ];

  List<Map<String, dynamic>> safetyItems = [
    {
      "id": "SAFE-001",
      "title": "Improper Scaffolding Setup",
      "type": "safety_issue",
      "priority": "high",
      "status": "open",
      "reported_by": "John Martinez",
      "reporter_id": "EMP-007",
      "reporter_photo": "https://picsum.photos/100/100?random=7&keyword=person",
      "project_name": "Metro Downtown Complex",
      "project_id": "PRJ-001",
      "location": "Building A - 5th Floor",
      "coordinates": "40.7589, -73.9851",
      "report_date": "2024-06-15",
      "due_date": "2024-06-20",
      "assigned_to": "Safety Team",
      "assignee_id": "TEAM-001",
      "description": "Scaffolding on 5th floor not properly secured. Missing guard rails and toe boards on east side. Multiple workers exposed to fall hazards.",
      "hazard_level": "high_risk",
      "affected_personnel": 8,
      "estimated_cost": 2500.00,
      "corrective_actions": [
        {
          "action": "Install missing guard rails",
          "assigned_to": "Michael Rodriguez",
          "due_date": "2024-06-17",
          "status": "in_progress",
          "cost": 800.00
        },
        {
          "action": "Add toe boards to platform",
          "assigned_to": "Safety Inspector",
          "due_date": "2024-06-18",
          "status": "pending",
          "cost": 400.00
        },
        {
          "action": "Conduct safety re-training",
          "assigned_to": "Training Coordinator",
          "due_date": "2024-06-20",
          "status": "pending",
          "cost": 1300.00
        }
      ],
      "photos": [
        "https://picsum.photos/400/300?random=1&keyword=scaffolding",
        "https://picsum.photos/400/300?random=2&keyword=construction"
      ],
      "safety_measures": [
        "Area cordoned off",
        "Warning signs posted",
        "Alternative access routes established"
      ],
      "regulations_violated": [
        "OSHA 1926.451(g)(1) - Guard rail systems",
        "OSHA 1926.451(h)(1) - Falling object protection"
      ],
      "previous_incidents": 2,
      "weather_conditions": "Clear, 18°C",
      "equipment_involved": ["Scaffolding System", "Safety Harnesses"],
      "witnesses": ["Sarah Thompson", "James Wilson"],
      "follow_up_required": true,
      "inspector_notes": "Immediate action required. High fall risk identified.",
      "resolution_notes": null,
      "closed_date": null,
      "tags": ["scaffolding", "fall_protection", "high_priority"]
    },
    {
      "id": "SAFE-002", 
      "title": "Chemical Spill in Storage Area",
      "type": "hazard_report",
      "priority": "critical",
      "status": "in_progress",
      "reported_by": "Maria Garcia",
      "reporter_id": "EMP-004",
      "reporter_photo": "https://picsum.photos/100/100?random=4&keyword=person",
      "project_name": "Healthcare Facility Expansion",
      "project_id": "PRJ-002",
      "location": "Storage Room B-12",
      "coordinates": "40.7505, -73.9934",
      "report_date": "2024-06-14",
      "due_date": "2024-06-14",
      "assigned_to": "Hazmat Team",
      "assignee_id": "TEAM-002",
      "description": "Solvent container leaked overnight creating a hazardous chemical spill. Area has strong fumes and poses respiratory hazard. Immediate containment required.",
      "hazard_level": "extreme_risk",
      "affected_personnel": 12,
      "estimated_cost": 8500.00,
      "corrective_actions": [
        {
          "action": "Emergency spill containment",
          "assigned_to": "Hazmat Specialist",
          "due_date": "2024-06-14",
          "status": "completed",
          "cost": 3500.00
        },
        {
          "action": "Air quality testing",
          "assigned_to": "Environmental Consultant",
          "due_date": "2024-06-15",
          "status": "completed",
          "cost": 1200.00
        },
        {
          "action": "Professional cleanup",
          "assigned_to": "Cleanup Contractor",
          "due_date": "2024-06-16",
          "status": "in_progress",
          "cost": 3800.00
        }
      ],
      "photos": [
        "https://picsum.photos/400/300?random=3&keyword=spill",
        "https://picsum.photos/400/300?random=4&keyword=chemical"
      ],
      "safety_measures": [
        "Area evacuated and secured",
        "Respiratory protection required",
        "Emergency ventilation activated",
        "Spill response team deployed"
      ],
      "regulations_violated": [
        "OSHA 1910.1200 - Hazard Communication",
        "EPA SPCC - Spill Prevention Control"
      ],
      "previous_incidents": 0,
      "weather_conditions": "Humid, 22°C",
      "equipment_involved": ["Chemical Storage System", "Ventilation System"],
      "witnesses": ["David Chen", "Safety Inspector"],
      "follow_up_required": true,
      "inspector_notes": "Critical situation handled appropriately. Review storage protocols.",
      "resolution_notes": "Spill contained. Air quality restored. Storage procedures updated.",
      "closed_date": null,
      "tags": ["chemical", "hazmat", "critical", "environmental"]
    },
    {
      "id": "SAFE-003",
      "title": "Faulty Electrical Panel",
      "type": "equipment_issue",
      "priority": "high",
      "status": "resolved",
      "reported_by": "Michael Rodriguez",
      "reporter_id": "EMP-001",
      "reporter_photo": "https://picsum.photos/100/100?random=1&keyword=person",
      "project_name": "Residential Tower A",
      "project_id": "PRJ-003",
      "location": "Electrical Room - Level 2",
      "coordinates": "40.7282, -74.0776",
      "report_date": "2024-06-10",
      "due_date": "2024-06-12",
      "assigned_to": "Electrical Team",
      "assignee_id": "TEAM-003",
      "description": "Main electrical panel showing signs of overheating. Breaker 3C tripping intermittently. Burning smell detected. Potential fire hazard.",
      "hazard_level": "high_risk",
      "affected_personnel": 15,
      "estimated_cost": 4200.00,
      "corrective_actions": [
        {
          "action": "Emergency shutdown of affected circuit",
          "assigned_to": "Lead Electrician",
          "due_date": "2024-06-10",
          "status": "completed",
          "cost": 0.00
        },
        {
          "action": "Replace faulty breaker",
          "assigned_to": "Michael Rodriguez",
          "due_date": "2024-06-11",
          "status": "completed",
          "cost": 850.00
        },
        {
          "action": "Electrical system inspection",
          "assigned_to": "Certified Inspector",
          "due_date": "2024-06-12",
          "status": "completed",
          "cost": 1200.00
        },
        {
          "action": "Load balancing adjustment",
          "assigned_to": "Senior Electrician",
          "due_date": "2024-06-12",
          "status": "completed",
          "cost": 2150.00
        }
      ],
      "photos": [
        "https://picsum.photos/400/300?random=5&keyword=electrical",
        "https://picsum.photos/400/300?random=6&keyword=panel"
      ],
      "safety_measures": [
        "Circuit isolated and locked out",
        "Fire watch established",
        "Alternative power routing activated"
      ],
      "regulations_violated": [
        "NFPA 70E - Electrical Safety Standards"
      ],
      "previous_incidents": 1,
      "weather_conditions": "Mild, 20°C",
      "equipment_involved": ["Main Panel Board", "Circuit Breakers"],
      "witnesses": ["Electrical Supervisor", "Site Foreman"],
      "follow_up_required": false,
      "inspector_notes": "Proper emergency procedures followed. System restored safely.",
      "resolution_notes": "Faulty breaker replaced. Load rebalanced. System tested and approved.",
      "closed_date": "2024-06-12",
      "tags": ["electrical", "fire_hazard", "resolved"]
    },
    {
      "id": "SAFE-004",
      "title": "Inadequate PPE Compliance",
      "type": "policy_violation",
      "priority": "medium",
      "status": "in_progress",
      "reported_by": "Safety Inspector",
      "reporter_id": "EMP-008",
      "reporter_photo": "https://picsum.photos/100/100?random=8&keyword=person",
      "project_name": "Riverside Office Park",
      "project_id": "PRJ-004",
      "location": "Construction Zone - Area C",
      "coordinates": "40.7061, -74.0087",
      "report_date": "2024-06-13",
      "due_date": "2024-06-18",
      "assigned_to": "Site Supervisor",
      "assignee_id": "EMP-009",
      "description": "Multiple workers observed without proper head protection. Hard hats not being worn consistently in designated zones. Safety policy violation requiring immediate intervention.",
      "hazard_level": "moderate_risk",
      "affected_personnel": 6,
      "estimated_cost": 1500.00,
      "corrective_actions": [
        {
          "action": "Issue verbal warnings to violators",
          "assigned_to": "Site Supervisor",
          "due_date": "2024-06-13",
          "status": "completed",
          "cost": 0.00
        },
        {
          "action": "Mandatory safety refresher training",
          "assigned_to": "Training Coordinator",
          "due_date": "2024-06-16",
          "status": "in_progress",
          "cost": 800.00
        },
        {
          "action": "Additional PPE procurement",
          "assigned_to": "Supply Manager",
          "due_date": "2024-06-17",
          "status": "pending",
          "cost": 700.00
        }
      ],
      "photos": [
        "https://picsum.photos/400/300?random=7&keyword=helmet",
        "https://picsum.photos/400/300?random=8&keyword=safety"
      ],
      "safety_measures": [
        "Increased supervision in area",
        "PPE checkpoint established",
        "Daily safety briefings implemented"
      ],
      "regulations_violated": [
        "OSHA 1926.95 - Personal Protective Equipment"
      ],
      "previous_incidents": 3,
      "weather_conditions": "Sunny, 25°C",
      "equipment_involved": ["Hard Hats", "Safety Vests"],
      "witnesses": ["Site Foreman", "Quality Inspector"],
      "follow_up_required": true,
      "inspector_notes": "Recurring issue. Enhanced monitoring required.",
      "resolution_notes": null,
      "closed_date": null,
      "tags": ["ppe", "compliance", "training_needed"]
    },
    {
      "id": "SAFE-005",
      "title": "Near Miss - Crane Operation",
      "type": "near_miss",
      "priority": "high",
      "status": "open",
      "reported_by": "Crane Operator",
      "reporter_id": "EMP-010",
      "reporter_photo": "https://picsum.photos/100/100?random=10&keyword=person",
      "project_name": "Industrial Facility Upgrade",
      "project_id": "PRJ-005",
      "location": "Crane Zone - North Side",
      "coordinates": "40.7128, -74.0060",
      "report_date": "2024-06-16",
      "due_date": "2024-06-18",
      "assigned_to": "Crane Safety Team",
      "assignee_id": "TEAM-005",
      "description": "Load swing during crane operation nearly struck ground worker. Communication breakdown between crane operator and signal person. Immediate safety protocol review required.",
      "hazard_level": "high_risk",
      "affected_personnel": 3,
      "estimated_cost": 3200.00,
      "corrective_actions": [
        {
          "action": "Investigate communication procedures",
          "assigned_to": "Safety Manager",
          "due_date": "2024-06-17",
          "status": "pending",
          "cost": 0.00
        },
        {
          "action": "Retrain crane operation team",
          "assigned_to": "Certified Trainer",
          "due_date": "2024-06-18",
          "status": "pending",
          "cost": 1800.00
        },
        {
          "action": "Review crane safety protocols",
          "assigned_to": "Operations Manager",
          "due_date": "2024-06-19",
          "status": "pending",
          "cost": 1400.00
        }
      ],
      "photos": [
        "https://picsum.photos/400/300?random=9&keyword=crane",
        "https://picsum.photos/400/300?random=10&keyword=construction"
      ],
      "safety_measures": [
        "Crane operations suspended",
        "Safety exclusion zone expanded",
        "Enhanced communication protocols activated"
      ],
      "regulations_violated": [
        "OSHA 1926.1419 - Crane Safety Standards"
      ],
      "previous_incidents": 0,
      "weather_conditions": "Windy, 15°C, 25 mph gusts",
      "equipment_involved": ["Tower Crane", "Communication Radios"],
      "witnesses": ["Signal Person", "Ground Crew"],
      "follow_up_required": true,
      "inspector_notes": "Serious near miss. Wind conditions may have contributed. Review weather protocols.",
      "resolution_notes": null,
      "closed_date": null,
      "tags": ["near_miss", "crane", "communication", "weather"]
    },
    {
      "id": "SAFE-006",
      "title": "Safety Training Required",
      "type": "training_need",
      "priority": "medium",
      "status": "open",
      "reported_by": "Site Manager",
      "reporter_id": "EMP-011",
      "reporter_photo": "https://picsum.photos/100/100?random=11&keyword=person",
      "project_name": "School Renovation Project",
      "project_id": "PRJ-006",
      "location": "Main Building - All Floors",
      "coordinates": "40.7831, -73.9712",
      "report_date": "2024-06-12",
      "due_date": "2024-06-25",
      "assigned_to": "Training Department",
      "assignee_id": "DEPT-001",
      "description": "New workers require comprehensive safety orientation before beginning work. Current safety training completion rate below required threshold of 100%.",
      "hazard_level": "low_risk",
      "affected_personnel": 10,
      "estimated_cost": 2800.00,
      "corrective_actions": [
        {
          "action": "Schedule OSHA 10-hour training",
          "assigned_to": "Training Coordinator",
          "due_date": "2024-06-20",
          "status": "pending",
          "cost": 1500.00
        },
        {
          "action": "Site-specific safety orientation",
          "assigned_to": "Safety Officer",
          "due_date": "2024-06-22",
          "status": "pending",
          "cost": 800.00
        },
        {
          "action": "Tool safety certification",
          "assigned_to": "Equipment Manager",
          "due_date": "2024-06-24",
          "status": "pending",
          "cost": 500.00
        }
      ],
      "photos": [
        "https://picsum.photos/400/300?random=11&keyword=training",
        "https://picsum.photos/400/300?random=12&keyword=classroom"
      ],
      "safety_measures": [
        "New workers assigned mentors",
        "Restricted work assignments until trained",
        "Enhanced supervision provided"
      ],
      "regulations_violated": [],
      "previous_incidents": 0,
      "weather_conditions": "Variable",
      "equipment_involved": ["Training Materials", "Safety Equipment"],
      "witnesses": [],
      "follow_up_required": true,
      "inspector_notes": "Proactive approach to safety training. Schedule training promptly.",
      "resolution_notes": null,
      "closed_date": null,
      "tags": ["training", "new_workers", "orientation"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Safety Management"),
        actions: [
          QButton(
            icon: Icons.add_alert,
            size: bs.sm,
            onPressed: () => _reportSafetyIssue(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _viewSafetyAnalytics(),
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
                  _buildSafetyOverview(),
                  _buildFilters(),
                  _buildCriticalAlerts(),
                  _buildSafetyItemsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildSafetyOverview() {
    int totalIssues = safetyItems.length;
    int openIssues = safetyItems.where((item) => item["status"] == "open").length;
    int criticalIssues = safetyItems.where((item) => item["priority"] == "critical").length;
    int highRiskIssues = safetyItems.where((item) => item["hazard_level"] == "high_risk" || item["hazard_level"] == "extreme_risk").length;
    double totalCost = safetyItems.fold(0.0, (sum, item) => sum + (item["estimated_cost"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: dangerColor.withAlpha(50)),
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
                  color: dangerColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.security, color: dangerColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Safety Management Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildOverviewCard("Total Issues", "$totalIssues", Icons.report_problem, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Open", "$openIssues", Icons.warning, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Critical", "$criticalIssues", Icons.error, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("High Risk", "$highRiskIssues", Icons.dangerous, dangerColor),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.attach_money, color: warningColor, size: 18),
                SizedBox(width: spXs),
                Text(
                  "Estimated Impact: \$${totalCost.currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Spacer(),
                Icon(Icons.trending_down, color: successColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Prevention Focus",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
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
                  label: "Search safety issues...",
                  value: searchQuery,
                  hint: "Search by title, reporter, or location",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.map,
                size: bs.sm,
                onPressed: () => _showSafetyMap(),
              ),
            ],
          ),
          Row(
            children: [
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

  Widget _buildCriticalAlerts() {
    List<Map<String, dynamic>> criticalItems = safetyItems
        .where((item) => item["priority"] == "critical" || item["hazard_level"] == "extreme_risk")
        .toList();

    if (criticalItems.isEmpty) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: dangerColor.withAlpha(50)),
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
                  color: dangerColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.emergency, color: dangerColor, size: 20),
              ),
              SizedBox(width: spMd),
              Text(
                "Critical Safety Alerts (${criticalItems.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Emergency",
                size: bs.sm,
                onPressed: () => _initiateEmergencyResponse(),
              ),
            ],
          ),
          ...criticalItems.take(2).map((item) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border(
                left: BorderSide(
                  color: _getPriorityColor(item["priority"]),
                  width: 4,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("${item["reporter_photo"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${item["project_name"]} | ${item["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.schedule, color: warningColor, size: 12),
                          SizedBox(width: spXs),
                          Text(
                            "Due: ${item["due_date"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: warningColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(Icons.person, color: disabledBoldColor, size: 12),
                          SizedBox(width: spXs),
                          Text(
                            "${item["affected_personnel"]} affected",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.priority_high,
                  size: bs.sm,
                  onPressed: () => _viewSafetyDetails(item["id"]),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSafetyItemsList() {
    List<Map<String, dynamic>> filteredItems = _getFilteredSafetyItems();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Safety Items (${filteredItems.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.file_download,
              size: bs.sm,
              onPressed: () => _exportSafetyReport(),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredItems.map((item) => _buildSafetyItemCard(item)),
      ],
    );
  }

  Widget _buildSafetyItemCard(Map<String, dynamic> item) {
    Color priorityColor = _getPriorityColor(item["priority"]);
    Color statusColor = _getStatusColor(item["status"]);
    Color riskColor = _getHazardLevelColor(item["hazard_level"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: priorityColor,
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
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${item["reporter_photo"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Reported by ${item["reported_by"]} | ${item["report_date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${item["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: priorityColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${item["project_name"]} - ${item["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.dangerous, color: riskColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Risk Level: ${item["hazard_level"]}".replaceAll('_', ' ').toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: riskColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.group, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${item["affected_personnel"]} personnel affected",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if ((item["photos"] as List).isNotEmpty)
            Container(
              height: 100,
              child: QHorizontalScroll(
                children: (item["photos"] as List).map((photo) => Container(
                  width: 140,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("$photo"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )).toList(),
              ),
            ),
          if ((item["corrective_actions"] as List).isNotEmpty)
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
                      Icon(Icons.build, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Corrective Actions (${(item["corrective_actions"] as List).length})",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  ...(item["corrective_actions"] as List).take(2).map((action) => Padding(
                    padding: EdgeInsets.only(left: spMd),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _getActionStatusColor(action["status"]),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${action["action"]} - ${action["status"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${(action["cost"] as double).currency}",
                          style: TextStyle(
                            fontSize: 11,
                            color: successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          if ((item["safety_measures"] as List).isNotEmpty)
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
                  Row(
                    children: [
                      Icon(Icons.shield, color: successColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Safety Measures Implemented",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  ...(item["safety_measures"] as List).take(3).map((measure) => Padding(
                    padding: EdgeInsets.only(left: spMd),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 12),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "$measure",
                            style: TextStyle(
                              fontSize: 11,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Due Date: ${item["due_date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.attach_money, color: successColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Est. Cost: \$${(item["estimated_cost"] as double).currency}",
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
                    Icon(Icons.assignment_ind, color: infoColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Assigned to: ${item["assigned_to"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.cloud, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${item["weather_conditions"]}",
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
          Row(
            children: [
              Expanded(
                child: Text(
                  "Type: ${item["type"]}".replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              QButton(
                icon: Icons.camera_alt,
                size: bs.sm,
                onPressed: () => _viewPhotos(item["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editSafetyItem(item["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showSafetyOptions(item),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredSafetyItems() {
    List<Map<String, dynamic>> filtered = safetyItems;

    if (selectedPriority != "all") {
      filtered = filtered.where((item) => item["priority"] == selectedPriority).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((item) => item["status"] == selectedStatus).toList();
    }

    if (selectedType != "all") {
      filtered = filtered.where((item) => item["type"] == selectedType).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) =>
          item["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["reported_by"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["location"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'resolved':
        return successColor;
      case 'closed':
        return primaryColor;
      case 'in_progress':
        return warningColor;
      case 'open':
        return dangerColor;
      case 'escalated':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getHazardLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'extreme_risk':
        return dangerColor;
      case 'high_risk':
        return warningColor;
      case 'moderate_risk':
        return infoColor;
      case 'low_risk':
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
        return warningColor;
      case 'pending':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _reportSafetyIssue() {
    ss("Report new safety issue");
  }

  void _viewSafetyAnalytics() {
    ss("Safety management analytics");
  }

  void _showSafetyMap() {
    ss("Show safety map view");
  }

  void _initiateEmergencyResponse() {
    ss("Emergency response initiated");
  }

  void _viewSafetyDetails(String itemId) {
    ss("View safety details $itemId");
  }

  void _exportSafetyReport() {
    ss("Export safety report");
  }

  void _showSortOptions() {
    ss("Safety items sort options");
  }

  void _viewPhotos(String itemId) {
    ss("View photos for $itemId");
  }

  void _editSafetyItem(String itemId) {
    ss("Edit safety item $itemId");
  }

  void _showSafetyOptions(Map<String, dynamic> item) {
    ss("Safety options for ${item["title"]}");
  }
}
