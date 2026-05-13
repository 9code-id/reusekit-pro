import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaImmigrationCasesView extends StatefulWidget {
  const LcaImmigrationCasesView({Key? key}) : super(key: key);

  @override
  State<LcaImmigrationCasesView> createState() => _LcaImmigrationCasesViewState();
}

class _LcaImmigrationCasesViewState extends State<LcaImmigrationCasesView> {
  String selectedVisaType = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> visaTypes = [
    {"label": "All Cases", "value": "all", "count": 47},
    {"label": "H-1B Visa", "value": "h1b", "count": 15},
    {"label": "L-1 Visa", "value": "l1", "count": 8},
    {"label": "Green Card", "value": "green_card", "count": 12},
    {"label": "Citizenship", "value": "citizenship", "count": 7},
    {"label": "Family Visa", "value": "family", "count": 5},
  ];

  List<Map<String, dynamic>> immigrationCases = [
    {
      "id": "IMM-2024-001",
      "client_name": "Rajesh Patel",
      "visa_type": "h1b",
      "status": "in_progress",
      "priority": "high",
      "filed_date": "2024-03-15",
      "expected_completion": "2024-08-20",
      "case_officer": "Sarah Chen, Esq.",
      "employer": "Tech Solutions Inc.",
      "petition_type": "Initial Application",
      "processing_time": 145,
      "fee_paid": 2500.0,
      "documents_status": "complete",
      "interview_scheduled": false,
    },
    {
      "id": "IMM-2024-002",
      "client_name": "Maria Rodriguez",
      "visa_type": "green_card",
      "status": "pending_review",
      "priority": "medium",
      "filed_date": "2024-02-10",
      "expected_completion": "2024-12-15",
      "case_officer": "Michael Johnson, Esq.",
      "employer": "Global Health Corp",
      "petition_type": "EB-2 Employment Based",
      "processing_time": 298,
      "fee_paid": 4200.0,
      "documents_status": "pending",
      "interview_scheduled": true,
    },
    {
      "id": "IMM-2024-003",
      "client_name": "Ahmed Hassan",
      "visa_type": "l1",
      "status": "approved",
      "priority": "low",
      "filed_date": "2024-01-20",
      "expected_completion": "2024-06-30",
      "case_officer": "Emily Rodriguez, Esq.",
      "employer": "International Consulting LLC",
      "petition_type": "L-1A Manager Transfer",
      "processing_time": 160,
      "fee_paid": 3100.0,
      "documents_status": "complete",
      "interview_scheduled": false,
    },
    {
      "id": "IMM-2024-004",
      "client_name": "Liu Wei",
      "visa_type": "citizenship",
      "status": "in_progress",
      "priority": "medium",
      "filed_date": "2024-04-05",
      "expected_completion": "2024-10-12",
      "case_officer": "David Wilson, Esq.",
      "employer": "N/A",
      "petition_type": "Naturalization Application",
      "processing_time": 98,
      "fee_paid": 1500.0,
      "documents_status": "under_review",
      "interview_scheduled": true,
    },
    {
      "id": "IMM-2024-005",
      "client_name": "Fatima Al-Zahra",
      "visa_type": "family",
      "status": "rejected",
      "priority": "high",
      "filed_date": "2024-03-22",
      "expected_completion": "N/A",
      "case_officer": "Sarah Chen, Esq.",
      "employer": "N/A",
      "petition_type": "Family Reunification",
      "processing_time": 87,
      "fee_paid": 1800.0,
      "documents_status": "incomplete",
      "interview_scheduled": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Immigration Cases"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addNewCase(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () => _showFilterOptions(),
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
                  _buildSearchAndStats(),
                  _buildVisaTypeFilter(),
                  _buildImmigrationCasesList(),
                ],
              ),
            ),
    );
  }

  Widget _buildSearchAndStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: disabledBoldColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Search immigration cases...",
                  value: searchQuery,
                  hint: "Search by client name, case ID, or visa type",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildStatCard("Total Cases", "47", Icons.folder, primaryColor),
              SizedBox(width: spSm),
              _buildStatCard("In Progress", "23", Icons.hourglass_bottom, warningColor),
              SizedBox(width: spSm),
              _buildStatCard("Approved", "18", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildStatCard("Pending", "6", Icons.schedule, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon, Color color) {
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

  Widget _buildVisaTypeFilter() {
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
            "Filter by Visa Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: visaTypes.map((visaType) {
              bool isSelected = selectedVisaType == visaType["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedVisaType = visaType["value"];
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
                      "${visaType["label"]} (${visaType["count"]})",
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

  Widget _buildImmigrationCasesList() {
    List<Map<String, dynamic>> filteredCases = _getFilteredCases();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Immigration Cases (${filteredCases.length})",
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
                      "${caseData["client_name"]}",
                      style: TextStyle(
                        fontSize: 16,
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
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${caseData["visa_type"]}".toUpperCase(),
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
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${caseData["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: priorityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "\$${((caseData["fee_paid"] as double)).currency}",
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
              Icon(Icons.business, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${caseData["employer"]}",
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
              Icon(Icons.description, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${caseData["petition_type"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.schedule, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${caseData["processing_time"]} days",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (caseData["interview_scheduled"] == true)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.event, color: infoColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    "Interview Scheduled",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Case Officer: ${caseData["case_officer"]}",
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
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCases() {
    List<Map<String, dynamic>> filtered = immigrationCases;

    if (selectedVisaType != "all") {
      filtered = filtered.where((c) => c["visa_type"] == selectedVisaType).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((c) =>
          c["client_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["visa_type"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return successColor;
      case 'in_progress':
        return warningColor;
      case 'pending_review':
        return infoColor;
      case 'rejected':
        return dangerColor;
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
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addNewCase() {
    ss("Add new immigration case");
  }

  void _showFilterOptions() {
    ss("Filter options");
  }

  void _showSortOptions() {
    ss("Sort options");
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
