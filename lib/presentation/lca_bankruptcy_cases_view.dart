import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaBankruptcyCasesView extends StatefulWidget {
  const LcaBankruptcyCasesView({Key? key}) : super(key: key);

  @override
  State<LcaBankruptcyCasesView> createState() => _LcaBankruptcyCasesViewState();
}

class _LcaBankruptcyCasesViewState extends State<LcaBankruptcyCasesView> {
  String selectedChapter = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> bankruptcyChapters = [
    {"label": "All Chapters", "value": "all", "count": 29},
    {"label": "Chapter 7", "value": "chapter_7", "count": 12},
    {"label": "Chapter 11", "value": "chapter_11", "count": 8},
    {"label": "Chapter 13", "value": "chapter_13", "count": 7},
    {"label": "Chapter 12", "value": "chapter_12", "count": 2},
  ];

  List<Map<String, dynamic>> bankruptcyCases = [
    {
      "id": "BK-2024-001",
      "title": "TechStart Liquidation",
      "debtor": "TechStart Solutions Inc.",
      "chapter": "chapter_7",
      "status": "active",
      "priority": "high",
      "filed_date": "2024-04-15",
      "meeting_date": "2024-07-20",
      "attorney": "Sarah Johnson, Esq.",
      "trustee": "John Patterson",
      "total_debt": 2500000.0,
      "total_assets": 850000.0,
      "creditors_count": 34,
      "case_description": "Technology startup liquidation due to failed funding rounds",
      "discharge_status": "pending",
      "assets_liquidated": 425000.0,
      "employees_affected": 28,
      "exemptions_claimed": 125000.0,
      "reaffirmation_agreements": 2,
    },
    {
      "id": "BK-2024-002",
      "title": "Restaurant Chain Reorganization",
      "debtor": "Family Dining Corp",
      "chapter": "chapter_11",
      "status": "plan_confirmation",
      "priority": "critical",
      "filed_date": "2024-03-10",
      "meeting_date": "2024-08-15",
      "attorney": "Michael Chen, Esq.",
      "trustee": "Maria Rodriguez",
      "total_debt": 8500000.0,
      "total_assets": 6200000.0,
      "creditors_count": 127,
      "case_description": "Restaurant chain reorganization to continue operations",
      "discharge_status": "in_progress",
      "assets_liquidated": 0.0,
      "employees_affected": 245,
      "plan_payment_percentage": 65.0,
      "reorganization_period": 5,
    },
    {
      "id": "BK-2024-003",
      "title": "Consumer Debt Adjustment",
      "debtor": "Jennifer & Mark Williams",
      "chapter": "chapter_13",
      "status": "payment_plan",
      "priority": "medium",
      "filed_date": "2024-02-28",
      "meeting_date": "2024-06-12",
      "attorney": "Emily Rodriguez, Esq.",
      "trustee": "Robert Davis",
      "total_debt": 185000.0,
      "total_assets": 320000.0,
      "creditors_count": 12,
      "case_description": "Married couple debt adjustment to save family home",
      "discharge_status": "on_track",
      "assets_liquidated": 0.0,
      "monthly_payment": 2850.0,
      "plan_duration": 60,
      "payments_made": 4,
    },
    {
      "id": "BK-2024-004",
      "title": "Farm Operation Adjustment",
      "debtor": "Heritage Farms LLC",
      "chapter": "chapter_12",
      "status": "active",
      "priority": "medium",
      "filed_date": "2024-05-02",
      "meeting_date": "2024-07-30",
      "attorney": "David Wilson, Esq.",
      "trustee": "Susan Thompson",
      "total_debt": 1200000.0,
      "total_assets": 1800000.0,
      "creditors_count": 18,
      "case_description": "Family farm debt adjustment due to drought conditions",
      "discharge_status": "pending",
      "assets_liquidated": 0.0,
      "farm_acres": 850,
      "seasonal_income": true,
      "crop_insurance_claim": 185000.0,
    },
    {
      "id": "BK-2024-005",
      "title": "Individual Consumer Liquidation",
      "debtor": "Patricia Johnson",
      "chapter": "chapter_7",
      "status": "discharged",
      "priority": "low",
      "filed_date": "2024-01-20",
      "meeting_date": "2024-04-25",
      "attorney": "Sarah Johnson, Esq.",
      "trustee": "Michael Clark",
      "total_debt": 95000.0,
      "total_assets": 45000.0,
      "creditors_count": 8,
      "case_description": "Individual consumer debt discharge due to medical expenses",
      "discharge_status": "completed",
      "assets_liquidated": 15000.0,
      "exemptions_claimed": 30000.0,
      "no_asset_case": true,
      "discharge_date": "2024-05-15",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bankruptcy Cases"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addNewBankruptcyCase(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.assessment,
            size: bs.sm,
            onPressed: () => _showBankruptcyReports(),
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
                  _buildBankruptcyOverview(),
                  _buildSearchAndFilter(),
                  _buildChapterFilter(),
                  _buildDebtStatistics(),
                  _buildBankruptcyCasesList(),
                ],
              ),
            ),
    );
  }

  Widget _buildBankruptcyOverview() {
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
                "Bankruptcy Practice Overview",
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
              _buildOverviewCard("Total Cases", "29", Icons.folder, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Active", "18", Icons.trending_up, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Discharged", "8", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Liquidation", "3", Icons.gavel, dangerColor),
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
              label: "Search bankruptcy cases...",
              value: searchQuery,
              hint: "Search by debtor, case ID, or trustee",
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

  Widget _buildChapterFilter() {
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
            "Filter by Bankruptcy Chapter",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: bankruptcyChapters.map((chapter) {
              bool isSelected = selectedChapter == chapter["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedChapter = chapter["value"];
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
                      "${chapter["label"]} (${chapter["count"]})",
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

  Widget _buildDebtStatistics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: dangerColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Debt Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: dangerColor,
            ),
          ),
          Row(
            children: [
              _buildDebtStatCard("Total Debt", "\$12.9M", Icons.trending_down),
              SizedBox(width: spSm),
              _buildDebtStatCard("Total Assets", "\$9.2M", Icons.account_balance_wallet),
              SizedBox(width: spSm),
              _buildDebtStatCard("Recovery Rate", "71%", Icons.restore),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDebtStatCard(String title, String value, IconData icon) {
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
            Icon(icon, color: dangerColor, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: dangerColor,
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

  Widget _buildBankruptcyCasesList() {
    List<Map<String, dynamic>> filteredCases = _getFilteredCases();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Bankruptcy Cases (${filteredCases.length})",
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
        ...filteredCases.map((caseData) => _buildBankruptcyCaseCard(caseData)),
      ],
    );
  }

  Widget _buildBankruptcyCaseCard(Map<String, dynamic> caseData) {
    Color statusColor = _getStatusColor(caseData["status"]);
    Color chapterColor = _getChapterColor(caseData["chapter"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: chapterColor,
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
                  color: chapterColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${caseData["chapter"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: chapterColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getDischargeStatusColor(caseData["discharge_status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${caseData["discharge_status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: _getDischargeStatusColor(caseData["discharge_status"]),
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
              Expanded(
                child: Text(
                  "Debtor: ${caseData["debtor"]}",
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
          Row(
            children: [
              Text(
                "Debt: \$${((caseData["total_debt"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: dangerColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "Assets: \$${((caseData["total_assets"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.group, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${caseData["creditors_count"]} creditors",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (caseData.containsKey("employees_affected")) ...[
                Spacer(),
                Icon(Icons.work, color: disabledBoldColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "${caseData["employees_affected"]} employees",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
          if ((caseData["assets_liquidated"] as double) > 0)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.monetization_on, color: warningColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    "Assets Liquidated: \$${((caseData["assets_liquidated"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Icon(Icons.person_pin, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Trustee: ${caseData["trustee"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Meeting: ${caseData["meeting_date"]}",
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
                onPressed: () => _viewBankruptcyCase(caseData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editBankruptcyCase(caseData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showBankruptcyCaseOptions(caseData),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCases() {
    List<Map<String, dynamic>> filtered = bankruptcyCases;

    if (selectedChapter != "all") {
      filtered = filtered.where((c) => c["chapter"] == selectedChapter).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((c) =>
          c["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["debtor"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["id"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'discharged':
        return successColor;
      case 'active':
        return warningColor;
      case 'plan_confirmation':
        return infoColor;
      case 'payment_plan':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getChapterColor(String chapter) {
    switch (chapter.toLowerCase()) {
      case 'chapter_7':
        return dangerColor;
      case 'chapter_11':
        return primaryColor;
      case 'chapter_13':
        return successColor;
      case 'chapter_12':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getDischargeStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'on_track':
        return primaryColor;
      case 'in_progress':
        return warningColor;
      case 'pending':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addNewBankruptcyCase() {
    ss("Add new bankruptcy case");
  }

  void _showBankruptcyReports() {
    ss("Bankruptcy reports");
  }

  void _showAdvancedFilters() {
    ss("Advanced filters");
  }

  void _showSortOptions() {
    ss("Sort options");
  }

  void _viewBankruptcyCase(String caseId) {
    ss("Viewing bankruptcy case $caseId");
  }

  void _editBankruptcyCase(String caseId) {
    ss("Editing bankruptcy case $caseId");
  }

  void _showBankruptcyCaseOptions(Map<String, dynamic> caseData) {
    ss("Bankruptcy case options for ${caseData["id"]}");
  }
}
