import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaContractManagementView extends StatefulWidget {
  const RhaContractManagementView({super.key});

  @override
  State<RhaContractManagementView> createState() => _RhaContractManagementViewState();
}

class _RhaContractManagementViewState extends State<RhaContractManagementView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Terminated", "value": "Terminated"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All", "value": "All"},
    {"label": "Service", "value": "Service"},
    {"label": "Employment", "value": "Employment"},
    {"label": "Vendor", "value": "Vendor"},
    {"label": "Partnership", "value": "Partnership"},
  ];

  List<Map<String, dynamic>> contracts = [
    {
      "id": "1",
      "title": "Software Development Agreement",
      "client": "TechCorp Solutions",
      "type": "Service",
      "status": "Active",
      "value": 125000.0,
      "startDate": "2024-01-15",
      "endDate": "2024-12-15",
      "renewalDate": "2024-11-15",
      "progress": 65,
      "manager": "John Smith",
      "priority": "High",
      "riskLevel": "Low",
    },
    {
      "id": "2",
      "title": "Marketing Services Contract",
      "client": "Brand Masters Inc",
      "type": "Service",
      "status": "Active",
      "value": 75000.0,
      "startDate": "2024-02-01",
      "endDate": "2024-07-31",
      "renewalDate": "2024-06-30",
      "progress": 80,
      "manager": "Sarah Johnson",
      "priority": "Medium",
      "riskLevel": "Medium",
    },
    {
      "id": "3",
      "title": "Employee Agreement - Developer",
      "client": "Michael Chen",
      "type": "Employment",
      "status": "Active",
      "value": 85000.0,
      "startDate": "2024-01-01",
      "endDate": "2025-01-01",
      "renewalDate": "2024-12-01",
      "progress": 25,
      "manager": "HR Department",
      "priority": "Low",
      "riskLevel": "Low",
    },
    {
      "id": "4",
      "title": "Vendor Supply Agreement",
      "client": "Office Supplies Co",
      "type": "Vendor",
      "status": "Pending",
      "value": 45000.0,
      "startDate": "2024-04-01",
      "endDate": "2025-03-31",
      "renewalDate": "2025-02-28",
      "progress": 0,
      "manager": "David Wilson",
      "priority": "Medium",
      "riskLevel": "High",
    },
    {
      "id": "5",
      "title": "Partnership Agreement",
      "client": "Strategic Partners LLC",
      "type": "Partnership",
      "status": "Active",
      "value": 200000.0,
      "startDate": "2023-06-01",
      "endDate": "2025-05-31",
      "renewalDate": "2025-04-30",
      "progress": 45,
      "manager": "Emma Davis",
      "priority": "High",
      "riskLevel": "Medium",
    },
    {
      "id": "6",
      "title": "Consulting Services",
      "client": "Innovation Hub",
      "type": "Service",
      "status": "Expired",
      "value": 35000.0,
      "startDate": "2023-01-01",
      "endDate": "2023-12-31",
      "renewalDate": "2023-11-30",
      "progress": 100,
      "manager": "Robert Brown",
      "priority": "Low",
      "riskLevel": "Low",
    },
  ];

  List<Map<String, dynamic>> get filteredContracts {
    return contracts.where((contract) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${contract["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${contract["client"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || contract["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || contract["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active": return successColor;
      case "Pending": return warningColor;
      case "Expired": return dangerColor;
      case "Terminated": return disabledBoldColor;
      default: return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High": return dangerColor;
      case "Medium": return warningColor;
      case "Low": return successColor;
      default: return primaryColor;
    }
  }

  Color _getRiskColor(String risk) {
    switch (risk) {
      case "High": return dangerColor;
      case "Medium": return warningColor;
      case "Low": return successColor;
      default: return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Contract Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Contracts", icon: Icon(Icons.description)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Renewals", icon: Icon(Icons.refresh)),
      ],
      tabChildren: [
        _buildContractsTab(),
        _buildAnalyticsTab(),
        _buildRenewalsTab(),
      ],
    );
  }

  Widget _buildContractsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search contracts...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  // Navigate to create contract
                },
              ),
            ],
          ),

          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
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
                  label: "Type",
                  items: typeItems,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.description, color: primaryColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "${contracts.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Contracts",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "${contracts.where((c) => c["status"] == "Active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Active",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.attach_money, color: infoColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "\$${((contracts.map((c) => c["value"] as double).reduce((a, b) => a + b)) / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Total Value",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Contracts List
          Column(
            spacing: spSm,
            children: filteredContracts.map((contract) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${contract["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${contract["status"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${contract["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor("${contract["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Client: ${contract["client"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${contract["type"]} • \$${((contract["value"] as double) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor("${contract["priority"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${contract["priority"]} Priority",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getPriorityColor("${contract["priority"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.date_range, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${contract["startDate"]} - ${contract["endDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Progress: ${contract["progress"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Manager: ${contract["manager"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: (contract["progress"] as int) / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getRiskColor("${contract["riskLevel"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${contract["riskLevel"]} Risk",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getRiskColor("${contract["riskLevel"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Contract Value by Type
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Contract Value by Type",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: typeItems.where((type) => type["value"] != "All").map((type) {
                    double totalValue = contracts
                        .where((c) => c["type"] == type["value"])
                        .map((c) => c["value"] as double)
                        .fold(0.0, (sum, value) => sum + value);
                    
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${type["label"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${(totalValue / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Status Distribution
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Contract Status Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: statusItems.where((status) => status["value"] != "All").map((status) {
                    int count = contracts.where((c) => c["status"] == status["value"]).length;
                    
                    return Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _getStatusColor("${status["value"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${status["label"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "$count",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Risk Assessment
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Risk Assessment",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: ["Low", "Medium", "High"].map((risk) {
                    int count = contracts.where((c) => c["riskLevel"] == risk).length;
                    
                    return Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _getRiskColor(risk),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "$risk Risk",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "$count",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRenewalsTab() {
    List<Map<String, dynamic>> upcomingRenewals = contracts
        .where((c) => c["status"] == "Active")
        .toList()
      ..sort((a, b) => "${a["renewalDate"]}".compareTo("${b["renewalDate"]}"));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Renewal Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.schedule, color: warningColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "${upcomingRenewals.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Upcoming Renewals",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.trending_up, color: successColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "85%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Renewal Rate",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Upcoming Renewals List
          Column(
            spacing: spSm,
            children: upcomingRenewals.map((contract) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${contract["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Renewal Due",
                            style: TextStyle(
                              fontSize: 10,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Client: ${contract["client"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.event, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "Renewal Date: ${contract["renewalDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${((contract["value"] as double) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        QButton(
                          label: "Start Renewal",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "View Contract",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.notifications,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
