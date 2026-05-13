import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCorporateCasesView extends StatefulWidget {
  const LcaCorporateCasesView({super.key});

  @override
  State<LcaCorporateCasesView> createState() => _LcaCorporateCasesViewState();
}

class _LcaCorporateCasesViewState extends State<LcaCorporateCasesView> {
  String selectedCompanyType = "All";
  String selectedCaseType = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  bool showActiveOnly = true;

  List<Map<String, dynamic>> companyTypeItems = [
    {"label": "All", "value": "All"},
    {"label": "Corporation", "value": "Corporation"},
    {"label": "LLC", "value": "LLC"},
    {"label": "Partnership", "value": "Partnership"},
    {"label": "Startup", "value": "Startup"},
    {"label": "Non-Profit", "value": "Non-Profit"},
  ];

  List<Map<String, dynamic>> caseTypeItems = [
    {"label": "All", "value": "All"},
    {"label": "Contract Disputes", "value": "Contract"},
    {"label": "Employment Law", "value": "Employment"},
    {"label": "Intellectual Property", "value": "IP"},
    {"label": "Mergers & Acquisitions", "value": "M&A"},
    {"label": "Securities Compliance", "value": "Securities"},
    {"label": "Tax Disputes", "value": "Tax"},
    {"label": "Regulatory Compliance", "value": "Regulatory"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "On Hold", "value": "On Hold"},
    {"label": "Settled", "value": "Settled"},
    {"label": "Closed", "value": "Closed"},
  ];

  List<Map<String, dynamic>> corporateCases = [
    {
      "id": "CORP-2024-001",
      "clientName": "TechVenture Corp",
      "companyType": "Corporation",
      "caseType": "Contract",
      "description": "Breach of software licensing agreement",
      "status": "Active",
      "priority": "High",
      "leadAttorney": "Sarah Mitchell",
      "teamSize": 4,
      "contractValue": 2500000.0,
      "estimatedValue": 3200000.0,
      "filingDate": "2024-01-15",
      "lastUpdate": "2024-03-20",
      "nextMilestone": "Mediation Scheduled",
      "deadline": "2024-04-15",
      "riskLevel": "Medium",
      "complianceStatus": "Compliant",
      "documents": 47,
      "billedHours": 156.5,
      "remainingBudget": 85000.0,
    },
    {
      "id": "CORP-2024-002",
      "clientName": "GreenEnergy LLC",
      "companyType": "LLC",
      "caseType": "Regulatory",
      "description": "Environmental compliance review",
      "status": "Pending",
      "priority": "Medium",
      "leadAttorney": "Michael Chen",
      "teamSize": 3,
      "contractValue": 850000.0,
      "estimatedValue": 950000.0,
      "filingDate": "2024-02-01",
      "lastUpdate": "2024-03-18",
      "nextMilestone": "EPA Review",
      "deadline": "2024-05-30",
      "riskLevel": "High",
      "complianceStatus": "Under Review",
      "documents": 32,
      "billedHours": 89.0,
      "remainingBudget": 125000.0,
    },
    {
      "id": "CORP-2024-003",
      "clientName": "InnovateTech Startup",
      "companyType": "Startup",
      "caseType": "IP",
      "description": "Patent infringement defense",
      "status": "Active",
      "priority": "High",
      "leadAttorney": "David Rodriguez",
      "teamSize": 5,
      "contractValue": 1800000.0,
      "estimatedValue": 2100000.0,
      "filingDate": "2024-01-20",
      "lastUpdate": "2024-03-19",
      "nextMilestone": "Discovery Phase",
      "deadline": "2024-06-15",
      "riskLevel": "High",
      "complianceStatus": "Compliant",
      "documents": 68,
      "billedHours": 234.5,
      "remainingBudget": 95000.0,
    },
    {
      "id": "CORP-2024-004",
      "clientName": "GlobalTrade Partners",
      "companyType": "Partnership",
      "caseType": "M&A",
      "description": "Acquisition due diligence",
      "status": "Active",
      "priority": "Critical",
      "leadAttorney": "Emma Thompson",
      "teamSize": 8,
      "contractValue": 5000000.0,
      "estimatedValue": 5500000.0,
      "filingDate": "2024-02-15",
      "lastUpdate": "2024-03-21",
      "nextMilestone": "Financial Review",
      "deadline": "2024-04-30",
      "riskLevel": "Medium",
      "complianceStatus": "Compliant",
      "documents": 156,
      "billedHours": 312.0,
      "remainingBudget": 275000.0,
    },
    {
      "id": "CORP-2024-005",
      "clientName": "HealthCare Foundation",
      "companyType": "Non-Profit",
      "caseType": "Employment",
      "description": "Workplace discrimination claim",
      "status": "Settled",
      "priority": "Medium",
      "leadAttorney": "Lisa Wang",
      "teamSize": 2,
      "contractValue": 450000.0,
      "estimatedValue": 520000.0,
      "filingDate": "2023-11-10",
      "lastUpdate": "2024-03-15",
      "nextMilestone": "Settlement Complete",
      "deadline": "2024-03-31",
      "riskLevel": "Low",
      "complianceStatus": "Compliant",
      "documents": 28,
      "billedHours": 145.5,
      "remainingBudget": 15000.0,
    },
    {
      "id": "CORP-2024-006",
      "clientName": "FinanceSecure Corp",
      "companyType": "Corporation",
      "caseType": "Securities",
      "description": "SEC compliance investigation",
      "status": "On Hold",
      "priority": "High",
      "leadAttorney": "Robert Kim",
      "teamSize": 6,
      "contractValue": 3200000.0,
      "estimatedValue": 3800000.0,
      "filingDate": "2024-01-05",
      "lastUpdate": "2024-03-10",
      "nextMilestone": "Awaiting SEC Response",
      "deadline": "2024-07-15",
      "riskLevel": "High",
      "complianceStatus": "Under Investigation",
      "documents": 89,
      "billedHours": 198.0,
      "remainingBudget": 180000.0,
    },
  ];

  List<Map<String, dynamic>> get filteredCases {
    return corporateCases.where((case_) {
      bool matchesCompanyType = selectedCompanyType == "All" || case_["companyType"] == selectedCompanyType;
      bool matchesCaseType = selectedCaseType == "All" || case_["caseType"] == selectedCaseType;
      bool matchesStatus = selectedStatus == "All" || case_["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty ||
          case_["clientName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          case_["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          case_["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesActiveFilter = !showActiveOnly || (case_["status"] == "Active" || case_["status"] == "Pending");

      return matchesCompanyType && matchesCaseType && matchesStatus && matchesSearch && matchesActiveFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Corporate Cases"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create corporate case
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterModal();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Corporate Cases Overview Cards
            _buildOverviewCards(),
            SizedBox(height: spLg),

            // Search and Quick Filters
            _buildSearchAndFilters(),
            SizedBox(height: spLg),

            // Active Filter Toggle
            _buildActiveFilter(),
            SizedBox(height: spLg),

            // Cases Statistics
            _buildCasesStatistics(),
            SizedBox(height: spLg),

            // Corporate Cases List
            _buildCasesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCards() {
    int totalCases = corporateCases.length;
    int activeCases = corporateCases.where((c) => c["status"] == "Active").length;
    int pendingCases = corporateCases.where((c) => c["status"] == "Pending").length;
    double totalContractValue = corporateCases.fold(0.0, (sum, c) => sum + (c["contractValue"] as double));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Corporate Legal Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          minItemWidth: 200,
          children: [
            _buildOverviewCard(
              "Total Cases",
              "$totalCases",
              Icons.business_center,
              primaryColor,
            ),
            _buildOverviewCard(
              "Active Cases", 
              "$activeCases",
              Icons.trending_up,
              successColor,
            ),
            _buildOverviewCard(
              "Pending Review",
              "$pendingCases",
              Icons.schedule,
              warningColor,
            ),
            _buildOverviewCard(
              "Contract Value",
              "\$${(totalContractValue / 1000000).toStringAsFixed(1)}M",
              Icons.attach_money,
              infoColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
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
              Spacer(),
              Icon(
                Icons.more_vert,
                color: disabledBoldColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Search & Filter Cases",
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
              child: QTextField(
                label: "Search cases...",
                value: searchQuery,
                hint: "Search by client name, case ID, or description",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.search,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          minItemWidth: 200,
          children: [
            QDropdownField(
              label: "Company Type",
              items: companyTypeItems,
              value: selectedCompanyType,
              onChanged: (value, label) {
                selectedCompanyType = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Case Type",
              items: caseTypeItems,
              value: selectedCaseType,
              onChanged: (value, label) {
                selectedCaseType = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Status",
              items: statusItems,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActiveFilter() {
    return Row(
      children: [
        Expanded(
          child: QSwitch(
            items: [
              {
                "label": "Show Active Cases Only",
                "value": true,
                "checked": showActiveOnly,
              }
            ],
            value: [
              if (showActiveOnly)
                {"label": "Show Active Cases Only", "value": true, "checked": true}
            ],
            onChanged: (values, ids) {
              showActiveOnly = values.isNotEmpty;
              setState(() {});
            },
          ),
        ),
        Spacer(),
        Text(
          "${filteredCases.length} cases found",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCasesStatistics() {
    Map<String, int> typeStats = {};
    Map<String, int> statusStats = {};
    
    for (var case_ in filteredCases) {
      String type = case_["caseType"];
      String status = case_["status"];
      
      typeStats[type] = (typeStats[type] ?? 0) + 1;
      statusStats[status] = (statusStats[status] ?? 0) + 1;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Case Distribution",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          minItemWidth: 200,
          children: [
            _buildStatisticsCard("By Type", typeStats, [
              primaryColor, successColor, warningColor, infoColor, dangerColor, secondaryColor
            ]),
            _buildStatisticsCard("By Status", statusStats, [
              successColor, warningColor, infoColor, dangerColor, disabledBoldColor
            ]),
          ],
        ),
      ],
    );
  }

  Widget _buildStatisticsCard(String title, Map<String, int> stats, List<Color> colors) {
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
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...stats.entries.map((entry) {
            int index = stats.keys.toList().indexOf(entry.key);
            Color color = colors[index % colors.length];
            
            return Padding(
              padding: EdgeInsets.only(bottom: spXs),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    "${entry.value}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
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

  Widget _buildCasesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Corporate Cases",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...filteredCases.map((case_) => _buildCaseCard(case_)).toList(),
      ],
    );
  }

  Widget _buildCaseCard(Map<String, dynamic> case_) {
    Color statusColor = _getStatusColor(case_["status"]);
    Color priorityColor = _getPriorityColor(case_["priority"]);
    Color riskColor = _getRiskColor(case_["riskLevel"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${case_["clientName"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${case_["id"]} • ${case_["companyType"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${case_["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${case_["priority"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: priorityColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Case Details
          Text(
            "${case_["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          // Case Type and Lead Attorney
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Case Type",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${case_["caseType"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
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
                      "Lead Attorney",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${case_["leadAttorney"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Financial Information
          ResponsiveGridView(
            minItemWidth: 150,
            children: [
              _buildDetailItem("Contract Value", "\$${((case_["contractValue"] as double) / 1000).toStringAsFixed(0)}K"),
              _buildDetailItem("Estimated Value", "\$${((case_["estimatedValue"] as double) / 1000).toStringAsFixed(0)}K"),
              _buildDetailItem("Billed Hours", "${(case_["billedHours"] as double).toStringAsFixed(1)}h"),
              _buildDetailItem("Remaining Budget", "\$${((case_["remainingBudget"] as double) / 1000).toStringAsFixed(0)}K"),
            ],
          ),
          SizedBox(height: spSm),

          // Additional Details
          ResponsiveGridView(
            minItemWidth: 150,
            children: [
              _buildDetailItem("Team Size", "${case_["teamSize"]} members"),
              _buildDetailItem("Documents", "${case_["documents"]} files"),
              _buildDetailItem("Risk Level", "${case_["riskLevel"]}", textColor: riskColor),
              _buildDetailItem("Compliance", "${case_["complianceStatus"]}", 
                textColor: case_["complianceStatus"] == "Compliant" ? successColor : warningColor),
            ],
          ),
          SizedBox(height: spSm),

          // Timeline Information
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Next Milestone",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${case_["nextMilestone"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
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
                      "Deadline",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${case_["deadline"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to case details
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Edit Case",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to edit case
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showCaseMenu(case_);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, {Color? textColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: textColor ?? primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "On Hold":
        return infoColor;
      case "Settled":
        return primaryColor;
      case "Closed":
        return disabledBoldColor;
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

  Color _getRiskColor(String risk) {
    switch (risk) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFilterModal() {
    // Show advanced filter modal
    ss("Advanced filters modal would open here");
  }

  void _showCaseMenu(Map<String, dynamic> case_) {
    // Show case action menu
    ss("Case menu for ${case_["id"]} would open here");
  }
}
