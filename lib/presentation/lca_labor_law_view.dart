import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaLaborLawView extends StatefulWidget {
  const LcaLaborLawView({Key? key}) : super(key: key);

  @override
  State<LcaLaborLawView> createState() => _LcaLaborLawViewState();
}

class _LcaLaborLawViewState extends State<LcaLaborLawView> {
  String selectedCaseType = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> laborCaseTypes = [
    {"label": "All Cases", "value": "all", "count": 42},
    {"label": "Employment", "value": "employment", "count": 16},
    {"label": "Discrimination", "value": "discrimination", "count": 12},
    {"label": "Wage Disputes", "value": "wage", "count": 8},
    {"label": "Workplace Safety", "value": "safety", "count": 6},
  ];

  List<Map<String, dynamic>> laborCases = [
    {
      "id": "LB-2024-001",
      "title": "Wrongful Termination Claim",
      "employee": "Jennifer Martinez",
      "employer": "TechCorp Industries",
      "case_type": "employment",
      "status": "active",
      "priority": "high",
      "filed_date": "2024-04-20",
      "hearing_date": "2024-08-15",
      "attorney": "Sarah Johnson, Esq.",
      "settlement_amount": 125000.0,
      "case_description": "Employee claims wrongful termination due to whistleblowing",
      "violation_type": "Retaliation",
      "evidence_strength": "strong",
      "witness_count": 4,
      "documentation_complete": true,
      "mediation_scheduled": false,
      "union_involved": false,
    },
    {
      "id": "LB-2024-002",
      "title": "Gender Pay Gap Discrimination",
      "employee": "Rachel Thompson",
      "employer": "Financial Services LLC",
      "case_type": "discrimination",
      "status": "mediation",
      "priority": "medium",
      "filed_date": "2024-03-15",
      "hearing_date": "2024-07-22",
      "attorney": "Michael Chen, Esq.",
      "settlement_amount": 85000.0,
      "case_description": "Female employee receiving unequal pay for same position",
      "violation_type": "Gender Discrimination",
      "evidence_strength": "moderate",
      "witness_count": 2,
      "documentation_complete": true,
      "mediation_scheduled": true,
      "union_involved": false,
    },
    {
      "id": "LB-2024-003",
      "title": "Unpaid Overtime Class Action",
      "employee": "Multiple Employees",
      "employer": "Retail Chain Corp",
      "case_type": "wage",
      "status": "litigation",
      "priority": "critical",
      "filed_date": "2024-02-10",
      "hearing_date": "2024-09-30",
      "attorney": "Emily Rodriguez, Esq.",
      "settlement_amount": 450000.0,
      "case_description": "Class action for systematic unpaid overtime violations",
      "violation_type": "FLSA Violations",
      "evidence_strength": "very_strong",
      "witness_count": 23,
      "documentation_complete": true,
      "mediation_scheduled": false,
      "union_involved": true,
    },
    {
      "id": "LB-2024-004",
      "title": "Workplace Safety Violation",
      "employee": "Robert Wilson",
      "employer": "Construction Plus Inc.",
      "case_type": "safety",
      "status": "investigation",
      "priority": "high",
      "filed_date": "2024-05-08",
      "hearing_date": "2024-08-25",
      "attorney": "David Wilson, Esq.",
      "settlement_amount": 75000.0,
      "case_description": "Injury due to inadequate safety equipment and training",
      "violation_type": "OSHA Violations",
      "evidence_strength": "strong",
      "witness_count": 6,
      "documentation_complete": false,
      "mediation_scheduled": false,
      "union_involved": true,
    },
    {
      "id": "LB-2024-005",
      "title": "Age Discrimination Lawsuit",
      "employee": "Harold Patterson",
      "employer": "Marketing Solutions Inc.",
      "case_type": "discrimination",
      "status": "settled",
      "priority": "low",
      "filed_date": "2024-01-30",
      "hearing_date": "N/A",
      "attorney": "Sarah Johnson, Esq.",
      "settlement_amount": 65000.0,
      "case_description": "Employee over 50 passed over for promotion repeatedly",
      "violation_type": "Age Discrimination",
      "evidence_strength": "moderate",
      "witness_count": 3,
      "documentation_complete": true,
      "mediation_scheduled": false,
      "union_involved": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Labor Law Cases"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addNewLaborCase(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showLaborAnalytics(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildLaborOverview(),
                  _buildSearchAndFilter(),
                  _buildCaseTypeFilter(),
                  _buildCaseStatistics(),
                  _buildLaborCasesList(),
                ],
              ),
            ),
    );
  }

  Widget _buildLaborOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.work, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Labor Law Portfolio",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildOverviewCard("Total Cases", "42", Icons.folder, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Active", "23", Icons.trending_up, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Litigation", "8", Icons.gavel, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Settled", "11", Icons.handshake, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String count, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
            Text(
              count,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: disabledBoldColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: QTextField(
              label: "Search labor cases...",
              value: searchQuery,
              hint: "Search by employee, employer, or case ID",
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
            onPressed: () => _showAdvancedFilters(),
          ),
        ],
      ),
    );
  }

  Widget _buildCaseTypeFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Filter by Case Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: laborCaseTypes.map((caseType) {
              bool isSelected = selectedCaseType == caseType["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedCaseType = caseType["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? primaryColor.withAlpha(30)
                          : Colors.grey.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      "${caseType["label"]} (${caseType["count"]})",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCaseStatistics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Case Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildStatCard("Avg. Settlement", "\$130K", Icons.attach_money),
              SizedBox(width: spSm),
              _buildStatCard("Success Rate", "87%", Icons.trending_up),
              SizedBox(width: spSm),
              _buildStatCard("Avg. Duration", "6.5 mo", Icons.access_time),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(icon, color: successColor, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLaborCasesList() {
    List<Map<String, dynamic>> filteredCases = _getFilteredCases();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Labor Cases (${filteredCases.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredCases.map((caseData) => _buildLaborCaseCard(caseData)),
      ],
    );
  }

  Widget _buildLaborCaseCard(Map<String, dynamic> caseData) {
    Color statusColor = _getStatusColor(caseData["status"]);
    Color evidenceColor = _getEvidenceStrengthColor(caseData["evidence_strength"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: statusColor,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${caseData["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${caseData["title"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${caseData["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${caseData["case_type"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: evidenceColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${caseData["evidence_strength"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: evidenceColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Employee: ${caseData["employee"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.business, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Employer: ${caseData["employer"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Violation: ${caseData["violation_type"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${caseData["case_description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.group, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${caseData["witness_count"]} witnesses",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Settlement: \$${((caseData["settlement_amount"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              if (caseData["union_involved"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "UNION INVOLVED",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (caseData["mediation_scheduled"] == true) ...[
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "MEDIATION SCHEDULED",
                    style: TextStyle(
                      fontSize: 10,
                      color: warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              Spacer(),
              if (caseData["hearing_date"] != "N/A")
                Text(
                  "Hearing: ${caseData["hearing_date"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Attorney: ${caseData["attorney"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewLaborCase(caseData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editLaborCase(caseData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showLaborCaseOptions(caseData),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCases() {
    List<Map<String, dynamic>> filtered = laborCases;

    if (selectedCaseType != "all") {
      filtered = filtered.where((c) => c["case_type"] == selectedCaseType).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((c) =>
          c["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["employee"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["employer"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'settled':
        return successColor;
      case 'active':
        return warningColor;
      case 'mediation':
        return infoColor;
      case 'litigation':
        return dangerColor;
      case 'investigation':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getEvidenceStrengthColor(String strength) {
    switch (strength.toLowerCase()) {
      case 'very_strong':
        return successColor;
      case 'strong':
        return primaryColor;
      case 'moderate':
        return warningColor;
      case 'weak':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addNewLaborCase() {
    ss("Add new labor case");
  }

  void _showLaborAnalytics() {
    ss("Labor law analytics");
  }

  void _showAdvancedFilters() {
    ss("Advanced filters");
  }

  void _showSortOptions() {
    ss("Sort options");
  }

  void _viewLaborCase(String caseId) {
    ss("Viewing labor case $caseId");
  }

  void _editLaborCase(String caseId) {
    ss("Editing labor case $caseId");
  }

  void _showLaborCaseOptions(Map<String, dynamic> caseData) {
    ss("Labor case options for ${caseData["id"]}");
  }
}
