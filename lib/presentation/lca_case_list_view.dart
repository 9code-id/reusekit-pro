import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCaseListView extends StatefulWidget {
  const LcaCaseListView({super.key});

  @override
  State<LcaCaseListView> createState() => _LcaCaseListViewState();
}

class _LcaCaseListViewState extends State<LcaCaseListView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  String selectedPriority = "All";
  String sortBy = "Recent";

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "On Hold", "value": "On Hold"},
    {"label": "Closed", "value": "Closed"},
    {"label": "Settled", "value": "Settled"},
  ];

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All", "value": "All"},
    {"label": "Civil Litigation", "value": "Civil Litigation"},
    {"label": "Criminal Defense", "value": "Criminal Defense"},
    {"label": "Corporate Law", "value": "Corporate Law"},
    {"label": "Family Law", "value": "Family Law"},
    {"label": "Personal Injury", "value": "Personal Injury"},
  ];

  List<Map<String, dynamic>> priorityFilters = [
    {"label": "All", "value": "All"},
    {"label": "Urgent", "value": "Urgent"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recent", "value": "Recent"},
    {"label": "Oldest", "value": "Oldest"},
    {"label": "Priority", "value": "Priority"},
    {"label": "Case Value", "value": "Case Value"},
    {"label": "Client Name", "value": "Client Name"},
  ];

  List<Map<String, dynamic>> cases = [
    {
      "id": "CASE-2024-001",
      "title": "Thompson vs. ABC Corporation",
      "type": "Civil Litigation",
      "status": "Active",
      "priority": "High",
      "client": "Robert Thompson",
      "assignedLawyer": "Sarah Johnson",
      "caseValue": 250000.0,
      "nextHearing": "2024-02-15",
      "daysRemaining": 12,
      "progress": 65,
      "lastUpdate": "2024-02-03",
      "documents": 15,
      "billableHours": 45.5,
    },
    {
      "id": "CASE-2024-002",
      "title": "Estate Planning - Wilson Family",
      "type": "Family Law",
      "status": "Pending",
      "priority": "Medium",
      "client": "Margaret Wilson",
      "assignedLawyer": "Michael Chen",
      "caseValue": 75000.0,
      "nextHearing": "2024-02-20",
      "daysRemaining": 17,
      "progress": 30,
      "lastUpdate": "2024-02-01",
      "documents": 8,
      "billableHours": 22.0,
    },
    {
      "id": "CASE-2024-003",
      "title": "Criminal Defense - State vs. Martinez",
      "type": "Criminal Defense",
      "status": "Active",
      "priority": "Urgent",
      "client": "Carlos Martinez",
      "assignedLawyer": "Emily Rodriguez",
      "caseValue": 0.0,
      "nextHearing": "2024-02-08",
      "daysRemaining": 5,
      "progress": 80,
      "lastUpdate": "2024-02-02",
      "documents": 25,
      "billableHours": 67.5,
    },
    {
      "id": "CASE-2024-004",
      "title": "Corporate Merger - TechCorp Acquisition",
      "type": "Corporate Law",
      "status": "Active",
      "priority": "High",
      "client": "TechCorp Industries",
      "assignedLawyer": "David Thompson",
      "caseValue": 1500000.0,
      "nextHearing": "",
      "daysRemaining": 0,
      "progress": 45,
      "lastUpdate": "2024-01-30",
      "documents": 42,
      "billableHours": 89.0,
    },
    {
      "id": "CASE-2024-005",
      "title": "Personal Injury - Motorcycle Accident",
      "type": "Personal Injury",
      "status": "Settled",
      "priority": "Low",
      "client": "Jennifer Adams",
      "assignedLawyer": "Lisa Anderson",
      "caseValue": 125000.0,
      "nextHearing": "",
      "daysRemaining": 0,
      "progress": 100,
      "lastUpdate": "2024-01-28",
      "documents": 18,
      "billableHours": 38.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Case Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _createNewCase(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          Expanded(
            child: _buildCaseList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search cases...",
                  value: searchQuery,
                  hint: "Search by case title, client, or case number",
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
                onPressed: () => _performSearch(),
              ),
            ],
          ),
          
          // Filter Row
          QHorizontalScroll(
            children: [
              _buildFilterChip("Status", selectedStatus, statusFilters),
              _buildFilterChip("Type", selectedType, typeFilters),
              _buildFilterChip("Priority", selectedPriority, priorityFilters),
              _buildSortChip(),
            ],
          ),
          
          // Active Filters Summary
          if (_hasActiveFilters()) _buildActiveFilters(),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String selectedValue, List<Map<String, dynamic>> options) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      child: GestureDetector(
        onTap: () => _showFilterDialog(label, selectedValue, options),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: selectedValue != "All" ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: selectedValue != "All" ? primaryColor : disabledOutlineBorderColor,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$label: $selectedValue",
                style: TextStyle(
                  fontSize: 12,
                  color: selectedValue != "All" ? primaryColor : disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: spXs),
              Icon(
                Icons.arrow_drop_down,
                size: 16,
                color: selectedValue != "All" ? primaryColor : disabledBoldColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSortChip() {
    return Container(
      child: GestureDetector(
        onTap: () => _showSortDialog(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.sort,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Sort: $sortBy",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveFilters() {
    List<String> activeFilters = [];
    if (selectedStatus != "All") activeFilters.add(selectedStatus);
    if (selectedType != "All") activeFilters.add(selectedType);
    if (selectedPriority != "All") activeFilters.add(selectedPriority);

    return Container(
      padding: EdgeInsets.only(top: spSm),
      child: Row(
        children: [
          Text(
            "Active filters:",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Wrap(
              spacing: spXs,
              children: activeFilters.map((filter) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),
          ),
          GestureDetector(
            onTap: _clearFilters,
            child: Text(
              "Clear all",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaseList() {
    List<Map<String, dynamic>> filteredCases = _getFilteredCases();

    if (filteredCases.isEmpty) {
      return _buildEmptyState();
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          _buildCaseStats(),
          ...filteredCases.map((caseData) => _buildCaseCard(caseData)),
        ],
      ),
    );
  }

  Widget _buildCaseStats() {
    List<Map<String, dynamic>> filteredCases = _getFilteredCases();
    int totalCases = filteredCases.length;
    int activeCases = filteredCases.where((c) => c["status"] == "Active").length;
    int urgentCases = filteredCases.where((c) => c["priority"] == "Urgent").length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("Total Cases", totalCases.toString(), Icons.folder, primaryColor),
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: _buildStatItem("Active", activeCases.toString(), Icons.play_circle, successColor),
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: _buildStatItem("Urgent", urgentCases.toString(), Icons.priority_high, dangerColor),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCaseCard(Map<String, dynamic> caseData) {
    Color priorityColor = _getPriorityColor(caseData["priority"]);
    Color statusColor = _getStatusColor(caseData["status"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${caseData["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${caseData["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${caseData["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Case Info Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(Icons.person, "Client", "${caseData["client"]}"),
                    SizedBox(height: spXs),
                    _buildInfoRow(Icons.gavel, "Type", "${caseData["type"]}"),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(Icons.account_balance, "Lawyer", "${caseData["assignedLawyer"]}"),
                    SizedBox(height: spXs),
                    _buildInfoRow(Icons.flag, "Priority", "${caseData["priority"]}"),
                  ],
                ),
              ),
            ],
          ),

          // Financial & Progress Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ((caseData["caseValue"] as double) > 0)
                      _buildInfoRow(Icons.attach_money, "Value", "\$${((caseData["caseValue"] as double)).currency}"),
                    SizedBox(height: spXs),
                    _buildInfoRow(Icons.access_time, "Hours", "${(caseData["billableHours"] as double).toStringAsFixed(1)}h"),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: (caseData["progress"] as int) / 100,
                            backgroundColor: Colors.grey.withAlpha(50),
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${caseData["progress"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Next Hearing Info
          if (caseData["nextHearing"] != "")
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (caseData["daysRemaining"] as int) <= 7 
                  ? dangerColor.withAlpha(20) 
                  : infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: (caseData["daysRemaining"] as int) <= 7 ? dangerColor : infoColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Next hearing: ${caseData["nextHearing"]} (${caseData["daysRemaining"]} days)",
                    style: TextStyle(
                      fontSize: 12,
                      color: (caseData["daysRemaining"] as int) <= 7 ? dangerColor : infoColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewCaseDetails(caseData),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editCase(caseData),
              ),
              SizedBox(width: spXs),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Text(
          "$label: ",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 64,
            color: disabledColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No cases found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            searchQuery.isNotEmpty
              ? "No cases match your search criteria"
              : "Create your first case to get started",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Create New Case",
            icon: Icons.add,
            size: bs.md,
            onPressed: () => _createNewCase(),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Urgent":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "On Hold":
        return infoColor;
      case "Closed":
      case "Settled":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  List<Map<String, dynamic>> _getFilteredCases() {
    return cases.where((caseData) {
      // Search filter
      if (searchQuery.isNotEmpty) {
        String searchLower = searchQuery.toLowerCase();
        if (!caseData["title"].toString().toLowerCase().contains(searchLower) &&
            !caseData["client"].toString().toLowerCase().contains(searchLower) &&
            !caseData["id"].toString().toLowerCase().contains(searchLower)) {
          return false;
        }
      }

      // Status filter
      if (selectedStatus != "All" && caseData["status"] != selectedStatus) {
        return false;
      }

      // Type filter
      if (selectedType != "All" && caseData["type"] != selectedType) {
        return false;
      }

      // Priority filter
      if (selectedPriority != "All" && caseData["priority"] != selectedPriority) {
        return false;
      }

      return true;
    }).toList();
  }

  bool _hasActiveFilters() {
    return selectedStatus != "All" || selectedType != "All" || selectedPriority != "All";
  }

  void _clearFilters() {
    setState(() {
      selectedStatus = "All";
      selectedType = "All";
      selectedPriority = "All";
      searchQuery = "";
    });
  }

  void _showFilterDialog(String label, String currentValue, List<Map<String, dynamic>> options) {
    // Show filter dialog implementation
  }

  void _showSortDialog() {
    // Show sort dialog implementation
  }

  void _performSearch() {
    setState(() {});
  }

  void _createNewCase() {
    // Navigate to case creation
  }

  void _viewCaseDetails(Map<String, dynamic> caseData) {
    // Navigate to case details
  }

  void _editCase(Map<String, dynamic> caseData) {
    // Navigate to case editing
  }

  void _showCaseOptions(Map<String, dynamic> caseData) {
    // Show case options menu
  }
}
