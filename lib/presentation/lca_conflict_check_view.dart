import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaConflictCheckView extends StatefulWidget {
  const LcaConflictCheckView({super.key});

  @override
  State<LcaConflictCheckView> createState() => _LcaConflictCheckViewState();
}

class _LcaConflictCheckViewState extends State<LcaConflictCheckView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "";
  String selectedType = "";
  String selectedPriority = "";
  
  // Form fields for new conflict check
  String clientName = "";
  String opposingParty = "";
  String caseType = "";
  String description = "";
  String jurisdiction = "";
  String estimatedValue = "";
  String requestedBy = "";
  
  final List<Map<String, dynamic>> conflictChecks = [
    {
      "id": "CC-2024-001",
      "client_name": "TechCorp Industries",
      "opposing_party": "DataFlow Systems",
      "case_type": "Commercial Litigation",
      "status": "in_progress",
      "priority": "high",
      "requested_by": "Sarah Johnson",
      "requested_date": "2024-03-15",
      "completed_date": null,
      "jurisdiction": "California",
      "estimated_value": 2500000,
      "description": "Contract dispute regarding software licensing agreement",
      "conflicts_found": 0,
      "potential_conflicts": 2,
      "assigned_attorney": "Michael Chen",
    },
    {
      "id": "CC-2024-002", 
      "client_name": "Green Energy Solutions",
      "opposing_party": "Metropolitan Power Co",
      "case_type": "Environmental Law",
      "status": "completed",
      "priority": "medium",
      "requested_by": "David Miller",
      "requested_date": "2024-03-10",
      "completed_date": "2024-03-12",
      "jurisdiction": "New York",
      "estimated_value": 850000,
      "description": "Environmental compliance dispute",
      "conflicts_found": 1,
      "potential_conflicts": 0,
      "assigned_attorney": "Lisa Rodriguez",
    },
    {
      "id": "CC-2024-003",
      "client_name": "Retail Dynamics LLC",
      "opposing_party": "Fashion Forward Inc",
      "case_type": "Intellectual Property",
      "status": "cleared",
      "priority": "low",
      "requested_by": "Jennifer Lee",
      "requested_date": "2024-03-08",
      "completed_date": "2024-03-09",
      "jurisdiction": "Texas",
      "estimated_value": 425000,
      "description": "Trademark infringement claim",
      "conflicts_found": 0,
      "potential_conflicts": 0,
      "assigned_attorney": "Robert Kim",
    },
    {
      "id": "CC-2024-004",
      "client_name": "Healthcare Innovations",
      "opposing_party": "MedTech Solutions",
      "case_type": "Corporate Law",
      "status": "flagged",
      "priority": "high",
      "requested_by": "Maria Garcia",
      "requested_date": "2024-03-14",
      "completed_date": null,
      "jurisdiction": "Florida",
      "estimated_value": 1750000,
      "description": "Merger and acquisition due diligence",
      "conflicts_found": 3,
      "potential_conflicts": 1,
      "assigned_attorney": "James Wilson",
    },
  ];

  final List<Map<String, dynamic>> statusOptions = [
    {"label": "All Statuses", "value": ""},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cleared", "value": "cleared"},
    {"label": "Flagged", "value": "flagged"},
  ];

  final List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Commercial Litigation", "value": "commercial_litigation"},
    {"label": "Environmental Law", "value": "environmental_law"},
    {"label": "Intellectual Property", "value": "intellectual_property"},
    {"label": "Corporate Law", "value": "corporate_law"},
    {"label": "Family Law", "value": "family_law"},
    {"label": "Criminal Defense", "value": "criminal_defense"},
  ];

  final List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": ""},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  final List<Map<String, dynamic>> jurisdictionOptions = [
    {"label": "California", "value": "california"},
    {"label": "New York", "value": "new_york"},
    {"label": "Texas", "value": "texas"},
    {"label": "Florida", "value": "florida"},
    {"label": "Illinois", "value": "illinois"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'in_progress':
        return warningColor;
      case 'completed':
        return successColor;
      case 'cleared':
        return successColor;
      case 'flagged':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'in_progress':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      case 'cleared':
        return 'Cleared';
      case 'flagged':
        return 'Flagged';
      default:
        return 'Unknown';
    }
  }

  List<Map<String, dynamic>> get filteredConflictChecks {
    return conflictChecks.where((check) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${check["client_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${check["opposing_party"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${check["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus.isEmpty || check["status"] == selectedStatus;
      bool matchesType = selectedType.isEmpty || check["case_type"].toString().toLowerCase().replaceAll(' ', '_') == selectedType;
      bool matchesPriority = selectedPriority.isEmpty || check["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesType && matchesPriority;
    }).toList();
  }

  Widget _buildOverviewTab() {
    final int totalChecks = conflictChecks.length;
    final int inProgress = conflictChecks.where((c) => c["status"] == "in_progress").length;
    final int flagged = conflictChecks.where((c) => c["status"] == "flagged").length;
    final int cleared = conflictChecks.where((c) => c["status"] == "cleared").length;

    return Column(
      spacing: spMd,
      children: [
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Icon(Icons.search, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Total Checks",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "$totalChecks",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Icon(Icons.pending, color: warningColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "In Progress",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "$inProgress",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Icon(Icons.flag, color: dangerColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Flagged",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "$flagged",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Icon(Icons.check_circle, color: successColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Cleared",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "$cleared",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Search & Filter",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QTextField(
                label: "Search conflicts...",
                value: searchQuery,
                hint: "Search by client, opposing party, or ID",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: statusOptions,
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Case Type",
                      items: typeOptions,
                      value: selectedType,
                      onChanged: (value, label) {
                        selectedType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Priority",
                      items: priorityOptions,
                      value: selectedPriority,
                      onChanged: (value, label) {
                        selectedPriority = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
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
                  Text(
                    "Recent Conflict Checks",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "New Check",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: spMd),
              ...filteredConflictChecks.take(5).map((check) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _getStatusColor("${check["status"]}"),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${check["id"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor("${check["status"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    _getStatusLabel("${check["status"]}"),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor("${check["status"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${check["client_name"]} vs ${check["opposing_party"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${check["case_type"]} • ${check["jurisdiction"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNewCheckTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "New Conflict Check",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Client Name",
            value: clientName,
            hint: "Enter client or company name",
            validator: Validator.required,
            onChanged: (value) {
              clientName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Opposing Party",
            value: opposingParty,
            hint: "Enter opposing party name",
            validator: Validator.required,
            onChanged: (value) {
              opposingParty = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Case Type",
                  items: typeOptions.where((item) => item["value"] != "").toList(),
                  value: caseType,
                  onChanged: (value, label) {
                    caseType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Jurisdiction",
                  items: jurisdictionOptions,
                  value: jurisdiction,
                  onChanged: (value, label) {
                    jurisdiction = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Estimated Value (\$)",
            value: estimatedValue,
            hint: "Enter estimated case value",
            onChanged: (value) {
              estimatedValue = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Requested By",
            value: requestedBy,
            hint: "Enter requesting attorney name",
            validator: Validator.required,
            onChanged: (value) {
              requestedBy = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Case Description",
            value: description,
            hint: "Provide detailed description of the matter",
            validator: Validator.required,
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  onPressed: () {
                    clientName = "";
                    opposingParty = "";
                    caseType = "";
                    description = "";
                    jurisdiction = "";
                    estimatedValue = "";
                    requestedBy = "";
                    setState(() {
                      currentTab = 0;
                    });
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Submit Check",
                  onPressed: () {
                    if (clientName.isNotEmpty && opposingParty.isNotEmpty) {
                      ss("Conflict check submitted successfully");
                      clientName = "";
                      opposingParty = "";
                      caseType = "";
                      description = "";
                      jurisdiction = "";
                      estimatedValue = "";
                      requestedBy = "";
                      setState(() {
                        currentTab = 0;
                      });
                    } else {
                      se("Please fill in all required fields");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Conflict Check History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...filteredConflictChecks.map((check) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${check["status"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          _getStatusLabel("${check["status"]}"),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor("${check["status"]}"),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getPriorityColor("${check["priority"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${check["priority"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _getPriorityColor("${check["priority"]}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${check["id"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${check["client_name"]} vs ${check["opposing_party"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${check["description"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.business, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${check["case_type"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${check["jurisdiction"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "\$${((check["estimated_value"] as int).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Conflicts: ${check["conflicts_found"]} | Potential: ${check["potential_conflicts"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: (check["conflicts_found"] as int) > 0 ? dangerColor : successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "Requested: ${check["requested_date"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      if (check["completed_date"] != null)
                        Text(
                          "Completed: ${check["completed_date"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Conflict Check",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "New Check", icon: Icon(Icons.add_circle)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOverviewTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildNewCheckTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildHistoryTab(),
        ),
      ],
    );
  }
}
