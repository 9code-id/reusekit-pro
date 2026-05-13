import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCriminalCasesView extends StatefulWidget {
  const LcaCriminalCasesView({Key? key}) : super(key: key);

  @override
  State<LcaCriminalCasesView> createState() => _LcaCriminalCasesViewState();
}

class _LcaCriminalCasesViewState extends State<LcaCriminalCasesView> {
  String selectedFilter = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Criminal Cases", "value": "all", "count": 28},
    {"label": "White Collar Crime", "value": "white_collar", "count": 8},
    {"label": "DUI/DWI", "value": "dui", "count": 6},
    {"label": "Drug Offenses", "value": "drug", "count": 5},
    {"label": "Assault & Battery", "value": "assault", "count": 4},
    {"label": "Theft & Fraud", "value": "theft", "count": 5},
  ];

  List<Map<String, dynamic>> criminalCases = [
    {
      "id": "LCA-2024-010",
      "title": "State vs. Marcus Johnson",
      "subcategory": "White Collar Crime",
      "client": "Marcus Johnson",
      "charges": ["Embezzlement", "Money Laundering", "Tax Evasion"],
      "status": "active",
      "priority": "high",
      "case_value": 150000.0,
      "filing_date": "2024-02-20",
      "trial_date": "2024-08-15",
      "lawyer": "Michael Chen, Esq.",
      "description": "Corporate embezzlement and money laundering scheme",
      "bail_amount": 100000.0,
      "plea_entered": "Not Guilty",
      "prosecution_attorney": "District Attorney Sarah Williams",
      "court": "Superior Court of California",
      "judge": "Hon. Robert Martinez",
      "case_stage": "Pre-trial",
      "next_hearing": "2024-07-10",
      "evidence_count": 45,
      "witness_count": 8,
    },
    {
      "id": "LCA-2024-015",
      "title": "State vs. Jennifer Lopez",
      "subcategory": "DUI/DWI",
      "client": "Jennifer Lopez",
      "charges": ["DUI", "Reckless Driving"],
      "status": "pending",
      "priority": "medium",
      "case_value": 25000.0,
      "filing_date": "2024-03-10",
      "trial_date": "2024-09-05",
      "lawyer": "David Wilson, Esq.",
      "description": "Third-time DUI offense with property damage",
      "bail_amount": 15000.0,
      "plea_entered": "Not Guilty",
      "prosecution_attorney": "Assistant DA Michael Brown",
      "court": "Municipal Court",
      "judge": "Hon. Linda Garcia",
      "case_stage": "Discovery",
      "next_hearing": "2024-07-20",
      "evidence_count": 12,
      "witness_count": 3,
    },
    {
      "id": "LCA-2024-022",
      "title": "State vs. Robert Chen",
      "subcategory": "Drug Offenses",
      "client": "Robert Chen",
      "charges": ["Possession with Intent", "Drug Trafficking"],
      "status": "active",
      "priority": "critical",
      "case_value": 75000.0,
      "filing_date": "2024-04-05",
      "trial_date": "2024-10-20",
      "lawyer": "Emily Rodriguez, Esq.",
      "description": "Large-scale drug trafficking operation",
      "bail_amount": 250000.0,
      "plea_entered": "Not Guilty",
      "prosecution_attorney": "District Attorney James Wilson",
      "court": "Federal District Court",
      "judge": "Hon. Patricia Johnson",
      "case_stage": "Pre-trial",
      "next_hearing": "2024-08-01",
      "evidence_count": 78,
      "witness_count": 12,
    },
    {
      "id": "LCA-2024-028",
      "title": "State vs. Amanda Rodriguez",
      "subcategory": "Assault & Battery",
      "client": "Amanda Rodriguez",
      "charges": ["Aggravated Assault", "Battery"],
      "status": "pending",
      "priority": "medium",
      "case_value": 35000.0,
      "filing_date": "2024-05-01",
      "trial_date": "2024-11-10",
      "lawyer": "Sarah Johnson, Esq.",
      "description": "Domestic violence incident with serious injuries",
      "bail_amount": 50000.0,
      "plea_entered": "Not Guilty",
      "prosecution_attorney": "Assistant DA Maria Santos",
      "court": "Superior Court",
      "judge": "Hon. Thomas Anderson",
      "case_stage": "Discovery",
      "next_hearing": "2024-08-15",
      "evidence_count": 23,
      "witness_count": 5,
    },
    {
      "id": "LCA-2024-035",
      "title": "State vs. Kevin Miller",
      "subcategory": "Theft & Fraud",
      "client": "Kevin Miller",
      "charges": ["Identity Theft", "Credit Card Fraud", "Wire Fraud"],
      "status": "active",
      "priority": "high",
      "case_value": 85000.0,
      "filing_date": "2024-05-20",
      "trial_date": "2024-12-01",
      "lawyer": "Michael Chen, Esq.",
      "description": "Multi-state identity theft and fraud scheme",
      "bail_amount": 75000.0,
      "plea_entered": "Not Guilty",
      "prosecution_attorney": "Federal Prosecutor John Davis",
      "court": "Federal District Court",
      "judge": "Hon. Elizabeth Wilson",
      "case_stage": "Pre-trial",
      "next_hearing": "2024-08-30",
      "evidence_count": 56,
      "witness_count": 9,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criminal Defense Cases"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _createNewCase(),
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
                  _buildHeader(),
                  _buildSearchAndFilter(),
                  _buildCriminalCasesOverview(),
                  _buildFilterTabs(),
                  _buildCasesList(),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(Icons.security, color: dangerColor, size: 24),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Criminal Defense Practice",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Defense of individuals and entities charged with criminal offenses",
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
              label: "Search criminal cases...",
              value: searchQuery,
              hint: "Search by case title, client, or charges",
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

  Widget _buildCriminalCasesOverview() {
    int totalCases = criminalCases.length;
    int activeCases = criminalCases.where((c) => c["status"] == "active").length;
    double totalBail = criminalCases.fold(0.0, (sum, c) => sum + (c["bail_amount"] as double));
    int trialReady = criminalCases.where((c) => c["case_stage"] == "Pre-trial").length;

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
            "Criminal Cases Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              _buildOverviewCard("Total Cases", "$totalCases", Icons.folder, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Active", "$activeCases", Icons.play_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Trial Ready", "$trialReady", Icons.gavel, warningColor),
            ],
          ),
          Row(
            children: [
              _buildOverviewCard("Total Bail", "\$${(totalBail / 1000).toStringAsFixed(0)}K", Icons.attach_money, infoColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Federal", "2", Icons.account_balance, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Plea Deals", "0", Icons.handshake, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
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
            Icon(icon, color: color, size: 16),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 9,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
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
            "Filter by Criminal Case Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: filterOptions.map((filter) {
              bool isSelected = selectedFilter == filter["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedFilter = filter["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? dangerColor.withAlpha(30)
                          : Colors.grey.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? dangerColor : disabledColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      "${filter["label"]} (${filter["count"]})",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? dangerColor : disabledBoldColor,
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

  Widget _buildCasesList() {
    List<Map<String, dynamic>> filteredCases = _getFilteredCases();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Criminal Cases (${filteredCases.length})",
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
        ...filteredCases.map((caseData) => _buildCaseCard(caseData)),
      ],
    );
  }

  Widget _buildCaseCard(Map<String, dynamic> caseData) {
    Color statusColor = _getStatusColor(caseData["status"]);
    Color priorityColor = _getPriorityColor(caseData["priority"]);
    List<String> charges = (caseData["charges"] as List).cast<String>();

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: dangerColor,
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
                    Row(
                      children: [
                        Text(
                          "${caseData["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${caseData["subcategory"]}",
                            style: TextStyle(
                              fontSize: 8,
                              color: dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
          Text(
            "${caseData["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text("Defendant: ", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Text("${caseData["client"]}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                    Spacer(),
                    Text("Plea: ${caseData["plea_entered"]}", style: TextStyle(fontSize: 10, color: warningColor, fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.account_balance, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text("Court: ", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Expanded(
                      child: Text("${caseData["court"]}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                    ),
                    Text("Judge: ${caseData["judge"]}", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Charges:",
                  style: TextStyle(
                    fontSize: 10,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: charges.map((charge) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        charge,
                        style: TextStyle(
                          fontSize: 10,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
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
                      "Bail Amount",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((caseData["bail_amount"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Trial Date",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${caseData["trial_date"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              _buildCaseStatusChip("${caseData["case_stage"]}".toUpperCase(), "Stage", infoColor),
              SizedBox(width: spSm),
              _buildCaseStatusChip("${caseData["evidence_count"]} EVIDENCE", "Items", warningColor),
              SizedBox(width: spSm),
              _buildCaseStatusChip("${caseData["witness_count"]} WITNESSES", "Total", successColor),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Defense Attorney: ${caseData["lawyer"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewCase(caseData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editCase(caseData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showCaseOptions(caseData),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(Icons.schedule, color: infoColor, size: 16),
                SizedBox(width: spSm),
                Text(
                  "Next Hearing: ${caseData["next_hearing"]} • Prosecutor: ${caseData["prosecution_attorney"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaseStatusChip(String label, String subtitle, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 8,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 6,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCases() {
    List<Map<String, dynamic>> filtered = criminalCases;

    if (selectedFilter != "all") {
      filtered = filtered.where((c) => 
          c["subcategory"].toString().toLowerCase().replaceAll(' ', '_').replaceAll('/', '').replaceAll('&', '') == 
          selectedFilter.replaceAll('_', ' ').toLowerCase().replaceAll(' ', '_').replaceAll('/', '').replaceAll('&', '')).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((c) =>
          c["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["client"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (c["charges"] as List).any((charge) => charge.toString().toLowerCase().contains(searchQuery.toLowerCase()))).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'pending':
        return warningColor;
      case 'closed':
        return disabledBoldColor;
      case 'on_hold':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return successColor;
      case 'medium':
        return warningColor;
      case 'high':
        return primaryColor;
      case 'critical':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _createNewCase() {
    ss("Create new criminal case");
  }

  void _showAdvancedFilters() {
    ss("Show advanced filters");
  }

  void _showSortOptions() {
    ss("Show sort options");
  }

  void _viewCase(String caseId) {
    ss("Viewing case $caseId");
  }

  void _editCase(String caseId) {
    ss("Editing case $caseId");
  }

  void _showCaseOptions(Map<String, dynamic> caseData) {
    ss("Case options for ${caseData["id"]}");
  }
}
