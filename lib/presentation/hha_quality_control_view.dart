import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaQualityControlView extends StatefulWidget {
  const HhaQualityControlView({super.key});

  @override
  State<HhaQualityControlView> createState() => _HhaQualityControlViewState();
}

class _HhaQualityControlViewState extends State<HhaQualityControlView> {
  String selectedDepartment = "All";
  String selectedStatus = "All";
  String selectedPriority = "All";

  List<Map<String, dynamic>> qualityChecks = [
    {
      "id": "QC001",
      "title": "Room Cleanliness Inspection",
      "department": "Housekeeping",
      "inspector": "Maria Rodriguez",
      "area": "Room 205",
      "checkDate": "2024-06-15",
      "dueDate": "2024-06-15",
      "status": "Completed",
      "priority": "High",
      "score": 98.5,
      "maxScore": 100.0,
      "issues": 1,
      "criticalIssues": 0,
      "checklist": [
        {"item": "Bed linens changed", "status": "Pass", "critical": true},
        {"item": "Bathroom cleaned", "status": "Pass", "critical": true},
        {"item": "Floor vacuumed", "status": "Pass", "critical": false},
        {"item": "Amenities restocked", "status": "Fail", "critical": false},
        {"item": "Windows cleaned", "status": "Pass", "critical": false},
      ],
      "notes": "Overall excellent condition. Minor issue with amenity restocking.",
      "correctionRequired": false,
      "followUpDate": null,
    },
    {
      "id": "QC002",
      "title": "Kitchen Hygiene Audit",
      "department": "Kitchen",
      "inspector": "Chef Thomas Wilson",
      "area": "Main Kitchen",
      "checkDate": "2024-06-14",
      "dueDate": "2024-06-14",
      "status": "In Progress",
      "priority": "Critical",
      "score": 85.2,
      "maxScore": 100.0,
      "issues": 3,
      "criticalIssues": 1,
      "checklist": [
        {"item": "Temperature monitoring", "status": "Pass", "critical": true},
        {"item": "Food storage protocols", "status": "Fail", "critical": true},
        {"item": "Equipment sanitization", "status": "Pass", "critical": true},
        {"item": "Staff hygiene compliance", "status": "Fail", "critical": false},
        {"item": "Waste disposal", "status": "Fail", "critical": false},
      ],
      "notes": "Critical issue with food storage temperature. Immediate correction required.",
      "correctionRequired": true,
      "followUpDate": "2024-06-16",
    },
    {
      "id": "QC003",
      "title": "Front Desk Service Standards",
      "department": "Front Office",
      "inspector": "Sarah Johnson",
      "area": "Reception Area",
      "checkDate": "2024-06-13",
      "dueDate": "2024-06-13",
      "status": "Completed",
      "priority": "Medium",
      "score": 92.0,
      "maxScore": 100.0,
      "issues": 2,
      "criticalIssues": 0,
      "checklist": [
        {"item": "Guest greeting protocol", "status": "Pass", "critical": true},
        {"item": "Check-in efficiency", "status": "Pass", "critical": false},
        {"item": "Uniform standards", "status": "Fail", "critical": false},
        {"item": "Area cleanliness", "status": "Pass", "critical": false},
        {"item": "System knowledge", "status": "Fail", "critical": false},
      ],
      "notes": "Good overall performance. Training needed on uniform standards and system usage.",
      "correctionRequired": true,
      "followUpDate": "2024-06-20",
    },
    {
      "id": "QC004",
      "title": "Restaurant Service Evaluation",
      "department": "Restaurant",
      "inspector": "Michael Chen",
      "area": "Main Dining Room",
      "checkDate": "2024-06-12",
      "dueDate": "2024-06-12",
      "status": "Pending",
      "priority": "Medium",
      "score": 0.0,
      "maxScore": 100.0,
      "issues": 0,
      "criticalIssues": 0,
      "checklist": [
        {"item": "Table setup standards", "status": "Pending", "critical": false},
        {"item": "Menu knowledge", "status": "Pending", "critical": false},
        {"item": "Service timing", "status": "Pending", "critical": true},
        {"item": "Guest interaction", "status": "Pending", "critical": false},
        {"item": "Food presentation", "status": "Pending", "critical": true},
      ],
      "notes": "Scheduled for inspection during dinner service.",
      "correctionRequired": false,
      "followUpDate": null,
    },
    {
      "id": "QC005",
      "title": "Safety and Security Check",
      "department": "Security",
      "inspector": "David Anderson",
      "area": "All Public Areas",
      "checkDate": "2024-06-11",
      "dueDate": "2024-06-11",
      "status": "Overdue",
      "priority": "Critical",
      "score": 0.0,
      "maxScore": 100.0,
      "issues": 0,
      "criticalIssues": 0,
      "checklist": [
        {"item": "Emergency exits clear", "status": "Pending", "critical": true},
        {"item": "Fire safety equipment", "status": "Pending", "critical": true},
        {"item": "CCTV functionality", "status": "Pending", "critical": false},
        {"item": "Key card system", "status": "Pending", "critical": true},
        {"item": "Lighting adequacy", "status": "Pending", "critical": false},
      ],
      "notes": "Inspection overdue. Immediate attention required.",
      "correctionRequired": false,
      "followUpDate": null,
    },
  ];

  List<Map<String, dynamic>> get filteredChecks {
    return qualityChecks.where((check) {
      final matchesDept = selectedDepartment == "All" || check["department"] == selectedDepartment;
      final matchesStatus = selectedStatus == "All" || check["status"] == selectedStatus;
      final matchesPriority = selectedPriority == "All" || check["priority"] == selectedPriority;
      return matchesDept && matchesStatus && matchesPriority;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Pending":
        return infoColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getPriorityColor(String priority) {
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
        return disabledBoldColor;
    }
  }

  Color getChecklistStatusColor(String status) {
    switch (status) {
      case "Pass":
        return successColor;
      case "Fail":
        return dangerColor;
      case "Pending":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quality Control"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('CreateQualityCheckView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Dashboard Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.assignment, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Checks",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${qualityChecks.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${qualityChecks.where((c) => c["status"] == "Completed").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning, color: dangerColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Critical Issues",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${qualityChecks.fold(0, (sum, c) => sum + (c["criticalIssues"] as int))}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.score, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Avg Score",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${(qualityChecks.where((c) => c["score"] > 0).fold(0.0, (sum, c) => sum + (c["score"] as double)) / qualityChecks.where((c) => c["score"] > 0).length).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Filters
            Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Department",
                        items: [
                          {"label": "All", "value": "All"},
                          {"label": "Housekeeping", "value": "Housekeeping"},
                          {"label": "Kitchen", "value": "Kitchen"},
                          {"label": "Front Office", "value": "Front Office"},
                          {"label": "Restaurant", "value": "Restaurant"},
                          {"label": "Security", "value": "Security"},
                        ],
                        value: selectedDepartment,
                        onChanged: (value, label) {
                          selectedDepartment = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: [
                          {"label": "All", "value": "All"},
                          {"label": "Completed", "value": "Completed"},
                          {"label": "In Progress", "value": "In Progress"},
                          {"label": "Pending", "value": "Pending"},
                          {"label": "Overdue", "value": "Overdue"},
                        ],
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Priority",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Critical", "value": "Critical"},
                    {"label": "High", "value": "High"},
                    {"label": "Medium", "value": "Medium"},
                    {"label": "Low", "value": "Low"},
                  ],
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Quality Checks List
            ...filteredChecks.map((check) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${check["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${check["department"]} • ${check["area"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Inspector: ${check["inspector"]} • ID: ${check["id"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
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
                                  color: getStatusColor(check["status"]),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${check["status"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
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
                                  color: getPriorityColor(check["priority"]),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${check["priority"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Date Information
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Check Date: ${check["checkDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Due: ${check["dueDate"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: check["status"] == "Overdue" ? dangerColor : disabledBoldColor,
                                fontWeight: check["status"] == "Overdue" ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Score and Issues (if completed or in progress)
                      if (check["status"] == "Completed" || check["status"] == "In Progress") ...[
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 200,
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Quality Score",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${check["score"]}/${check["maxScore"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: check["score"] >= 90 ? successColor : 
                                             check["score"] >= 70 ? warningColor : dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Issues",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${check["issues"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Critical Issues",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${check["criticalIssues"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],

                      // Checklist Items
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Checklist Items",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          ...(check["checklist"] as List<Map<String, dynamic>>).map((item) {
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: getChecklistStatusColor(item["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    item["status"] == "Pass" ? Icons.check_circle :
                                    item["status"] == "Fail" ? Icons.cancel :
                                    Icons.schedule,
                                    size: 16,
                                    color: getChecklistStatusColor(item["status"]),
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${item["item"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  if (item["critical"] as bool)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "CRITICAL",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: getChecklistStatusColor(item["status"]),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${item["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),

                      // Notes
                      if (check["notes"] != null && (check["notes"] as String).isNotEmpty) ...[
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Inspector Notes",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "${check["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Correction Required & Follow-up
                      if (check["correctionRequired"] as bool) ...[
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.warning, color: warningColor, size: 16),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "Correction Required",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ),
                              if (check["followUpDate"] != null)
                                Text(
                                  "Follow-up: ${check["followUpDate"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: warningColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],

                      // Actions
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('QualityCheckDetailView', arguments: check)
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          if (check["status"] != "Completed")
                            Expanded(
                              child: QButton(
                                label: "Continue Check",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('ContinueQualityCheckView', arguments: check)
                                },
                              ),
                            ),
                          if (check["status"] == "Completed")
                            Expanded(
                              child: QButton(
                                label: "Generate Report",
                                size: bs.sm,
                                onPressed: () {
                                  //generateQualityReport(check)
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
