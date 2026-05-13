import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaAuditTrackingView extends StatefulWidget {
  const AmaAuditTrackingView({super.key});

  @override
  State<AmaAuditTrackingView> createState() => _AmaAuditTrackingViewState();
}

class _AmaAuditTrackingViewState extends State<AmaAuditTrackingView> {
  List auditRecords = [
    {
      "id": 1,
      "audit_type": "Organic Certification",
      "auditor": "Green Certification Agency",
      "scheduled_date": "2024-02-15",
      "status": "Completed",
      "score": 92,
      "findings": 2,
      "critical_issues": 0,
      "location": "Main Farm - Block A",
      "duration": "4 hours",
      "next_audit": "2024-08-15",
      "compliance_rate": 95,
      "color": successColor,
      "icon": Icons.eco,
    },
    {
      "id": 2,
      "audit_type": "Food Safety Inspection",
      "auditor": "Food Safety Authority",
      "scheduled_date": "2024-01-25",
      "status": "Action Required",
      "score": 78,
      "findings": 5,
      "critical_issues": 1,
      "location": "Storage Facility",
      "duration": "3 hours",
      "next_audit": "2024-04-25",
      "compliance_rate": 82,
      "color": warningColor,
      "icon": Icons.health_and_safety,
    },
    {
      "id": 3,
      "audit_type": "Environmental Compliance",
      "auditor": "Environmental Protection Agency",
      "scheduled_date": "2024-03-10",
      "status": "Scheduled",
      "score": null,
      "findings": null,
      "critical_issues": null,
      "location": "Entire Property",
      "duration": "6 hours",
      "next_audit": null,
      "compliance_rate": null,
      "color": infoColor,
      "icon": Icons.nature,
    },
    {
      "id": 4,
      "audit_type": "Water Quality Assessment",
      "auditor": "Water Resources Department",
      "scheduled_date": "2024-01-10",
      "status": "Failed",
      "score": 65,
      "findings": 8,
      "critical_issues": 3,
      "location": "Irrigation System",
      "duration": "2 hours",
      "next_audit": "2024-03-10",
      "compliance_rate": 68,
      "color": dangerColor,
      "icon": Icons.water_drop,
    },
    {
      "id": 5,
      "audit_type": "Pesticide Usage Review",
      "auditor": "Agricultural Extension Office",
      "scheduled_date": "2024-01-30",
      "status": "In Progress",
      "score": null,
      "findings": null,
      "critical_issues": null,
      "location": "Field Operations",
      "duration": "5 hours",
      "next_audit": null,
      "compliance_rate": null,
      "color": primaryColor,
      "icon": Icons.bug_report,
    },
    {
      "id": 6,
      "audit_type": "Worker Safety Inspection",
      "auditor": "Occupational Safety Board",
      "scheduled_date": "2023-12-20",
      "status": "Completed",
      "score": 88,
      "findings": 3,
      "critical_issues": 0,
      "location": "Equipment Storage",
      "duration": "3 hours",
      "next_audit": "2024-06-20",
      "compliance_rate": 90,
      "color": secondaryColor,
      "icon": Icons.safety_check,
    },
  ];

  String selectedStatus = "All";
  String selectedAuditType = "All";
  List<String> statuses = ["All", "Completed", "Action Required", "Scheduled", "Failed", "In Progress"];
  List<String> auditTypes = ["All", "Organic Certification", "Food Safety Inspection", "Environmental Compliance", "Water Quality Assessment", "Pesticide Usage Review", "Worker Safety Inspection"];

  @override
  Widget build(BuildContext context) {
    List filteredAudits = auditRecords.where((audit) {
      bool statusMatch = selectedStatus == "All" || audit["status"] == selectedStatus;
      bool typeMatch = selectedAuditType == "All" || audit["audit_type"] == selectedAuditType;
      return statusMatch && typeMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Audit Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Schedule new audit
            },
          ),
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: () {
              // View audit reports
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Audit Overview Statistics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.assignment_turned_in,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Audit Overview",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${auditRecords.where((a) => a["status"] == "Completed").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Completed",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
                              "${auditRecords.where((a) => a["status"] == "Action Required").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Need Action",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
                              "${auditRecords.where((a) => a["status"] == "Scheduled").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Upcoming",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
            
            SizedBox(height: spLg),
            
            // Compliance Score Summary
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
                    "Average Compliance Score",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${((auditRecords.where((a) => a["compliance_rate"] != null).fold(0.0, (sum, a) => sum + (a["compliance_rate"] as int))) / auditRecords.where((a) => a["compliance_rate"] != null).length).toInt()}%",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Overall Score",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${auditRecords.where((a) => a["critical_issues"] != null).fold(0, (sum, a) => sum + (a["critical_issues"] as int))}",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Critical Issues",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
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
            
            SizedBox(height: spLg),
            
            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Schedule Audit",
                    icon: Icons.schedule,
                    size: bs.sm,
                    onPressed: () {
                      // Schedule new audit
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Generate Report",
                    icon: Icons.description,
                    size: bs.sm,
                    onPressed: () {
                      // Generate audit report
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statuses.map((status) => {
                      "label": status,
                      "value": status,
                    }).toList(),
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
                    label: "Audit Type",
                    items: auditTypes.map((type) => {
                      "label": type,
                      "value": type,
                    }).toList(),
                    value: selectedAuditType,
                    onChanged: (value, label) {
                      selectedAuditType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Audit Records
            Text(
              "Audit Records (${filteredAudits.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredAudits.length,
              itemBuilder: (context, index) {
                final audit = filteredAudits[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: audit["color"] as Color,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (audit["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                audit["icon"] as IconData,
                                color: audit["color"] as Color,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${audit["audit_type"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${audit["auditor"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getStatusColor(audit["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${audit["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getStatusColor(audit["status"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Audit Details
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${audit["scheduled_date"]}",
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
                                          Icons.location_on,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Expanded(
                                          child: Text(
                                            "${audit["location"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Duration: ${audit["duration"]}",
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
                        
                        // Results (if available)
                        if (audit["score"] != null) ...[
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${audit["score"]}",
                                        style: TextStyle(
                                          fontSize: fsH5,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                      Text(
                                        "Score",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
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
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${audit["findings"]}",
                                        style: TextStyle(
                                          fontSize: fsH5,
                                          fontWeight: FontWeight.bold,
                                          color: warningColor,
                                        ),
                                      ),
                                      Text(
                                        "Findings",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: warningColor,
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
                                    color: dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${audit["critical_issues"]}",
                                        style: TextStyle(
                                          fontSize: fsH5,
                                          fontWeight: FontWeight.bold,
                                          color: dangerColor,
                                        ),
                                      ),
                                      Text(
                                        "Critical",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        
                        // Next Audit Date
                        if (audit["next_audit"] != null) ...[
                          SizedBox(height: spSm),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: infoColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Next Audit: ${audit["next_audit"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        
                        SizedBox(height: spSm),
                        
                        // Actions
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  // View audit details
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Report",
                              icon: Icons.description,
                              size: bs.sm,
                              onPressed: () {
                                // View/download audit report
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Action Required":
        return warningColor;
      case "Failed":
        return dangerColor;
      case "Scheduled":
        return infoColor;
      case "In Progress":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }
}
