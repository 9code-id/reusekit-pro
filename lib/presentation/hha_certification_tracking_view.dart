import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaCertificationTrackingView extends StatefulWidget {
  const HhaCertificationTrackingView({super.key});

  @override
  State<HhaCertificationTrackingView> createState() => _HhaCertificationTrackingViewState();
}

class _HhaCertificationTrackingViewState extends State<HhaCertificationTrackingView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  String selectedEmployee = "All";
  int currentTab = 0;
  
  List<Map<String, dynamic>> categoryOptions = [
    {
      "label": "All Categories",
      "value": "All",
    },
    {
      "label": "Food Safety",
      "value": "food_safety",
    },
    {
      "label": "Fire Safety",
      "value": "fire_safety",
    },
    {
      "label": "First Aid",
      "value": "first_aid",
    },
    {
      "label": "Housekeeping",
      "value": "housekeeping",
    },
    {
      "label": "Customer Service",
      "value": "customer_service",
    },
    {
      "label": "Maintenance",
      "value": "maintenance",
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {
      "label": "All Status",
      "value": "All",
    },
    {
      "label": "Active",
      "value": "active",
    },
    {
      "label": "Expired",
      "value": "expired",
    },
    {
      "label": "Expiring Soon",
      "value": "expiring_soon",
    },
    {
      "label": "Pending Renewal",
      "value": "pending_renewal",
    },
  ];

  List<Map<String, dynamic>> employeeOptions = [
    {
      "label": "All Employees",
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
    {
      "label": "Sarah Johnson",
      "value": "sarah_johnson",
    },
  ];

  List<Map<String, dynamic>> certifications = [
    {
      "id": "CERT001",
      "employee_name": "Maria Santos",
      "employee_id": "EMP001",
      "position": "Housekeeping Supervisor",
      "department": "Housekeeping",
      "certification_name": "Food Safety Manager Certification",
      "category": "food_safety",
      "issuing_authority": "National Restaurant Association",
      "issue_date": "2024-01-15",
      "expiry_date": "2025-01-15",
      "status": "active",
      "renewal_required": true,
      "cost": 150.00,
      "certificate_number": "FSM2024001",
      "attachments": [
        {
          "name": "food_safety_certificate.pdf",
          "type": "certificate",
          "url": "#"
        }
      ]
    },
    {
      "id": "CERT002",
      "employee_name": "John Wilson",
      "employee_id": "EMP002",
      "position": "Maintenance Technician",
      "department": "Maintenance",
      "certification_name": "First Aid & CPR Certification",
      "category": "first_aid",
      "issuing_authority": "American Red Cross",
      "issue_date": "2023-11-20",
      "expiry_date": "2024-11-20",
      "status": "expired",
      "renewal_required": true,
      "cost": 95.00,
      "certificate_number": "ARC2023045",
      "attachments": []
    },
    {
      "id": "CERT003",
      "employee_name": "Lisa Chen",
      "employee_id": "EMP003",
      "position": "Front Desk Manager",
      "department": "Guest Services",
      "certification_name": "Fire Safety Training",
      "category": "fire_safety",
      "issuing_authority": "Local Fire Department",
      "issue_date": "2024-09-10",
      "expiry_date": "2025-03-10",
      "status": "expiring_soon",
      "renewal_required": true,
      "cost": 75.00,
      "certificate_number": "FS2024089",
      "attachments": [
        {
          "name": "fire_safety_certificate.pdf",
          "type": "certificate",
          "url": "#"
        }
      ]
    },
    {
      "id": "CERT004",
      "employee_name": "David Brown",
      "employee_id": "EMP004",
      "position": "Room Attendant",
      "department": "Housekeeping",
      "certification_name": "Professional Housekeeping Certification",
      "category": "housekeeping",
      "issuing_authority": "International Executive Housekeepers Association",
      "issue_date": "2024-06-15",
      "expiry_date": "2026-06-15",
      "status": "active",
      "renewal_required": true,
      "cost": 200.00,
      "certificate_number": "IEHA2024078",
      "attachments": []
    },
    {
      "id": "CERT005",
      "employee_name": "Sarah Johnson",
      "employee_id": "EMP005",
      "position": "Guest Relations Coordinator",
      "department": "Guest Services",
      "certification_name": "Customer Service Excellence",
      "category": "customer_service",
      "issuing_authority": "Hospitality Training Institute",
      "issue_date": "2024-03-20",
      "expiry_date": "2025-01-05",
      "status": "expiring_soon",
      "renewal_required": true,
      "cost": 120.00,
      "certificate_number": "CSE2024032",
      "attachments": [
        {
          "name": "customer_service_certificate.pdf",
          "type": "certificate",
          "url": "#"
        }
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredCertifications {
    return certifications.where((cert) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${cert["employee_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${cert["certification_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${cert["certificate_number"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || cert["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || cert["status"] == selectedStatus;
      bool matchesEmployee = selectedEmployee == "All" || 
          "${cert["employee_name"]}".toLowerCase().replaceAll(' ', '_') == selectedEmployee;
      
      return matchesSearch && matchesCategory && matchesStatus && matchesEmployee;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "expired":
        return dangerColor;
      case "expiring_soon":
        return warningColor;
      case "pending_renewal":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "expiring_soon":
        return "Expiring Soon";
      case "pending_renewal":
        return "Pending Renewal";
      default:
        return status.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
    }
  }

  int _getDaysUntilExpiry(String expiryDate) {
    DateTime expiry = DateTime.parse(expiryDate);
    DateTime now = DateTime.now();
    return expiry.difference(now).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Certification Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add new certification
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
                    label: "Search certifications...",
                    value: searchQuery,
                    hint: "Search by employee, certification, or certificate number",
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
                          items: categoryOptions,
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
                    ],
                  ),
                  QDropdownField(
                    label: "Employee",
                    items: employeeOptions,
                    value: selectedEmployee,
                    onChanged: (value, label) {
                      selectedEmployee = value;
                      setState(() {});
                    },
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
                        Icons.verified,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${certifications.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Certifications",
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
                        "${certifications.where((c) => c["status"] == "active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Active",
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
                        Icons.warning,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${certifications.where((c) => c["status"] == "expiring_soon").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Expiring Soon",
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
                        Icons.error,
                        color: dangerColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${certifications.where((c) => c["status"] == "expired").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Expired",
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

            // Certifications List
            ...filteredCertifications.map((cert) {
              int daysUntilExpiry = _getDaysUntilExpiry("${cert["expiry_date"]}");
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: cert["status"] == "expired" || cert["status"] == "expiring_soon"
                      ? Border.all(
                          color: cert["status"] == "expired" ? dangerColor : warningColor,
                          width: 1,
                        )
                      : null,
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
                                    "${cert["certificate_number"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  if (cert["status"] == "expiring_soon" || cert["status"] == "expired")
                                    Icon(
                                      cert["status"] == "expired" ? Icons.error : Icons.warning,
                                      size: 16,
                                      color: cert["status"] == "expired" ? dangerColor : warningColor,
                                    ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${cert["certification_name"]}",
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
                            color: _getStatusColor("${cert["status"]}").withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            _getStatusLabel("${cert["status"]}"),
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor("${cert["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Employee Information
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: primaryColor.withAlpha(30),
                          child: Text(
                            "${cert["employee_name"]}".split(' ').map((name) => name[0]).join(''),
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${cert["employee_name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${cert["position"]} • ${cert["department"]}",
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

                    // Certification Details
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.business,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${cert["issuing_authority"]}",
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
                                Icons.calendar_today,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Issued: ${DateTime.parse("${cert["issue_date"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Expires: ${DateTime.parse("${cert["expiry_date"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: cert["status"] == "expired" 
                                      ? dangerColor 
                                      : cert["status"] == "expiring_soon"
                                          ? warningColor
                                          : disabledBoldColor,
                                  fontWeight: cert["status"] == "expired" || cert["status"] == "expiring_soon"
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          if (cert["status"] == "expiring_soon")
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "$daysUntilExpiry days until expiry",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          if (cert["status"] == "expired")
                            Row(
                              children: [
                                Icon(
                                  Icons.error,
                                  size: 16,
                                  color: dangerColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Expired ${(-daysUntilExpiry)} days ago",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    // Cost and Attachments
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Cost: \$${((cert["cost"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        if ((cert["attachments"] as List).isNotEmpty)
                          Row(
                            children: [
                              Icon(
                                Icons.attach_file,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(cert["attachments"] as List).length} attachment(s)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: cert["status"] == "expired" || cert["status"] == "expiring_soon"
                                ? "Renew Certificate"
                                : "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to certificate details or renewal
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to edit certification
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            // Download certificate
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

            if (filteredCertifications.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.verified,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No certifications found",
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
          // Navigate to add new certification
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
