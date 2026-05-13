import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCasePriorityView extends StatefulWidget {
  const LcaCasePriorityView({Key? key}) : super(key: key);

  @override
  State<LcaCasePriorityView> createState() => _LcaCasePriorityViewState();
}

class _LcaCasePriorityViewState extends State<LcaCasePriorityView> {
  String selectedPriority = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> priorityLevels = [
    {"label": "All Priorities", "value": "all", "color": primaryColor, "count": 156, "icon": Icons.all_inclusive},
    {"label": "Critical", "value": "critical", "color": dangerColor, "count": 8, "icon": Icons.priority_high},
    {"label": "High", "value": "high", "color": primaryColor, "count": 32, "icon": Icons.keyboard_arrow_up},
    {"label": "Medium", "value": "medium", "color": warningColor, "count": 89, "icon": Icons.remove},
    {"label": "Low", "value": "low", "color": successColor, "count": 27, "icon": Icons.keyboard_arrow_down},
  ];

  List<Map<String, dynamic>> cases = [
    {
      "id": "LCA-2024-003",
      "title": "TechCorp Patent Dispute",
      "client": "TechCorp Industries",
      "priority": "critical",
      "status": "active",
      "case_value": 500000.0,
      "deadline": "2024-07-20",
      "lawyer": "Emily Rodriguez, Esq.",
      "type": "Intellectual Property",
      "urgency_score": 95,
      "last_update": "2024-06-16",
      "estimated_hours": 120,
      "time_sensitive": true,
    },
    {
      "id": "LCA-2024-001",
      "title": "Smith vs. Johnson Construction",
      "client": "John Smith",
      "priority": "high",
      "status": "active",
      "case_value": 250000.0,
      "deadline": "2024-07-25",
      "lawyer": "Sarah Johnson, Esq.",
      "type": "Personal Injury",
      "urgency_score": 78,
      "last_update": "2024-06-15",
      "estimated_hours": 80,
      "time_sensitive": true,
    },
    {
      "id": "LCA-2024-006",
      "title": "Miller Criminal Defense",
      "client": "James Miller",
      "priority": "high",
      "status": "pending",
      "case_value": 75000.0,
      "deadline": "2024-08-05",
      "lawyer": "Michael Chen, Esq.",
      "type": "Criminal Defense",
      "urgency_score": 82,
      "last_update": "2024-06-14",
      "estimated_hours": 60,
      "time_sensitive": true,
    },
    {
      "id": "LCA-2024-002",
      "title": "Davis Divorce Settlement",
      "client": "Maria Davis",
      "priority": "medium",
      "status": "pending",
      "case_value": 85000.0,
      "deadline": "2024-08-10",
      "lawyer": "Michael Chen, Esq.",
      "type": "Family Law",
      "urgency_score": 55,
      "last_update": "2024-06-14",
      "estimated_hours": 40,
      "time_sensitive": false,
    },
    {
      "id": "LCA-2024-004",
      "title": "Wilson Employment Contract",
      "client": "Robert Wilson",
      "priority": "low",
      "status": "on_hold",
      "case_value": 45000.0,
      "deadline": "2024-09-15",
      "lawyer": "David Wilson, Esq.",
      "type": "Employment Law",
      "urgency_score": 25,
      "last_update": "2024-06-10",
      "estimated_hours": 25,
      "time_sensitive": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Case Priority Management"),
        actions: [
          QButton(
            icon: Icons.sort,
            size: bs.sm,
            onPressed: () => _showSortOptions(),
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
                  _buildPriorityOverview(),
                  _buildPriorityMatrix(),
                  _buildPriorityCategories(),
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
              label: "Search cases by priority...",
              value: searchQuery,
              hint: "Search by case title, client, or priority level",
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
            onPressed: () => _showFilterOptions(),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: dangerColor.withAlpha(50)),
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
                  color: dangerColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.priority_high, color: dangerColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Priority Dashboard",
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
              _buildPriorityCard("Critical", "8", Icons.warning, dangerColor),
              SizedBox(width: spSm),
              _buildPriorityCard("High", "32", Icons.arrow_upward, primaryColor),
              SizedBox(width: spSm),
              _buildPriorityCard("Urgent", "12", Icons.schedule, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityCard(String title, String count, IconData icon, Color color) {
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

  Widget _buildPriorityMatrix() {
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
            "Priority Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildPriorityBar("Critical", priorityLevels[1]["count"], dangerColor, 156),
              ),
              SizedBox(width: spSm),
              Expanded(
                flex: 3,
                child: _buildPriorityBar("High", priorityLevels[2]["count"], primaryColor, 156),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: _buildPriorityBar("Medium", priorityLevels[3]["count"], warningColor, 156),
              ),
              SizedBox(width: spSm),
              Expanded(
                flex: 2,
                child: _buildPriorityBar("Low", priorityLevels[4]["count"], successColor, 156),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityBar(String label, int count, Color color, int total) {
    double percentage = (count / total) * 100;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            Spacer(),
            Text(
              "$count (${percentage.toStringAsFixed(1)}%)",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: disabledColor,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriorityCategories() {
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
            "Filter by Priority Level",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: priorityLevels.map((priority) {
              bool isSelected = selectedPriority == priority["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedPriority = priority["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? (priority["color"] as Color).withAlpha(30)
                          : Colors.grey.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected 
                            ? (priority["color"] as Color)
                            : disabledColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          priority["icon"] as IconData,
                          color: priority["color"] as Color,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${priority["label"]} (${priority["count"]})",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected 
                                ? (priority["color"] as Color)
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
    filteredCases.sort((a, b) => (b["urgency_score"] as int).compareTo(a["urgency_score"] as int));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Cases by Priority (${filteredCases.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "Sorted by Urgency Score",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        ...filteredCases.map((caseData) => _buildCaseCard(caseData)),
      ],
    );
  }

  Widget _buildCaseCard(Map<String, dynamic> caseData) {
    Color priorityColor = _getPriorityColor(caseData["priority"]);
    bool isTimeSensitive = caseData["time_sensitive"] as bool;
    int urgencyScore = caseData["urgency_score"] as int;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: priorityColor,
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
                        if (isTimeSensitive) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "TIME SENSITIVE",
                              style: TextStyle(
                                fontSize: 8,
                                color: dangerColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
                  color: priorityColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getPriorityIcon(caseData["priority"]),
                      color: priorityColor,
                      size: 12,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${caseData["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        color: priorityColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
              Icon(Icons.schedule, color: warningColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Due: ${caseData["deadline"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: priorityColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: priorityColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Urgency Score",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "$urgencyScore/100",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: priorityColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: urgencyScore / 100,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(priorityColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spMd),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Case Value",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((caseData["case_value"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Assigned: ${caseData["lawyer"]} • Est. ${caseData["estimated_hours"]}h",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.priority_high,
                size: bs.sm,
                onPressed: () => _adjustPriority(caseData),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewCase(caseData["id"]),
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

    if (selectedPriority != "all") {
      filtered = filtered.where((c) => c["priority"] == selectedPriority).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((c) =>
          c["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["client"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["priority"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return primaryColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getPriorityIcon(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return Icons.warning;
      case 'high':
        return Icons.keyboard_arrow_up;
      case 'medium':
        return Icons.remove;
      case 'low':
        return Icons.keyboard_arrow_down;
      default:
        return Icons.help;
    }
  }

  void _showFilterOptions() {
    ss("Filter options");
  }

  void _showSortOptions() {
    ss("Sort options");
  }

  void _adjustPriority(Map<String, dynamic> caseData) {
    ss("Adjust priority for ${caseData["id"]}");
  }

  void _viewCase(String caseId) {
    ss("Viewing case $caseId");
  }

  void _showCaseOptions(Map<String, dynamic> caseData) {
    ss("Case options for ${caseData["id"]}");
  }
}
