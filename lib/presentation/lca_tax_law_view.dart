import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaTaxLawView extends StatefulWidget {
  const LcaTaxLawView({Key? key}) : super(key: key);

  @override
  State<LcaTaxLawView> createState() => _LcaTaxLawViewState();
}

class _LcaTaxLawViewState extends State<LcaTaxLawView> {
  String selectedTaxType = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> taxTypes = [
    {"label": "All Tax Cases", "value": "all", "count": 38},
    {"label": "Corporate Tax", "value": "corporate", "count": 15},
    {"label": "Individual Tax", "value": "individual", "count": 12},
    {"label": "Tax Disputes", "value": "dispute", "count": 8},
    {"label": "Tax Planning", "value": "planning", "count": 3},
  ];

  List<Map<String, dynamic>> taxCases = [
    {
      "id": "TX-2024-001",
      "title": "Corporate Tax Audit Defense",
      "client": "InnovateTech Corporation",
      "tax_type": "corporate",
      "status": "active",
      "priority": "critical",
      "tax_year": "2023",
      "amount_disputed": 850000.0,
      "penalties_assessed": 125000.0,
      "attorney": "Dr. Sarah Mitchell, Esq.",
      "irs_agent": "Agent Johnson",
      "audit_start_date": "2024-03-15",
      "response_deadline": "2024-08-20",
      "case_description": "IRS audit of R&D tax credits and foreign income",
      "complexity_level": "high",
      "documentation_required": 156,
      "documents_submitted": 142,
      "meetings_held": 4,
      "extension_requested": true,
    },
    {
      "id": "TX-2024-002",
      "title": "Individual Tax Penalty Abatement",
      "client": "Robert Chen",
      "tax_type": "individual",
      "status": "resolved",
      "priority": "medium",
      "tax_year": "2022",
      "amount_disputed": 25000.0,
      "penalties_assessed": 8500.0,
      "attorney": "Michael Johnson, Esq.",
      "irs_agent": "Agent Davis",
      "audit_start_date": "2024-02-10",
      "response_deadline": "2024-06-15",
      "case_description": "Penalty abatement request for late filing due to medical emergency",
      "complexity_level": "low",
      "documentation_required": 12,
      "documents_submitted": 12,
      "meetings_held": 2,
      "extension_requested": false,
    },
    {
      "id": "TX-2024-003",
      "title": "Estate Tax Planning Strategy",
      "client": "Williams Family Trust",
      "tax_type": "planning",
      "status": "ongoing",
      "priority": "high",
      "tax_year": "2024",
      "amount_disputed": 0.0,
      "penalties_assessed": 0.0,
      "attorney": "Emily Rodriguez, Esq.",
      "irs_agent": "N/A",
      "audit_start_date": "N/A",
      "response_deadline": "2024-12-31",
      "case_description": "Comprehensive estate tax planning for high-net-worth family",
      "complexity_level": "very_high",
      "documentation_required": 85,
      "documents_submitted": 45,
      "meetings_held": 6,
      "extension_requested": false,
    },
    {
      "id": "TX-2024-004",
      "title": "Sales Tax Compliance Audit",
      "client": "Retail Solutions LLC",
      "tax_type": "corporate",
      "status": "dispute",
      "priority": "high",
      "tax_year": "2022-2023",
      "amount_disputed": 340000.0,
      "penalties_assessed": 85000.0,
      "attorney": "David Wilson, Esq.",
      "irs_agent": "Agent Martinez",
      "audit_start_date": "2024-04-22",
      "response_deadline": "2024-09-15",
      "case_description": "Multi-state sales tax compliance issues for online retailer",
      "complexity_level": "high",
      "documentation_required": 234,
      "documents_submitted": 198,
      "meetings_held": 7,
      "extension_requested": true,
    },
    {
      "id": "TX-2024-005",
      "title": "Partnership Tax Dispute",
      "client": "Professional Services Partners",
      "tax_type": "dispute",
      "status": "litigation",
      "priority": "critical",
      "tax_year": "2021-2022",
      "amount_disputed": 750000.0,
      "penalties_assessed": 180000.0,
      "attorney": "Dr. Sarah Mitchell, Esq.",
      "irs_agent": "Agent Thompson",
      "audit_start_date": "2024-01-08",
      "response_deadline": "2024-10-30",
      "case_description": "Partnership distribution and basis calculation disputes",
      "complexity_level": "very_high",
      "documentation_required": 312,
      "documents_submitted": 289,
      "meetings_held": 12,
      "extension_requested": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Law Cases"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addNewTaxCase(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.calendar_today,
            size: bs.sm,
            onPressed: () => _showTaxCalendar(),
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
                  _buildTaxOverview(),
                  _buildSearchAndFilter(),
                  _buildTaxTypeFilter(),
                  _buildTaxMetrics(),
                  _buildTaxCasesList(),
                ],
              ),
            ),
    );
  }

  Widget _buildTaxOverview() {
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
                child: Icon(Icons.account_balance, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Tax Law Portfolio",
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
              _buildOverviewCard("Total Cases", "38", Icons.folder, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Active", "24", Icons.trending_up, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Disputes", "12", Icons.warning, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Planning", "3", Icons.lightbulb, warningColor),
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
              label: "Search tax cases...",
              value: searchQuery,
              hint: "Search by client, case ID, or tax year",
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

  Widget _buildTaxTypeFilter() {
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
            "Filter by Tax Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: taxTypes.map((taxType) {
              bool isSelected = selectedTaxType == taxType["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedTaxType = taxType["value"];
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
                      "${taxType["label"]} (${taxType["count"]})",
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

  Widget _buildTaxMetrics() {
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
            "Tax Practice Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildMetricCard("Total Disputed", "\$2.76M", Icons.gavel),
              SizedBox(width: spSm),
              _buildMetricCard("Penalties Saved", "\$1.2M", Icons.savings),
              SizedBox(width: spSm),
              _buildMetricCard("Success Rate", "92%", Icons.trending_up),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
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

  Widget _buildTaxCasesList() {
    List<Map<String, dynamic>> filteredCases = _getFilteredCases();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Tax Cases (${filteredCases.length})",
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
        ...filteredCases.map((caseData) => _buildTaxCaseCard(caseData)),
      ],
    );
  }

  Widget _buildTaxCaseCard(Map<String, dynamic> caseData) {
    Color statusColor = _getStatusColor(caseData["status"]);
    Color complexityColor = _getComplexityColor(caseData["complexity_level"]);

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
                      "${caseData["id"]} - Tax Year ${caseData["tax_year"]}",
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_getTaxTypeIcon(caseData["tax_type"]), color: primaryColor, size: 12),
                    SizedBox(width: spXs),
                    Text(
                      "${caseData["tax_type"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: complexityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${caseData["complexity_level"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: complexityColor,
                    fontWeight: FontWeight.w600,
                  ),
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
                  "${caseData["client"]}",
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
            child: Text(
              "${caseData["case_description"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          if ((caseData["amount_disputed"] as double) > 0)
            Row(
              children: [
                Text(
                  "Amount Disputed: \$${((caseData["amount_disputed"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if ((caseData["penalties_assessed"] as double) > 0) ...[
                  Spacer(),
                  Text(
                    "Penalties: \$${((caseData["penalties_assessed"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          Row(
            children: [
              Text(
                "Documents: ${caseData["documents_submitted"]}/${caseData["documentation_required"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Text(
                "Meetings: ${caseData["meetings_held"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (caseData["extension_requested"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "EXTENSION",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          if (caseData["irs_agent"] != "N/A")
            Row(
              children: [
                Icon(Icons.person_pin, color: disabledBoldColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "IRS Agent: ${caseData["irs_agent"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                if (caseData["response_deadline"] != "N/A")
                  Text(
                    "Deadline: ${caseData["response_deadline"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: dangerColor,
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
                onPressed: () => _viewTaxCase(caseData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editTaxCase(caseData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showTaxCaseOptions(caseData),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCases() {
    List<Map<String, dynamic>> filtered = taxCases;

    if (selectedTaxType != "all") {
      filtered = filtered.where((c) => c["tax_type"] == selectedTaxType).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((c) =>
          c["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["client"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["id"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'resolved':
        return successColor;
      case 'active':
      case 'ongoing':
        return warningColor;
      case 'dispute':
      case 'litigation':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getComplexityColor(String complexity) {
    switch (complexity.toLowerCase()) {
      case 'low':
        return successColor;
      case 'medium':
        return warningColor;
      case 'high':
        return dangerColor;
      case 'very_high':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTaxTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'corporate':
        return Icons.business;
      case 'individual':
        return Icons.person;
      case 'dispute':
        return Icons.gavel;
      case 'planning':
        return Icons.lightbulb;
      default:
        return Icons.account_balance;
    }
  }

  void _addNewTaxCase() {
    ss("Add new tax case");
  }

  void _showTaxCalendar() {
    ss("Tax deadlines calendar");
  }

  void _showAdvancedFilters() {
    ss("Advanced filters");
  }

  void _showSortOptions() {
    ss("Sort options");
  }

  void _viewTaxCase(String caseId) {
    ss("Viewing tax case $caseId");
  }

  void _editTaxCase(String caseId) {
    ss("Editing tax case $caseId");
  }

  void _showTaxCaseOptions(Map<String, dynamic> caseData) {
    ss("Tax case options for ${caseData["id"]}");
  }
}
