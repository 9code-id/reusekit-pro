import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaSafetyProtocolsView extends StatefulWidget {
  const ComaSafetyProtocolsView({Key? key}) : super(key: key);

  @override
  State<ComaSafetyProtocolsView> createState() => _ComaSafetyProtocolsViewState();
}

class _ComaSafetyProtocolsViewState extends State<ComaSafetyProtocolsView> {
  String selectedCategory = "all";
  String selectedStatus = "all";
  String selectedCompliance = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> categoryFilters = [
    {"label": "All Categories", "value": "all"},
    {"label": "Personal Safety", "value": "personal_safety"},
    {"label": "Equipment Safety", "value": "equipment_safety"},
    {"label": "Site Security", "value": "site_security"},
    {"label": "Emergency Response", "value": "emergency_response"},
    {"label": "Environmental", "value": "environmental"},
    {"label": "Fire Safety", "value": "fire_safety"},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Pending Approval", "value": "pending_approval"},
    {"label": "Archived", "value": "archived"},
    {"label": "Draft", "value": "draft"},
  ];

  List<Map<String, dynamic>> complianceFilters = [
    {"label": "All Compliance", "value": "all"},
    {"label": "OSHA Required", "value": "osha_required"},
    {"label": "Company Policy", "value": "company_policy"},
    {"label": "Industry Standard", "value": "industry_standard"},
    {"label": "Local Regulation", "value": "local_regulation"},
  ];

  List<Map<String, dynamic>> safetyProtocols = [
    {
      "id": "PROTO-001",
      "protocol_name": "Personal Protective Equipment (PPE) Guidelines",
      "category": "personal_safety",
      "status": "active",
      "compliance_type": "osha_required",
      "version": "2.1",
      "effective_date": "2024-01-15",
      "last_updated": "2024-05-10",
      "next_review": "2024-11-15",
      "created_by": "Safety Manager",
      "approved_by": "Operations Director",
      "approval_date": "2024-01-12",
      "priority": "high",
      "mandatory": true,
      "training_required": true,
      "description": "Comprehensive guidelines for the proper selection, use, maintenance, and disposal of personal protective equipment on all construction sites.",
      "scope": "All personnel working on construction sites",
      "regulatory_references": [
        "OSHA 1926.95 - Personal Protective Equipment",
        "OSHA 1926.96 - Occupational foot protection",
        "OSHA 1926.100 - Head protection"
      ],
      "key_requirements": [
        {
          "requirement": "Hard hat usage in designated zones",
          "mandatory": true,
          "penalty_level": "immediate_removal"
        },
        {
          "requirement": "Safety boots with steel toes",
          "mandatory": true,
          "penalty_level": "written_warning"
        },
        {
          "requirement": "High-visibility safety vests",
          "mandatory": true,
          "penalty_level": "verbal_warning"
        },
        {
          "requirement": "Eye protection when required",
          "mandatory": true,
          "penalty_level": "immediate_removal"
        }
      ],
      "procedures": [
        {
          "step": 1,
          "title": "PPE Selection",
          "description": "Identify required PPE based on job hazard analysis",
          "responsibility": "Site Supervisor",
          "time_required": "5 minutes"
        },
        {
          "step": 2,
          "title": "PPE Inspection",
          "description": "Daily inspection of PPE condition before use",
          "responsibility": "Individual Worker",
          "time_required": "2 minutes"
        },
        {
          "step": 3,
          "title": "Proper Fitting",
          "description": "Ensure PPE fits properly and is worn correctly",
          "responsibility": "Individual Worker",
          "time_required": "3 minutes"
        }
      ],
      "training_materials": [
        {
          "type": "video",
          "title": "PPE Safety Training",
          "duration": "15 minutes",
          "url": "safety_ppe_training.mp4"
        },
        {
          "type": "document",
          "title": "PPE Quick Reference Guide",
          "pages": 4,
          "url": "ppe_quick_reference.pdf"
        }
      ],
      "enforcement": {
        "inspection_frequency": "daily",
        "violations_this_month": 3,
        "compliance_rate": 96.8,
        "last_violation": "2024-06-10"
      },
      "related_protocols": ["PROTO-002", "PROTO-008"],
      "document_url": "safety_protocols/ppe_guidelines_v2.1.pdf",
      "checklist_items": [
        "Hard hat properly secured",
        "Safety boots laced and in good condition",
        "Safety vest clean and visible",
        "Eye protection available when needed"
      ],
      "incident_history": [
        {
          "date": "2024-05-15",
          "incident_type": "PPE violation",
          "description": "Worker not wearing hard hat in designated zone",
          "action_taken": "Verbal warning and immediate correction"
        }
      ]
    },
    {
      "id": "PROTO-002",
      "protocol_name": "Fall Protection Safety Procedures",
      "category": "personal_safety",
      "status": "active",
      "compliance_type": "osha_required",
      "version": "3.0",
      "effective_date": "2024-02-01",
      "last_updated": "2024-06-01",
      "next_review": "2025-02-01",
      "created_by": "Safety Engineer",
      "approved_by": "Safety Director",
      "approval_date": "2024-01-28",
      "priority": "critical",
      "mandatory": true,
      "training_required": true,
      "description": "Detailed procedures for fall protection systems, including guardrails, safety nets, and personal fall arrest systems for work at heights above 6 feet.",
      "scope": "All workers performing tasks at heights of 6 feet or more",
      "regulatory_references": [
        "OSHA 1926.501 - Fall protection duty to have fall protection",
        "OSHA 1926.502 - Fall protection systems",
        "OSHA 1926.503 - Fall protection training requirements"
      ],
      "key_requirements": [
        {
          "requirement": "Full body harness for work above 6 feet",
          "mandatory": true,
          "penalty_level": "immediate_removal"
        },
        {
          "requirement": "100% tie-off when moving between anchor points",
          "mandatory": true,
          "penalty_level": "immediate_removal"
        },
        {
          "requirement": "Daily inspection of fall protection equipment",
          "mandatory": true,
          "penalty_level": "written_warning"
        }
      ],
      "procedures": [
        {
          "step": 1,
          "title": "Pre-work Inspection",
          "description": "Inspect all fall protection equipment before use",
          "responsibility": "Qualified Person",
          "time_required": "10 minutes"
        },
        {
          "step": 2,
          "title": "Anchor Point Verification",
          "description": "Verify anchor points can support 5,000 lbs per person",
          "responsibility": "Competent Person",
          "time_required": "5 minutes"
        },
        {
          "step": 3,
          "title": "Harness Fitting",
          "description": "Properly fit and adjust full body harness",
          "responsibility": "Individual Worker",
          "time_required": "3 minutes"
        },
        {
          "step": 4,
          "title": "Connection Verification",
          "description": "Verify proper connection to anchor point",
          "responsibility": "Individual Worker",
          "time_required": "2 minutes"
        }
      ],
      "training_materials": [
        {
          "type": "video",
          "title": "Fall Protection Systems Training",
          "duration": "25 minutes",
          "url": "fall_protection_training.mp4"
        },
        {
          "type": "hands_on",
          "title": "Harness Fitting Demonstration",
          "duration": "20 minutes",
          "url": "harness_demo.mp4"
        }
      ],
      "enforcement": {
        "inspection_frequency": "every_shift",
        "violations_this_month": 1,
        "compliance_rate": 98.5,
        "last_violation": "2024-06-08"
      },
      "related_protocols": ["PROTO-001", "PROTO-003"],
      "document_url": "safety_protocols/fall_protection_v3.0.pdf",
      "checklist_items": [
        "Harness properly fitted and adjusted",
        "Anchor point capacity verified",
        "Lanyard free from damage",
        "100% tie-off maintained"
      ],
      "incident_history": [
        {
          "date": "2024-04-22",
          "incident_type": "near_miss",
          "description": "Worker fell but was caught by safety harness",
          "action_taken": "Additional training provided, equipment inspected"
        }
      ]
    },
    {
      "id": "PROTO-003",
      "protocol_name": "Excavation and Trenching Safety",
      "category": "equipment_safety",
      "status": "active",
      "compliance_type": "osha_required",
      "version": "1.8",
      "effective_date": "2024-03-15",
      "last_updated": "2024-05-20",
      "next_review": "2024-12-15",
      "created_by": "Site Safety Coordinator",
      "approved_by": "Project Manager",
      "approval_date": "2024-03-10",
      "priority": "critical",
      "mandatory": true,
      "training_required": true,
      "description": "Safety protocols for excavation work including soil analysis, protective systems, and safe entry/exit procedures for trenches and excavations.",
      "scope": "All personnel involved in excavation and trenching operations",
      "regulatory_references": [
        "OSHA 1926.650 - Excavation general requirements",
        "OSHA 1926.651 - Specific excavation requirements",
        "OSHA 1926.652 - Requirements for protective systems"
      ],
      "key_requirements": [
        {
          "requirement": "Competent person on-site during excavation",
          "mandatory": true,
          "penalty_level": "work_stoppage"
        },
        {
          "requirement": "Protective system for excavations 5+ feet deep",
          "mandatory": true,
          "penalty_level": "work_stoppage"
        },
        {
          "requirement": "Daily inspection of excavation",
          "mandatory": true,
          "penalty_level": "written_warning"
        }
      ],
      "procedures": [
        {
          "step": 1,
          "title": "Utility Location",
          "description": "Call 811 and mark all utilities before excavation",
          "responsibility": "Site Supervisor",
          "time_required": "2-3 days"
        },
        {
          "step": 2,
          "title": "Soil Classification",
          "description": "Classify soil type and determine protective system",
          "responsibility": "Competent Person",
          "time_required": "30 minutes"
        },
        {
          "step": 3,
          "title": "Protective System Installation",
          "description": "Install appropriate shoring, sloping, or shielding",
          "responsibility": "Qualified Personnel",
          "time_required": "1-2 hours"
        }
      ],
      "training_materials": [
        {
          "type": "classroom",
          "title": "Excavation Safety Training",
          "duration": "4 hours",
          "url": "excavation_safety_course.pdf"
        },
        {
          "type": "video",
          "title": "Soil Classification Guide",
          "duration": "18 minutes",
          "url": "soil_classification.mp4"
        }
      ],
      "enforcement": {
        "inspection_frequency": "daily",
        "violations_this_month": 0,
        "compliance_rate": 100.0,
        "last_violation": "2024-04-15"
      },
      "related_protocols": ["PROTO-004", "PROTO-009"],
      "document_url": "safety_protocols/excavation_safety_v1.8.pdf",
      "checklist_items": [
        "Utilities located and marked",
        "Competent person assigned",
        "Protective system in place",
        "Safe entry/exit provided"
      ],
      "incident_history": []
    },
    {
      "id": "PROTO-004",
      "protocol_name": "Emergency Evacuation Procedures",
      "category": "emergency_response",
      "status": "active",
      "compliance_type": "company_policy",
      "version": "2.3",
      "effective_date": "2024-01-01",
      "last_updated": "2024-04-15",
      "next_review": "2024-10-01",
      "created_by": "Emergency Coordinator",
      "approved_by": "Site Manager",
      "approval_date": "2023-12-28",
      "priority": "critical",
      "mandatory": true,
      "training_required": true,
      "description": "Comprehensive emergency evacuation procedures for various emergency scenarios including fire, chemical spill, severe weather, and security threats.",
      "scope": "All site personnel including workers, visitors, and contractors",
      "regulatory_references": [
        "OSHA 1926.95 - Emergency action plans",
        "Local Fire Department Requirements",
        "Emergency Management Guidelines"
      ],
      "key_requirements": [
        {
          "requirement": "Know location of nearest emergency exit",
          "mandatory": true,
          "penalty_level": "training_required"
        },
        {
          "requirement": "Participate in quarterly evacuation drills",
          "mandatory": true,
          "penalty_level": "written_warning"
        },
        {
          "requirement": "Report to designated assembly area",
          "mandatory": true,
          "penalty_level": "disciplinary_action"
        }
      ],
      "procedures": [
        {
          "step": 1,
          "title": "Emergency Signal Recognition",
          "description": "Recognize emergency signals and alarms",
          "responsibility": "All Personnel",
          "time_required": "Immediate"
        },
        {
          "step": 2,
          "title": "Safe Evacuation Route",
          "description": "Use nearest safe evacuation route to exit",
          "responsibility": "All Personnel",
          "time_required": "2-5 minutes"
        },
        {
          "step": 3,
          "title": "Assembly Area Report",
          "description": "Report to designated assembly area for accountability",
          "responsibility": "All Personnel",
          "time_required": "5-10 minutes"
        },
        {
          "step": 4,
          "title": "Accountability Check",
          "description": "Conduct headcount and report missing persons",
          "responsibility": "Area Supervisors",
          "time_required": "5-15 minutes"
        }
      ],
      "training_materials": [
        {
          "type": "presentation",
          "title": "Emergency Response Overview",
          "duration": "30 minutes",
          "url": "emergency_response_overview.ppt"
        },
        {
          "type": "drill",
          "title": "Evacuation Drill Practice",
          "duration": "20 minutes",
          "url": "evacuation_drill_guide.pdf"
        }
      ],
      "enforcement": {
        "inspection_frequency": "quarterly",
        "violations_this_month": 0,
        "compliance_rate": 100.0,
        "last_violation": "none"
      },
      "related_protocols": ["PROTO-005", "PROTO-006"],
      "document_url": "safety_protocols/emergency_evacuation_v2.3.pdf",
      "checklist_items": [
        "Emergency exits clearly marked",
        "Assembly areas designated",
        "Communication systems functional",
        "Evacuation routes unobstructed"
      ],
      "incident_history": [
        {
          "date": "2024-03-10",
          "incident_type": "drill",
          "description": "Quarterly evacuation drill conducted",
          "action_taken": "All personnel evacuated in 4.5 minutes"
        }
      ]
    },
    {
      "id": "PROTO-005",
      "protocol_name": "Fire Prevention and Response",
      "category": "fire_safety",
      "status": "active",
      "compliance_type": "local_regulation",
      "version": "1.5",
      "effective_date": "2024-02-20",
      "last_updated": "2024-05-05",
      "next_review": "2024-11-20",
      "created_by": "Fire Safety Officer",
      "approved_by": "Safety Director",
      "approval_date": "2024-02-15",
      "priority": "high",
      "mandatory": true,
      "training_required": true,
      "description": "Fire prevention strategies and emergency response procedures including proper use of fire extinguishers, evacuation protocols, and hot work procedures.",
      "scope": "All site personnel and hot work operations",
      "regulatory_references": [
        "NFPA 241 - Safeguarding Construction, Alteration, and Demolition Operations",
        "Local Fire Code Requirements",
        "OSHA 1926.352 - Fire prevention and protection"
      ],
      "key_requirements": [
        {
          "requirement": "Fire watch during hot work operations",
          "mandatory": true,
          "penalty_level": "work_stoppage"
        },
        {
          "requirement": "Proper storage of flammable materials",
          "mandatory": true,
          "penalty_level": "immediate_correction"
        },
        {
          "requirement": "Monthly fire extinguisher inspection",
          "mandatory": true,
          "penalty_level": "written_warning"
        }
      ],
      "procedures": [
        {
          "step": 1,
          "title": "Hot Work Permit",
          "description": "Obtain hot work permit before welding, cutting, or grinding",
          "responsibility": "Supervisor",
          "time_required": "15 minutes"
        },
        {
          "step": 2,
          "title": "Fire Watch Assignment",
          "description": "Assign trained fire watch personnel",
          "responsibility": "Supervisor",
          "time_required": "5 minutes"
        },
        {
          "step": 3,
          "title": "Area Preparation",
          "description": "Clear combustible materials from work area",
          "responsibility": "Fire Watch",
          "time_required": "10-20 minutes"
        },
        {
          "step": 4,
          "title": "Fire Suppression Setup",
          "description": "Position appropriate fire suppression equipment",
          "responsibility": "Fire Watch",
          "time_required": "5 minutes"
        }
      ],
      "training_materials": [
        {
          "type": "hands_on",
          "title": "Fire Extinguisher Training",
          "duration": "45 minutes",
          "url": "fire_extinguisher_training.mp4"
        },
        {
          "type": "video",
          "title": "Hot Work Safety Procedures",
          "duration": "20 minutes",
          "url": "hot_work_safety.mp4"
        }
      ],
      "enforcement": {
        "inspection_frequency": "weekly",
        "violations_this_month": 2,
        "compliance_rate": 94.2,
        "last_violation": "2024-06-12"
      },
      "related_protocols": ["PROTO-004", "PROTO-007"],
      "document_url": "safety_protocols/fire_prevention_v1.5.pdf",
      "checklist_items": [
        "Hot work permits current",
        "Fire extinguishers accessible",
        "Flammable materials properly stored",
        "Fire watch personnel trained"
      ],
      "incident_history": [
        {
          "date": "2024-05-20",
          "incident_type": "minor_fire",
          "description": "Small electrical fire in temporary panel",
          "action_taken": "Fire suppressed immediately, equipment replaced"
        }
      ]
    },
    {
      "id": "PROTO-006",
      "protocol_name": "Hazardous Material Handling",
      "category": "environmental",
      "status": "under_review",
      "compliance_type": "industry_standard",
      "version": "2.0",
      "effective_date": "2024-04-01",
      "last_updated": "2024-06-10",
      "next_review": "2024-07-01",
      "created_by": "Environmental Specialist",
      "approved_by": "Environmental Manager",
      "approval_date": "2024-03-25",
      "priority": "high",
      "mandatory": true,
      "training_required": true,
      "description": "Procedures for safe handling, storage, and disposal of hazardous materials including chemicals, solvents, and contaminated materials on construction sites.",
      "scope": "Personnel handling hazardous materials and chemicals",
      "regulatory_references": [
        "OSHA 1910.1200 - Hazard Communication Standard",
        "EPA Resource Conservation and Recovery Act",
        "DOT Hazardous Materials Regulations"
      ],
      "key_requirements": [
        {
          "requirement": "Safety Data Sheet (SDS) review before use",
          "mandatory": true,
          "penalty_level": "immediate_correction"
        },
        {
          "requirement": "Appropriate PPE for chemical handling",
          "mandatory": true,
          "penalty_level": "immediate_removal"
        },
        {
          "requirement": "Proper labeling of all containers",
          "mandatory": true,
          "penalty_level": "written_warning"
        }
      ],
      "procedures": [
        {
          "step": 1,
          "title": "Material Identification",
          "description": "Identify hazardous properties and classification",
          "responsibility": "Material Handler",
          "time_required": "10 minutes"
        },
        {
          "step": 2,
          "title": "PPE Selection",
          "description": "Select appropriate personal protective equipment",
          "responsibility": "Material Handler",
          "time_required": "5 minutes"
        },
        {
          "step": 3,
          "title": "Handling Procedures",
          "description": "Follow specific handling and storage procedures",
          "responsibility": "Material Handler",
          "time_required": "Variable"
        }
      ],
      "training_materials": [
        {
          "type": "classroom",
          "title": "Hazardous Materials Training",
          "duration": "8 hours",
          "url": "hazmat_training_course.pdf"
        },
        {
          "type": "document",
          "title": "Chemical Safety Reference",
          "pages": 25,
          "url": "chemical_safety_reference.pdf"
        }
      ],
      "enforcement": {
        "inspection_frequency": "monthly",
        "violations_this_month": 1,
        "compliance_rate": 97.1,
        "last_violation": "2024-06-05"
      },
      "related_protocols": ["PROTO-008", "PROTO-009"],
      "document_url": "safety_protocols/hazmat_handling_v2.0.pdf",
      "checklist_items": [
        "SDS sheets readily available",
        "Containers properly labeled",
        "Spill response materials present",
        "Proper storage conditions maintained"
      ],
      "incident_history": [
        {
          "date": "2024-05-15",
          "incident_type": "spill",
          "description": "Minor solvent spill during transfer",
          "action_taken": "Immediate cleanup, additional training provided"
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Safety Protocols"),
        actions: [
          QButton(
            icon: Icons.add_box,
            size: bs.sm,
            onPressed: () => _createNewProtocol(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.schedule,
            size: bs.sm,
            onPressed: () => _showReviewSchedule(),
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
                  _buildProtocolOverview(),
                  _buildFilters(),
                  _buildComplianceStatus(),
                  _buildProtocolsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildProtocolOverview() {
    int totalProtocols = safetyProtocols.length;
    int activeProtocols = safetyProtocols.where((p) => p["status"] == "active").length;
    int mandatoryProtocols = safetyProtocols.where((p) => p["mandatory"] == true).length;
    int reviewDue = safetyProtocols.where((p) => _isReviewDue(p["next_review"])).length;

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
                child: Icon(Icons.policy, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Safety Protocols Overview",
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
              _buildOverviewCard("Total Protocols", "$totalProtocols", Icons.description, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Active", "$activeProtocols", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Mandatory", "$mandatoryProtocols", Icons.priority_high, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Review Due", "$reviewDue", Icons.schedule, warningColor),
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
                  label: "Search protocols...",
                  value: searchQuery,
                  hint: "Search by name, category, or requirement",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.library_books,
                size: bs.sm,
                onPressed: () => _showProtocolLibrary(),
              ),
            ],
          ),
          Row(
            children: [
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
                  label: "Compliance",
                  items: complianceFilters,
                  value: selectedCompliance,
                  onChanged: (value, label) {
                    selectedCompliance = value;
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

  Widget _buildComplianceStatus() {
    Map<String, int> categoryCount = {};
    Map<String, double> complianceRates = {};
    
    for (var protocol in safetyProtocols) {
      String category = protocol["category"];
      categoryCount[category] = (categoryCount[category] ?? 0) + 1;
      
      if (protocol["enforcement"] != null) {
        complianceRates[category] = (complianceRates[category] ?? 0.0) + 
            (protocol["enforcement"]["compliance_rate"] as double);
      }
    }

    // Calculate average compliance rates
    complianceRates.forEach((key, value) {
      complianceRates[key] = value / (categoryCount[key] ?? 1);
    });

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
            "Compliance Status by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          QHorizontalScroll(
            children: categoryCount.entries.map((entry) => Container(
              width: 180,
              margin: EdgeInsets.only(right: spMd),
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
                    "${entry.key}".replaceAll('_', ' ').toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.description, color: primaryColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${entry.value} protocols",
                        style: TextStyle(
                          fontSize: 11,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.trending_up, color: successColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${(complianceRates[entry.key] ?? 0).toStringAsFixed(1)}% compliance",
                        style: TextStyle(
                          fontSize: 11,
                          color: successColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProtocolsList() {
    List<Map<String, dynamic>> filteredProtocols = _getFilteredProtocols();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Safety Protocols (${filteredProtocols.length})",
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
              onPressed: () => _exportProtocols(),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredProtocols.map((protocol) => _buildProtocolCard(protocol)),
      ],
    );
  }

  Widget _buildProtocolCard(Map<String, dynamic> protocol) {
    Color statusColor = _getStatusColor(protocol["status"]);
    Color priorityColor = _getPriorityColor(protocol["priority"]);
    Color categoryColor = _getCategoryColor(protocol["category"]);

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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: categoryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(_getCategoryIcon(protocol["category"]), color: categoryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${protocol["protocol_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Version ${protocol["version"]} | Created by ${protocol["created_by"]}",
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
                            color: statusColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${protocol["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        if (protocol["mandatory"] == true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "MANDATORY",
                              style: TextStyle(
                                fontSize: 10,
                                color: dangerColor,
                                fontWeight: FontWeight.bold,
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
                    Icon(Icons.category, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Category: ${protocol["category"]}".replaceAll('_', ' ').toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${protocol["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.people, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Scope: ${protocol["scope"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if ((protocol["key_requirements"] as List).isNotEmpty)
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
                      Icon(Icons.rule, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Key Requirements (${(protocol["key_requirements"] as List).length})",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  ...(protocol["key_requirements"] as List).take(3).map((req) => Padding(
                    padding: EdgeInsets.only(left: spMd),
                    child: Row(
                      children: [
                        Icon(
                          req["mandatory"] == true ? Icons.priority_high : Icons.info,
                          color: req["mandatory"] == true ? dangerColor : infoColor,
                          size: 12,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${req["requirement"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          if ((protocol["procedures"] as List).isNotEmpty)
            Container(
              height: 120,
              child: QHorizontalScroll(
                children: (protocol["procedures"] as List).map((procedure) => Container(
                  width: 200,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: infoColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "${procedure["step"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${procedure["title"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${procedure["description"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(Icons.person, color: disabledBoldColor, size: 10),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${procedure["responsibility"]}",
                              style: TextStyle(
                                fontSize: 9,
                                color: disabledBoldColor,
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
          if (protocol["enforcement"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.assessment, color: successColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Compliance: ${protocol["enforcement"]["compliance_rate"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.warning, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Violations: ${protocol["enforcement"]["violations_this_month"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: infoColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Inspections: ${protocol["enforcement"]["inspection_frequency"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Last violation: ${protocol["enforcement"]["last_violation"]}",
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
                    Icon(Icons.date_range, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Effective: ${protocol["effective_date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.update, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Review Due: ${protocol["next_review"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: _isReviewDue(protocol["next_review"]) ? dangerColor : warningColor,
                        fontWeight: _isReviewDue(protocol["next_review"]) ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.verified_user, color: successColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Approved by: ${protocol["approved_by"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                    Spacer(),
                    if (protocol["training_required"] == true)
                      Row(
                        children: [
                          Icon(Icons.school, color: infoColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "Training Required",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                  "Compliance: ${protocol["compliance_type"]}".replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              QButton(
                icon: Icons.description,
                size: bs.sm,
                onPressed: () => _viewProtocolDocument(protocol["document_url"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editProtocol(protocol["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showProtocolOptions(protocol),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredProtocols() {
    List<Map<String, dynamic>> filtered = safetyProtocols;

    if (selectedCategory != "all") {
      filtered = filtered.where((protocol) => protocol["category"] == selectedCategory).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((protocol) => protocol["status"] == selectedStatus).toList();
    }

    if (selectedCompliance != "all") {
      filtered = filtered.where((protocol) => protocol["compliance_type"] == selectedCompliance).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((protocol) =>
          protocol["protocol_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          protocol["description"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  bool _isReviewDue(String nextReview) {
    try {
      DateTime reviewDate = DateTime.parse(nextReview);
      DateTime now = DateTime.now();
      return reviewDate.isBefore(now.add(Duration(days: 30)));
    } catch (e) {
      return false;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'under_review':
        return warningColor;
      case 'pending_approval':
        return infoColor;
      case 'archived':
        return disabledBoldColor;
      case 'draft':
        return primaryColor;
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

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'personal_safety':
        return dangerColor;
      case 'equipment_safety':
        return warningColor;
      case 'site_security':
        return primaryColor;
      case 'emergency_response':
        return dangerColor;
      case 'environmental':
        return successColor;
      case 'fire_safety':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'personal_safety':
        return Icons.person;
      case 'equipment_safety':
        return Icons.build;
      case 'site_security':
        return Icons.security;
      case 'emergency_response':
        return Icons.emergency;
      case 'environmental':
        return Icons.eco;
      case 'fire_safety':
        return Icons.local_fire_department;
      default:
        return Icons.policy;
    }
  }

  void _createNewProtocol() {
    ss("Create new safety protocol");
  }

  void _showReviewSchedule() {
    ss("Show protocol review schedule");
  }

  void _showProtocolLibrary() {
    ss("Show protocol library");
  }

  void _exportProtocols() {
    ss("Export safety protocols");
  }

  void _showSortOptions() {
    ss("Protocol sort options");
  }

  void _viewProtocolDocument(String documentUrl) {
    ss("View protocol document $documentUrl");
  }

  void _editProtocol(String protocolId) {
    ss("Edit protocol $protocolId");
  }

  void _showProtocolOptions(Map<String, dynamic> protocol) {
    ss("Protocol options for ${protocol["protocol_name"]}");
  }
}
