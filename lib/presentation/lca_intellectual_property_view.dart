import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaIntellectualPropertyView extends StatefulWidget {
  const LcaIntellectualPropertyView({Key? key}) : super(key: key);

  @override
  State<LcaIntellectualPropertyView> createState() => _LcaIntellectualPropertyViewState();
}

class _LcaIntellectualPropertyViewState extends State<LcaIntellectualPropertyView> {
  String selectedCategory = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> ipCategories = [
    {"label": "All IP Cases", "value": "all", "count": 64},
    {"label": "Patents", "value": "patent", "count": 25},
    {"label": "Trademarks", "value": "trademark", "count": 18},
    {"label": "Copyrights", "value": "copyright", "count": 12},
    {"label": "Trade Secrets", "value": "trade_secret", "count": 9},
  ];

  List<Map<String, dynamic>> ipCases = [
    {
      "id": "IP-2024-001",
      "title": "TechFlow AI Algorithm Patent",
      "client": "TechFlow Solutions Inc.",
      "type": "patent",
      "status": "filed",
      "priority": "high",
      "filed_date": "2024-04-12",
      "expected_approval": "2024-12-20",
      "attorney": "Dr. Sarah Mitchell, Esq.",
      "application_number": "US17/123,456",
      "jurisdiction": "United States",
      "filing_fee": 8500.0,
      "maintenance_fee": 2400.0,
      "description": "Machine learning algorithm for predictive analytics",
      "claims": 15,
      "prior_art_citations": 23,
      "examination_status": "under_review",
    },
    {
      "id": "IP-2024-002",
      "title": "GreenEnergy Logo Trademark",
      "client": "GreenEnergy Corp",
      "type": "trademark",
      "status": "approved",
      "priority": "medium",
      "filed_date": "2024-03-05",
      "expected_approval": "2024-08-15",
      "attorney": "Michael Chen, Esq.",
      "application_number": "TM88/234,567",
      "jurisdiction": "United States",
      "filing_fee": 3200.0,
      "maintenance_fee": 800.0,
      "description": "Corporate logo and brand identity protection",
      "classes": 4,
      "opposition_period": false,
      "registration_number": "REG6,789,012",
    },
    {
      "id": "IP-2024-003",
      "title": "Digital Music Composition",
      "client": "Harmony Studios LLC",
      "type": "copyright",
      "status": "registered",
      "priority": "low",
      "filed_date": "2024-02-18",
      "expected_approval": "2024-06-30",
      "attorney": "Emily Rodriguez, Esq.",
      "application_number": "CR24/345,678",
      "jurisdiction": "United States",
      "filing_fee": 1500.0,
      "maintenance_fee": 0.0,
      "description": "Original musical composition for commercial use",
      "work_type": "Musical Work",
      "publication_date": "2024-03-01",
      "copyright_term": "Life + 70 years",
    },
    {
      "id": "IP-2024-004",
      "title": "Proprietary Manufacturing Process",
      "client": "InnovateTech Manufacturing",
      "type": "trade_secret",
      "status": "protected",
      "priority": "critical",
      "filed_date": "2024-01-25",
      "expected_approval": "N/A",
      "attorney": "David Wilson, Esq.",
      "application_number": "TS24/456,789",
      "jurisdiction": "Multiple States",
      "filing_fee": 5000.0,
      "maintenance_fee": 1200.0,
      "description": "Confidential manufacturing process documentation",
      "protection_measures": "NDA, Employee Training, Access Control",
      "economic_value": 2500000.0,
      "disclosure_risk": "Medium",
    },
    {
      "id": "IP-2024-005",
      "title": "Mobile App Patent Infringement",
      "client": "AppDev Solutions",
      "type": "patent",
      "status": "litigation",
      "priority": "critical",
      "filed_date": "2024-05-03",
      "expected_approval": "2024-11-30",
      "attorney": "Dr. Sarah Mitchell, Esq.",
      "application_number": "US17/567,890",
      "jurisdiction": "Federal Court",
      "filing_fee": 12000.0,
      "maintenance_fee": 4500.0,
      "description": "Patent infringement dispute resolution",
      "defendants": "CompetitorTech Inc.",
      "damages_sought": 750000.0,
      "trial_date": "2024-09-15",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intellectual Property"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addNewIPCase(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showIPAnalytics(),
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
                  _buildIPOverview(),
                  _buildSearchAndFilter(),
                  _buildCategoryFilter(),
                  _buildIPCasesList(),
                ],
              ),
            ),
    );
  }

  Widget _buildIPOverview() {
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
                child: Icon(Icons.lightbulb, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "IP Portfolio Overview",
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
              _buildOverviewCard("Total Cases", "64", Icons.folder, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Active", "42", Icons.trending_up, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Pending", "15", Icons.schedule, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Litigation", "7", Icons.gavel, dangerColor),
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
              label: "Search IP cases...",
              value: searchQuery,
              hint: "Search by title, client, or application number",
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

  Widget _buildCategoryFilter() {
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
            "Filter by IP Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: ipCategories.map((category) {
              bool isSelected = selectedCategory == category["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedCategory = category["value"];
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
                      "${category["label"]} (${category["count"]})",
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

  Widget _buildIPCasesList() {
    List<Map<String, dynamic>> filteredCases = _getFilteredCases();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "IP Cases (${filteredCases.length})",
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
        ...filteredCases.map((caseData) => _buildIPCaseCard(caseData)),
      ],
    );
  }

  Widget _buildIPCaseCard(Map<String, dynamic> caseData) {
    Color statusColor = _getStatusColor(caseData["status"]);
    Color typeColor = _getTypeColor(caseData["type"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: typeColor,
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
                  "${caseData["status"]}".replaceAll("_", " ").toUpperCase(),
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
                  color: typeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_getTypeIcon(caseData["type"]), color: typeColor, size: 12),
                    SizedBox(width: spXs),
                    Text(
                      "${caseData["type"]}".replaceAll("_", " ").toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        color: typeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                "${caseData["application_number"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
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
          Row(
            children: [
              Icon(Icons.location_on, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${caseData["jurisdiction"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Filed: ${caseData["filed_date"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
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
              "${caseData["description"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "Filing Fee: \$${((caseData["filing_fee"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if ((caseData["maintenance_fee"] as double) > 0) ...[
                SizedBox(width: spMd),
                Text(
                  "Maintenance: \$${((caseData["maintenance_fee"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
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
                onPressed: () => _viewIPCase(caseData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editIPCase(caseData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showIPCaseOptions(caseData),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCases() {
    List<Map<String, dynamic>> filtered = ipCases;

    if (selectedCategory != "all") {
      filtered = filtered.where((c) => c["type"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((c) =>
          c["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["client"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["application_number"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
      case 'registered':
      case 'protected':
        return successColor;
      case 'filed':
      case 'under_review':
        return warningColor;
      case 'litigation':
        return dangerColor;
      case 'pending':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'patent':
        return primaryColor;
      case 'trademark':
        return successColor;
      case 'copyright':
        return warningColor;
      case 'trade_secret':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'patent':
        return Icons.lightbulb;
      case 'trademark':
        return Icons.verified;
      case 'copyright':
        return Icons.copyright;
      case 'trade_secret':
        return Icons.security;
      default:
        return Icons.description;
    }
  }

  void _addNewIPCase() {
    ss("Add new IP case");
  }

  void _showIPAnalytics() {
    ss("IP analytics dashboard");
  }

  void _showAdvancedFilters() {
    ss("Advanced filters");
  }

  void _showSortOptions() {
    ss("Sort options");
  }

  void _viewIPCase(String caseId) {
    ss("Viewing IP case $caseId");
  }

  void _editIPCase(String caseId) {
    ss("Editing IP case $caseId");
  }

  void _showIPCaseOptions(Map<String, dynamic> caseData) {
    ss("IP case options for ${caseData["id"]}");
  }
}
