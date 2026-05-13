import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaContractsView extends StatefulWidget {
  const ComaContractsView({super.key});

  @override
  State<ComaContractsView> createState() => _ComaContractsViewState();
}

class _ComaContractsViewState extends State<ComaContractsView> {
  String searchQuery = "";
  String selectedType = "";
  String selectedStatus = "";
  String selectedPriority = "";

  List<Map<String, dynamic>> contractTypes = [
    {"label": "All Types", "value": ""},
    {"label": "Construction", "value": "construction"},
    {"label": "Service", "value": "service"},
    {"label": "Supply", "value": "supply"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Consulting", "value": "consulting"},
    {"label": "Equipment", "value": "equipment"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "active"},
    {"label": "Pending", "value": "pending"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Approved", "value": "approved"},
    {"label": "Expired", "value": "expired"},
    {"label": "Terminated", "value": "terminated"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": ""},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> contracts = [
    {
      "id": "CON-001",
      "title": "Hospital Foundation Construction",
      "contractor": "BuildTech Construction Ltd",
      "type": "construction",
      "status": "active",
      "priority": "critical",
      "start_date": "2024-01-15",
      "end_date": "2024-12-15",
      "contract_value": 2500000.0,
      "paid_amount": 1200000.0,
      "remaining_amount": 1300000.0,
      "project": "Metro Hospital Complex",
      "contract_manager": "Sarah Johnson",
      "project_manager": "Michael Zhang",
      "progress_percentage": 48,
      "description": "Complete foundation construction including excavation, concrete works, and structural elements",
      "payment_terms": "Monthly progress payments",
      "warranty_period": "24 months",
      "retention_percentage": 5.0,
      "retention_amount": 125000.0,
      "insurance_coverage": 5000000.0,
      "bond_amount": 250000.0,
      "variations_count": 3,
      "variations_value": 150000.0,
      "claims_count": 1,
      "claims_value": 45000.0,
      "milestones": [
        {"name": "Excavation Complete", "status": "completed", "date": "2024-02-28"},
        {"name": "Foundation Concrete", "status": "in_progress", "date": "2024-04-15"},
        {"name": "Structural Works", "status": "pending", "date": "2024-08-30"},
        {"name": "Final Completion", "status": "pending", "date": "2024-12-15"}
      ],
      "risk_level": "medium",
      "performance_rating": 4.2
    },
    {
      "id": "CON-002",
      "title": "HVAC System Installation & Maintenance",
      "contractor": "Climate Control Solutions",
      "type": "service",
      "status": "active",
      "priority": "high",
      "start_date": "2024-02-01",
      "end_date": "2027-02-01",
      "contract_value": 850000.0,
      "paid_amount": 280000.0,
      "remaining_amount": 570000.0,
      "project": "Office Complex Phase 2",
      "contract_manager": "Lisa Chen",
      "project_manager": "Robert Brown",
      "progress_percentage": 33,
      "description": "Complete HVAC system installation and 3-year maintenance service contract",
      "payment_terms": "Quarterly payments",
      "warranty_period": "36 months",
      "retention_percentage": 10.0,
      "retention_amount": 85000.0,
      "insurance_coverage": 2000000.0,
      "bond_amount": 85000.0,
      "variations_count": 2,
      "variations_value": 75000.0,
      "claims_count": 0,
      "claims_value": 0.0,
      "milestones": [
        {"name": "Design Approval", "status": "completed", "date": "2024-02-15"},
        {"name": "Equipment Delivery", "status": "completed", "date": "2024-03-30"},
        {"name": "Installation Phase 1", "status": "in_progress", "date": "2024-06-15"},
        {"name": "Commissioning", "status": "pending", "date": "2024-09-30"}
      ],
      "risk_level": "low",
      "performance_rating": 4.7
    },
    {
      "id": "CON-003",
      "title": "Electrical Equipment Supply",
      "contractor": "PowerTech Electrical Supplies",
      "type": "supply",
      "status": "under_review",
      "priority": "high",
      "start_date": "2024-03-01",
      "end_date": "2024-08-31",
      "contract_value": 450000.0,
      "paid_amount": 0.0,
      "remaining_amount": 450000.0,
      "project": "Industrial Facility Upgrade",
      "contract_manager": "David Wilson",
      "project_manager": "Emma Thompson",
      "progress_percentage": 0,
      "description": "Supply of high-voltage electrical equipment including transformers, switchgear, and control panels",
      "payment_terms": "50% advance, 50% on delivery",
      "warranty_period": "12 months",
      "retention_percentage": 0.0,
      "retention_amount": 0.0,
      "insurance_coverage": 1000000.0,
      "bond_amount": 45000.0,
      "variations_count": 0,
      "variations_value": 0.0,
      "claims_count": 0,
      "claims_value": 0.0,
      "milestones": [
        {"name": "Order Confirmation", "status": "pending", "date": "2024-03-15"},
        {"name": "Manufacturing", "status": "pending", "date": "2024-05-30"},
        {"name": "Quality Testing", "status": "pending", "date": "2024-07-15"},
        {"name": "Delivery", "status": "pending", "date": "2024-08-31"}
      ],
      "risk_level": "medium",
      "performance_rating": 0.0
    },
    {
      "id": "CON-004",
      "title": "Bridge Maintenance Services",
      "contractor": "Infrastructure Maintenance Group",
      "type": "maintenance",
      "status": "approved",
      "priority": "medium",
      "start_date": "2024-04-01",
      "end_date": "2029-03-31",
      "contract_value": 1200000.0,
      "paid_amount": 240000.0,
      "remaining_amount": 960000.0,
      "project": "City Bridge Network",
      "contract_manager": "Jennifer Kim",
      "project_manager": "Alex Rodriguez",
      "progress_percentage": 20,
      "description": "Comprehensive 5-year maintenance contract for city bridge network including inspections and repairs",
      "payment_terms": "Annual payments",
      "warranty_period": "12 months per service",
      "retention_percentage": 5.0,
      "retention_amount": 60000.0,
      "insurance_coverage": 3000000.0,
      "bond_amount": 120000.0,
      "variations_count": 1,
      "variations_value": 25000.0,
      "claims_count": 0,
      "claims_value": 0.0,
      "milestones": [
        {"name": "Initial Assessment", "status": "completed", "date": "2024-04-30"},
        {"name": "Year 1 Maintenance", "status": "in_progress", "date": "2024-12-31"},
        {"name": "Year 2 Maintenance", "status": "pending", "date": "2025-12-31"},
        {"name": "Final Assessment", "status": "pending", "date": "2029-03-31"}
      ],
      "risk_level": "low",
      "performance_rating": 4.5
    },
    {
      "id": "CON-005",
      "title": "Environmental Consulting Services",
      "contractor": "EcoConsult Environmental",
      "type": "consulting",
      "status": "pending",
      "priority": "medium",
      "start_date": "2024-05-01",
      "end_date": "2024-11-30",
      "contract_value": 180000.0,
      "paid_amount": 0.0,
      "remaining_amount": 180000.0,
      "project": "Green Building Certification",
      "contract_manager": "Carlos Martinez",
      "project_manager": "Linda Davis",
      "progress_percentage": 0,
      "description": "Environmental impact assessment and green building certification consulting services",
      "payment_terms": "Monthly milestone payments",
      "warranty_period": "6 months",
      "retention_percentage": 10.0,
      "retention_amount": 18000.0,
      "insurance_coverage": 500000.0,
      "bond_amount": 18000.0,
      "variations_count": 0,
      "variations_value": 0.0,
      "claims_count": 0,
      "claims_value": 0.0,
      "milestones": [
        {"name": "Site Assessment", "status": "pending", "date": "2024-05-31"},
        {"name": "Impact Analysis", "status": "pending", "date": "2024-07-31"},
        {"name": "Certification Application", "status": "pending", "date": "2024-09-30"},
        {"name": "Final Report", "status": "pending", "date": "2024-11-30"}
      ],
      "risk_level": "low",
      "performance_rating": 0.0
    },
    {
      "id": "CON-006",
      "title": "Heavy Equipment Rental",
      "contractor": "MegaEquip Rentals",
      "type": "equipment",
      "status": "expired",
      "priority": "low",
      "start_date": "2023-06-01",
      "end_date": "2024-01-31",
      "contract_value": 320000.0,
      "paid_amount": 320000.0,
      "remaining_amount": 0.0,
      "project": "Site Preparation Works",
      "contract_manager": "Sophie Wilson",
      "project_manager": "James Taylor",
      "progress_percentage": 100,
      "description": "8-month rental of heavy equipment including excavators, bulldozers, and dump trucks",
      "payment_terms": "Monthly rental payments",
      "warranty_period": "Equipment warranty",
      "retention_percentage": 0.0,
      "retention_amount": 0.0,
      "insurance_coverage": 1500000.0,
      "bond_amount": 32000.0,
      "variations_count": 2,
      "variations_value": 40000.0,
      "claims_count": 1,
      "claims_value": 15000.0,
      "milestones": [
        {"name": "Equipment Delivery", "status": "completed", "date": "2023-06-15"},
        {"name": "Mid-term Inspection", "status": "completed", "date": "2023-10-15"},
        {"name": "Project Completion", "status": "completed", "date": "2024-01-15"},
        {"name": "Equipment Return", "status": "completed", "date": "2024-01-31"}
      ],
      "risk_level": "low",
      "performance_rating": 4.1
    }
  ];

  List<Map<String, dynamic>> get filteredContracts {
    return contracts.where((contract) {
      bool matchesSearch = searchQuery.isEmpty ||
          (contract["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (contract["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (contract["contractor"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (contract["project"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedType.isEmpty || contract["type"] == selectedType;
      bool matchesStatus = selectedStatus.isEmpty || contract["status"] == selectedStatus;
      bool matchesPriority = selectedPriority.isEmpty || contract["priority"] == selectedPriority;
      
      return matchesSearch && matchesType && matchesStatus && matchesPriority;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "active":
      case "approved":
        return successColor;
      case "pending":
      case "under_review":
        return warningColor;
      case "expired":
      case "terminated":
        return dangerColor;
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

  Color getRiskColor(String risk) {
    switch (risk) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalValue = contracts.fold(0.0, (sum, contract) => sum + (contract["contract_value"] as double));
    double totalPaid = contracts.fold(0.0, (sum, contract) => sum + (contract["paid_amount"] as double));
    int activeContracts = contracts.where((c) => c["status"] == "active").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Contracts"),
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
                          Icon(Icons.description, color: primaryColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Total Contracts",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${contracts.length}",
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
                          Icon(Icons.attach_money, color: successColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Total Value",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(totalValue / 1000000).toStringAsFixed(1)}M",
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
                          Icon(Icons.check_circle, color: infoColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Active",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$activeContracts",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
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
                          Icon(Icons.payment, color: warningColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Paid Amount",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(totalPaid / 1000000).toStringAsFixed(1)}M",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
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
                    label: "Search contracts...",
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
                          label: "Type",
                          items: contractTypes,
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

            // Contracts Grid
            ResponsiveGridView(
              minItemWidth: 200,
              children: filteredContracts.map((contract) {
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
                              color: getPriorityColor(contract["priority"]),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.description,
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
                                  "${contract["id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${contract["title"]}",
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
                          color: getStatusColor(contract["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(
                            color: getStatusColor(contract["status"]),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "${contract["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: getStatusColor(contract["status"]),
                          ),
                        ),
                      ),

                      Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.business, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${contract["contractor"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.folder, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${contract["project"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.person, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${contract["contract_manager"]}",
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
                                  "Progress",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${contract["progress_percentage"]}%",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            LinearProgressIndicator(
                              value: (contract["progress_percentage"] as int) / 100,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                (contract["progress_percentage"] as int) >= 80 
                                  ? successColor 
                                  : (contract["progress_percentage"] as int) >= 50 
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
                                  "Value",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((contract["contract_value"] as double) / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
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
                                  "Paid",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((contract["paid_amount"] as double) / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
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
                                  "Risk",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: getRiskColor(contract["risk_level"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${contract["risk_level"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: getRiskColor(contract["risk_level"]),
                                    ),
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
                          label: "View Contract",
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
