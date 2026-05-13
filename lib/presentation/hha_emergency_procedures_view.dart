import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaEmergencyProceduresView extends StatefulWidget {
  const HhaEmergencyProceduresView({super.key});

  @override
  State<HhaEmergencyProceduresView> createState() => _HhaEmergencyProceduresViewState();
}

class _HhaEmergencyProceduresViewState extends State<HhaEmergencyProceduresView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedPriority = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Fire Emergency", "value": "Fire Emergency"},
    {"label": "Medical Emergency", "value": "Medical Emergency"},
    {"label": "Security Threat", "value": "Security Threat"},
    {"label": "Natural Disaster", "value": "Natural Disaster"},
    {"label": "Evacuation", "value": "Evacuation"},
    {"label": "Power Outage", "value": "Power Outage"},
    {"label": "Chemical Spill", "value": "Chemical Spill"},
    {"label": "Bomb Threat", "value": "Bomb Threat"},
    {"label": "Lockdown", "value": "Lockdown"},
    {"label": "IT Emergency", "value": "IT Emergency"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Under Review", "value": "Under Review"},
    {"label": "Needs Update", "value": "Needs Update"},
    {"label": "Draft", "value": "Draft"},
  ];

  List<Map<String, dynamic>> procedures = [
    {
      "id": "EP-001",
      "title": "Fire Emergency Response",
      "category": "Fire Emergency",
      "priority": "Critical",
      "status": "Active",
      "description": "Comprehensive fire emergency response procedures including evacuation routes, assembly points, and communication protocols.",
      "lastUpdated": "2024-01-10",
      "version": "3.2",
      "author": "Fire Safety Officer",
      "estimatedTime": "5-15 minutes",
      "affectedAreas": ["All Hospital Areas"],
      "keyPersonnel": ["Fire Safety Officer", "Security Chief", "Medical Director"],
      "steps": [
        "Immediately sound fire alarm and call 911",
        "Evacuate patients and staff using designated routes",
        "Close all fire doors to contain spread",
        "Move to designated assembly points",
        "Conduct headcount and report to incident commander",
      ],
      "equipmentRequired": ["Fire extinguishers", "Emergency stretchers", "Communication radios"],
      "trainingRequired": true,
      "reviewDate": "2024-06-10",
      "attachments": ["fire_evacuation_map.pdf", "assembly_points.pdf"],
    },
    {
      "id": "EP-002",
      "title": "Code Blue - Cardiac Arrest Response",
      "category": "Medical Emergency",
      "priority": "Critical",
      "status": "Active",
      "description": "Rapid response protocol for cardiac arrest emergencies including CPR, defibrillation, and medication administration.",
      "lastUpdated": "2024-01-08",
      "version": "2.1",
      "author": "Chief Medical Officer",
      "estimatedTime": "Immediate - 30 minutes",
      "affectedAreas": ["All Patient Areas", "Emergency Department"],
      "keyPersonnel": ["Attending Physician", "Nurses", "Respiratory Therapist"],
      "steps": [
        "Call Code Blue and announce location",
        "Begin CPR immediately if no pulse",
        "Attach defibrillator and analyze rhythm",
        "Administer medications per ACLS protocol",
        "Continue resuscitation efforts until ROSC or termination",
      ],
      "equipmentRequired": ["Crash cart", "Defibrillator", "Oxygen equipment", "Medications"],
      "trainingRequired": true,
      "reviewDate": "2024-07-08",
      "attachments": ["acls_flowchart.pdf", "medication_dosing.pdf"],
    },
    {
      "id": "EP-003",
      "title": "Active Shooter/Security Threat",
      "category": "Security Threat",
      "priority": "Critical",
      "status": "Active",
      "description": "Security threat response including lockdown procedures, law enforcement coordination, and staff safety protocols.",
      "lastUpdated": "2024-01-05",
      "version": "1.8",
      "author": "Security Director",
      "estimatedTime": "Variable",
      "affectedAreas": ["Entire Hospital Complex"],
      "keyPersonnel": ["Security Team", "Administration", "Law Enforcement"],
      "steps": [
        "Activate lockdown alarm and notify all areas",
        "Secure all entrances and restrict access",
        "Direct staff and patients to safe locations",
        "Coordinate with law enforcement response",
        "Maintain communication with all departments",
      ],
      "equipmentRequired": ["Communication systems", "Security cameras", "Emergency lighting", "First aid supplies"],
      "trainingRequired": true,
      "reviewDate": "2024-04-05",
      "attachments": ["lockdown_zones.pdf", "communication_tree.pdf"],
    },
    {
      "id": "EP-004",
      "title": "Hospital Evacuation - Natural Disaster",
      "category": "Natural Disaster",
      "priority": "High",
      "status": "Active",
      "description": "Large-scale evacuation procedures for natural disasters including patient transport, equipment protection, and coordination with external agencies.",
      "lastUpdated": "2023-12-15",
      "version": "2.0",
      "author": "Emergency Management Director",
      "estimatedTime": "2-6 hours",
      "affectedAreas": ["All Hospital Areas"],
      "keyPersonnel": ["Hospital Command Center", "Nursing Supervisors", "Transport Team"],
      "steps": [
        "Activate hospital incident command system",
        "Assess extent of evacuation needed",
        "Begin patient triage and transport priority",
        "Coordinate with external emergency services",
        "Secure essential equipment and records",
      ],
      "equipmentRequired": ["Transport vehicles", "Portable oxygen", "Emergency communications", "Patient records"],
      "trainingRequired": true,
      "reviewDate": "2024-03-15",
      "attachments": ["evacuation_routes.pdf", "transport_priority.pdf"],
    },
    {
      "id": "EP-005",
      "title": "Power Outage Emergency Response",
      "category": "Power Outage",
      "priority": "High",
      "status": "Active",
      "description": "Power outage response including backup generator activation, critical system prioritization, and patient safety measures.",
      "lastUpdated": "2024-01-12",
      "version": "1.5",
      "author": "Facilities Manager",
      "estimatedTime": "15 minutes - 24 hours",
      "affectedAreas": ["All Hospital Areas"],
      "keyPersonnel": ["Engineering Staff", "IT Department", "Clinical Supervisors"],
      "steps": [
        "Verify generator activation and essential systems",
        "Prioritize power to critical care areas",
        "Check all battery-powered backup systems",
        "Implement manual procedures for affected systems",
        "Coordinate with utility company for restoration",
      ],
      "equipmentRequired": ["Emergency generators", "Flashlights", "Battery backups", "Manual logs"],
      "trainingRequired": true,
      "reviewDate": "2024-05-12",
      "attachments": ["power_priority_list.pdf", "generator_procedures.pdf"],
    },
    {
      "id": "EP-006",
      "title": "Chemical Spill Containment",
      "category": "Chemical Spill",
      "priority": "High",
      "status": "Under Review",
      "description": "Chemical spill response including containment, evacuation of affected areas, and hazmat team coordination.",
      "lastUpdated": "2023-11-20",
      "version": "1.3",
      "author": "Safety Officer",
      "estimatedTime": "30 minutes - 4 hours",
      "affectedAreas": ["Laboratory", "Pharmacy", "Maintenance Areas"],
      "keyPersonnel": ["Safety Officer", "Hazmat Team", "Facilities Staff"],
      "steps": [
        "Secure the area and evacuate personnel",
        "Identify the chemical and assess hazards",
        "Contain spill using appropriate materials",
        "Notify external hazmat response if needed",
        "Decontaminate affected areas and personnel",
      ],
      "equipmentRequired": ["Spill kits", "PPE", "Ventilation equipment", "Decontamination supplies"],
      "trainingRequired": true,
      "reviewDate": "2024-02-20",
      "attachments": ["chemical_inventory.pdf", "spill_kit_locations.pdf"],
    },
    {
      "id": "EP-007",
      "title": "Bomb Threat Response",
      "category": "Bomb Threat",
      "priority": "Critical",
      "status": "Active",
      "description": "Bomb threat response procedures including threat assessment, search protocols, and evacuation decisions.",
      "lastUpdated": "2023-10-30",
      "version": "1.6",
      "author": "Security Director",
      "estimatedTime": "1-4 hours",
      "affectedAreas": ["Entire Hospital Complex"],
      "keyPersonnel": ["Security Team", "Administration", "Law Enforcement", "Bomb Squad"],
      "steps": [
        "Document threat details and notify authorities",
        "Assess credibility and immediate danger",
        "Coordinate with law enforcement and bomb squad",
        "Implement search procedures if appropriate",
        "Evacuate areas as directed by authorities",
      ],
      "equipmentRequired": ["Communication systems", "Search equipment", "Evacuation supplies"],
      "trainingRequired": true,
      "reviewDate": "2024-01-30",
      "attachments": ["threat_assessment_form.pdf", "search_procedures.pdf"],
    },
    {
      "id": "EP-008",
      "title": "IT System Emergency - Cyberattack",
      "category": "IT Emergency",
      "priority": "High",
      "status": "Needs Update",
      "description": "IT emergency response for cyberattacks including system isolation, data protection, and manual procedures activation.",
      "lastUpdated": "2023-09-15",
      "version": "1.2",
      "author": "IT Security Manager",
      "estimatedTime": "1-24 hours",
      "affectedAreas": ["All Departments"],
      "keyPersonnel": ["IT Team", "Cybersecurity Specialist", "Administration"],
      "steps": [
        "Identify and isolate affected systems",
        "Activate manual backup procedures",
        "Notify cybersecurity team and authorities",
        "Implement data protection measures",
        "Coordinate system recovery efforts",
      ],
      "equipmentRequired": ["Backup systems", "Manual forms", "Communication devices"],
      "trainingRequired": true,
      "reviewDate": "2024-03-15",
      "attachments": ["system_isolation_guide.pdf", "manual_procedures.pdf"],
    },
  ];

  List<Map<String, dynamic>> get filteredProcedures {
    return procedures.where((procedure) {
      final matchesSearch = procedure["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          procedure["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          procedure["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesCategory = selectedCategory == "All" || procedure["category"] == selectedCategory;
      final matchesPriority = selectedPriority == "All" || procedure["priority"] == selectedPriority;
      final matchesStatus = selectedStatus == "All" || procedure["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesPriority && matchesStatus;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Under Review":
        return warningColor;
      case "Needs Update":
        return dangerColor;
      case "Draft":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusAction(String status) {
    switch (status) {
      case "Active":
        return "Review Procedure";
      case "Under Review":
        return "Complete Review";
      case "Needs Update":
        return "Update Now";
      case "Draft":
        return "Finalize Draft";
      default:
        return "View Details";
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusCounts = {
      "Active": procedures.where((p) => p["status"] == "Active").length,
      "Under Review": procedures.where((p) => p["status"] == "Under Review").length,
      "Needs Update": procedures.where((p) => p["status"] == "Needs Update").length,
      "Draft": procedures.where((p) => p["status"] == "Draft").length,
    };

    final criticalProcedures = procedures.where((p) => p["priority"] == "Critical").length;
    final needsTraining = procedures.where((p) => p["trainingRequired"] == true).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Procedures"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              ss("New emergency procedure form opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.school),
            onPressed: () {
              ss("Training management opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search Procedures",
                  value: searchQuery,
                  hint: "Search by title, description, or category...",
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
                        label: "Category",
                        items: categoryOptions,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QDropdownField(
                        label: "Priority",
                        items: priorityOptions,
                        value: selectedPriority,
                        onChanged: (value, label) {
                          selectedPriority = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Status Overview Cards
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.emergency,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Critical Procedures",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$criticalProcedures",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Life-saving Protocols",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Active Procedures",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${statusCounts["Active"]}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Ready for Use",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.school,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Training Required",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$needsTraining",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Procedures Need Training",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Needs Update",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${statusCounts["Needs Update"]}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Require Immediate Update",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Emergency Drill",
                          icon: Icons.play_circle,
                          size: bs.sm,
                          onPressed: () {
                            ss("Emergency drill scheduler opened");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Training Schedule",
                          icon: Icons.calendar_today,
                          size: bs.sm,
                          onPressed: () {
                            ss("Training schedule opened");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Emergency Contacts
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Emergency Contacts",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    spacing: spMd,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Emergency Services",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              "911",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
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
                              "Hospital Security",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              "Ext. 2911",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
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
                              "Incident Commander",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              "Ext. 1001",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
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

            // Procedures List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Emergency Procedures (${filteredProcedures.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: spSm),
                ...filteredProcedures.map((procedure) {
                  final priorityColor = _getPriorityColor(procedure["priority"]);
                  final statusColor = _getStatusColor(procedure["status"]);
                  final statusAction = _getStatusAction(procedure["status"]);
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: priorityColor,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${procedure["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${procedure["id"]} • Version ${procedure["version"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: priorityColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${procedure["priority"]}",
                                    style: TextStyle(
                                      color: priorityColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${procedure["status"]}",
                                    style: TextStyle(
                                      color: statusColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${procedure["description"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 13,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spSm),
                        Row(
                          spacing: spLg,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Category",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${procedure["category"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Est. Time",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${procedure["estimatedTime"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last Updated",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${procedure["lastUpdated"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          spacing: spLg,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Author",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${procedure["author"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Key Personnel",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${(procedure["keyPersonnel"] as List).length} roles",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Review Date",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${procedure["reviewDate"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            if (procedure["trainingRequired"] == true)
                              Container(
                                margin: EdgeInsets.only(right: spXs),
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Training Required",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            Container(
                              margin: EdgeInsets.only(right: spXs),
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${(procedure["steps"] as List).length} steps",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if ((procedure["attachments"] as List).isNotEmpty)
                              Container(
                                margin: EdgeInsets.only(right: spXs),
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${(procedure["attachments"] as List).length} attachments",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: QButton(
                                label: statusAction,
                                size: bs.sm,
                                onPressed: () {
                                  ss("$statusAction for ${procedure["title"]}");
                                },
                              ),
                            ),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {
                                ss("Procedure options for ${procedure["title"]}");
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
          ],
        ),
      ),
    );
  }
}
