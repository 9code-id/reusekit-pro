import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaComplianceView extends StatefulWidget {
  const ComaComplianceView({super.key});

  @override
  State<ComaComplianceView> createState() => _ComaComplianceViewState();
}

class _ComaComplianceViewState extends State<ComaComplianceView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Compliant", "value": "Compliant"},
    {"label": "Non-Compliant", "value": "Non-Compliant"},
    {"label": "Pending Review", "value": "Pending Review"},
    {"label": "Action Required", "value": "Action Required"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Safety Standards", "value": "Safety Standards"},
    {"label": "Environmental", "value": "Environmental"},
    {"label": "Building Codes", "value": "Building Codes"},
    {"label": "Labor Regulations", "value": "Labor Regulations"},
    {"label": "Quality Standards", "value": "Quality Standards"},
    {"label": "Documentation", "value": "Documentation"},
  ];

  List<Map<String, dynamic>> complianceItems = [
    {
      "id": "C001",
      "title": "OSHA Safety Training Certification",
      "category": "Safety Standards",
      "status": "Compliant",
      "dueDate": "2024-03-15",
      "completedDate": "2024-02-20",
      "priority": "High",
      "description": "All construction workers must complete OSHA 30-hour safety training",
      "requirements": [
        "OSHA 30-hour certification for supervisors",
        "OSHA 10-hour certification for workers",
        "Annual refresher training required",
        "Documentation must be maintained on-site"
      ],
      "assignedTo": "Safety Manager",
      "documents": ["OSHA_Cert_2024.pdf", "Training_Records.xlsx"],
      "progress": 100,
      "cost": 2500.0,
      "lastReview": "2024-02-20"
    },
    {
      "id": "C002",
      "title": "Environmental Impact Assessment",
      "category": "Environmental",
      "status": "Pending Review",
      "dueDate": "2024-02-28",
      "completedDate": null,
      "priority": "Critical",
      "description": "Environmental impact assessment for construction activities",
      "requirements": [
        "Air quality monitoring reports",
        "Noise level assessments",
        "Soil contamination testing",
        "Water quality impact analysis",
        "Wildlife habitat protection plan"
      ],
      "assignedTo": "Environmental Consultant",
      "documents": ["EIA_Draft_v2.pdf", "Monitoring_Data.xlsx"],
      "progress": 75,
      "cost": 15000.0,
      "lastReview": "2024-02-15"
    },
    {
      "id": "C003",
      "title": "Building Code Compliance Review",
      "category": "Building Codes",
      "status": "Action Required",
      "dueDate": "2024-02-25",
      "completedDate": null,
      "priority": "High",
      "description": "Structural design compliance with local building codes",
      "requirements": [
        "Structural engineering review",
        "Fire safety code compliance",
        "Accessibility standards (ADA)",
        "Electrical code compliance",
        "Plumbing code compliance"
      ],
      "assignedTo": "Chief Engineer",
      "documents": ["Building_Plans_v3.pdf", "Code_Review_Notes.pdf"],
      "progress": 60,
      "cost": 8000.0,
      "lastReview": "2024-02-10"
    },
    {
      "id": "C004",
      "title": "Worker Safety Equipment Inspection",
      "category": "Safety Standards",
      "status": "Non-Compliant",
      "dueDate": "2024-02-20",
      "completedDate": null,
      "priority": "Critical",
      "description": "Monthly inspection of personal protective equipment",
      "requirements": [
        "Hard hat inspection and replacement",
        "Safety harness integrity check",
        "Respirator maintenance and testing",
        "Safety boot condition assessment",
        "High-visibility clothing inspection"
      ],
      "assignedTo": "Site Safety Officer",
      "documents": ["PPE_Inspection_Checklist.pdf"],
      "progress": 30,
      "cost": 5000.0,
      "lastReview": "2024-01-15"
    },
    {
      "id": "C005",
      "title": "Quality Control Documentation",
      "category": "Quality Standards",
      "status": "Compliant",
      "dueDate": "2024-03-01",
      "completedDate": "2024-02-18",
      "priority": "Medium",
      "description": "Quality control documentation for concrete testing",
      "requirements": [
        "Concrete strength test reports",
        "Material certification documents",
        "Quality control photographs",
        "Inspection reports",
        "Non-conformance reports"
      ],
      "assignedTo": "Quality Manager",
      "documents": ["QC_Reports_Feb.pdf", "Material_Certs.pdf", "Test_Results.xlsx"],
      "progress": 100,
      "cost": 3500.0,
      "lastReview": "2024-02-18"
    },
    {
      "id": "C006",
      "title": "Labor Compliance Audit",
      "category": "Labor Regulations",
      "status": "Pending Review",
      "dueDate": "2024-03-10",
      "completedDate": null,
      "priority": "Medium",
      "description": "Compliance with prevailing wage and labor standards",
      "requirements": [
        "Prevailing wage documentation",
        "Worker classification verification",
        "Overtime calculation records",
        "Union agreement compliance",
        "Worker rights posting requirements"
      ],
      "assignedTo": "HR Manager",
      "documents": ["Payroll_Records.xlsx", "Union_Agreement.pdf"],
      "progress": 85,
      "cost": 4000.0,
      "lastReview": "2024-02-12"
    }
  ];

  List<Map<String, dynamic>> get filteredComplianceItems {
    return complianceItems.where((item) {
      bool matchesSearch = searchQuery.isEmpty ||
          (item["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || item["status"] == selectedStatus;
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      
      return matchesSearch && matchesStatus && matchesCategory;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Compliant":
        return successColor;
      case "Non-Compliant":
        return dangerColor;
      case "Pending Review":
        return warningColor;
      case "Action Required":
        return infoColor;
      default:
        return disabledBoldColor;
    }
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
        return disabledBoldColor;
    }
  }

  void _showComplianceDetails(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getStatusColor(item["status"] as String),
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item["title"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${item["category"]} • ${item["priority"]} Priority",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => back(),
                    icon: Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status and Progress
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getStatusColor(item["status"] as String).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(item["status"] as String),
                                  ),
                                ),
                                Text(
                                  "${item["status"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
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
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Progress",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${item["progress"]}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    // Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Completion Progress",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: (item["progress"] as int) / 100,
                          backgroundColor: disabledColor.withAlpha(50),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getStatusColor(item["status"] as String),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spLg),
                    
                    // Description
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${item["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: spLg),
                    
                    // Requirements
                    Text(
                      "Requirements",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(item["requirements"] as List).map((requirement) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                requirement,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: spLg),
                    
                    // Timeline Information
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Due Date",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                                Text(
                                  "${item["dueDate"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
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
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last Review",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "${item["lastReview"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    // Assignment and Cost
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Assigned To",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "${item["assignedTo"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cost",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: dangerColor,
                                  ),
                                ),
                                Text(
                                  "\$${((item["cost"] as double).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spLg),
                    
                    // Documents
                    Text(
                      "Documents",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(item["documents"] as List).map((document) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.description, color: primaryColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                document,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            QButton(
                              icon: Icons.download,
                              size: bs.sm,
                              onPressed: () {
                                // Download document
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: spLg),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Update Status",
                            size: bs.sm,
                            onPressed: () {
                              // Update compliance status
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Add Document",
                            size: bs.sm,
                            onPressed: () {
                              // Add document
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    int compliantCount = complianceItems.where((item) => item["status"] == "Compliant").length;
    int nonCompliantCount = complianceItems.where((item) => item["status"] == "Non-Compliant").length;
    int pendingCount = complianceItems.where((item) => item["status"] == "Pending Review").length;
    int actionRequiredCount = complianceItems.where((item) => item["status"] == "Action Required").length;
    
    double totalCost = complianceItems.fold(0.0, (sum, item) => sum + (item["cost"] as double));
    double avgProgress = complianceItems.fold(0.0, (sum, item) => sum + (item["progress"] as int)) / complianceItems.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Statistics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: successColor.withAlpha(100)),
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
                          "Compliant",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$compliantCount",
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
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: dangerColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.cancel, color: dangerColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Non-Compliant",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$nonCompliantCount",
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
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.pending, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$pendingCount",
                      style: TextStyle(
                        fontSize: fsH4,
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
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning, color: infoColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Action Required",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$actionRequiredCount",
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
          
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Overall Progress",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${avgProgress.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    color: secondaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Cost",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: secondaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(totalCost.toDouble()).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Recent Activities
          Text(
            "Recent Compliance Activities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...complianceItems.take(3).map((item) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getStatusColor(item["status"] as String).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      _getStatusIcon(item["status"] as String),
                      color: _getStatusColor(item["status"] as String),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${item["category"]} • Due: ${item["dueDate"]}",
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
                      color: _getStatusColor(item["status"] as String),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${item["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Compliant":
        return Icons.check_circle;
      case "Non-Compliant":
        return Icons.cancel;
      case "Pending Review":
        return Icons.pending;
      case "Action Required":
        return Icons.warning;
      default:
        return Icons.help;
    }
  }

  Widget _buildComplianceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search compliance items...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  _showFilterDialog();
                },
              ),
            ],
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
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Compliance Items List
          Text(
            "Compliance Items (${filteredComplianceItems.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          if (filteredComplianceItems.isEmpty)
            Container(
              padding: EdgeInsets.all(sp2xl),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No compliance items found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search or filters",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...filteredComplianceItems.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getStatusColor(item["status"] as String).withAlpha(20),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor(item["status"] as String),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${item["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(item["priority"] as String),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${item["priority"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${item["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${item["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spSm),
                          
                          // Progress Bar
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Progress",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${item["progress"]}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              LinearProgressIndicator(
                                value: (item["progress"] as int) / 100,
                                backgroundColor: disabledColor.withAlpha(50),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _getStatusColor(item["status"] as String),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Icon(Icons.person, size: 16, color: disabledColor),
                              SizedBox(width: spXs),
                              Text(
                                "${item["assignedTo"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.schedule, size: 16, color: disabledColor),
                              SizedBox(width: spXs),
                              Text(
                                "Due: ${item["dueDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () => _showComplianceDetails(item),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Compliance Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Compliance Items", icon: Icon(Icons.rule)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildComplianceTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Compliance Items"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Status",
              items: statusOptions,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Category",
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              selectedStatus = "All";
              selectedCategory = "All";
              setState(() {});
              back();
            },
            child: Text("Clear All"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }
}
