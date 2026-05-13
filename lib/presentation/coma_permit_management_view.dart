import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaPermitManagementView extends StatefulWidget {
  const ComaPermitManagementView({super.key});

  @override
  State<ComaPermitManagementView> createState() => _ComaPermitManagementViewState();
}

class _ComaPermitManagementViewState extends State<ComaPermitManagementView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  String selectedPriority = "All";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Rejected", "value": "Rejected"},
    {"label": "Under Review", "value": "Under Review"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Building Permit", "value": "Building Permit"},
    {"label": "Demolition Permit", "value": "Demolition Permit"},
    {"label": "Electrical Permit", "value": "Electrical Permit"},
    {"label": "Plumbing Permit", "value": "Plumbing Permit"},
    {"label": "Excavation Permit", "value": "Excavation Permit"},
    {"label": "Environmental Permit", "value": "Environmental Permit"},
    {"label": "Fire Safety Permit", "value": "Fire Safety Permit"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> permits = [
    {
      "id": "BP-2024-001",
      "title": "Main Building Construction Permit",
      "type": "Building Permit",
      "status": "Active",
      "priority": "Critical",
      "issuedDate": "2024-01-15",
      "expiryDate": "2024-12-15",
      "issuingAuthority": "City Planning Department",
      "contactPerson": "John Smith",
      "contactPhone": "(555) 123-4567",
      "description": "Permit for construction of 5-story commercial building",
      "conditions": [
        "Construction must comply with current building codes",
        "Regular inspections required at key milestones",
        "Noise restrictions: 7 AM to 6 PM weekdays only",
        "Traffic management plan must be implemented",
        "Environmental protection measures required"
      ],
      "documents": [
        "Building_Permit_BP-2024-001.pdf",
        "Architectural_Plans_v3.pdf",
        "Structural_Engineering_Report.pdf"
      ],
      "inspections": [
        {"date": "2024-02-01", "type": "Foundation", "status": "Passed"},
        {"date": "2024-02-15", "type": "Framing", "status": "Passed"},
        {"date": "2024-03-01", "type": "Electrical Rough-in", "status": "Scheduled"}
      ],
      "fees": 15000.0,
      "renewalRequired": false,
      "daysUntilExpiry": 298
    },
    {
      "id": "EP-2024-002",
      "title": "Electrical Installation Permit",
      "type": "Electrical Permit", 
      "status": "Pending",
      "priority": "High",
      "issuedDate": null,
      "expiryDate": null,
      "issuingAuthority": "Electrical Safety Authority",
      "contactPerson": "Sarah Johnson",
      "contactPhone": "(555) 234-5678",
      "description": "Permit for electrical system installation in commercial building",
      "conditions": [
        "Licensed electrician must perform all work",
        "Electrical plans must be approved before installation",
        "Inspection required before energizing",
        "Compliance with National Electrical Code required"
      ],
      "documents": [
        "Electrical_Plans_Draft.pdf",
        "Load_Calculation_Report.pdf"
      ],
      "inspections": [],
      "fees": 2500.0,
      "renewalRequired": false,
      "daysUntilExpiry": null,
      "applicationDate": "2024-02-10",
      "expectedApproval": "2024-02-25"
    },
    {
      "id": "PP-2024-003",
      "title": "Plumbing System Permit",
      "type": "Plumbing Permit",
      "status": "Under Review",
      "priority": "Medium",
      "issuedDate": null,
      "expiryDate": null,
      "issuingAuthority": "Municipal Water Department",
      "contactPerson": "Mike Wilson",
      "contactPhone": "(555) 345-6789",
      "description": "Permit for plumbing system installation and water service connection",
      "conditions": [
        "Licensed plumber must perform installation",
        "Water meter installation by city crews only",
        "Backflow prevention device required",
        "Pressure testing required before activation"
      ],
      "documents": [
        "Plumbing_Plans_v2.pdf",
        "Water_Service_Application.pdf",
        "Backflow_Prevention_Specs.pdf"
      ],
      "inspections": [],
      "fees": 1800.0,
      "renewalRequired": false,
      "daysUntilExpiry": null,
      "applicationDate": "2024-02-12",
      "expectedApproval": "2024-02-28"
    },
    {
      "id": "DP-2024-004",
      "title": "Old Structure Demolition Permit",
      "type": "Demolition Permit",
      "status": "Expired",
      "priority": "Low",
      "issuedDate": "2023-08-15",
      "expiryDate": "2024-02-15",
      "issuingAuthority": "Building Safety Department",
      "contactPerson": "Lisa Brown",
      "contactPhone": "(555) 456-7890",
      "description": "Permit for demolition of existing warehouse structure",
      "conditions": [
        "Hazardous material survey required",
        "Dust control measures mandatory",
        "Utility disconnection before demolition",
        "Debris disposal at approved facilities only"
      ],
      "documents": [
        "Demolition_Permit_DP-2024-004.pdf",
        "Hazmat_Survey_Report.pdf",
        "Demolition_Plan.pdf"
      ],
      "inspections": [
        {"date": "2023-08-20", "type": "Pre-demolition", "status": "Passed"},
        {"date": "2023-09-15", "type": "Final", "status": "Passed"}
      ],
      "fees": 3500.0,
      "renewalRequired": true,
      "daysUntilExpiry": -7
    },
    {
      "id": "EV-2024-005",
      "title": "Site Excavation Permit",
      "type": "Excavation Permit",
      "status": "Active",
      "priority": "High",
      "issuedDate": "2024-01-20",
      "expiryDate": "2024-06-20",
      "issuingAuthority": "Public Works Department",
      "contactPerson": "David Chen",
      "contactPhone": "(555) 567-8901",
      "description": "Permit for site excavation and foundation preparation",
      "conditions": [
        "Call before you dig - utility location required",
        "Shoring system required for depths over 5 feet",
        "Soil erosion control measures mandatory",
        "Traffic control plan implementation required"
      ],
      "documents": [
        "Excavation_Permit_EV-2024-005.pdf",
        "Soil_Report.pdf",
        "Shoring_Plan.pdf",
        "Traffic_Control_Plan.pdf"
      ],
      "inspections": [
        {"date": "2024-01-25", "type": "Pre-excavation", "status": "Passed"},
        {"date": "2024-02-10", "type": "Shoring", "status": "Passed"}
      ],
      "fees": 4200.0,
      "renewalRequired": false,
      "daysUntilExpiry": 131
    },
    {
      "id": "EN-2024-006",
      "title": "Environmental Impact Permit",
      "type": "Environmental Permit",
      "status": "Rejected",
      "priority": "Critical",
      "issuedDate": null,
      "expiryDate": null,
      "issuingAuthority": "Environmental Protection Agency",
      "contactPerson": "Maria Garcia",
      "contactPhone": "(555) 678-9012",
      "description": "Permit for construction activities with environmental considerations",
      "conditions": [
        "Environmental impact assessment required",
        "Wildlife habitat protection measures",
        "Water quality monitoring during construction",
        "Air quality standards compliance"
      ],
      "documents": [
        "Environmental_Assessment_v1.pdf",
        "Rejection_Letter.pdf",
        "Required_Modifications.pdf"
      ],
      "inspections": [],
      "fees": 8500.0,
      "renewalRequired": false,
      "daysUntilExpiry": null,
      "applicationDate": "2024-01-05",
      "rejectionDate": "2024-02-18",
      "rejectionReason": "Additional environmental impact studies required"
    }
  ];

  List<Map<String, dynamic>> get filteredPermits {
    return permits.where((permit) {
      bool matchesSearch = searchQuery.isEmpty ||
          (permit["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (permit["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (permit["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || permit["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || permit["type"] == selectedType;
      bool matchesPriority = selectedPriority == "All" || permit["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesType && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "Expired":
        return dangerColor;
      case "Rejected":
        return dangerColor;
      case "Under Review":
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

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Active":
        return Icons.check_circle;
      case "Pending":
        return Icons.schedule;
      case "Expired":
        return Icons.warning;
      case "Rejected":
        return Icons.cancel;
      case "Under Review":
        return Icons.visibility;
      default:
        return Icons.help;
    }
  }

  void _showPermitDetails(Map<String, dynamic> permit) {
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
                color: _getStatusColor(permit["status"] as String),
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${permit["id"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                        Text(
                          "${permit["title"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${permit["type"]} • ${permit["priority"]} Priority",
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
                    // Status and Dates
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getStatusColor(permit["status"] as String).withAlpha(20),
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
                                    color: _getStatusColor(permit["status"] as String),
                                  ),
                                ),
                                Text(
                                  "${permit["status"]}",
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
                                  permit["status"] == "Active" ? "Days Until Expiry" : "Priority",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  permit["status"] == "Active" 
                                      ? "${permit["daysUntilExpiry"]} days"
                                      : "${permit["priority"]}",
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
                      "${permit["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: spLg),
                    
                    // Contact Information
                    Text(
                      "Issuing Authority",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: infoColor.withAlpha(100)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${permit["issuingAuthority"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.person, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${permit["contactPerson"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${permit["contactPhone"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              QButton(
                                icon: Icons.call,
                                size: bs.sm,
                                onPressed: () {
                                  // Call contact
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spLg),
                    
                    // Dates Information
                    if (permit["issuedDate"] != null || permit["expiryDate"] != null) ...[
                      Text(
                        "Important Dates",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          if (permit["issuedDate"] != null)
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
                                      "Issued Date",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                    Text(
                                      "${permit["issuedDate"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (permit["issuedDate"] != null && permit["expiryDate"] != null)
                            SizedBox(width: spSm),
                          if (permit["expiryDate"] != null)
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
                                      "Expiry Date",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                    Text(
                                      "${permit["expiryDate"]}",
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
                    ],
                    
                    // Conditions
                    Text(
                      "Permit Conditions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(permit["conditions"] as List).asMap().entries.map((entry) {
                      int index = entry.key;
                      String condition = entry.value;
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
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                condition,
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
                    
                    // Documents
                    Text(
                      "Related Documents",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(permit["documents"] as List).map((document) {
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
                    
                    // Inspections (if any)
                    if ((permit["inspections"] as List).isNotEmpty) ...[
                      Text(
                        "Inspections",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...(permit["inspections"] as List).map((inspection) {
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
                              Icon(
                                inspection["status"] == "Passed" 
                                    ? Icons.check_circle 
                                    : inspection["status"] == "Scheduled"
                                        ? Icons.schedule
                                        : Icons.cancel,
                                color: inspection["status"] == "Passed" 
                                    ? successColor
                                    : inspection["status"] == "Scheduled"
                                        ? warningColor
                                        : dangerColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${inspection["type"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${inspection["date"]} • ${inspection["status"]}",
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
                        );
                      }).toList(),
                      SizedBox(height: spLg),
                    ],
                    
                    // Fee Information
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.payment, color: secondaryColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Permit Fees",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor,
                                  ),
                                ),
                                Text(
                                  "\$${((permit["fees"] as double).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spLg),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: permit["renewalRequired"] == true 
                                ? "Renew Permit" 
                                : permit["status"] == "Rejected"
                                    ? "Reapply"
                                    : "Update Status",
                            size: bs.sm,
                            onPressed: () {
                              // Handle action based on permit status
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Contact Authority",
                            size: bs.sm,
                            onPressed: () {
                              // Contact issuing authority
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

  void _showCreatePermitDialog() {
    String permitTitle = "";
    String permitType = "";
    String permitDescription = "";
    String contactPerson = "";
    String contactPhone = "";
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Apply for New Permit",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QTextField(
                label: "Permit Title",
                value: permitTitle,
                onChanged: (value) {
                  permitTitle = value;
                },
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Permit Type",
                items: typeOptions.where((item) => item["value"] != "All").toList(),
                value: permitType,
                onChanged: (value, label) {
                  permitType = value;
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Description",
                value: permitDescription,
                onChanged: (value) {
                  permitDescription = value;
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Contact Person",
                value: contactPerson,
                onChanged: (value) {
                  contactPerson = value;
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Contact Phone",
                value: contactPhone,
                onChanged: (value) {
                  contactPhone = value;
                },
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => back(),
                      child: Text("Cancel"),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Submit Application",
                      size: bs.sm,
                      onPressed: () {
                        // Submit permit application
                        back();
                        ss("Permit application submitted successfully");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int activeCount = permits.where((p) => p["status"] == "Active").length;
    int pendingCount = permits.where((p) => p["status"] == "Pending" || p["status"] == "Under Review").length;
    int expiredCount = permits.where((p) => p["status"] == "Expired").length;
    int rejectedCount = permits.where((p) => p["status"] == "Rejected").length;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Permit Management"),
        actions: [
          IconButton(
            onPressed: _showCreatePermitDialog,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                            "Active",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$activeCount",
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
                          Icon(Icons.schedule, color: warningColor, size: 20),
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
                          Icon(Icons.warning, color: dangerColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Expired",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$expiredCount",
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
                          Icon(Icons.cancel, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Rejected",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$rejectedCount",
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
            
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search permits...",
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
                    label: "Type",
                    items: typeOptions,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            // Permits List
            Text(
              "Permits (${filteredPermits.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            if (filteredPermits.isEmpty)
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
                      "No permits found",
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
              ...filteredPermits.map((permit) {
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
                          color: _getStatusColor(permit["status"] as String).withAlpha(20),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _getStatusIcon(permit["status"] as String),
                              color: _getStatusColor(permit["status"] as String),
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor(permit["status"] as String),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${permit["status"]}",
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
                                color: _getPriorityColor(permit["priority"] as String),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${permit["priority"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${permit["id"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
                              "${permit["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${permit["type"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${permit["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.business, size: 16, color: disabledColor),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${permit["issuingAuthority"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ),
                                if (permit["expiryDate"] != null) ...[
                                  Icon(Icons.schedule, size: 16, color: disabledColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Expires: ${permit["expiryDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () => _showPermitDetails(permit),
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
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Permits"),
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
              label: "Type",
              items: typeOptions,
              value: selectedType,
              onChanged: (value, label) {
                selectedType = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Priority",
              items: priorityOptions,
              value: selectedPriority,
              onChanged: (value, label) {
                selectedPriority = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              selectedStatus = "All";
              selectedType = "All";
              selectedPriority = "All";
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
