import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaInspectionReportsView extends StatefulWidget {
  const HhaInspectionReportsView({super.key});

  @override
  State<HhaInspectionReportsView> createState() => _HhaInspectionReportsViewState();
}

class _HhaInspectionReportsViewState extends State<HhaInspectionReportsView> {
  String searchQuery = "";
  String selectedType = "All";
  String selectedStatus = "All";
  String selectedPeriod = "This Month";
  String selectedInspector = "All";
  
  List<Map<String, dynamic>> reportTypes = [
    {
      "label": "All Types",
      "value": "All",
    },
    {
      "label": "Room Inspection",
      "value": "room",
    },
    {
      "label": "Kitchen Audit",
      "value": "kitchen",
    },
    {
      "label": "Safety Check",
      "value": "safety",
    },
    {
      "label": "Maintenance Review",
      "value": "maintenance",
    },
    {
      "label": "Service Quality",
      "value": "service",
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {
      "label": "All Status",
      "value": "All",
    },
    {
      "label": "Draft",
      "value": "draft",
    },
    {
      "label": "Submitted",
      "value": "submitted",
    },
    {
      "label": "Under Review",
      "value": "under_review",
    },
    {
      "label": "Approved",
      "value": "approved",
    },
    {
      "label": "Rejected",
      "value": "rejected",
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {
      "label": "This Week",
      "value": "This Week",
    },
    {
      "label": "This Month",
      "value": "This Month",
    },
    {
      "label": "Last Month",
      "value": "Last Month",
    },
    {
      "label": "Last 3 Months",
      "value": "Last 3 Months",
    },
    {
      "label": "This Year",
      "value": "This Year",
    },
  ];

  List<Map<String, dynamic>> inspectorOptions = [
    {
      "label": "All Inspectors",
      "value": "All",
    },
    {
      "label": "Maria Santos",
      "value": "maria_santos",
    },
    {
      "label": "John Wilson",
      "value": "john_wilson",
    },
    {
      "label": "Lisa Chen",
      "value": "lisa_chen",
    },
    {
      "label": "David Brown",
      "value": "david_brown",
    },
  ];

  List<Map<String, dynamic>> inspectionReports = [
    {
      "id": "RPT001",
      "title": "Daily Room Inspection - Floor 3",
      "type": "room",
      "status": "approved",
      "inspector": "Maria Santos",
      "inspection_date": "2024-12-15",
      "submitted_date": "2024-12-15",
      "score": 92,
      "max_score": 100,
      "issues_found": 3,
      "critical_issues": 1,
      "location": "Floor 3 - Rooms 301-320",
      "summary": "Overall good condition with minor cleanliness issues in rooms 305 and 312",
      "recommendations": [
        "Improve bathroom cleaning procedures",
        "Check air freshener levels daily",
        "Replace worn bathroom fixtures in room 305"
      ],
      "attachments": [
        {
          "name": "room_305_bathroom.jpg",
          "type": "image",
          "url": "https://picsum.photos/400/300?random=1&keyword=bathroom"
        },
        {
          "name": "inspection_checklist.pdf",
          "type": "document",
          "url": "#"
        }
      ]
    },
    {
      "id": "RPT002",
      "title": "Kitchen Safety & Hygiene Audit",
      "type": "kitchen",
      "status": "under_review",
      "inspector": "John Wilson",
      "inspection_date": "2024-12-14",
      "submitted_date": "2024-12-14",
      "score": 78,
      "max_score": 100,
      "issues_found": 8,
      "critical_issues": 2,
      "location": "Main Kitchen & Prep Areas",
      "summary": "Several safety violations identified, immediate action required for critical issues",
      "recommendations": [
        "Fix temperature control on refrigeration unit #3",
        "Replace damaged floor tiles in prep area",
        "Update food safety training for all kitchen staff"
      ],
      "attachments": []
    },
    {
      "id": "RPT003",
      "title": "Fire Safety Equipment Check",
      "type": "safety",
      "status": "approved",
      "inspector": "Lisa Chen",
      "inspection_date": "2024-12-12",
      "submitted_date": "2024-12-13",
      "score": 95,
      "max_score": 100,
      "issues_found": 2,
      "critical_issues": 0,
      "location": "All Building Areas",
      "summary": "Fire safety systems in excellent condition with minor maintenance needs",
      "recommendations": [
        "Replace batteries in smoke detectors on floor 2",
        "Update evacuation route signage in basement"
      ],
      "attachments": [
        {
          "name": "fire_equipment_log.pdf",
          "type": "document",
          "url": "#"
        }
      ]
    },
    {
      "id": "RPT004",
      "title": "HVAC System Performance Review",
      "type": "maintenance",
      "status": "draft",
      "inspector": "David Brown",
      "inspection_date": "2024-12-13",
      "submitted_date": null,
      "score": 85,
      "max_score": 100,
      "issues_found": 5,
      "critical_issues": 1,
      "location": "All HVAC Units",
      "summary": "System performance within acceptable range, some units need attention",
      "recommendations": [
        "Service air handler unit on floor 4",
        "Clean ductwork in guest areas",
        "Calibrate thermostats in conference rooms"
      ],
      "attachments": []
    },
    {
      "id": "RPT005",
      "title": "Guest Service Quality Assessment",
      "type": "service",
      "status": "submitted",
      "inspector": "Maria Santos",
      "inspection_date": "2024-12-11",
      "submitted_date": "2024-12-12",
      "score": 88,
      "max_score": 100,
      "issues_found": 4,
      "critical_issues": 0,
      "location": "Front Desk & Concierge",
      "summary": "Good service standards maintained, room for improvement in response times",
      "recommendations": [
        "Reduce check-in waiting time during peak hours",
        "Improve knowledge of local attractions",
        "Enhance multilingual capabilities"
      ],
      "attachments": [
        {
          "name": "service_survey_results.pdf",
          "type": "document",
          "url": "#"
        }
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredReports {
    return inspectionReports.where((report) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${report["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${report["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${report["location"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedType == "All" || report["type"] == selectedType;
      bool matchesStatus = selectedStatus == "All" || report["status"] == selectedStatus;
      bool matchesInspector = selectedInspector == "All" || 
          "${report["inspector"]}".toLowerCase().replaceAll(' ', '_') == selectedInspector;
      
      return matchesSearch && matchesType && matchesStatus && matchesInspector;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "approved":
        return successColor;
      case "submitted":
        return infoColor;
      case "under_review":
        return warningColor;
      case "draft":
        return disabledBoldColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getScoreColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 75) return warningColor;
    return dangerColor;
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "under_review":
        return "Under Review";
      default:
        return status.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inspection Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create new report
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter dialog
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search reports...",
                    value: searchQuery,
                    hint: "Search by ID, title, or location",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: reportTypes,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
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
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: periodOptions,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Inspector",
                          items: inspectorOptions,
                          value: selectedInspector,
                          onChanged: (value, label) {
                            selectedInspector = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
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
                    children: [
                      Icon(
                        Icons.assessment,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${inspectionReports.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Reports",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
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
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${inspectionReports.where((r) => r["status"] == "approved").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Approved",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
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
                    children: [
                      Icon(
                        Icons.pending,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${inspectionReports.where((r) => r["status"] == "under_review").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Under Review",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
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
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: infoColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(inspectionReports.map((r) => r["score"] as int).reduce((a, b) => a + b) / inspectionReports.length).round()}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Avg. Score",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Reports List
            ...filteredReports.map((report) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
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
                              Row(
                                children: [
                                  Text(
                                    "${report["id"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getScoreColor(report["score"] as int).withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${report["score"]}/${report["max_score"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getScoreColor(report["score"] as int),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${report["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${report["status"]}").withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            _getStatusLabel("${report["status"]}"),
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor("${report["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Location and Inspector
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${report["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${report["inspector"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${DateTime.parse("${report["inspection_date"]}").dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    // Issues Summary
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (report["critical_issues"] as int) > 0 
                                  ? dangerColor.withAlpha(20) 
                                  : warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${report["issues_found"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: (report["critical_issues"] as int) > 0 
                                        ? dangerColor 
                                        : warningColor,
                                  ),
                                ),
                                Text(
                                  "Total Issues",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (report["critical_issues"] as int) > 0 
                                  ? dangerColor.withAlpha(20) 
                                  : successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${report["critical_issues"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: (report["critical_issues"] as int) > 0 
                                        ? dangerColor 
                                        : successColor,
                                  ),
                                ),
                                Text(
                                  "Critical",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (report["attachments"] as List).isNotEmpty 
                                  ? infoColor.withAlpha(20) 
                                  : disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${(report["attachments"] as List).length}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: (report["attachments"] as List).isNotEmpty 
                                        ? infoColor 
                                        : disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Attachments",
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

                    // Summary
                    if (report["summary"] != null)
                      Text(
                        "${report["summary"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Report",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to report details
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to edit report
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {
                            // Share report
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            // Show more options
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredReports.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.assessment,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No reports found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create new report
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
