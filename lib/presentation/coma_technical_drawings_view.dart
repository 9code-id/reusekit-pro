import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaTechnicalDrawingsView extends StatefulWidget {
  const ComaTechnicalDrawingsView({super.key});

  @override
  State<ComaTechnicalDrawingsView> createState() => _ComaTechnicalDrawingsViewState();
}

class _ComaTechnicalDrawingsViewState extends State<ComaTechnicalDrawingsView> {
  String searchQuery = "";
  String selectedCategory = "";
  String selectedStatus = "";
  String selectedPriority = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": ""},
    {"label": "Structural", "value": "structural"},
    {"label": "Electrical", "value": "electrical"},
    {"label": "Mechanical", "value": "mechanical"},
    {"label": "Plumbing", "value": "plumbing"},
    {"label": "HVAC", "value": "hvac"},
    {"label": "Safety", "value": "safety"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Approved", "value": "approved"},
    {"label": "Revision Required", "value": "revision_required"},
    {"label": "Final", "value": "final"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": ""},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> technicalDrawings = [
    {
      "id": "TD-001",
      "title": "Foundation Plan - North Wing",
      "category": "structural",
      "drawing_type": "Foundation Plan",
      "status": "approved",
      "priority": "critical",
      "version": "v2.1",
      "scale": "1:100",
      "created_date": "2024-01-15",
      "last_modified": "2024-01-20",
      "project": "Hospital Complex",
      "engineer": "Sarah Johnson",
      "discipline": "Structural Engineering",
      "sheet_number": "S-101",
      "revision_number": 3,
      "file_size": "2.8 MB",
      "format": "DWG",
      "accuracy": 98,
      "compliance_status": "Compliant",
      "dimensions": {
        "length": 45.5,
        "width": 32.0,
        "height": 8.5
      },
      "materials": ["Concrete", "Steel Reinforcement"],
      "specifications": ["AS 3600-2018", "AS/NZS 4671"],
      "review_status": "Passed",
      "comments_count": 12,
      "download_count": 45
    },
    {
      "id": "TD-002", 
      "title": "Electrical Layout - Level 2",
      "category": "electrical",
      "drawing_type": "Electrical Plan",
      "status": "under_review",
      "priority": "high",
      "version": "v1.3",
      "scale": "1:50",
      "created_date": "2024-01-18",
      "last_modified": "2024-01-22",
      "project": "Office Building",
      "engineer": "Mike Chen",
      "discipline": "Electrical Engineering",
      "sheet_number": "E-201",
      "revision_number": 2,
      "file_size": "1.5 MB",
      "format": "PDF",
      "accuracy": 95,
      "compliance_status": "Under Review",
      "dimensions": {
        "length": 28.0,
        "width": 18.5,
        "height": 3.2
      },
      "materials": ["Copper Wiring", "PVC Conduits"],
      "specifications": ["AS/NZS 3000", "IEC 60364"],
      "review_status": "In Progress",
      "comments_count": 8,
      "download_count": 23
    },
    {
      "id": "TD-003",
      "title": "HVAC Ductwork - Main Floor",
      "category": "hvac",
      "drawing_type": "HVAC Plan",
      "status": "revision_required",
      "priority": "medium",
      "version": "v1.1",
      "scale": "1:75",
      "created_date": "2024-01-10",
      "last_modified": "2024-01-25",
      "project": "Shopping Mall",
      "engineer": "Lisa Wang",
      "discipline": "Mechanical Engineering",
      "sheet_number": "M-301",
      "revision_number": 1,
      "file_size": "3.2 MB",
      "format": "DWG",
      "accuracy": 87,
      "compliance_status": "Non-Compliant",
      "dimensions": {
        "length": 62.0,
        "width": 35.5,
        "height": 4.8
      },
      "materials": ["Galvanized Steel", "Insulation"],
      "specifications": ["ASHRAE 90.1", "SMACNA"],
      "review_status": "Failed",
      "comments_count": 15,
      "download_count": 31
    },
    {
      "id": "TD-004",
      "title": "Plumbing Schematic - Residential Block",
      "category": "plumbing",
      "drawing_type": "Plumbing Plan",
      "status": "in_progress",
      "priority": "high",
      "version": "v0.8",
      "scale": "1:100",
      "created_date": "2024-01-22",
      "last_modified": "2024-01-26",
      "project": "Apartment Complex",
      "engineer": "David Kim",
      "discipline": "Plumbing Engineering",
      "sheet_number": "P-401",
      "revision_number": 0,
      "file_size": "2.1 MB",
      "format": "PDF",
      "accuracy": 92,
      "compliance_status": "Pending Review",
      "dimensions": {
        "length": 38.5,
        "width": 25.0,
        "height": 12.0
      },
      "materials": ["PVC Pipes", "Copper Fittings"],
      "specifications": ["AS/NZS 3500", "WaterMark"],
      "review_status": "Pending",
      "comments_count": 6,
      "download_count": 18
    },
    {
      "id": "TD-005",
      "title": "Safety Systems Layout",
      "category": "safety",
      "drawing_type": "Safety Plan",
      "status": "final",
      "priority": "critical",
      "version": "v3.0",
      "scale": "1:200",
      "created_date": "2024-01-05",
      "last_modified": "2024-01-28",
      "project": "Industrial Facility",
      "engineer": "Emma Thompson",
      "discipline": "Safety Engineering",
      "sheet_number": "SF-501",
      "revision_number": 5,
      "file_size": "4.1 MB",
      "format": "DWG",
      "accuracy": 99,
      "compliance_status": "Fully Compliant",
      "dimensions": {
        "length": 85.0,
        "width": 55.0,
        "height": 15.5
      },
      "materials": ["Fire-rated Materials", "Emergency Systems"],
      "specifications": ["AS 1851", "NFPA 101"],
      "review_status": "Approved",
      "comments_count": 3,
      "download_count": 67
    },
    {
      "id": "TD-006",
      "title": "Structural Details - Column Connections",
      "category": "structural",
      "drawing_type": "Detail Drawing",
      "status": "approved",
      "priority": "high",
      "version": "v1.5",
      "scale": "1:10",
      "created_date": "2024-01-12",
      "last_modified": "2024-01-24",
      "project": "Bridge Construction",
      "engineer": "Robert Brown",
      "discipline": "Structural Engineering",
      "sheet_number": "S-601",
      "revision_number": 2,
      "file_size": "1.8 MB",
      "format": "PDF",
      "accuracy": 96,
      "compliance_status": "Compliant",
      "dimensions": {
        "length": 2.5,
        "width": 1.8,
        "height": 3.2
      },
      "materials": ["High-strength Steel", "Bolts"],
      "specifications": ["AS 4100", "AS/NZS 5131"],
      "review_status": "Passed",
      "comments_count": 9,
      "download_count": 42
    }
  ];

  List<Map<String, dynamic>> get filteredDrawings {
    return technicalDrawings.where((drawing) {
      bool matchesSearch = searchQuery.isEmpty ||
          (drawing["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (drawing["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (drawing["engineer"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory.isEmpty || drawing["category"] == selectedCategory;
      bool matchesStatus = selectedStatus.isEmpty || drawing["status"] == selectedStatus;
      bool matchesPriority = selectedPriority.isEmpty || drawing["priority"] == selectedPriority;
      
      return matchesSearch && matchesCategory && matchesStatus && matchesPriority;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "approved":
      case "final":
        return successColor;
      case "under_review":
      case "in_progress":
        return infoColor;
      case "revision_required":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Technical Drawings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Statistics
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.engineering, color: primaryColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Total Drawings",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${technicalDrawings.length}",
                        style: TextStyle(
                          fontSize: 28,
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
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Approved",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${technicalDrawings.where((d) => d["status"] == "approved" || d["status"] == "final").length}",
                        style: TextStyle(
                          fontSize: 28,
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
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.pending, color: warningColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Under Review",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${technicalDrawings.where((d) => d["status"] == "under_review" || d["status"] == "revision_required").length}",
                        style: TextStyle(
                          fontSize: 28,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.assessment, color: infoColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Avg Accuracy",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${(technicalDrawings.map((d) => d["accuracy"] as int).reduce((a, b) => a + b) / technicalDrawings.length).round()}%",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search drawings...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categories,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
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
                ],
              ),
            ),

            // Technical Drawings Grid
            ResponsiveGridView(
              minItemWidth: 200,
              children: filteredDrawings.map((drawing) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: getPriorityColor(drawing["priority"]),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.architecture,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${drawing["id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${drawing["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: getStatusColor(drawing["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(
                            color: getStatusColor(drawing["status"]),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "${drawing["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: getStatusColor(drawing["status"]),
                          ),
                        ),
                      ),

                      Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.category, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${drawing["drawing_type"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.straighten, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Scale: ${drawing["scale"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.person, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${drawing["engineer"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.folder, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${drawing["project"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Accuracy",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${drawing["accuracy"]}%",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            LinearProgressIndicator(
                              value: (drawing["accuracy"] as int) / 100,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                (drawing["accuracy"] as int) >= 95 
                                  ? successColor 
                                  : (drawing["accuracy"] as int) >= 85 
                                    ? infoColor 
                                    : warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Version",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${drawing["version"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
                                  "Format",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${drawing["format"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
                                  "Size",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${drawing["file_size"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "View Drawing",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
