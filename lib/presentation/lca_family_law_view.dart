import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaFamilyLawView extends StatefulWidget {
  const LcaFamilyLawView({super.key});

  @override
  State<LcaFamilyLawView> createState() => _LcaFamilyLawViewState();
}

class _LcaFamilyLawViewState extends State<LcaFamilyLawView> {
  String selectedCaseType = "All";
  String selectedStatus = "All";
  String selectedUrgency = "All";
  String searchQuery = "";
  bool showChildrenInvolved = false;
  bool showHighPriority = false;

  List<Map<String, dynamic>> caseTypeItems = [
    {"label": "All", "value": "All"},
    {"label": "Divorce", "value": "Divorce"},
    {"label": "Child Custody", "value": "Custody"},
    {"label": "Child Support", "value": "Support"},
    {"label": "Adoption", "value": "Adoption"},
    {"label": "Domestic Violence", "value": "DV"},
    {"label": "Prenuptial Agreement", "value": "Prenup"},
    {"label": "Property Division", "value": "Property"},
    {"label": "Spousal Support", "value": "Alimony"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Mediation", "value": "Mediation"},
    {"label": "Court Scheduled", "value": "Court"},
    {"label": "Settled", "value": "Settled"},
    {"label": "Closed", "value": "Closed"},
  ];

  List<Map<String, dynamic>> urgencyItems = [
    {"label": "All", "value": "All"},
    {"label": "Emergency", "value": "Emergency"},
    {"label": "Urgent", "value": "Urgent"},
    {"label": "Standard", "value": "Standard"},
    {"label": "Low Priority", "value": "Low"},
  ];

  List<Map<String, dynamic>> familyLawCases = [
    {
      "id": "FAM-2024-001",
      "clientName": "Sarah Johnson",
      "caseType": "Divorce",
      "description": "Contested divorce with child custody dispute",
      "status": "Active",
      "urgency": "Urgent",
      "priority": "High",
      "assignedAttorney": "Jennifer Martinez",
      "childrenInvolved": true,
      "numberOfChildren": 2,
      "childrenAges": "8, 12",
      "filingDate": "2024-01-10",
      "lastUpdate": "2024-03-20",
      "nextHearing": "2024-04-05",
      "nextMilestone": "Custody Evaluation",
      "estimatedDuration": "8-12 months",
      "assetValue": 850000.0,
      "supportAmount": 3200.0,
      "monthlyExpenses": 4500.0,
      "courtLocation": "Family Court - Downtown",
      "mediationScheduled": true,
      "domesticViolence": false,
      "protectiveOrder": false,
      "documents": 34,
      "billedHours": 67.5,
      "remainingBudget": 15000.0,
      "emotionalStatus": "High Stress",
      "communicationLevel": "Difficult",
    },
    {
      "id": "FAM-2024-002", 
      "clientName": "Michael Chen",
      "caseType": "Custody",
      "description": "Child custody modification request",
      "status": "Mediation",
      "urgency": "Standard",
      "priority": "Medium",
      "assignedAttorney": "Robert Wilson",
      "childrenInvolved": true,
      "numberOfChildren": 1,
      "childrenAges": "14",
      "filingDate": "2024-02-15",
      "lastUpdate": "2024-03-18",
      "nextHearing": "2024-04-12",
      "nextMilestone": "Mediation Session",
      "estimatedDuration": "3-6 months",
      "assetValue": 0.0,
      "supportAmount": 1800.0,
      "monthlyExpenses": 2200.0,
      "courtLocation": "Family Court - North",
      "mediationScheduled": true,
      "domesticViolence": false,
      "protectiveOrder": false,
      "documents": 18,
      "billedHours": 23.0,
      "remainingBudget": 8500.0,
      "emotionalStatus": "Moderate",
      "communicationLevel": "Cooperative",
    },
    {
      "id": "FAM-2024-003",
      "clientName": "Lisa Rodriguez",
      "caseType": "DV",
      "description": "Domestic violence protective order",
      "status": "Emergency",
      "urgency": "Emergency",
      "priority": "Critical",
      "assignedAttorney": "Amanda Davis",
      "childrenInvolved": true,
      "numberOfChildren": 3,
      "childrenAges": "4, 7, 9",
      "filingDate": "2024-03-15",
      "lastUpdate": "2024-03-21",
      "nextHearing": "2024-03-25",
      "nextMilestone": "Emergency Hearing",
      "estimatedDuration": "Immediate",
      "assetValue": 0.0,
      "supportAmount": 0.0,
      "monthlyExpenses": 3800.0,
      "courtLocation": "Family Court - Emergency",
      "mediationScheduled": false,
      "domesticViolence": true,
      "protectiveOrder": true,
      "documents": 12,
      "billedHours": 15.5,
      "remainingBudget": 5000.0,
      "emotionalStatus": "Crisis",
      "communicationLevel": "Safety Concerns",
    },
    {
      "id": "FAM-2024-004",
      "clientName": "David Thompson",
      "caseType": "Adoption",
      "description": "Stepparent adoption proceedings",
      "status": "Active",
      "urgency": "Standard",
      "priority": "Medium",
      "assignedAttorney": "Patricia Brown",
      "childrenInvolved": true,
      "numberOfChildren": 1,
      "childrenAges": "6",
      "filingDate": "2024-01-25",
      "lastUpdate": "2024-03-19",
      "nextHearing": "2024-04-20",
      "nextMilestone": "Home Study Complete",
      "estimatedDuration": "6-9 months",
      "assetValue": 0.0,
      "supportAmount": 0.0,
      "monthlyExpenses": 2800.0,
      "courtLocation": "Family Court - South",
      "mediationScheduled": false,
      "domesticViolence": false,
      "protectiveOrder": false,
      "documents": 28,
      "billedHours": 32.0,
      "remainingBudget": 7200.0,
      "emotionalStatus": "Positive",
      "communicationLevel": "Excellent",
    },
    {
      "id": "FAM-2024-005",
      "clientName": "Emily Davis",
      "caseType": "Support",
      "description": "Child support enforcement action",
      "status": "Court",
      "urgency": "Urgent",
      "priority": "High",
      "assignedAttorney": "Mark Anderson",
      "childrenInvolved": true,
      "numberOfChildren": 2,
      "childrenAges": "10, 13",
      "filingDate": "2024-02-01",
      "lastUpdate": "2024-03-17",
      "nextHearing": "2024-04-08",
      "nextMilestone": "Wage Garnishment",
      "estimatedDuration": "2-4 months",
      "assetValue": 0.0,
      "supportAmount": 2400.0,
      "monthlyExpenses": 3500.0,
      "courtLocation": "Family Court - Central",
      "mediationScheduled": false,
      "domesticViolence": false,
      "protectiveOrder": false,
      "documents": 22,
      "billedHours": 28.5,
      "remainingBudget": 4500.0,
      "emotionalStatus": "Frustrated",
      "communicationLevel": "Challenging",
    },
    {
      "id": "FAM-2024-006",
      "clientName": "James Wilson",
      "caseType": "Prenup",
      "description": "Prenuptial agreement review and modification",
      "status": "Settled",
      "urgency": "Low",
      "priority": "Low",
      "assignedAttorney": "Laura Johnson",
      "childrenInvolved": false,
      "numberOfChildren": 0,
      "childrenAges": "N/A",
      "filingDate": "2024-01-05",
      "lastUpdate": "2024-03-10",
      "nextHearing": "N/A",
      "nextMilestone": "Agreement Signed",
      "estimatedDuration": "Completed",
      "assetValue": 1200000.0,
      "supportAmount": 0.0,
      "monthlyExpenses": 0.0,
      "courtLocation": "N/A",
      "mediationScheduled": false,
      "domesticViolence": false,
      "protectiveOrder": false,
      "documents": 15,
      "billedHours": 22.0,
      "remainingBudget": 2000.0,
      "emotionalStatus": "Neutral",
      "communicationLevel": "Professional",
    },
  ];

  List<Map<String, dynamic>> get filteredCases {
    return familyLawCases.where((case_) {
      bool matchesCaseType = selectedCaseType == "All" || case_["caseType"] == selectedCaseType;
      bool matchesStatus = selectedStatus == "All" || case_["status"] == selectedStatus;
      bool matchesUrgency = selectedUrgency == "All" || case_["urgency"] == selectedUrgency;
      bool matchesSearch = searchQuery.isEmpty ||
          case_["clientName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          case_["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          case_["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesChildrenFilter = !showChildrenInvolved || (case_["childrenInvolved"] as bool);
      bool matchesPriorityFilter = !showHighPriority || (case_["priority"] == "High" || case_["priority"] == "Critical");

      return matchesCaseType && matchesStatus && matchesUrgency && matchesSearch && matchesChildrenFilter && matchesPriorityFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Family Law Cases"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create family law case
            },
          ),
          IconButton(
            icon: Icon(Icons.emergency),
            onPressed: () {
              _showEmergencyGuidelines();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency Alert Banner
            _buildEmergencyAlert(),
            SizedBox(height: spMd),

            // Family Law Overview Cards
            _buildOverviewCards(),
            SizedBox(height: spLg),

            // Search and Filters
            _buildSearchAndFilters(),
            SizedBox(height: spLg),

            // Special Filters
            _buildSpecialFilters(),
            SizedBox(height: spLg),

            // Case Statistics
            _buildCaseStatistics(),
            SizedBox(height: spLg),

            // Cases List
            _buildCasesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyAlert() {
    int emergencyCases = familyLawCases.where((c) => c["urgency"] == "Emergency").length;
    
    if (emergencyCases == 0) return SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: dangerColor,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Emergency Cases Alert",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "$emergencyCases case(s) require immediate attention",
                  style: TextStyle(
                    fontSize: 14,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "View",
            size: bs.sm,
            onPressed: () {
              setState(() {
                selectedUrgency = "Emergency";
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCards() {
    int totalCases = familyLawCases.length;
    int activeCases = familyLawCases.where((c) => c["status"] == "Active").length;
    int childrenCases = familyLawCases.where((c) => c["childrenInvolved"] as bool).length;
    int emergencyCases = familyLawCases.where((c) => c["urgency"] == "Emergency").length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Family Law Overview",
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
              Icons.family_restroom,
              primaryColor,
            ),
            _buildOverviewCard(
              "Active Cases", 
              "$activeCases",
              Icons.trending_up,
              successColor,
            ),
            _buildOverviewCard(
              "Children Involved",
              "$childrenCases",
              Icons.child_care,
              infoColor,
            ),
            _buildOverviewCard(
              "Emergency",
              "$emergencyCases",
              Icons.emergency,
              dangerColor,
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
            QDropdownField(
              label: "Urgency",
              items: urgencyItems,
              value: selectedUrgency,
              onChanged: (value, label) {
                selectedUrgency = value;
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecialFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Special Filters",
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
              child: QSwitch(
                items: [
                  {
                    "label": "Children Involved Only",
                    "value": true,
                    "checked": showChildrenInvolved,
                  }
                ],
                value: [
                  if (showChildrenInvolved)
                    {"label": "Children Involved Only", "value": true, "checked": true}
                ],
                onChanged: (values, ids) {
                  showChildrenInvolved = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QSwitch(
                items: [
                  {
                    "label": "High Priority Only",
                    "value": true,
                    "checked": showHighPriority,
                  }
                ],
                value: [
                  if (showHighPriority)
                    {"label": "High Priority Only", "value": true, "checked": true}
                ],
                onChanged: (values, ids) {
                  showHighPriority = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
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

  Widget _buildCaseStatistics() {
    Map<String, int> typeStats = {};
    Map<String, int> urgencyStats = {};
    
    for (var case_ in filteredCases) {
      String type = case_["caseType"];
      String urgency = case_["urgency"];
      
      typeStats[type] = (typeStats[type] ?? 0) + 1;
      urgencyStats[urgency] = (urgencyStats[urgency] ?? 0) + 1;
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
            _buildStatisticsCard("By Urgency", urgencyStats, [
              dangerColor, warningColor, infoColor, successColor
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
          "Family Law Cases",
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
    Color urgencyColor = _getUrgencyColor(case_["urgency"]);
    bool hasChildren = case_["childrenInvolved"] as bool;
    bool hasDV = case_["domesticViolence"] as bool;
    bool hasProtectiveOrder = case_["protectiveOrder"] as bool;

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
            color: urgencyColor,
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
                    Row(
                      children: [
                        Text(
                          "${case_["clientName"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (hasChildren) ...[
                          SizedBox(width: spXs),
                          Icon(
                            Icons.child_care,
                            color: infoColor,
                            size: 16,
                          ),
                        ],
                        if (hasDV) ...[
                          SizedBox(width: spXs),
                          Icon(
                            Icons.warning,
                            color: dangerColor,
                            size: 16,
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${case_["id"]} • ${case_["caseType"]}",
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
                      color: urgencyColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${case_["urgency"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: urgencyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Case Description
          Text(
            "${case_["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          // Special Alerts
          if (hasProtectiveOrder || hasDV) ...[
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    hasProtectiveOrder ? "Protective Order Active" : "Domestic Violence Case",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
          ],

          // Attorney and Children Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assigned Attorney",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${case_["assignedAttorney"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasChildren)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Children",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${case_["numberOfChildren"]} child(ren) • Ages: ${case_["childrenAges"]}",
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
          if ((case_["assetValue"] as double) > 0 || (case_["supportAmount"] as double) > 0) ...[
            ResponsiveGridView(
              minItemWidth: 150,
              children: [
                if ((case_["assetValue"] as double) > 0)
                  _buildDetailItem("Asset Value", "\$${((case_["assetValue"] as double) / 1000).toStringAsFixed(0)}K"),
                if ((case_["supportAmount"] as double) > 0)
                  _buildDetailItem("Support Amount", "\$${(case_["supportAmount"] as double).toStringAsFixed(0)}/mo"),
                _buildDetailItem("Monthly Expenses", "\$${(case_["monthlyExpenses"] as double).toStringAsFixed(0)}"),
                _buildDetailItem("Estimated Duration", "${case_["estimatedDuration"]}"),
              ],
            ),
            SizedBox(height: spSm),
          ],

          // Case Management Details
          ResponsiveGridView(
            minItemWidth: 150,
            children: [
              _buildDetailItem("Documents", "${case_["documents"]} files"),
              _buildDetailItem("Billed Hours", "${(case_["billedHours"] as double).toStringAsFixed(1)}h"),
              _buildDetailItem("Remaining Budget", "\$${((case_["remainingBudget"] as double) / 1000).toStringAsFixed(1)}K"),
              _buildDetailItem("Emotional Status", "${case_["emotionalStatus"]}", 
                textColor: _getEmotionalStatusColor(case_["emotionalStatus"])),
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
              if (case_["nextHearing"] != "N/A")
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Next Hearing",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${case_["nextHearing"]}",
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
      case "Mediation":
        return infoColor;
      case "Court":
        return primaryColor;
      case "Emergency":
        return dangerColor;
      case "Settled":
        return successColor;
      case "Closed":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "Emergency":
        return dangerColor;
      case "Urgent":
        return warningColor;
      case "Standard":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getEmotionalStatusColor(String status) {
    switch (status) {
      case "Crisis":
        return dangerColor;
      case "High Stress":
        return warningColor;
      case "Frustrated":
        return warningColor;
      case "Moderate":
        return infoColor;
      case "Positive":
        return successColor;
      case "Neutral":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showEmergencyGuidelines() {
    // Show emergency procedures modal
    ss("Emergency guidelines modal would open here");
  }

  void _showCaseMenu(Map<String, dynamic> case_) {
    // Show case action menu
    ss("Case menu for ${case_["id"]} would open here");
  }
}
