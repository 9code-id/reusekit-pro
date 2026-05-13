import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaIncidentReportingView extends StatefulWidget {
  const ComaIncidentReportingView({Key? key}) : super(key: key);

  @override
  State<ComaIncidentReportingView> createState() => _ComaIncidentReportingViewState();
}

class _ComaIncidentReportingViewState extends State<ComaIncidentReportingView> {
  String selectedType = "all";
  String selectedSeverity = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All Types", "value": "all"},
    {"label": "Injury", "value": "injury"},
    {"label": "Near Miss", "value": "near_miss"},
    {"label": "Property Damage", "value": "property_damage"},
    {"label": "Environmental", "value": "environmental"},
    {"label": "Security", "value": "security"},
    {"label": "Equipment Failure", "value": "equipment_failure"},
  ];

  List<Map<String, dynamic>> severityFilters = [
    {"label": "All Severity", "value": "all"},
    {"label": "Fatal", "value": "fatal"},
    {"label": "Serious", "value": "serious"},
    {"label": "Minor", "value": "minor"},
    {"label": "First Aid", "value": "first_aid"},
    {"label": "No Injury", "value": "no_injury"},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Open", "value": "open"},
    {"label": "Under Investigation", "value": "investigating"},
    {"label": "Pending Review", "value": "pending_review"},
    {"label": "Closed", "value": "closed"},
    {"label": "Escalated", "value": "escalated"},
  ];

  List<Map<String, dynamic>> incidentReports = [
    {
      "id": "INC-2024-001",
      "incident_number": "INC-2024-001",
      "title": "Fall from Scaffolding - East Wing",
      "type": "injury",
      "severity": "serious",
      "status": "investigating",
      "report_date": "2024-06-15",
      "incident_date": "2024-06-15",
      "incident_time": "14:30",
      "reporter_name": "Site Supervisor",
      "reporter_id": "EMP-012",
      "reporter_photo": "https://picsum.photos/100/100?random=12&keyword=person",
      "injured_person": "Carlos Mendez",
      "injured_id": "EMP-013",
      "injured_photo": "https://picsum.photos/100/100?random=13&keyword=person",
      "project_name": "Metro Downtown Complex",
      "project_id": "PRJ-001",
      "location": "Building A - East Wing, 3rd Floor",
      "coordinates": "40.7589, -73.9851",
      "weather_conditions": "Clear, 22°C, Light breeze",
      "description": "Worker fell approximately 8 feet from scaffolding platform while installing exterior cladding. Safety harness was not properly connected to anchor point. Worker sustained injuries to left arm and ribs.",
      "immediate_actions_taken": [
        "Emergency services called at 14:32",
        "First aid administered by certified responder",
        "Work area secured and evacuated",
        "Site safety manager notified",
        "Equipment preserved for investigation"
      ],
      "injury_details": {
        "body_parts_affected": ["Left arm", "Ribs", "Left shoulder"],
        "injury_type": "Fracture and contusions",
        "medical_treatment": "Hospital emergency room",
        "days_away_from_work": 14,
        "return_to_work_date": "2024-06-29",
        "medical_provider": "Metro General Hospital",
        "treating_physician": "Dr. Sarah Chen",
        "restrictions": ["No lifting over 10 lbs", "No work at height"]
      },
      "incident_investigation": {
        "lead_investigator": "Safety Manager",
        "investigation_team": ["Safety Manager", "Site Supervisor", "HR Representative"],
        "start_date": "2024-06-15",
        "expected_completion": "2024-06-22",
        "preliminary_findings": "Failure to follow fall protection procedures, inadequate supervision",
        "root_causes": [
          "Worker did not connect safety harness to anchor point",
          "Supervisor did not verify proper PPE usage",
          "Inadequate safety training for scaffolding work"
        ]
      },
      "witnesses": [
        {
          "name": "John Martinez",
          "id": "EMP-007",
          "statement_taken": true,
          "statement_date": "2024-06-15"
        },
        {
          "name": "Michael Rodriguez",
          "id": "EMP-001",
          "statement_taken": true,
          "statement_date": "2024-06-16"
        }
      ],
      "photos": [
        "https://picsum.photos/400/300?random=13&keyword=scaffolding",
        "https://picsum.photos/400/300?random=14&keyword=accident",
        "https://picsum.photos/400/300?random=15&keyword=safety"
      ],
      "equipment_involved": [
        {
          "equipment_type": "Scaffolding System",
          "manufacturer": "ABC Scaffolding Co.",
          "model": "Professional Series 2000",
          "serial_number": "SC-2000-4521",
          "last_inspection": "2024-06-10",
          "condition": "Good"
        },
        {
          "equipment_type": "Safety Harness",
          "manufacturer": "Safety First Corp",
          "model": "Full Body Pro",
          "serial_number": "SF-FB-8847",
          "last_inspection": "2024-06-01",
          "condition": "Good"
        }
      ],
      "corrective_actions": [
        {
          "action": "Immediate retraining on fall protection for all workers",
          "assigned_to": "Training Manager",
          "due_date": "2024-06-20",
          "status": "in_progress",
          "priority": "high"
        },
        {
          "action": "Implement mandatory safety buddy system for height work",
          "assigned_to": "Site Manager",
          "due_date": "2024-06-18",
          "status": "pending",
          "priority": "high"
        },
        {
          "action": "Review and update scaffolding safety procedures",
          "assigned_to": "Safety Committee",
          "due_date": "2024-06-25",
          "status": "pending",
          "priority": "medium"
        }
      ],
      "regulatory_notifications": [
        {
          "agency": "OSHA",
          "notification_date": "2024-06-15",
          "method": "Online reporting system",
          "reference_number": "OSHA-2024-156789"
        },
        {
          "agency": "Workers Compensation",
          "notification_date": "2024-06-15",
          "method": "Phone and online",
          "reference_number": "WC-2024-45123"
        }
      ],
      "estimated_costs": {
        "medical_expenses": 12500.00,
        "lost_time_costs": 8750.00,
        "equipment_damage": 0.00,
        "investigation_costs": 2500.00,
        "total_estimated": 23750.00
      },
      "lessons_learned": "Reinforce the critical importance of 100% tie-off requirements and the need for continuous supervision of safety protocols.",
      "preventive_measures": [
        "Enhanced safety supervision",
        "Mandatory pre-task safety briefings",
        "Increased frequency of safety audits"
      ],
      "follow_up_required": true,
      "next_review_date": "2024-06-29"
    },
    {
      "id": "INC-2024-002",
      "incident_number": "INC-2024-002",
      "title": "Chemical Spill - Storage Area B",
      "type": "environmental",
      "severity": "minor",
      "status": "closed",
      "report_date": "2024-06-12",
      "incident_date": "2024-06-12",
      "incident_time": "09:15",
      "reporter_name": "Environmental Coordinator",
      "reporter_id": "EMP-014",
      "reporter_photo": "https://picsum.photos/100/100?random=14&keyword=person",
      "injured_person": null,
      "injured_id": null,
      "injured_photo": null,
      "project_name": "Healthcare Facility Expansion",
      "project_id": "PRJ-002",
      "location": "Storage Area B - Ground Level",
      "coordinates": "40.7505, -73.9934",
      "weather_conditions": "Overcast, 18°C, Calm",
      "description": "Approximately 2 gallons of paint thinner spilled from damaged container during routine material transfer. Spill was contained within secondary containment area. No personnel exposure occurred.",
      "immediate_actions_taken": [
        "Area evacuated and secured",
        "Spill response team activated",
        "Absorbent material applied",
        "Ventilation increased in area",
        "Spill reported to environmental manager"
      ],
      "injury_details": null,
      "incident_investigation": {
        "lead_investigator": "Environmental Manager",
        "investigation_team": ["Environmental Manager", "Material Handler"],
        "start_date": "2024-06-12",
        "expected_completion": "2024-06-14",
        "preliminary_findings": "Container damaged during transport, secondary containment system worked as designed",
        "root_causes": [
          "Inadequate inspection of containers before transport",
          "Rough handling during material movement"
        ]
      },
      "witnesses": [
        {
          "name": "Maria Garcia",
          "id": "EMP-004",
          "statement_taken": true,
          "statement_date": "2024-06-12"
        }
      ],
      "photos": [
        "https://picsum.photos/400/300?random=16&keyword=spill",
        "https://picsum.photos/400/300?random=17&keyword=cleanup"
      ],
      "equipment_involved": [
        {
          "equipment_type": "Storage Container",
          "manufacturer": "Industrial Storage Inc.",
          "model": "Heavy Duty 5-Gallon",
          "serial_number": "IS-5G-9876",
          "last_inspection": "2024-05-15",
          "condition": "Damaged"
        }
      ],
      "corrective_actions": [
        {
          "action": "Improve container inspection procedures",
          "assigned_to": "Material Handler",
          "due_date": "2024-06-15",
          "status": "completed",
          "priority": "medium"
        },
        {
          "action": "Provide additional training on material handling",
          "assigned_to": "Training Coordinator",
          "due_date": "2024-06-18",
          "status": "completed",
          "priority": "medium"
        }
      ],
      "regulatory_notifications": [
        {
          "agency": "EPA Regional Office",
          "notification_date": "2024-06-12",
          "method": "Phone notification",
          "reference_number": "EPA-REG-2024-334"
        }
      ],
      "estimated_costs": {
        "medical_expenses": 0.00,
        "lost_time_costs": 0.00,
        "equipment_damage": 150.00,
        "investigation_costs": 500.00,
        "cleanup_costs": 800.00,
        "total_estimated": 1450.00
      },
      "lessons_learned": "Secondary containment systems are effective when properly maintained. Container inspection procedures need improvement.",
      "preventive_measures": [
        "Enhanced container inspection checklist",
        "Improved material handling training",
        "Regular secondary containment system checks"
      ],
      "follow_up_required": false,
      "next_review_date": null
    },
    {
      "id": "INC-2024-003",
      "incident_number": "INC-2024-003",
      "title": "Near Miss - Crane Load Swing",
      "type": "near_miss",
      "severity": "no_injury",
      "status": "pending_review",
      "report_date": "2024-06-16",
      "incident_date": "2024-06-16",
      "incident_time": "11:45",
      "reporter_name": "Crane Operator",
      "reporter_id": "EMP-010",
      "reporter_photo": "https://picsum.photos/100/100?random=10&keyword=person",
      "injured_person": null,
      "injured_id": null,
      "injured_photo": null,
      "project_name": "Industrial Facility Upgrade",
      "project_id": "PRJ-005",
      "location": "Crane Zone - North Side",
      "coordinates": "40.7128, -74.0060",
      "weather_conditions": "Windy, 15°C, 30 mph gusts",
      "description": "During material lift operation, unexpected wind gust caused load to swing toward ground worker position. Worker was able to move to safety. No contact made but missed by approximately 3 feet.",
      "immediate_actions_taken": [
        "Crane operations immediately halted",
        "Area cleared of all personnel",
        "Wind conditions reassessed",
        "Safety meeting conducted with crew",
        "Load securing procedures reviewed"
      ],
      "injury_details": null,
      "incident_investigation": {
        "lead_investigator": "Crane Safety Supervisor",
        "investigation_team": ["Crane Safety Supervisor", "Operations Manager"],
        "start_date": "2024-06-16",
        "expected_completion": "2024-06-20",
        "preliminary_findings": "Wind conditions exceeded safe operating limits, communication protocols need improvement",
        "root_causes": [
          "Continued operations in excessive wind conditions",
          "Inadequate communication between operator and ground crew",
          "Insufficient load securing for wind conditions"
        ]
      },
      "witnesses": [
        {
          "name": "Ground Worker",
          "id": "EMP-015",
          "statement_taken": true,
          "statement_date": "2024-06-16"
        },
        {
          "name": "Signal Person",
          "id": "EMP-016",
          "statement_taken": true,
          "statement_date": "2024-06-16"
        }
      ],
      "photos": [
        "https://picsum.photos/400/300?random=18&keyword=crane",
        "https://picsum.photos/400/300?random=19&keyword=wind"
      ],
      "equipment_involved": [
        {
          "equipment_type": "Tower Crane",
          "manufacturer": "Heavy Lift Systems",
          "model": "TL-200",
          "serial_number": "HLS-TL200-1155",
          "last_inspection": "2024-06-10",
          "condition": "Good"
        }
      ],
      "corrective_actions": [
        {
          "action": "Review and update wind speed operating limits",
          "assigned_to": "Operations Manager",
          "due_date": "2024-06-20",
          "status": "in_progress",
          "priority": "high"
        },
        {
          "action": "Implement real-time wind monitoring system",
          "assigned_to": "Safety Manager",
          "due_date": "2024-06-25",
          "status": "pending",
          "priority": "high"
        },
        {
          "action": "Enhanced communication training for crane operations",
          "assigned_to": "Training Manager",
          "due_date": "2024-06-22",
          "status": "pending",
          "priority": "medium"
        }
      ],
      "regulatory_notifications": [],
      "estimated_costs": {
        "medical_expenses": 0.00,
        "lost_time_costs": 1250.00,
        "equipment_damage": 0.00,
        "investigation_costs": 800.00,
        "total_estimated": 2050.00
      },
      "lessons_learned": "Weather monitoring and communication protocols are critical for crane safety. Near misses provide valuable learning opportunities.",
      "preventive_measures": [
        "Real-time weather monitoring",
        "Enhanced communication protocols",
        "Regular safety briefings before crane operations"
      ],
      "follow_up_required": true,
      "next_review_date": "2024-06-25"
    },
    {
      "id": "INC-2024-004",
      "incident_number": "INC-2024-004",
      "title": "Vehicle Collision - Parking Area",
      "type": "property_damage",
      "severity": "minor",
      "status": "open",
      "report_date": "2024-06-14",
      "incident_date": "2024-06-14",
      "incident_time": "16:20",
      "reporter_name": "Security Guard",
      "reporter_id": "EMP-017",
      "reporter_photo": "https://picsum.photos/100/100?random=17&keyword=person",
      "injured_person": null,
      "injured_id": null,
      "injured_photo": null,
      "project_name": "Riverside Office Park",
      "project_id": "PRJ-004",
      "location": "Employee Parking Area - Section C",
      "coordinates": "40.7061, -74.0087",
      "weather_conditions": "Rainy, 16°C, Poor visibility",
      "description": "Company delivery truck backed into parked personal vehicle while maneuvering in parking area. Minor damage to both vehicles. No injuries reported.",
      "immediate_actions_taken": [
        "Both vehicles moved to safe location",
        "Site security notified",
        "Photos taken of damage",
        "Driver information exchanged",
        "Insurance companies notified"
      ],
      "injury_details": null,
      "incident_investigation": {
        "lead_investigator": "Fleet Manager",
        "investigation_team": ["Fleet Manager", "Security Supervisor"],
        "start_date": "2024-06-14",
        "expected_completion": "2024-06-19",
        "preliminary_findings": "Poor visibility due to weather, inadequate spotting assistance",
        "root_causes": [
          "Driver attempted backing without spotter in poor visibility",
          "Inadequate parking area lighting",
          "Rushed delivery schedule"
        ]
      },
      "witnesses": [
        {
          "name": "Parking Lot Attendant",
          "id": "EMP-018",
          "statement_taken": true,
          "statement_date": "2024-06-14"
        }
      ],
      "photos": [
        "https://picsum.photos/400/300?random=20&keyword=collision",
        "https://picsum.photos/400/300?random=21&keyword=damage"
      ],
      "equipment_involved": [
        {
          "equipment_type": "Delivery Truck",
          "manufacturer": "Ford",
          "model": "Transit 350",
          "serial_number": "FT350-2023-4567",
          "last_inspection": "2024-05-20",
          "condition": "Minor damage to rear bumper"
        }
      ],
      "corrective_actions": [
        {
          "action": "Improve parking area lighting",
          "assigned_to": "Facilities Manager",
          "due_date": "2024-06-30",
          "status": "pending",
          "priority": "medium"
        },
        {
          "action": "Mandatory spotter for backing operations",
          "assigned_to": "Fleet Manager",
          "due_date": "2024-06-17",
          "status": "in_progress",
          "priority": "high"
        },
        {
          "action": "Driver refresher training on backing procedures",
          "assigned_to": "Training Coordinator",
          "due_date": "2024-06-21",
          "status": "pending",
          "priority": "medium"
        }
      ],
      "regulatory_notifications": [],
      "estimated_costs": {
        "medical_expenses": 0.00,
        "lost_time_costs": 0.00,
        "equipment_damage": 2500.00,
        "investigation_costs": 300.00,
        "total_estimated": 2800.00
      },
      "lessons_learned": "Weather conditions significantly impact vehicle operation safety. Spotting assistance is crucial for backing operations.",
      "preventive_measures": [
        "Enhanced lighting in parking areas",
        "Mandatory spotter requirements",
        "Weather-specific operating procedures"
      ],
      "follow_up_required": true,
      "next_review_date": "2024-06-21"
    },
    {
      "id": "INC-2024-005",
      "incident_number": "INC-2024-005",
      "title": "Equipment Malfunction - Concrete Pump",
      "type": "equipment_failure",
      "severity": "minor",
      "status": "closed",
      "report_date": "2024-06-11",
      "incident_date": "2024-06-11",
      "incident_time": "13:10",
      "reporter_name": "Equipment Operator",
      "reporter_id": "EMP-019",
      "reporter_photo": "https://picsum.photos/100/100?random=19&keyword=person",
      "injured_person": null,
      "injured_id": null,
      "injured_photo": null,
      "project_name": "School Renovation Project",
      "project_id": "PRJ-006",
      "location": "Foundation Area - Building C",
      "coordinates": "40.7831, -73.9712",
      "weather_conditions": "Sunny, 24°C, Calm",
      "description": "Hydraulic line failure on concrete pump caused sudden loss of pressure and emergency shutdown. Small amount of hydraulic fluid leaked onto ground. No injuries occurred.",
      "immediate_actions_taken": [
        "Emergency shutdown activated",
        "Work area evacuated",
        "Hydraulic fluid spill contained",
        "Equipment manufacturer contacted",
        "Alternative pumping arrangements made"
      ],
      "injury_details": null,
      "incident_investigation": {
        "lead_investigator": "Equipment Manager",
        "investigation_team": ["Equipment Manager", "Maintenance Supervisor"],
        "start_date": "2024-06-11",
        "expected_completion": "2024-06-13",
        "preliminary_findings": "Hydraulic line exceeded service life, inadequate preventive maintenance",
        "root_causes": [
          "Hydraulic line beyond recommended replacement interval",
          "Missed scheduled maintenance inspection",
          "Inadequate pressure monitoring"
        ]
      },
      "witnesses": [
        {
          "name": "Concrete Crew Foreman",
          "id": "EMP-020",
          "statement_taken": true,
          "statement_date": "2024-06-11"
        }
      ],
      "photos": [
        "https://picsum.photos/400/300?random=22&keyword=equipment",
        "https://picsum.photos/400/300?random=23&keyword=hydraulic"
      ],
      "equipment_involved": [
        {
          "equipment_type": "Concrete Pump",
          "manufacturer": "Concrete Pro Systems",
          "model": "CP-45M",
          "serial_number": "CPS-CP45-7789",
          "last_inspection": "2024-04-15",
          "condition": "Hydraulic system failure"
        }
      ],
      "corrective_actions": [
        {
          "action": "Replace all hydraulic lines",
          "assigned_to": "Maintenance Team",
          "due_date": "2024-06-12",
          "status": "completed",
          "priority": "high"
        },
        {
          "action": "Update preventive maintenance schedule",
          "assigned_to": "Equipment Manager",
          "due_date": "2024-06-15",
          "status": "completed",
          "priority": "medium"
        },
        {
          "action": "Implement pressure monitoring system",
          "assigned_to": "Equipment Manager",
          "due_date": "2024-06-20",
          "status": "completed",
          "priority": "medium"
        }
      ],
      "regulatory_notifications": [],
      "estimated_costs": {
        "medical_expenses": 0.00,
        "lost_time_costs": 3200.00,
        "equipment_damage": 4500.00,
        "investigation_costs": 400.00,
        "total_estimated": 8100.00
      },
      "lessons_learned": "Preventive maintenance schedules must be strictly followed. Equipment age and service intervals are critical safety factors.",
      "preventive_measures": [
        "Enhanced preventive maintenance tracking",
        "Regular pressure monitoring",
        "Proactive component replacement"
      ],
      "follow_up_required": false,
      "next_review_date": null
    },
    {
      "id": "INC-2024-006",
      "incident_number": "INC-2024-006",
      "title": "Security Breach - Unauthorized Access",
      "type": "security",
      "severity": "minor",
      "status": "escalated",
      "report_date": "2024-06-13",
      "incident_date": "2024-06-13",
      "incident_time": "22:30",
      "reporter_name": "Night Security Guard",
      "reporter_id": "EMP-021",
      "reporter_photo": "https://picsum.photos/100/100?random=21&keyword=person",
      "injured_person": null,
      "injured_id": null,
      "injured_photo": null,
      "project_name": "Metro Downtown Complex",
      "project_id": "PRJ-001",
      "location": "East Gate - Perimeter Fence",
      "coordinates": "40.7589, -73.9851",
      "weather_conditions": "Clear, 19°C, Calm",
      "description": "Unauthorized individual found on construction site after hours. Person was escorted off property. No theft or vandalism detected. Security protocols require review.",
      "immediate_actions_taken": [
        "Individual confronted and questioned",
        "Site security sweep conducted",
        "Local police notified",
        "Entry point secured",
        "Additional patrols scheduled"
      ],
      "injury_details": null,
      "incident_investigation": {
        "lead_investigator": "Security Manager",
        "investigation_team": ["Security Manager", "Site Manager"],
        "start_date": "2024-06-13",
        "expected_completion": "2024-06-18",
        "preliminary_findings": "Gap in perimeter fencing allowed unauthorized access",
        "root_causes": [
          "Damaged section of perimeter fencing",
          "Inadequate lighting in perimeter area",
          "Insufficient security patrol frequency"
        ]
      },
      "witnesses": [
        {
          "name": "Second Security Guard",
          "id": "EMP-022",
          "statement_taken": true,
          "statement_date": "2024-06-13"
        }
      ],
      "photos": [
        "https://picsum.photos/400/300?random=24&keyword=fence",
        "https://picsum.photos/400/300?random=25&keyword=security"
      ],
      "equipment_involved": [
        {
          "equipment_type": "Security Camera System",
          "manufacturer": "SecureView Pro",
          "model": "SV-HD-200",
          "serial_number": "SVP-HD200-3344",
          "last_inspection": "2024-06-01",
          "condition": "Partially obstructed view"
        }
      ],
      "corrective_actions": [
        {
          "action": "Repair perimeter fencing",
          "assigned_to": "Facilities Team",
          "due_date": "2024-06-15",
          "status": "completed",
          "priority": "high"
        },
        {
          "action": "Improve perimeter lighting",
          "assigned_to": "Electrical Team",
          "due_date": "2024-06-20",
          "status": "in_progress",
          "priority": "high"
        },
        {
          "action": "Increase security patrol frequency",
          "assigned_to": "Security Manager",
          "due_date": "2024-06-14",
          "status": "completed",
          "priority": "medium"
        }
      ],
      "regulatory_notifications": [
        {
          "agency": "Local Police Department",
          "notification_date": "2024-06-13",
          "method": "Phone report",
          "reference_number": "PD-2024-567"
        }
      ],
      "estimated_costs": {
        "medical_expenses": 0.00,
        "lost_time_costs": 0.00,
        "equipment_damage": 0.00,
        "investigation_costs": 500.00,
        "security_improvements": 2200.00,
        "total_estimated": 2700.00
      },
      "lessons_learned": "Perimeter security requires regular inspection and maintenance. Adequate lighting is essential for security effectiveness.",
      "preventive_measures": [
        "Regular perimeter inspections",
        "Enhanced lighting systems",
        "Improved security patrol protocols"
      ],
      "follow_up_required": true,
      "next_review_date": "2024-06-20"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Incident Reporting"),
        actions: [
          QButton(
            icon: Icons.add_alert,
            size: bs.sm,
            onPressed: () => _reportNewIncident(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _viewIncidentAnalytics(),
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
                  _buildIncidentOverview(),
                  _buildFilters(),
                  _buildCriticalIncidents(),
                  _buildIncidentsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildIncidentOverview() {
    int totalIncidents = incidentReports.length;
    int openIncidents = incidentReports.where((i) => i["status"] == "open" || i["status"] == "investigating").length;
    int seriousIncidents = incidentReports.where((i) => i["severity"] == "serious" || i["severity"] == "fatal").length;
    int thisMonthIncidents = incidentReports.where((i) => _isThisMonth(i["incident_date"])).length;
    double totalCosts = incidentReports.fold(0.0, (sum, i) => sum + (i["estimated_costs"]["total_estimated"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: warningColor.withAlpha(50)),
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
                  color: warningColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.report_problem, color: warningColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Incident Reporting Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildOverviewCard("Total Reports", "$totalIncidents", Icons.description, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Open/Active", "$openIncidents", Icons.warning, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Serious", "$seriousIncidents", Icons.emergency, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("This Month", "$thisMonthIncidents", Icons.calendar_today, infoColor),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: dangerColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.attach_money, color: dangerColor, size: 18),
                SizedBox(width: spXs),
                Text(
                  "Total Incident Costs: \$${totalCosts.currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
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
                  label: "Search incidents...",
                  value: searchQuery,
                  hint: "Search by incident number, title, or location",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.timeline,
                size: bs.sm,
                onPressed: () => _showIncidentTimeline(),
              ),
            ],
          ),
          Row(
            children: [
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
                  label: "Status",
                  items: statusFilters,
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
    );
  }

  Widget _buildCriticalIncidents() {
    List<Map<String, dynamic>> criticalIncidents = incidentReports
        .where((incident) => incident["severity"] == "serious" || incident["severity"] == "fatal" || incident["status"] == "escalated")
        .toList();

    if (criticalIncidents.isEmpty) return SizedBox.shrink();

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
                child: Icon(Icons.error, color: dangerColor, size: 20),
              ),
              SizedBox(width: spMd),
              Text(
                "Critical Incidents (${criticalIncidents.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Escalate",
                size: bs.sm,
                onPressed: () => _escalateIncidents(),
              ),
            ],
          ),
          ...criticalIncidents.take(2).map((incident) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border(
                left: BorderSide(
                  color: _getSeverityColor(incident["severity"]),
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
                      image: NetworkImage("${incident["reporter_photo"]}"),
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
                        "${incident["incident_number"]}: ${incident["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${incident["project_name"]} | ${incident["incident_date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.emergency, color: _getSeverityColor(incident["severity"]), size: 12),
                          SizedBox(width: spXs),
                          Text(
                            "${incident["severity"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              color: _getSeverityColor(incident["severity"]),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(Icons.work, color: _getStatusColor(incident["status"]), size: 12),
                          SizedBox(width: spXs),
                          Text(
                            "${incident["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              color: _getStatusColor(incident["status"]),
                              fontWeight: FontWeight.bold,
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
                  onPressed: () => _viewIncidentDetails(incident["id"]),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildIncidentsList() {
    List<Map<String, dynamic>> filteredIncidents = _getFilteredIncidents();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Incident Reports (${filteredIncidents.length})",
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
              onPressed: () => _exportIncidentReport(),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredIncidents.map((incident) => _buildIncidentCard(incident)),
      ],
    );
  }

  Widget _buildIncidentCard(Map<String, dynamic> incident) {
    Color severityColor = _getSeverityColor(incident["severity"]);
    Color statusColor = _getStatusColor(incident["status"]);
    Color typeColor = _getTypeColor(incident["type"]);

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
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${incident["reporter_photo"]}"),
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
                      "${incident["incident_number"]}: ${incident["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Reported by ${incident["reporter_name"]} | ${incident["incident_date"]} ${incident["incident_time"]}",
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
                            color: severityColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${incident["severity"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: severityColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: typeColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${incident["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: typeColor,
                              fontWeight: FontWeight.w600,
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
                            "${incident["status"]}".toUpperCase(),
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
                        "${incident["project_name"]} - ${incident["location"]}",
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
                  "${incident["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
                if (incident["injured_person"] != null)
                  Row(
                    children: [
                      Icon(Icons.person, color: dangerColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Injured: ${incident["injured_person"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Icon(Icons.cloud, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Weather: ${incident["weather_conditions"]}",
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
          if ((incident["photos"] as List).isNotEmpty)
            Container(
              height: 100,
              child: QHorizontalScroll(
                children: (incident["photos"] as List).map((photo) => Container(
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
          if (incident["incident_investigation"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.search, color: infoColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Investigation: ${incident["incident_investigation"]["lead_investigator"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Expected completion: ${incident["incident_investigation"]["expected_completion"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: infoColor,
                    ),
                  ),
                  if (incident["incident_investigation"]["preliminary_findings"] != null)
                    Text(
                      "Findings: ${incident["incident_investigation"]["preliminary_findings"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                      ),
                    ),
                ],
              ),
            ),
          if ((incident["corrective_actions"] as List).isNotEmpty)
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
                        "Corrective Actions (${(incident["corrective_actions"] as List).length})",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  ...(incident["corrective_actions"] as List).take(2).map((action) => Padding(
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
                    Icon(Icons.attach_money, color: dangerColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Total Cost: \$${(incident["estimated_costs"]["total_estimated"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    if (incident["follow_up_required"] == true)
                      Row(
                        children: [
                          Icon(Icons.schedule, color: warningColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "Follow-up: ${incident["next_review_date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                if ((incident["witnesses"] as List).isNotEmpty)
                  Row(
                    children: [
                      Icon(Icons.group, color: infoColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Witnesses: ${(incident["witnesses"] as List).length}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                      Spacer(),
                      if ((incident["regulatory_notifications"] as List).isNotEmpty)
                        Row(
                          children: [
                            Icon(Icons.notification_important, color: primaryColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Regulatory notifications: ${(incident["regulatory_notifications"] as List).length}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
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
                  "${incident["lessons_learned"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              QButton(
                icon: Icons.camera_alt,
                size: bs.sm,
                onPressed: () => _viewIncidentPhotos(incident["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editIncident(incident["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showIncidentOptions(incident),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredIncidents() {
    List<Map<String, dynamic>> filtered = incidentReports;

    if (selectedType != "all") {
      filtered = filtered.where((incident) => incident["type"] == selectedType).toList();
    }

    if (selectedSeverity != "all") {
      filtered = filtered.where((incident) => incident["severity"] == selectedSeverity).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((incident) => incident["status"] == selectedStatus).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((incident) =>
          incident["incident_number"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          incident["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          incident["location"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  bool _isThisMonth(String date) {
    try {
      DateTime incidentDate = DateTime.parse(date);
      DateTime now = DateTime.now();
      return incidentDate.year == now.year && incidentDate.month == now.month;
    } catch (e) {
      return false;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'fatal':
        return dangerColor;
      case 'serious':
        return dangerColor;
      case 'minor':
        return warningColor;
      case 'first_aid':
        return infoColor;
      case 'no_injury':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'closed':
        return successColor;
      case 'investigating':
        return warningColor;
      case 'pending_review':
        return infoColor;
      case 'open':
        return dangerColor;
      case 'escalated':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'injury':
        return dangerColor;
      case 'near_miss':
        return warningColor;
      case 'property_damage':
        return infoColor;
      case 'environmental':
        return successColor;
      case 'security':
        return primaryColor;
      case 'equipment_failure':
        return warningColor;
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

  void _reportNewIncident() {
    ss("Report new incident");
  }

  void _viewIncidentAnalytics() {
    ss("View incident analytics");
  }

  void _showIncidentTimeline() {
    ss("Show incident timeline");
  }

  void _escalateIncidents() {
    ss("Escalate critical incidents");
  }

  void _viewIncidentDetails(String incidentId) {
    ss("View incident details $incidentId");
  }

  void _exportIncidentReport() {
    ss("Export incident report");
  }

  void _showSortOptions() {
    ss("Incident sort options");
  }

  void _viewIncidentPhotos(String incidentId) {
    ss("View incident photos $incidentId");
  }

  void _editIncident(String incidentId) {
    ss("Edit incident $incidentId");
  }

  void _showIncidentOptions(Map<String, dynamic> incident) {
    ss("Incident options for ${incident["incident_number"]}");
  }
}
