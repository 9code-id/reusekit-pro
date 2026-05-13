import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaHealthInspectionView extends StatefulWidget {
  const FmaHealthInspectionView({super.key});

  @override
  State<FmaHealthInspectionView> createState() => _FmaHealthInspectionViewState();
}

class _FmaHealthInspectionViewState extends State<FmaHealthInspectionView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "All";
  String inspectionType = "Routine";
  String inspector = "";
  String notes = "";
  String status = "Scheduled";

  List<Map<String, dynamic>> inspections = [
    {
      "id": "INS001",
      "type": "Routine Health Inspection",
      "inspector": "Sarah Johnson - Health Department",
      "scheduledDate": "2024-06-20",
      "completedDate": "2024-06-20",
      "status": "Completed",
      "score": 95,
      "grade": "A",
      "violations": 2,
      "critical": 0,
      "nonCritical": 2,
      "duration": "2.5 hours",
      "nextInspection": "2024-12-20",
      "areas": ["Kitchen", "Storage", "Dining", "Restrooms"],
      "certificate": "CERT2024-001",
      "color": successColor,
    },
    {
      "id": "INS002",
      "type": "Follow-up Inspection",
      "inspector": "Mike Wilson - Health Department",
      "scheduledDate": "2024-06-25",
      "completedDate": null,
      "status": "Scheduled",
      "score": null,
      "grade": null,
      "violations": null,
      "critical": null,
      "nonCritical": null,
      "duration": "1 hour",
      "nextInspection": null,
      "areas": ["Kitchen", "Storage"],
      "certificate": null,
      "color": infoColor,
    },
    {
      "id": "INS003",
      "type": "Complaint Investigation",
      "inspector": "Emily Davis - Health Department",
      "scheduledDate": "2024-06-18",
      "completedDate": "2024-06-18",
      "status": "Completed",
      "score": 78,
      "grade": "B",
      "violations": 5,
      "critical": 1,
      "nonCritical": 4,
      "duration": "3 hours",
      "nextInspection": "2024-07-18",
      "areas": ["Kitchen", "Food Handling"],
      "certificate": null,
      "color": warningColor,
    },
    {
      "id": "INS004",
      "type": "License Renewal Inspection",
      "inspector": "David Brown - Health Department",
      "scheduledDate": "2024-07-15",
      "completedDate": null,
      "status": "Upcoming",
      "score": null,
      "grade": null,
      "violations": null,
      "critical": null,
      "nonCritical": null,
      "duration": "2 hours",
      "nextInspection": null,
      "areas": ["All Areas"],
      "certificate": null,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> violations = [
    {
      "id": "VIO001",
      "inspectionId": "INS001",
      "category": "Food Storage",
      "severity": "Non-Critical",
      "description": "Some food items in refrigerator not properly covered",
      "location": "Walk-in Cooler",
      "code": "3-302.12",
      "correctedOnSite": true,
      "correctionRequired": "Cover all food items to prevent contamination",
      "followUpRequired": false,
      "responsiblePerson": "Kitchen Manager",
      "dateIdentified": "2024-06-20",
      "dateCorrected": "2024-06-20",
      "status": "Corrected",
    },
    {
      "id": "VIO002", 
      "inspectionId": "INS001",
      "category": "Equipment Maintenance",
      "severity": "Non-Critical",
      "description": "Loose handle on prep table drawer",
      "location": "Prep Station #2",
      "code": "4-501.11",
      "correctedOnSite": false,
      "correctionRequired": "Tighten or replace loose hardware",
      "followUpRequired": true,
      "responsiblePerson": "Maintenance Team",
      "dateIdentified": "2024-06-20",
      "dateCorrected": "2024-06-21",
      "status": "Corrected",
    },
    {
      "id": "VIO003",
      "inspectionId": "INS003",
      "category": "Temperature Control",
      "severity": "Critical",
      "description": "Hot holding unit not maintaining proper temperature",
      "location": "Serving Line",
      "code": "3-501.16",
      "correctedOnSite": false,
      "correctionRequired": "Repair heating element and calibrate thermostat",
      "followUpRequired": true,
      "responsiblePerson": "Equipment Manager",
      "dateIdentified": "2024-06-18",
      "dateCorrected": "2024-06-19",
      "status": "Corrected",
    },
    {
      "id": "VIO004",
      "inspectionId": "INS003",
      "category": "Hand Washing",
      "severity": "Non-Critical",
      "description": "Hand wash station missing paper towels",
      "location": "Employee Restroom",
      "code": "6-301.12",
      "correctedOnSite": true,
      "correctionRequired": "Ensure adequate supply of single-use towels",
      "followUpRequired": false,
      "responsiblePerson": "Janitorial Staff",
      "dateIdentified": "2024-06-18",
      "dateCorrected": "2024-06-18",
      "status": "Corrected",
    },
  ];

  List<Map<String, dynamic>> checklist = [
    {
      "category": "Food Source & Temperature",
      "items": [
        {"item": "Food from approved sources", "status": "Pass", "required": true},
        {"item": "Proper cold holding temperatures (41°F or below)", "status": "Pass", "required": true},
        {"item": "Proper hot holding temperatures (135°F or above)", "status": "Fail", "required": true},
        {"item": "Proper cooking temperatures", "status": "Pass", "required": true},
        {"item": "Proper reheating temperatures", "status": "Pass", "required": true},
      ],
    },
    {
      "category": "Personal Hygiene",
      "items": [
        {"item": "Hand washing facilities accessible and stocked", "status": "Pass", "required": true},
        {"item": "Employees washing hands properly", "status": "Pass", "required": true},
        {"item": "No bare hand contact with ready-to-eat food", "status": "Pass", "required": true},
        {"item": "Proper use of hair restraints", "status": "Pass", "required": false},
        {"item": "Clean uniforms and aprons", "status": "Pass", "required": false},
      ],
    },
    {
      "category": "Food Protection",
      "items": [
        {"item": "Food properly covered and protected", "status": "Fail", "required": true},
        {"item": "No cross-contamination", "status": "Pass", "required": true},
        {"item": "Proper chemical storage", "status": "Pass", "required": true},
        {"item": "Proper warewashing procedures", "status": "Pass", "required": true},
        {"item": "Sanitizer concentration adequate", "status": "Pass", "required": true},
      ],
    },
    {
      "category": "Equipment & Facilities",
      "items": [
        {"item": "Equipment in good repair", "status": "Fail", "required": false},
        {"item": "Adequate ventilation", "status": "Pass", "required": true},
        {"item": "Clean floors, walls, and ceilings", "status": "Pass", "required": false},
        {"item": "Pest control measures in place", "status": "Pass", "required": true},
        {"item": "Adequate lighting", "status": "Pass", "required": true},
      ],
    },
  ];

  List<Map<String, dynamic>> documents = [
    {
      "id": "DOC001",
      "type": "Health Permit",
      "title": "Food Service Establishment Permit",
      "issueDate": "2024-01-15",
      "expiryDate": "2024-12-31",
      "authority": "County Health Department",
      "status": "Valid",
      "number": "FSE-2024-1234",
      "description": "Permit to operate food service establishment",
      "renewalRequired": true,
      "downloadUrl": "/documents/health-permit-2024.pdf",
    },
    {
      "id": "DOC002",
      "type": "Inspection Report",
      "title": "Routine Health Inspection Report - June 2024",
      "issueDate": "2024-06-20",
      "expiryDate": null,
      "authority": "Health Inspector - Sarah Johnson",
      "status": "Final",
      "number": "RPT-2024-0620",
      "description": "Complete inspection report with score and violations",
      "renewalRequired": false,
      "downloadUrl": "/documents/inspection-report-june-2024.pdf",
    },
    {
      "id": "DOC003",
      "type": "Certificate",
      "title": "Food Safety Manager Certification",
      "issueDate": "2023-03-10",
      "expiryDate": "2028-03-10",
      "authority": "ServSafe",
      "status": "Valid",
      "number": "SSC-2023-9876",
      "description": "Certification for food safety manager",
      "renewalRequired": false,
      "downloadUrl": "/documents/food-safety-cert.pdf",
    },
    {
      "id": "DOC004",
      "type": "Corrective Action",
      "title": "Violation Correction Documentation",
      "issueDate": "2024-06-21",
      "expiryDate": null,
      "authority": "Restaurant Management",
      "status": "Submitted",
      "number": "CAR-2024-001",
      "description": "Documentation of corrective actions for inspection violations",
      "renewalRequired": false,
      "downloadUrl": "/documents/corrective-actions.pdf",
    },
  ];

  List<String> inspectionTypes = ["Routine", "Follow-up", "Complaint", "License Renewal", "Special"];
  List<String> statusOptions = ["Scheduled", "In Progress", "Completed", "Cancelled"];

  Widget _buildInspectionHistory() {
    var filteredInspections = inspections.where((inspection) {
      return inspection["type"].toString().toLowerCase().contains(searchQuery.toLowerCase()) &&
             (selectedFilter == "All" || inspection["status"] == selectedFilter);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search inspections...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Container(
              width: 120,
              child: QDropdownField(
                label: "Status",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Completed", "value": "Completed"},
                  {"label": "Scheduled", "value": "Scheduled"},
                  {"label": "Upcoming", "value": "Upcoming"},
                ],
                value: selectedFilter,
                onChanged: (value, label) {
                  selectedFilter = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
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
                      Icon(
                        Icons.assignment_turned_in,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Total Inspections",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${inspections.length}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "this year",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
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
                      Icon(
                        Icons.star,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Average Score",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "87",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "Grade A average",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
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
                      Icon(
                        Icons.warning,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Total Violations",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "7",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                  Text(
                    "1 critical, 6 non-critical",
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
        SizedBox(height: spMd),
        Text(
          "Inspection History (${filteredInspections.length} records)",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...filteredInspections.map((inspection) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: inspection["color"],
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${inspection["type"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    if (inspection["score"] != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: inspection["color"].withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Grade ${inspection["grade"]} (${inspection["score"]})",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: inspection["color"],
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${inspection["inspector"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Date: ${inspection["scheduledDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          if (inspection["violations"] != null) ...[
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 14,
                                  color: inspection["critical"] > 0 ? dangerColor : warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${inspection["violations"]} violations (${inspection["critical"]} critical)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: inspection["critical"] > 0 ? dangerColor : warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (inspection["nextInspection"] != null) ...[
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Next: ${inspection["nextInspection"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: inspection["color"].withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${inspection["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: inspection["color"],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "Areas: ${(inspection["areas"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View Report",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildViolationsTracking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Violations Tracking",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
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
                      Icon(
                        Icons.error,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Critical Violations",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${violations.where((v) => v["severity"] == "Critical").length}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  Text(
                    "all corrected",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
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
                      Icon(
                        Icons.warning,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Non-Critical",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${violations.where((v) => v["severity"] == "Non-Critical").length}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                  Text(
                    "minor issues",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
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
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Correction Rate",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "100%",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "timely corrections",
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
        SizedBox(height: spMd),
        Text(
          "Violation Details",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...violations.map((violation) {
          Color severityColor = violation["severity"] == "Critical" ? dangerColor : warningColor;
          
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: severityColor,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${violation["category"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: severityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${violation["severity"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: severityColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${violation["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${violation["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.numbers,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Code: ${violation["code"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Correction Required:",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "${violation["correctionRequired"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    if (violation["correctedOnSite"])
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Corrected On-Site",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    Spacer(),
                    Text(
                      "Corrected: ${violation["dateCorrected"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildPreparationChecklist() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Inspection Preparation Checklist",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...checklist.map((category) {
          List items = category["items"];
          int passCount = items.where((item) => item["status"] == "Pass").length;
          int failCount = items.where((item) => item["status"] == "Fail").length;
          
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusSm),
                      topRight: Radius.circular(radiusSm),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${category["category"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: failCount > 0 ? dangerColor.withAlpha(100) : successColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$passCount Pass, $failCount Fail",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: failCount > 0 ? dangerColor : successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    children: items.map<Widget>((item) {
                      Color statusColor = item["status"] == "Pass" ? successColor : dangerColor;
                      bool isRequired = item["required"];
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(
                            color: statusColor.withAlpha(30),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item["status"] == "Pass" ? Icons.check_circle : Icons.cancel,
                              color: statusColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${item["item"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            if (isRequired)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "REQUIRED",
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        SizedBox(height: spMd),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Schedule Mock Inspection",
            icon: Icons.schedule,
            onPressed: () {
              ss("Mock inspection scheduled");
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDocuments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Inspection Documents",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Upload Document",
            icon: Icons.upload_file,
            onPressed: () {
              ss("Document upload initiated");
            },
          ),
        ),
        SizedBox(height: spMd),
        ...documents.map((document) {
          Color statusColor = document["status"] == "Valid" ? successColor :
                             document["status"] == "Final" ? infoColor :
                             document["status"] == "Submitted" ? warningColor : disabledColor;
          
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
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
                    Icon(
                      Icons.description,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${document["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${document["type"]} • ${document["authority"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${document["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${document["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.numbers,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${document["number"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Issued: ${document["issueDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                if (document["expiryDate"] != null) ...[
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.event,
                        size: 14,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Expires: ${document["expiryDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: spSm),
                Row(
                  children: [
                    Spacer(),
                    QButton(
                      label: "Download",
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Health Inspection Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Violations", icon: Icon(Icons.warning)),
        Tab(text: "Checklist", icon: Icon(Icons.checklist)),
        Tab(text: "Documents", icon: Icon(Icons.folder)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildInspectionHistory(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildViolationsTracking(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildPreparationChecklist(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildDocuments(),
        ),
      ],
    );
  }
}
