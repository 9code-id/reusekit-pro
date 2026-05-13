import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaRepairRequestsView extends StatefulWidget {
  const HhaRepairRequestsView({super.key});

  @override
  State<HhaRepairRequestsView> createState() => _HhaRepairRequestsViewState();
}

class _HhaRepairRequestsViewState extends State<HhaRepairRequestsView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";
  String selectedDepartment = "All";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Submitted", "value": "submitted"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Approved", "value": "approved"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "On Hold", "value": "on_hold"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Emergency", "value": "emergency"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All", "value": "All"},
    {"label": "Emergency", "value": "emergency"},
    {"label": "ICU", "value": "icu"},
    {"label": "Surgery", "value": "surgery"},
    {"label": "Radiology", "value": "radiology"},
    {"label": "Laboratory", "value": "laboratory"},
    {"label": "Cardiology", "value": "cardiology"},
    {"label": "Pediatrics", "value": "pediatrics"},
  ];

  List<Map<String, dynamic>> repairRequests = [
    {
      "id": "REQ001",
      "requestNumber": "RR-2024-0156",
      "equipmentId": "EQ023",
      "equipmentName": "Patient Monitor - Philips IntelliVue",
      "department": "ICU",
      "location": "ICU Room 205",
      "priority": "Emergency",
      "status": "In Progress",
      "issueDescription": "Monitor screen intermittently goes black during patient monitoring. Critical safety issue affecting patient care.",
      "reportedBy": "Nurse Sarah Johnson",
      "reportedDate": "2024-12-15",
      "reportedTime": "08:30",
      "assignedTechnician": "Tech. Michael Chen",
      "estimatedCost": 850.0,
      "estimatedCompletion": "2024-12-16",
      "actualCost": null,
      "completionDate": null,
      "urgencyReason": "Patient safety - affects continuous monitoring",
      "symptoms": [
        "Screen blackout every 15-20 minutes",
        "Alarm sounds inconsistently",
        "Touch screen unresponsive",
        "Power indicator flickering"
      ],
      "troubleshootingAttempts": [
        "Power cycle performed - temporary fix",
        "Cable connections checked - secure",
        "Software restart attempted - issue persists"
      ],
      "requiredParts": ["LCD Display Assembly", "Power Supply Board"],
      "workOrderNumber": "WO-2024-0289",
      "approvedBy": "ICU Supervisor - Dr. Lisa Martinez",
      "contactPerson": "Nurse Sarah Johnson",
      "contactInfo": "ext. 3205",
      "notes": "Backup monitor deployed to maintain patient safety",
    },
    {
      "id": "REQ002", 
      "requestNumber": "RR-2024-0157",
      "equipmentId": "EQ015",
      "equipmentName": "X-Ray Machine - GE Precision 500",
      "department": "Radiology",
      "location": "Imaging Suite 2",
      "priority": "High",
      "status": "Under Review",
      "issueDescription": "Image quality degradation with visible artifacts and reduced contrast in diagnostic images.",
      "reportedBy": "Radiologic Technologist Mark Wilson",
      "reportedDate": "2024-12-14",
      "reportedTime": "14:15",
      "assignedTechnician": null,
      "estimatedCost": 2200.0,
      "estimatedCompletion": "2024-12-20",
      "actualCost": null,
      "completionDate": null,
      "urgencyReason": "Diagnostic accuracy compromised",
      "symptoms": [
        "Horizontal line artifacts on images",
        "Reduced image contrast",
        "Uneven exposure across image field",
        "Detector calibration warnings"
      ],
      "troubleshootingAttempts": [
        "Detector calibration performed - minimal improvement",
        "Image processing settings adjusted",
        "Collimator alignment checked"
      ],
      "requiredParts": ["Digital Detector Panel", "X-Ray Tube Assembly"],
      "workOrderNumber": null,
      "approvedBy": null,
      "contactPerson": "Mark Wilson",
      "contactInfo": "ext. 2150",
      "notes": "Quality assurance tests scheduled for review",
    },
    {
      "id": "REQ003",
      "requestNumber": "RR-2024-0158",
      "equipmentId": "EQ008",
      "equipmentName": "Ventilator - Medtronic PB980",
      "department": "Emergency",
      "location": "ER Bay 4",
      "priority": "Emergency",
      "status": "Approved",
      "issueDescription": "Ventilator pressure alarms triggering inappropriately. Potential breathing circuit leak affecting patient ventilation.",
      "reportedBy": "Dr. Amanda Foster",
      "reportedDate": "2024-12-15",
      "reportedTime": "11:45",
      "assignedTechnician": "Tech. Robert Davis",
      "estimatedCost": 450.0,
      "estimatedCompletion": "2024-12-15",
      "actualCost": null,
      "completionDate": null,
      "urgencyReason": "Life support equipment - immediate patient safety risk",
      "symptoms": [
        "High pressure alarms",
        "Low tidal volume delivery",
        "Audible air leak from circuit",
        "Pressure gauge fluctuations"
      ],
      "troubleshootingAttempts": [
        "Circuit connections tightened",
        "Pressure sensor cleaned",
        "Circuit replaced - issue continues"
      ],
      "requiredParts": ["Pressure Sensor", "Breathing Circuit Valve"],
      "workOrderNumber": "WO-2024-0290",
      "approvedBy": "ER Director - Dr. James Peterson",
      "contactPerson": "Dr. Amanda Foster",
      "contactInfo": "ext. 4012",
      "notes": "URGENT: Backup ventilator in use for patient",
    },
    {
      "id": "REQ004",
      "requestNumber": "RR-2024-0159",
      "equipmentId": "EQ035",
      "equipmentName": "Ultrasound - Siemens ACUSON",
      "department": "Cardiology",
      "location": "Echo Lab",
      "priority": "Medium",
      "status": "Completed",
      "issueDescription": "Transducer cable intermittent connection causing image dropout during cardiac examinations.",
      "reportedBy": "Sonographer Jennifer Liu",
      "reportedDate": "2024-12-12",
      "reportedTime": "09:20",
      "assignedTechnician": "Dr. Patricia Adams",
      "estimatedCost": 320.0,
      "estimatedCompletion": "2024-12-13",
      "actualCost": 285.0,
      "completionDate": "2024-12-13",
      "urgencyReason": "Affects diagnostic quality",
      "symptoms": [
        "Image freezing during scans",
        "Transducer not recognized",
        "Connection error messages",
        "Cable housing damage visible"
      ],
      "troubleshootingAttempts": [
        "Cable repositioning tested",
        "Connector cleaned",
        "System diagnostics run"
      ],
      "requiredParts": ["Transducer Cable Assembly"],
      "workOrderNumber": "WO-2024-0285",
      "approvedBy": "Cardiology Chief - Dr. Steven Roberts",
      "contactPerson": "Jennifer Liu",
      "contactInfo": "ext. 2501",
      "notes": "Repair completed successfully - tested and verified",
    },
    {
      "id": "REQ005",
      "requestNumber": "RR-2024-0160",
      "equipmentId": "EQ041",
      "equipmentName": "Anesthesia Machine - Draeger Fabius",
      "department": "Surgery",
      "location": "OR-3",
      "priority": "High",
      "status": "On Hold",
      "issueDescription": "Gas flow meter readings inconsistent. Anesthetic gas concentration fluctuations during procedures.",
      "reportedBy": "Anesthesiologist Dr. Katherine Brown",
      "reportedDate": "2024-12-13",
      "reportedTime": "16:30",
      "assignedTechnician": "Tech. David Thompson",
      "estimatedCost": 1500.0,
      "estimatedCompletion": "2024-12-18",
      "actualCost": null,
      "completionDate": null,
      "urgencyReason": "Patient safety during anesthesia delivery",
      "symptoms": [
        "Flow meter needle sticking",
        "Inconsistent gas delivery",
        "Calibration drift",
        "Alarm system triggers"
      ],
      "troubleshootingAttempts": [
        "Flow meter cleaning attempted",
        "Gas line pressure checked", 
        "Calibration adjustment made"
      ],
      "requiredParts": ["Flow Meter Assembly", "Gas Mixing Valve"],
      "workOrderNumber": "WO-2024-0291",
      "approvedBy": "OR Supervisor - Nurse Manager Carol White",
      "contactPerson": "Dr. Katherine Brown",
      "contactInfo": "ext. 3512",
      "notes": "Waiting for manufacturer parts delivery - ETA 3 days",
    },
    {
      "id": "REQ006",
      "requestNumber": "RR-2024-0161",
      "equipmentId": "EQ052",
      "equipmentName": "Defibrillator - Zoll X Series",
      "department": "Emergency",
      "location": "ER Crash Cart 2",
      "priority": "Emergency",
      "status": "Submitted",
      "issueDescription": "Defibrillator fails to charge to full energy level. Critical life-saving equipment malfunction.",
      "reportedBy": "Paramedic John Martinez",
      "reportedDate": "2024-12-15",
      "reportedTime": "15:20",
      "assignedTechnician": null,
      "estimatedCost": null,
      "estimatedCompletion": null,
      "actualCost": null,
      "completionDate": null,
      "urgencyReason": "Life-saving equipment - immediate response required",
      "symptoms": [
        "Charging stops at 150J instead of 200J",
        "Error code displayed",
        "Battery indicator shows full charge",
        "Paddle test shows reduced output"
      ],
      "troubleshootingAttempts": [
        "Self-test diagnostics run",
        "Battery connections checked",
        "Paddle contacts cleaned"
      ],
      "requiredParts": ["To be determined"],
      "workOrderNumber": null,
      "approvedBy": null,
      "contactPerson": "John Martinez",
      "contactInfo": "ext. 4025",
      "notes": "CRITICAL: Backup defibrillator deployed immediately",
    },
  ];

  List<Map<String, dynamic>> get filteredRequests {
    return repairRequests.where((request) {
      bool matchesSearch = request["equipmentName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          request["requestNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          request["issueDescription"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || request["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || request["priority"] == selectedPriority;
      bool matchesDepartment = selectedDepartment == "All" || request["department"].toString().toLowerCase() == selectedDepartment.toLowerCase();
      
      return matchesSearch && matchesStatus && matchesPriority && matchesDepartment;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'submitted':
        return infoColor;
      case 'under review':
        return warningColor;
      case 'approved':
        return successColor;
      case 'in progress':
        return primaryColor;
      case 'completed':
        return successColor;
      case 'rejected':
        return dangerColor;
      case 'on hold':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'emergency':
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Repair Requests"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Create new repair request
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Repair requests report exported");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Status Overview Cards
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildStatusCard(
                  "Total Requests",
                  "${repairRequests.length}",
                  primaryColor,
                  Icons.build,
                ),
                _buildStatusCard(
                  "Emergency",
                  "${repairRequests.where((r) => r["priority"] == "Emergency").length}",
                  dangerColor,
                  Icons.warning,
                ),
                _buildStatusCard(
                  "In Progress",
                  "${repairRequests.where((r) => r["status"] == "In Progress").length}",
                  primaryColor,
                  Icons.engineering,
                ),
                _buildStatusCard(
                  "Completed",
                  "${repairRequests.where((r) => r["status"] == "Completed").length}",
                  successColor,
                  Icons.check_circle,
                ),
                _buildStatusCard(
                  "Pending Review",
                  "${repairRequests.where((r) => r["status"] == "Under Review" || r["status"] == "Submitted").length}",
                  warningColor,
                  Icons.hourglass_empty,
                ),
                _buildStatusCard(
                  "On Hold",
                  "${repairRequests.where((r) => r["status"] == "On Hold").length}",
                  disabledBoldColor,
                  Icons.pause_circle,
                ),
              ],
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search & Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  QTextField(
                    label: "Search Requests",
                    value: searchQuery,
                    hint: "Search by equipment, request number, or issue",
                    onChanged: (value) {
                      searchQuery = value;
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
                    label: "Department",
                    items: departmentOptions,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Repair Requests List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Text(
                          "Repair Requests",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredRequests.length} requests found",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredRequests.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final request = filteredRequests[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getPriorityColor("${request["priority"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${request["priority"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: _getPriorityColor("${request["priority"]}"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${request["requestNumber"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${request["equipmentName"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${request["issueDescription"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor("${request["status"]}").withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${request["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: _getStatusColor("${request["status"]}"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    if (request["estimatedCost"] != null) ...[
                                      Text(
                                        "\$${((request["estimatedCost"] as num).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${request["reportedBy"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${request["reportedDate"]} ${request["reportedTime"]}",
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${request["department"]} - ${request["location"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (request["assignedTechnician"] != null) ...[
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.engineering,
                                                size: 12,
                                                color: disabledBoldColor,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${request["assignedTechnician"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (request["urgencyReason"] != null && "${request["urgencyReason"]}".isNotEmpty) ...[
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor("${request["priority"]}").withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border(
                                    left: BorderSide(
                                      color: _getPriorityColor("${request["priority"]}"),
                                      width: 3,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.priority_high,
                                      size: 14,
                                      color: _getPriorityColor("${request["priority"]}"),
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${request["urgencyReason"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _getPriorityColor("${request["priority"]}"),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: _getActionLabel("${request["status"]}"),
                                    size: bs.sm,
                                    onPressed: () {
                                      _performAction(request);
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.info,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Show full details
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Show options menu
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            count,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _getActionLabel(String status) {
    switch (status.toLowerCase()) {
      case 'submitted':
        return "Review";
      case 'under review':
        return "Approve";
      case 'approved':
        return "Assign Tech";
      case 'in progress':
        return "Update";
      case 'completed':
        return "View Report";
      case 'rejected':
        return "Resubmit";
      case 'on hold':
        return "Resume";
      default:
        return "View";
    }
  }

  void _performAction(Map<String, dynamic> request) {
    String status = "${request["status"]}";
    String action = _getActionLabel(status);
    ss("$action performed for ${request["requestNumber"]}");
  }
}
