import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmContractManagementView extends StatefulWidget {
  const CrmContractManagementView({super.key});

  @override
  State<CrmContractManagementView> createState() => _CrmContractManagementViewState();
}

class _CrmContractManagementViewState extends State<CrmContractManagementView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  String selectedClient = "all";
  bool showFilterPanel = false;
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Contracts", "value": "all"},
    {"label": "Draft", "value": "draft"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Active", "value": "active"},
    {"label": "Expired", "value": "expired"},
    {"label": "Terminated", "value": "terminated"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": "all"},
    {"label": "Service Agreement", "value": "service"},
    {"label": "Sales Contract", "value": "sales"},
    {"label": "Partnership", "value": "partnership"},
    {"label": "NDA", "value": "nda"},
    {"label": "Employment", "value": "employment"},
  ];

  List<Map<String, dynamic>> clientItems = [
    {"label": "All Clients", "value": "all"},
    {"label": "Acme Corporation", "value": "acme"},
    {"label": "Tech Solutions Inc", "value": "tech_solutions"},
    {"label": "Global Enterprises", "value": "global"},
    {"label": "StartUp Ventures", "value": "startup"},
    {"label": "Enterprise Solutions", "value": "enterprise"},
  ];

  List<Map<String, dynamic>> contracts = [
    {
      "id": "CNT-001",
      "title": "Software Development Agreement",
      "client": "Acme Corporation",
      "type": "service",
      "status": "active",
      "value": 250000.0,
      "startDate": "2024-01-15",
      "endDate": "2024-12-31",
      "renewalDate": "2024-11-15",
      "progress": 0.65,
      "documents": 8,
      "milestones": 12,
      "completedMilestones": 8,
      "nextReview": "2024-08-15",
      "assignedTo": "John Smith",
      "priority": "high",
      "autoRenewal": true,
    },
    {
      "id": "CNT-002",
      "title": "Marketing Services Contract",
      "client": "Tech Solutions Inc",
      "type": "service",
      "status": "under_review",
      "value": 180000.0,
      "startDate": "2024-03-01",
      "endDate": "2025-02-28",
      "renewalDate": "2025-01-15",
      "progress": 0.25,
      "documents": 6,
      "milestones": 8,
      "completedMilestones": 2,
      "nextReview": "2024-07-01",
      "assignedTo": "Sarah Johnson",
      "priority": "medium",
      "autoRenewal": false,
    },
    {
      "id": "CNT-003",
      "title": "Product Sales Agreement",
      "client": "Global Enterprises",
      "type": "sales",
      "status": "draft",
      "value": 500000.0,
      "startDate": "2024-07-01",
      "endDate": "2025-06-30",
      "renewalDate": "2025-05-01",
      "progress": 0.0,
      "documents": 3,
      "milestones": 15,
      "completedMilestones": 0,
      "nextReview": "2024-06-15",
      "assignedTo": "Mike Wilson",
      "priority": "high",
      "autoRenewal": true,
    },
    {
      "id": "CNT-004",
      "title": "Partnership Agreement",
      "client": "StartUp Ventures",
      "type": "partnership",
      "status": "active",
      "value": 75000.0,
      "startDate": "2024-02-01",
      "endDate": "2026-01-31",
      "renewalDate": "2025-12-01",
      "progress": 0.85,
      "documents": 12,
      "milestones": 6,
      "completedMilestones": 5,
      "nextReview": "2024-09-01",
      "assignedTo": "Emma Davis",
      "priority": "medium",
      "autoRenewal": false,
    },
    {
      "id": "CNT-005",
      "title": "Non-Disclosure Agreement",
      "client": "Enterprise Solutions",
      "type": "nda",
      "status": "expired",
      "value": 0.0,
      "startDate": "2023-06-01",
      "endDate": "2024-05-31",
      "renewalDate": "2024-04-01",
      "progress": 1.0,
      "documents": 2,
      "milestones": 2,
      "completedMilestones": 2,
      "nextReview": "2024-06-01",
      "assignedTo": "David Brown",
      "priority": "low",
      "autoRenewal": false,
    },
  ];

  List<Map<String, dynamic>> get filteredContracts {
    return contracts.where((contract) {
      final matchesSearch = contract["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          contract["client"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          contract["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "all" || contract["status"] == selectedStatus;
      final matchesType = selectedType == "all" || contract["type"] == selectedType;
      final matchesClient = selectedClient == "all" || contract["client"].toString().toLowerCase().contains(clientItems.firstWhere((item) => item["value"] == selectedClient, orElse: () => {"label": ""})["label"].toString().toLowerCase());
      
      return matchesSearch && matchesStatus && matchesType && matchesClient;
    }).toList();
  }

  String _getStatusColor(String status) {
    switch (status) {
      case "active": return "success";
      case "draft": return "warning";
      case "under_review": return "info";
      case "expired": return "danger";
      case "terminated": return "danger";
      default: return "secondary";
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "active": return "Active";
      case "draft": return "Draft";
      case "under_review": return "Under Review";
      case "expired": return "Expired";
      case "terminated": return "Terminated";
      default: return status;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case "service": return "Service Agreement";
      case "sales": return "Sales Contract";
      case "partnership": return "Partnership";
      case "nda": return "NDA";
      case "employment": return "Employment";
      default: return type;
    }
  }

  String _getPriorityColor(String priority) {
    switch (priority) {
      case "high": return "danger";
      case "medium": return "warning";
      case "low": return "success";
      default: return "secondary";
    }
  }

  void _filterContracts() {
    setState(() {});
  }

  void _resetFilters() {
    selectedStatus = "all";
    selectedType = "all";
    selectedClient = "all";
    searchQuery = "";
    setState(() {});
  }

  void _createContract() {
    showDialog(
      context: context,
      builder: (context) => _buildCreateContractDialog(),
    );
  }

  void _editContract(Map<String, dynamic> contract) {
    showDialog(
      context: context,
      builder: (context) => _buildEditContractDialog(contract),
    );
  }

  Future<void> _deleteContract(Map<String, dynamic> contract) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this contract?");
    if (isConfirmed) {
      loading = true;
      setState(() {});
      
      await Future.delayed(Duration(seconds: 1));
      
      contracts.removeWhere((c) => c["id"] == contract["id"]);
      loading = false;
      setState(() {});
      
      ss("Contract deleted successfully");
    }
  }

  void _renewContract(Map<String, dynamic> contract) {
    showDialog(
      context: context,
      builder: (context) => _buildRenewContractDialog(contract),
    );
  }

  void _exportContracts() {
    si("Exporting contracts to PDF...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contract Management"),
        actions: [
          IconButton(
            icon: Icon(showFilterPanel ? Icons.filter_list_off : Icons.filter_list),
            onPressed: () {
              showFilterPanel = !showFilterPanel;
              setState(() {});
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: _createContract,
                child: ListTile(
                  leading: Icon(Icons.add),
                  title: Text("New Contract"),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                onTap: _exportContracts,
                child: ListTile(
                  leading: Icon(Icons.download),
                  title: Text("Export"),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: loading ? 
        Center(child: CircularProgressIndicator()) : 
        Column(
          children: [
            if (showFilterPanel) _buildFilterPanel(),
            _buildSearchBar(),
            _buildStatsCards(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  loading = true;
                  setState(() {});
                  await Future.delayed(Duration(seconds: 1));
                  loading = false;
                  setState(() {});
                },
                child: filteredContracts.isEmpty ? 
                  _buildEmptyState() : 
                  _buildContractsList(),
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createContract,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterPanel() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    _filterContracts();
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeItems,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    _filterContracts();
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Client",
                  items: clientItems,
                  value: selectedClient,
                  onChanged: (value, label) {
                    selectedClient = value;
                    _filterContracts();
                  },
                ),
              ),
              QButton(
                label: "Reset",
                size: bs.sm,
                onPressed: _resetFilters,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: QTextField(
              label: "Search contracts...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                _filterContracts();
              },
            ),
          ),
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    final activeContracts = contracts.where((c) => c["status"] == "active").length;
    final expiringSoon = contracts.where((c) => c["status"] == "active" && DateTime.parse(c["endDate"]).difference(DateTime.now()).inDays <= 30).length;
    final totalValue = contracts.where((c) => c["status"] == "active").fold(0.0, (sum, c) => sum + (c["value"] as num).toDouble());
    final averageValue = activeContracts > 0 ? totalValue / activeContracts : 0.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: _buildStatCard(
              "Active",
              "$activeContracts",
              Icons.assignment,
              successColor,
            ),
          ),
          Expanded(
            child: _buildStatCard(
              "Expiring Soon",
              "$expiringSoon",
              Icons.schedule,
              warningColor,
            ),
          ),
          Expanded(
            child: _buildStatCard(
              "Total Value",
              "\$${(totalValue / 1000).toStringAsFixed(0)}K",
              Icons.monetization_on,
              primaryColor,
            ),
          ),
          Expanded(
            child: _buildStatCard(
              "Avg Value",
              "\$${(averageValue / 1000).toStringAsFixed(0)}K",
              Icons.trending_up,
              infoColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 20),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContractsList() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredContracts.length,
      itemBuilder: (context, index) {
        final contract = filteredContracts[index];
        return _buildContractCard(contract);
      },
    );
  }

  Widget _buildContractCard(Map<String, dynamic> contract) {
    final statusColor = _getStatusColor(contract["status"]);
    final priorityColor = _getPriorityColor(contract["priority"]);
    final progress = (contract["progress"] as num).toDouble();
    final daysToExpiry = DateTime.parse(contract["endDate"]).difference(DateTime.now()).inDays;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor == "success" ? successColor :
                   statusColor == "warning" ? warningColor :
                   statusColor == "danger" ? dangerColor :
                   statusColor == "info" ? infoColor : secondaryColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Column(
          spacing: spSm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        spacing: spXs,
                        children: [
                          Text(
                            "${contract["id"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: priorityColor == "danger" ? dangerColor.withAlpha(20) :
                                     priorityColor == "warning" ? warningColor.withAlpha(20) :
                                     successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${contract["priority"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: priorityColor == "danger" ? dangerColor :
                                       priorityColor == "warning" ? warningColor : successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${contract["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${contract["client"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: spXs,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor == "success" ? successColor.withAlpha(20) :
                               statusColor == "warning" ? warningColor.withAlpha(20) :
                               statusColor == "danger" ? dangerColor.withAlpha(20) :
                               statusColor == "info" ? infoColor.withAlpha(20) :
                               secondaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        _getStatusLabel(contract["status"]),
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor == "success" ? successColor :
                                 statusColor == "warning" ? warningColor :
                                 statusColor == "danger" ? dangerColor :
                                 statusColor == "info" ? infoColor : secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if ((contract["value"] as num) > 0)
                      Text(
                        "\$${((contract["value"] as num).toDouble()).currency}",
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
            
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        spacing: spSm,
                        children: [
                          Icon(Icons.category, size: 14, color: disabledBoldColor),
                          Text(
                            _getTypeLabel(contract["type"]),
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                        ],
                      ),
                      Row(
                        spacing: spSm,
                        children: [
                          Icon(Icons.person, size: 14, color: disabledBoldColor),
                          Text(
                            "${contract["assignedTo"]}",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        spacing: spSm,
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                          Text(
                            "Ends: ${DateTime.parse(contract["endDate"]).dMMMy}",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                        ],
                      ),
                      if (daysToExpiry <= 30 && daysToExpiry > 0)
                        Row(
                          spacing: spSm,
                          children: [
                            Icon(Icons.warning, size: 14, color: warningColor),
                            Text(
                              "Expires in $daysToExpiry days",
                              style: TextStyle(fontSize: 12, color: warningColor),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),

            if (progress > 0)
              Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Progress: ${(progress * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${contract["completedMilestones"]}/${contract["milestones"]} milestones",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress >= 0.8 ? successColor : 
                      progress >= 0.5 ? warningColor : primaryColor,
                    ),
                  ),
                ],
              ),

            Row(
              children: [
                Row(
                  spacing: spSm,
                  children: [
                    Icon(Icons.folder, size: 14, color: disabledBoldColor),
                    Text(
                      "${contract["documents"]} docs",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    if (contract["autoRenewal"] == true) ...[
                      Icon(Icons.autorenew, size: 14, color: successColor),
                      Text(
                        "Auto-renew",
                        style: TextStyle(fontSize: 12, color: successColor),
                      ),
                    ],
                  ],
                ),
                Spacer(),
                Row(
                  spacing: spXs,
                  children: [
                    GestureDetector(
                      onTap: () => _editContract(contract),
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(Icons.edit, size: 16, color: primaryColor),
                      ),
                    ),
                    if (contract["status"] == "active")
                      GestureDetector(
                        onTap: () => _renewContract(contract),
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(Icons.autorenew, size: 16, color: successColor),
                        ),
                      ),
                    GestureDetector(
                      onTap: () => _deleteContract(contract),
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(Icons.delete, size: 16, color: dangerColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: spMd,
        children: [
          Icon(
            Icons.assignment,
            size: 64,
            color: disabledColor,
          ),
          Text(
            "No contracts found",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Create your first contract to get started",
            style: TextStyle(
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
          QButton(
            label: "Create Contract",
            onPressed: _createContract,
          ),
        ],
      ),
    );
  }

  Widget _buildCreateContractDialog() {
    String title = "";
    String client = "";
    String type = "service";
    String value = "";
    String startDate = DateTime.now().toString().split(' ')[0];
    String endDate = DateTime.now().add(Duration(days: 365)).toString().split(' ')[0];
    bool autoRenewal = false;

    return StatefulBuilder(
      builder: (context, setDialogState) {
        return AlertDialog(
          title: Text("Create New Contract"),
          content: SingleChildScrollView(
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Contract Title",
                  value: title,
                  onChanged: (value) => title = value,
                ),
                QTextField(
                  label: "Client Name",
                  value: client,
                  onChanged: (value) => client = value,
                ),
                QDropdownField(
                  label: "Contract Type",
                  items: typeItems.where((item) => item["value"] != "all").toList(),
                  value: type,
                  onChanged: (value, label) {
                    type = value;
                    setDialogState(() {});
                  },
                ),
                QNumberField(
                  label: "Contract Value (\$)",
                  value: value,
                  onChanged: (v) => value = v,
                ),
                QDatePicker(
                  label: "Start Date",
                  value: DateTime.parse(startDate),
                  onChanged: (date) {
                    startDate = date.toString().split(' ')[0];
                    setDialogState(() {});
                  },
                ),
                QDatePicker(
                  label: "End Date",
                  value: DateTime.parse(endDate),
                  onChanged: (date) {
                    endDate = date.toString().split(' ')[0];
                    setDialogState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Auto-renewal enabled",
                      "value": true,
                      "checked": autoRenewal,
                    }
                  ],
                  value: [if (autoRenewal) {"label": "Auto-renewal enabled", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    autoRenewal = values.isNotEmpty;
                    setDialogState(() {});
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Create",
              onPressed: () {
                if (title.isNotEmpty && client.isNotEmpty) {
                  final newContract = {
                    "id": "CNT-${(contracts.length + 1).toString().padLeft(3, '0')}",
                    "title": title,
                    "client": client,
                    "type": type,
                    "status": "draft",
                    "value": double.tryParse(value) ?? 0.0,
                    "startDate": startDate,
                    "endDate": endDate,
                    "renewalDate": DateTime.parse(endDate).subtract(Duration(days: 30)).toString().split(' ')[0],
                    "progress": 0.0,
                    "documents": 0,
                    "milestones": 0,
                    "completedMilestones": 0,
                    "nextReview": DateTime.now().add(Duration(days: 30)).toString().split(' ')[0],
                    "assignedTo": "Current User",
                    "priority": "medium",
                    "autoRenewal": autoRenewal,
                  };
                  
                  contracts.insert(0, newContract);
                  setState(() {});
                  Navigator.pop(context);
                  ss("Contract created successfully");
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditContractDialog(Map<String, dynamic> contract) {
    String title = contract["title"];
    String client = contract["client"];
    String type = contract["type"];
    String value = contract["value"].toString();
    String startDate = contract["startDate"];
    String endDate = contract["endDate"];
    bool autoRenewal = contract["autoRenewal"] ?? false;

    return StatefulBuilder(
      builder: (context, setDialogState) {
        return AlertDialog(
          title: Text("Edit Contract"),
          content: SingleChildScrollView(
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Contract Title",
                  value: title,
                  onChanged: (value) => title = value,
                ),
                QTextField(
                  label: "Client Name",
                  value: client,
                  onChanged: (value) => client = value,
                ),
                QDropdownField(
                  label: "Contract Type",
                  items: typeItems.where((item) => item["value"] != "all").toList(),
                  value: type,
                  onChanged: (value, label) {
                    type = value;
                    setDialogState(() {});
                  },
                ),
                QNumberField(
                  label: "Contract Value (\$)",
                  value: value,
                  onChanged: (v) => value = v,
                ),
                QDatePicker(
                  label: "Start Date",
                  value: DateTime.parse(startDate),
                  onChanged: (date) {
                    startDate = date.toString().split(' ')[0];
                    setDialogState(() {});
                  },
                ),
                QDatePicker(
                  label: "End Date",
                  value: DateTime.parse(endDate),
                  onChanged: (date) {
                    endDate = date.toString().split(' ')[0];
                    setDialogState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Auto-renewal enabled",
                      "value": true,
                      "checked": autoRenewal,
                    }
                  ],
                  value: [if (autoRenewal) {"label": "Auto-renewal enabled", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    autoRenewal = values.isNotEmpty;
                    setDialogState(() {});
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Update",
              onPressed: () {
                contract["title"] = title;
                contract["client"] = client;
                contract["type"] = type;
                contract["value"] = double.tryParse(value) ?? 0.0;
                contract["startDate"] = startDate;
                contract["endDate"] = endDate;
                contract["autoRenewal"] = autoRenewal;
                
                setState(() {});
                Navigator.pop(context);
                ss("Contract updated successfully");
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildRenewContractDialog(Map<String, dynamic> contract) {
    String newEndDate = DateTime.parse(contract["endDate"]).add(Duration(days: 365)).toString().split(' ')[0];
    String newValue = contract["value"].toString();
    bool autoRenewal = contract["autoRenewal"] ?? false;

    return StatefulBuilder(
      builder: (context, setDialogState) {
        return AlertDialog(
          title: Text("Renew Contract"),
          content: Column(
            spacing: spSm,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Contract: ${contract["title"]}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Current end date: ${DateTime.parse(contract["endDate"]).dMMMy}",
                style: TextStyle(color: disabledBoldColor),
              ),
              QDatePicker(
                label: "New End Date",
                value: DateTime.parse(newEndDate),
                onChanged: (date) {
                  newEndDate = date.toString().split(' ')[0];
                  setDialogState(() {});
                },
              ),
              QNumberField(
                label: "New Contract Value (\$)",
                value: newValue,
                onChanged: (v) => newValue = v,
              ),
              QSwitch(
                items: [
                  {
                    "label": "Auto-renewal enabled",
                    "value": true,
                    "checked": autoRenewal,
                  }
                ],
                value: [if (autoRenewal) {"label": "Auto-renewal enabled", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  autoRenewal = values.isNotEmpty;
                  setDialogState(() {});
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Renew Contract",
              onPressed: () {
                contract["endDate"] = newEndDate;
                contract["value"] = double.tryParse(newValue) ?? contract["value"];
                contract["autoRenewal"] = autoRenewal;
                contract["renewalDate"] = DateTime.parse(newEndDate).subtract(Duration(days: 30)).toString().split(' ')[0];
                contract["status"] = "active";
                
                setState(() {});
                Navigator.pop(context);
                ss("Contract renewed successfully");
              },
            ),
          ],
        );
      },
    );
  }
}
