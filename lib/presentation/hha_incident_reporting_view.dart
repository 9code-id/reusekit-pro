import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaIncidentReportingView extends StatefulWidget {
  const HhaIncidentReportingView({super.key});

  @override
  State<HhaIncidentReportingView> createState() => _HhaIncidentReportingViewState();
}

class _HhaIncidentReportingViewState extends State<HhaIncidentReportingView> {
  String searchQuery = "";
  String selectedPriority = "All";
  String selectedStatus = "All";
  String selectedCategory = "All";
  String selectedReporter = "All";

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Open", "value": "Open"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Under Review", "value": "Under Review"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Closed", "value": "Closed"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Patient Safety", "value": "Patient Safety"},
    {"label": "Staff Safety", "value": "Staff Safety"},
    {"label": "Equipment Failure", "value": "Equipment Failure"},
    {"label": "Security Breach", "value": "Security Breach"},
    {"label": "Fire Safety", "value": "Fire Safety"},
    {"label": "Environmental", "value": "Environmental"},
    {"label": "Visitor Incident", "value": "Visitor Incident"},
    {"label": "Property Damage", "value": "Property Damage"},
    {"label": "Data Breach", "value": "Data Breach"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> reporterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Staff", "value": "Staff"},
    {"label": "Patient", "value": "Patient"},
    {"label": "Visitor", "value": "Visitor"},
    {"label": "Security", "value": "Security"},
    {"label": "Anonymous", "value": "Anonymous"},
  ];

  List<Map<String, dynamic>> incidents = [
    {
      "id": "INC-001",
      "title": "Patient Fall in Room 204",
      "category": "Patient Safety",
      "priority": "High",
      "status": "In Progress",
      "description": "Elderly patient fell while getting out of bed. No apparent injuries but requires medical assessment.",
      "location": "Room 204 - Ward A",
      "reportedBy": "Staff",
      "reporterName": "Nurse Sarah Johnson",
      "reportedDate": "2024-01-15",
      "reportedTime": "14:30",
      "assignedTo": "Dr. Michael Chen",
      "witnesses": 2,
      "injuries": true,
      "medicalAttention": true,
      "attachments": ["incident_photo.jpg", "witness_statement.pdf"],
      "followUpRequired": true,
      "estimatedResolution": "2024-01-16",
    },
    {
      "id": "INC-002",
      "title": "Equipment Malfunction - Ventilator",
      "category": "Equipment Failure",
      "priority": "Critical",
      "status": "Under Review",
      "description": "ICU ventilator stopped working unexpectedly during patient care. Backup unit immediately deployed.",
      "location": "ICU - Bed 3",
      "reportedBy": "Staff",
      "reporterName": "Dr. Lisa Rodriguez",
      "reportedDate": "2024-01-15",
      "reportedTime": "08:45",
      "assignedTo": "Biomedical Engineering",
      "witnesses": 3,
      "injuries": false,
      "medicalAttention": false,
      "attachments": ["equipment_log.pdf", "maintenance_history.pdf"],
      "followUpRequired": true,
      "estimatedResolution": "2024-01-16",
    },
    {
      "id": "INC-003",
      "title": "Unauthorized Access to Restricted Area",
      "category": "Security Breach",
      "priority": "High",
      "status": "Open",
      "description": "Unknown individual found in the pharmacy storage area without proper authorization.",
      "location": "Pharmacy - Storage Room",
      "reportedBy": "Security",
      "reporterName": "Security Officer Mike Brown",
      "reportedDate": "2024-01-15",
      "reportedTime": "22:15",
      "assignedTo": "Security Manager",
      "witnesses": 1,
      "injuries": false,
      "medicalAttention": false,
      "attachments": ["security_footage.mp4", "access_log.pdf"],
      "followUpRequired": true,
      "estimatedResolution": "2024-01-17",
    },
    {
      "id": "INC-004",
      "title": "Slip and Fall in Cafeteria",
      "category": "Visitor Incident",
      "priority": "Medium",
      "status": "Resolved",
      "description": "Visitor slipped on wet floor near the beverage station. Minor injury to wrist.",
      "location": "Main Cafeteria",
      "reportedBy": "Visitor",
      "reporterName": "John Smith (Visitor)",
      "reportedDate": "2024-01-14",
      "reportedTime": "12:30",
      "assignedTo": "Facilities Manager",
      "witnesses": 4,
      "injuries": true,
      "medicalAttention": true,
      "attachments": ["incident_report.pdf", "medical_assessment.pdf"],
      "followUpRequired": false,
      "estimatedResolution": "2024-01-14",
    },
    {
      "id": "INC-005",
      "title": "Fire Alarm Malfunction",
      "category": "Fire Safety",
      "priority": "High",
      "status": "Closed",
      "description": "False fire alarm activation in the east wing caused unnecessary evacuation procedures.",
      "location": "East Wing - 3rd Floor",
      "reportedBy": "Staff",
      "reporterName": "Maintenance Tech Robert Wilson",
      "reportedDate": "2024-01-13",
      "reportedTime": "16:20",
      "assignedTo": "Fire Safety Officer",
      "witnesses": 0,
      "injuries": false,
      "medicalAttention": false,
      "attachments": ["system_diagnostic.pdf", "repair_log.pdf"],
      "followUpRequired": false,
      "estimatedResolution": "2024-01-13",
    },
    {
      "id": "INC-006",
      "title": "Medication Error - Wrong Dosage",
      "category": "Patient Safety",
      "priority": "Critical",
      "status": "In Progress",
      "description": "Patient received incorrect medication dosage due to transcription error. Immediate corrective action taken.",
      "location": "Ward B - Room 118",
      "reportedBy": "Staff",
      "reporterName": "Pharmacist Dr. Jennifer Lee",
      "reportedDate": "2024-01-15",
      "reportedTime": "10:15",
      "assignedTo": "Chief Medical Officer",
      "witnesses": 2,
      "injuries": false,
      "medicalAttention": true,
      "attachments": ["medication_log.pdf", "error_analysis.pdf"],
      "followUpRequired": true,
      "estimatedResolution": "2024-01-16",
    },
    {
      "id": "INC-007",
      "title": "Staff Injury - Needle Stick",
      "category": "Staff Safety",
      "priority": "Medium",
      "status": "Under Review",
      "description": "Nurse sustained needle stick injury while disposing of used syringe. Following standard protocols.",
      "location": "Emergency Department",
      "reportedBy": "Staff",
      "reporterName": "Nurse Patricia Davis",
      "reportedDate": "2024-01-14",
      "reportedTime": "18:45",
      "assignedTo": "Occupational Health",
      "witnesses": 1,
      "injuries": true,
      "medicalAttention": true,
      "attachments": ["injury_report.pdf", "blood_test_order.pdf"],
      "followUpRequired": true,
      "estimatedResolution": "2024-01-18",
    },
    {
      "id": "INC-008",
      "title": "Computer System Outage",
      "category": "Data Breach",
      "priority": "High",
      "status": "Resolved",
      "description": "Hospital information system experienced unexpected outage for 2 hours affecting patient records access.",
      "location": "IT Server Room",
      "reportedBy": "Staff",
      "reporterName": "IT Manager Tom Anderson",
      "reportedDate": "2024-01-12",
      "reportedTime": "09:30",
      "assignedTo": "IT Department",
      "witnesses": 0,
      "injuries": false,
      "medicalAttention": false,
      "attachments": ["system_log.txt", "recovery_report.pdf"],
      "followUpRequired": false,
      "estimatedResolution": "2024-01-12",
    },
  ];

  List<Map<String, dynamic>> get filteredIncidents {
    return incidents.where((incident) {
      final matchesSearch = incident["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          incident["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          incident["location"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesPriority = selectedPriority == "All" || incident["priority"] == selectedPriority;
      final matchesStatus = selectedStatus == "All" || incident["status"] == selectedStatus;
      final matchesCategory = selectedCategory == "All" || incident["category"] == selectedCategory;
      final matchesReporter = selectedReporter == "All" || incident["reportedBy"] == selectedReporter;
      
      return matchesSearch && matchesPriority && matchesStatus && matchesCategory && matchesReporter;
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
      case "Open":
        return dangerColor;
      case "In Progress":
        return warningColor;
      case "Under Review":
        return infoColor;
      case "Resolved":
        return successColor;
      case "Closed":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusAction(String status) {
    switch (status) {
      case "Open":
        return "Assign & Start";
      case "In Progress":
        return "Update Progress";
      case "Under Review":
        return "Complete Review";
      case "Resolved":
        return "Close Incident";
      case "Closed":
        return "View Details";
      default:
        return "Take Action";
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusCounts = {
      "Open": incidents.where((i) => i["status"] == "Open").length,
      "In Progress": incidents.where((i) => i["status"] == "In Progress").length,
      "Under Review": incidents.where((i) => i["status"] == "Under Review").length,
      "Resolved": incidents.where((i) => i["status"] == "Resolved").length,
      "Closed": incidents.where((i) => i["status"] == "Closed").length,
    };

    final criticalIncidents = incidents.where((i) => i["priority"] == "Critical").length;
    final totalWithInjuries = incidents.where((i) => i["injuries"] == true).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Incident Reporting"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              ss("New incident report form opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: () {
              ss("Incident analytics opened");
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
                  label: "Search Incidents",
                  value: searchQuery,
                  hint: "Search by title, description, or location...",
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
                        label: "Priority",
                        items: priorityOptions,
                        value: selectedPriority,
                        onChanged: (value, label) {
                          selectedPriority = value;
                          setState(() {});
                        },
                      ),
                    ),
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
                  ],
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
                        label: "Reporter",
                        items: reporterOptions,
                        value: selectedReporter,
                        onChanged: (value, label) {
                          selectedReporter = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
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
                            Icons.warning,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Critical Incidents",
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
                        "$criticalIncidents",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Require Immediate Action",
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
                            Icons.assignment,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Open Reports",
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
                        "${statusCounts["Open"]}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Awaiting Assignment",
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
                            Icons.medical_services,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "With Injuries",
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
                        "$totalWithInjuries",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Medical Attention Required",
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
                            "Resolved",
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
                        "${statusCounts["Resolved"]}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Successfully Handled",
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
                          label: "New Report",
                          icon: Icons.add_circle,
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening new incident report form");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Generate Report",
                          icon: Icons.assessment,
                          size: bs.sm,
                          onPressed: () {
                            ss("Generating incident analytics report");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Incident List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  ],
                ),
                SizedBox(height: spSm),
                ...filteredIncidents.map((incident) {
                  final priorityColor = _getPriorityColor(incident["priority"]);
                  final statusColor = _getStatusColor(incident["status"]);
                  final statusAction = _getStatusAction(incident["status"]);
                  
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
                                    "${incident["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${incident["id"]} • ${incident["location"]}",
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
                                    "${incident["priority"]}",
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
                                    "${incident["status"]}",
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
                          "${incident["description"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 13,
                            height: 1.4,
                          ),
                          maxLines: 3,
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
                                  "${incident["category"]}",
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
                                  "Reported By",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${incident["reporterName"]}",
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
                                  "Date & Time",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${incident["reportedDate"]} ${incident["reportedTime"]}",
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
                                  "Assigned To",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${incident["assignedTo"]}",
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
                                  "Witnesses",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${incident["witnesses"]} people",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            if (incident["estimatedResolution"] != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Target Resolution",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "${incident["estimatedResolution"]}",
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
                            if (incident["injuries"] == true)
                              Container(
                                margin: EdgeInsets.only(right: spXs),
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Injuries",
                                  style: TextStyle(
                                    color: dangerColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            if (incident["medicalAttention"] == true)
                              Container(
                                margin: EdgeInsets.only(right: spXs),
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Medical Care",
                                  style: TextStyle(
                                    color: warningColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            if (incident["followUpRequired"] == true)
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
                                  "Follow-up Required",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            if ((incident["attachments"] as List).isNotEmpty)
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
                                  "${(incident["attachments"] as List).length} attachments",
                                  style: TextStyle(
                                    color: primaryColor,
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
                                  ss("$statusAction for ${incident["title"]}");
                                },
                              ),
                            ),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {
                                ss("Incident options for ${incident["title"]}");
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
