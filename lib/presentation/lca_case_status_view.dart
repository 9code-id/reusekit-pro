import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCaseStatusView extends StatefulWidget {
  const LcaCaseStatusView({Key? key}) : super(key: key);

  @override
  State<LcaCaseStatusView> createState() => _LcaCaseStatusViewState();
}

class _LcaCaseStatusViewState extends State<LcaCaseStatusView> {
  String selectedStatus = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> statusCategories = [
    {"label": "All Cases", "value": "all", "color": primaryColor, "count": 156},
    {"label": "Active", "value": "active", "color": successColor, "count": 89},
    {"label": "Pending", "value": "pending", "color": warningColor, "count": 34},
    {"label": "On Hold", "value": "on_hold", "color": infoColor, "count": 12},
    {"label": "Closed", "value": "closed", "color": disabledBoldColor, "count": 21},
  ];

  List<Map<String, dynamic>> cases = [
    {
      "id": "LCA-2024-001",
      "title": "Smith vs. Johnson Construction",
      "client": "John Smith",
      "status": "active",
      "priority": "high",
      "last_update": "2024-06-15",
      "next_hearing": "2024-07-25",
      "case_value": 250000.0,
      "lawyer": "Sarah Johnson, Esq.",
      "type": "Personal Injury",
      "progress": 65,
    },
    {
      "id": "LCA-2024-002",
      "title": "Davis Divorce Settlement",
      "client": "Maria Davis",
      "status": "pending",
      "priority": "medium",
      "last_update": "2024-06-14",
      "next_hearing": "2024-08-10",
      "case_value": 85000.0,
      "lawyer": "Michael Chen, Esq.",
      "type": "Family Law",
      "progress": 40,
    },
    {
      "id": "LCA-2024-003",
      "title": "TechCorp Patent Dispute",
      "client": "TechCorp Industries",
      "status": "active",
      "priority": "critical",
      "last_update": "2024-06-16",
      "next_hearing": "2024-07-20",
      "case_value": 500000.0,
      "lawyer": "Emily Rodriguez, Esq.",
      "type": "Intellectual Property",
      "progress": 80,
    },
    {
      "id": "LCA-2024-004",
      "title": "Wilson Employment Contract",
      "client": "Robert Wilson",
      "status": "on_hold",
      "priority": "low",
      "last_update": "2024-06-10",
      "next_hearing": "2024-09-15",
      "case_value": 45000.0,
      "lawyer": "David Wilson, Esq.",
      "type": "Employment Law",
      "progress": 25,
    },
    {
      "id": "LCA-2024-005",
      "title": "Anderson Real Estate Deal",
      "client": "Jennifer Anderson",
      "status": "closed",
      "priority": "medium",
      "last_update": "2024-06-12",
      "next_hearing": "N/A",
      "case_value": 150000.0,
      "lawyer": "Sarah Johnson, Esq.",
      "type": "Real Estate",
      "progress": 100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Case Status Management"),
        actions: [
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
                  _buildSearchBar(),
                  _buildStatusOverview(),
                  _buildStatusCategories(),
                  _buildCasesList(),
                ],
              ),
            ),
    );
  }

  Widget _buildSearchBar() {
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
              label: "Search cases...",
              value: searchQuery,
              hint: "Search by case ID, client name, or title",
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
    );
  }

  Widget _buildStatusOverview() {
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
                child: Icon(Icons.dashboard, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Case Status Overview",
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
              _buildOverviewCard("Total Cases", "${statusCategories[0]["count"]}", Icons.folder, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Active", "${statusCategories[1]["count"]}", Icons.play_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Pending", "${statusCategories[2]["count"]}", Icons.schedule, warningColor),
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
            Icon(icon, color: color, size: 20),
            SizedBox(height: spXs),
            Text(
              count,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
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

  Widget _buildStatusCategories() {
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
            "Filter by Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: statusCategories.map((status) {
              bool isSelected = selectedStatus == status["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedStatus = status["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? (status["color"] as Color).withAlpha(30)
                          : Colors.grey.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected 
                            ? (status["color"] as Color)
                            : disabledColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: status["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${status["label"]} (${status["count"]})",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected 
                                ? (status["color"] as Color)
                                : disabledBoldColor,
                          ),
                        ),
                      ],
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
              "Cases (${filteredCases.length})",
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
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${caseData["client"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.gavel, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${caseData["type"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
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
              SizedBox(width: spSm),
              Text(
                "\$${((caseData["case_value"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "Updated: ${caseData["last_update"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (caseData["status"] != "closed")
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Progress: ${caseData["progress"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Next Hearing: ${caseData["next_hearing"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: (caseData["progress"] as int) / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ],
            ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Assigned to: ${caseData["lawyer"]}",
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
    List<Map<String, dynamic>> filtered = cases;

    if (selectedStatus != "all") {
      filtered = filtered.where((c) => c["status"] == selectedStatus).toList();
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

  void _performSearch() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 1), () {
      loading = false;
      setState(() {});
    });
  }

  void _showFilterOptions() {
    // Show filter options modal
    ss("Filter options");
  }

  void _showSortOptions() {
    // Show sort options modal
    ss("Sort options");
  }

  void _viewCase(String caseId) {
    // Navigate to case detail view
    ss("Viewing case $caseId");
  }

  void _editCase(String caseId) {
    // Navigate to edit case view
    ss("Editing case $caseId");
  }

  void _showCaseOptions(Map<String, dynamic> caseData) {
    // Show case action options
    ss("Case options for ${caseData["id"]}");
  }
}
