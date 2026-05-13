import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaRetainerAgreementsView extends StatefulWidget {
  const LcaRetainerAgreementsView({super.key});

  @override
  State<LcaRetainerAgreementsView> createState() => _LcaRetainerAgreementsViewState();
}

class _LcaRetainerAgreementsViewState extends State<LcaRetainerAgreementsView> {
  bool loading = false;
  String selectedStatus = "all";
  String selectedClient = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Pending", "value": "pending"},
    {"label": "Expired", "value": "expired"},
    {"label": "Terminated", "value": "terminated"},
  ];

  List<Map<String, dynamic>> clientOptions = [
    {"label": "All Clients", "value": "all"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Michael Chen", "value": "michael_chen"},
    {"label": "Emma Wilson", "value": "emma_wilson"},
    {"label": "TechStart Inc", "value": "techstart_inc"},
    {"label": "GlobalCorp Ltd", "value": "globalcorp_ltd"},
  ];

  List<Map<String, dynamic>> retainerAgreements = [
    {
      "id": "RA-2024-001",
      "clientName": "Sarah Johnson",
      "clientId": "sarah_johnson",
      "practiceArea": "Corporate Law",
      "startDate": "2024-01-15",
      "endDate": "2025-01-15",
      "retainerAmount": 25000.0,
      "usedAmount": 12500.0,
      "hourlyRate": 350.0,
      "status": "active",
      "description": "General corporate legal services and contract review",
      "renewalDate": "2024-12-15",
      "scope": "Legal consultation, contract review, compliance advice",
      "lastActivity": "2024-06-18",
      "attorney": "Michael Davis",
      "notes": "VIP client - priority handling required",
    },
    {
      "id": "RA-2024-002",
      "clientName": "TechStart Inc",
      "clientId": "techstart_inc",
      "practiceArea": "Intellectual Property",
      "startDate": "2024-03-01",
      "endDate": "2025-03-01",
      "retainerAmount": 50000.0,
      "usedAmount": 8200.0,
      "hourlyRate": 400.0,
      "status": "active",
      "description": "IP protection and patent filing services",
      "renewalDate": "2024-12-01",
      "scope": "Patent applications, trademark registration, IP litigation",
      "lastActivity": "2024-06-19",
      "attorney": "Sarah Kim",
      "notes": "Fast-growing startup with significant IP portfolio",
    },
    {
      "id": "RA-2023-089",
      "clientName": "Emma Wilson",
      "clientId": "emma_wilson",
      "practiceArea": "Employment Law",
      "startDate": "2023-08-01",
      "endDate": "2024-08-01",
      "retainerAmount": 15000.0,
      "usedAmount": 14800.0,
      "hourlyRate": 320.0,
      "status": "pending",
      "description": "Employment law consultation and policy development",
      "renewalDate": "2024-07-01",
      "scope": "HR policies, employment contracts, workplace compliance",
      "lastActivity": "2024-06-10",
      "attorney": "David Rodriguez",
      "notes": "Renewal discussion scheduled for next week",
    },
    {
      "id": "RA-2023-067",
      "clientName": "GlobalCorp Ltd",
      "clientId": "globalcorp_ltd",
      "practiceArea": "International Law",
      "startDate": "2023-05-15",
      "endDate": "2024-05-15",
      "retainerAmount": 100000.0,
      "usedAmount": 98500.0,
      "hourlyRate": 450.0,
      "status": "expired",
      "description": "International business law and regulatory compliance",
      "renewalDate": "2024-04-15",
      "scope": "Cross-border transactions, regulatory compliance, trade law",
      "lastActivity": "2024-05-20",
      "attorney": "Jennifer Lee",
      "notes": "Client considering renewal with increased retainer amount",
    },
    {
      "id": "RA-2023-045",
      "clientName": "Michael Chen",
      "clientId": "michael_chen",
      "practiceArea": "Business Law",
      "startDate": "2023-12-01",
      "endDate": "2024-12-01",
      "retainerAmount": 30000.0,
      "usedAmount": 0.0,
      "hourlyRate": 375.0,
      "status": "terminated",
      "description": "Business formation and ongoing legal support",
      "renewalDate": "2024-11-01",
      "scope": "Business formation, contracts, regulatory compliance",
      "lastActivity": "2024-02-15",
      "attorney": "Robert Wilson",
      "notes": "Client terminated early due to business pivot",
    },
  ];

  List<Map<String, dynamic>> get filteredAgreements {
    List<Map<String, dynamic>> filtered = retainerAgreements;
    
    if (selectedStatus != "all") {
      filtered = filtered.where((agreement) => agreement["status"] == selectedStatus).toList();
    }
    
    if (selectedClient != "all") {
      filtered = filtered.where((agreement) => agreement["clientId"] == selectedClient).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((agreement) {
        return agreement["clientName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               agreement["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               agreement["practiceArea"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retainer Agreements"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateRetainerDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              si("Opening retainer analytics");
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRetainerStats(),
                  _buildSearchAndFilters(),
                  _buildRetainersList(),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateRetainerDialog();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildRetainerStats() {
    int totalAgreements = retainerAgreements.length;
    int activeAgreements = retainerAgreements.where((r) => r["status"] == "active").length;
    double totalRetainerValue = retainerAgreements.fold(0.0, (sum, r) => sum + (r["retainerAmount"] as double));
    double totalUsedAmount = retainerAgreements.fold(0.0, (sum, r) => sum + (r["usedAmount"] as double));

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Agreements", totalAgreements.toString(), Icons.description, primaryColor),
        _buildStatCard("Active", activeAgreements.toString(), Icons.check_circle, successColor),
        _buildStatCard("Total Value", "\$${totalRetainerValue.currency}", Icons.attach_money, infoColor),
        _buildStatCard("Used Amount", "\$${totalUsedAmount.currency}", Icons.trending_down, warningColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Search & Filter",
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
              Expanded(
                child: QTextField(
                  label: "Search agreements...",
                  value: searchQuery,
                  hint: "Search by client, ID, or practice area",
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
                onPressed: () {
                  // Search is already handled by onChanged
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Status",
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
                  label: "Filter by Client",
                  items: clientOptions,
                  value: selectedClient,
                  onChanged: (value, label) {
                    selectedClient = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRetainersList() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.folder_special, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Retainer Agreements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredAgreements.length} agreements",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (filteredAgreements.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.search_off, color: disabledBoldColor, size: 48),
                    SizedBox(height: spSm),
                    Text(
                      "No retainer agreements found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...filteredAgreements.map((agreement) => _buildRetainerItem(agreement)).toList(),
        ],
      ),
    );
  }

  Widget _buildRetainerItem(Map<String, dynamic> agreement) {
    Color statusColor = _getStatusColor(agreement["status"]);
    double remainingAmount = (agreement["retainerAmount"] as double) - (agreement["usedAmount"] as double);
    double usagePercentage = (agreement["usedAmount"] as double) / (agreement["retainerAmount"] as double) * 100;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(13),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${agreement["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${agreement["clientName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${agreement["practiceArea"]} • ${agreement["attorney"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${agreement["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Rate: \$${((agreement["hourlyRate"] as double).toDouble()).currency}/hr",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(128),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${agreement["description"]}",
              style: TextStyle(
                fontSize: 13,
                color: primaryColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Scope: ",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${agreement["scope"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if (agreement["notes"].toString().isNotEmpty)
                  Row(
                    children: [
                      Text(
                        "Notes: ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${agreement["notes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: infoColor,
                          ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Retainer Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((agreement["retainerAmount"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Used (${usagePercentage.toStringAsFixed(1)}%)",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((agreement["usedAmount"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Remaining",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${remainingAmount.currency}",
                      style: TextStyle(
                        fontSize: 16,
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
            height: 6,
            decoration: BoxDecoration(
              color: disabledOutlineBorderColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              widthFactor: usagePercentage / 100,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: usagePercentage > 80 ? dangerColor : 
                         usagePercentage > 60 ? warningColor : successColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Period: ${agreement["startDate"]} to ${agreement["endDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Renewal: ${agreement["renewalDate"]} • Last Activity: ${agreement["lastActivity"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  icon: Icons.visibility,
                  size: bs.sm,
                  onPressed: () {
                    _showRetainerDetails(agreement);
                  },
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  si("Editing ${agreement["id"]}");
                },
              ),
              SizedBox(width: spXs),
              if (agreement["status"] == "active")
                QButton(
                  icon: Icons.add_task,
                  size: bs.sm,
                  onPressed: () {
                    _showLogTimeDialog(agreement);
                  },
                ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showRetainerMenu(agreement);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "pending":
        return warningColor;
      case "expired":
        return dangerColor;
      case "terminated":
        return disabledBoldColor;
      default:
        return infoColor;
    }
  }

  void _showCreateRetainerDialog() {
    String clientName = "";
    String practiceArea = "";
    String retainerAmount = "";
    String hourlyRate = "";
    String startDate = DateTime.now().toString().split(' ')[0];
    String endDate = DateTime.now().add(Duration(days: 365)).toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Retainer Agreement"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Client",
                items: clientOptions.where((item) => item["value"] != "all").toList(),
                value: clientName,
                onChanged: (value, label) => clientName = value,
              ),
              QTextField(
                label: "Practice Area",
                value: practiceArea,
                validator: Validator.required,
                onChanged: (value) => practiceArea = value,
              ),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Retainer Amount (\$)",
                      value: retainerAmount,
                      validator: Validator.required,
                      onChanged: (value) => retainerAmount = value,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Hourly Rate (\$)",
                      value: hourlyRate,
                      validator: Validator.required,
                      onChanged: (value) => hourlyRate = value,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QDatePicker(
                      label: "Start Date",
                      value: DateTime.parse(startDate),
                      onChanged: (value) => startDate = value.toString().split(' ')[0],
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDatePicker(
                      label: "End Date",
                      value: DateTime.parse(endDate),
                      onChanged: (value) => endDate = value.toString().split(' ')[0],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (clientName.isNotEmpty && practiceArea.isNotEmpty && 
                  retainerAmount.isNotEmpty && hourlyRate.isNotEmpty) {
                Navigator.pop(context);
                ss("Retainer agreement created successfully");
              } else {
                se("Please fill in all required fields");
              }
            },
            child: Text("Create Agreement"),
          ),
        ],
      ),
    );
  }

  void _showRetainerDetails(Map<String, dynamic> agreement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${agreement["id"]} Details"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              _buildDetailRow("Client", agreement["clientName"]),
              _buildDetailRow("Practice Area", agreement["practiceArea"]),
              _buildDetailRow("Attorney", agreement["attorney"]),
              _buildDetailRow("Status", agreement["status"]),
              _buildDetailRow("Retainer Amount", "\$${((agreement["retainerAmount"] as double).toDouble()).currency}"),
              _buildDetailRow("Used Amount", "\$${((agreement["usedAmount"] as double).toDouble()).currency}"),
              _buildDetailRow("Hourly Rate", "\$${((agreement["hourlyRate"] as double).toDouble()).currency}/hr"),
              _buildDetailRow("Start Date", agreement["startDate"]),
              _buildDetailRow("End Date", agreement["endDate"]),
              _buildDetailRow("Renewal Date", agreement["renewalDate"]),
              _buildDetailRow("Last Activity", agreement["lastActivity"]),
              if (agreement["notes"].toString().isNotEmpty)
                _buildDetailRow("Notes", agreement["notes"]),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              si("Downloading ${agreement["id"]} document");
            },
            child: Text("Download"),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  void _showLogTimeDialog(Map<String, dynamic> agreement) {
    String hours = "";
    String description = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Log Time - ${agreement["clientName"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QNumberField(
              label: "Hours",
              value: hours,
              hint: "e.g., 2.5",
              validator: Validator.required,
              onChanged: (value) => hours = value,
            ),
            QMemoField(
              label: "Description",
              value: description,
              validator: Validator.required,
              hint: "Describe the work performed",
              onChanged: (value) => description = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (hours.isNotEmpty && description.isNotEmpty) {
                Navigator.pop(context);
                double timeValue = double.tryParse(hours) ?? 0.0;
                double cost = timeValue * (agreement["hourlyRate"] as double);
                ss("Time logged: ${timeValue}h - \$${cost.currency}");
              } else {
                se("Please fill in all fields");
              }
            },
            child: Text("Log Time"),
          ),
        ],
      ),
    );
  }

  void _showRetainerMenu(Map<String, dynamic> agreement) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 200, 0, 0),
      items: [
        PopupMenuItem(
          value: "edit",
          child: Text("Edit Agreement"),
        ),
        PopupMenuItem(
          value: "renew",
          child: Text("Renew Agreement"),
        ),
        PopupMenuItem(
          value: "time_entries",
          child: Text("View Time Entries"),
        ),
        PopupMenuItem(
          value: "invoice",
          child: Text("Generate Invoice"),
        ),
        PopupMenuItem(
          value: "terminate",
          child: Text("Terminate Agreement"),
        ),
        PopupMenuItem(
          value: "download",
          child: Text("Download Document"),
        ),
      ],
    ).then((value) {
      if (value != null) {
        switch (value) {
          case "terminate":
            _confirmTerminateAgreement(agreement);
            break;
          default:
            si("${value} for ${agreement["id"]}");
        }
      }
    });
  }

  void _confirmTerminateAgreement(Map<String, dynamic> agreement) async {
    bool isConfirmed = await confirm("Are you sure you want to terminate retainer agreement ${agreement["id"]}?");
    if (isConfirmed) {
      ss("Retainer agreement terminated");
      // Update agreement status
      setState(() {
        agreement["status"] = "terminated";
      });
    }
  }
}
