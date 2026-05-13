import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmCustomerContractsView extends StatefulWidget {
  const FsmCustomerContractsView({super.key});

  @override
  State<FsmCustomerContractsView> createState() => _FsmCustomerContractsViewState();
}

class _FsmCustomerContractsViewState extends State<FsmCustomerContractsView> {
  String searchQuery = "";
  String selectedStatus = "";
  String selectedType = "";
  String selectedCustomer = "";
  String sortBy = "date";

  List<Map<String, dynamic>> contracts = [
    {
      "id": "CT-2024-001",
      "customerId": "CUST-001",
      "customerName": "TechCorp Solutions",
      "type": "Maintenance",
      "status": "Active",
      "startDate": "2024-01-15",
      "endDate": "2024-12-31",
      "value": 48000.0,
      "billingCycle": "Monthly",
      "nextBilling": "2024-03-01",
      "servicesIncluded": ["Preventive Maintenance", "Emergency Support", "Parts Coverage"],
      "slaResponse": "4 hours",
      "renewalDate": "2024-11-30",
      "priority": "High",
      "equipment": ["HVAC System", "Generators", "Fire Safety"]
    },
    {
      "id": "CT-2024-002",
      "customerId": "CUST-002",
      "customerName": "Global Industries",
      "type": "Support",
      "status": "Pending",
      "startDate": "2024-02-01",
      "endDate": "2025-01-31",
      "value": 72000.0,
      "billingCycle": "Quarterly",
      "nextBilling": "2024-04-01",
      "servicesIncluded": ["24/7 Support", "Remote Monitoring", "Consulting"],
      "slaResponse": "2 hours",
      "renewalDate": "2025-01-01",
      "priority": "Critical",
      "equipment": ["Production Line", "Quality Control", "Automation"]
    },
    {
      "id": "CT-2024-003",
      "customerId": "CUST-003",
      "customerName": "Metro Healthcare",
      "type": "Full Service",
      "status": "Expired",
      "startDate": "2023-03-01",
      "endDate": "2024-02-29",
      "value": 96000.0,
      "billingCycle": "Annual",
      "nextBilling": "2024-03-01",
      "servicesIncluded": ["Maintenance", "Emergency", "Upgrades", "Training"],
      "slaResponse": "1 hour",
      "renewalDate": "2024-02-15",
      "priority": "Critical",
      "equipment": ["Medical Equipment", "HVAC", "Electrical", "Security"]
    },
    {
      "id": "CT-2024-004",
      "customerId": "CUST-004",
      "customerName": "Retail Chain Plus",
      "type": "Basic",
      "status": "Active",
      "startDate": "2024-01-01",
      "endDate": "2024-06-30",
      "value": 24000.0,
      "billingCycle": "Monthly",
      "nextBilling": "2024-03-01",
      "servicesIncluded": ["Basic Maintenance", "Emergency Calls"],
      "slaResponse": "8 hours",
      "renewalDate": "2024-06-01",
      "priority": "Medium",
      "equipment": ["HVAC", "Lighting"]
    },
    {
      "id": "CT-2024-005",
      "customerId": "CUST-005",
      "customerName": "Manufacturing Co",
      "type": "Premium",
      "status": "Draft",
      "startDate": "2024-03-15",
      "endDate": "2025-03-14",
      "value": 144000.0,
      "billingCycle": "Quarterly",
      "nextBilling": "2024-06-15",
      "servicesIncluded": ["Comprehensive Maintenance", "24/7 Support", "Parts", "Upgrades"],
      "slaResponse": "30 minutes",
      "renewalDate": "2025-02-14",
      "priority": "Critical",
      "equipment": ["Production Systems", "Safety Equipment", "Quality Control"]
    },
    {
      "id": "CT-2024-006",
      "customerId": "CUST-006",
      "customerName": "Office Complex",
      "type": "Maintenance",
      "status": "Suspended",
      "startDate": "2023-06-01",
      "endDate": "2024-05-31",
      "value": 36000.0,
      "billingCycle": "Monthly",
      "nextBilling": "2024-03-01",
      "servicesIncluded": ["Preventive Maintenance", "Emergency Support"],
      "slaResponse": "6 hours",
      "renewalDate": "2024-05-01",
      "priority": "Low",
      "equipment": ["HVAC", "Elevators", "Security Systems"]
    }
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Suspended", "value": "Suspended"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": ""},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Support", "value": "Support"},
    {"label": "Full Service", "value": "Full Service"},
    {"label": "Basic", "value": "Basic"},
    {"label": "Premium", "value": "Premium"},
  ];

  List<Map<String, dynamic>> customerItems = [
    {"label": "All Customers", "value": ""},
    {"label": "TechCorp Solutions", "value": "TechCorp Solutions"},
    {"label": "Global Industries", "value": "Global Industries"},
    {"label": "Metro Healthcare", "value": "Metro Healthcare"},
    {"label": "Retail Chain Plus", "value": "Retail Chain Plus"},
    {"label": "Manufacturing Co", "value": "Manufacturing Co"},
    {"label": "Office Complex", "value": "Office Complex"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Sort by Date", "value": "date"},
    {"label": "Sort by Value", "value": "value"},
    {"label": "Sort by Customer", "value": "customer"},
    {"label": "Sort by Status", "value": "status"},
    {"label": "Sort by Type", "value": "type"},
  ];

  List<Map<String, dynamic>> get filteredContracts {
    List<Map<String, dynamic>> filtered = contracts.where((contract) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${contract["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${contract["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${contract["type"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus.isEmpty || contract["status"] == selectedStatus;
      bool matchesType = selectedType.isEmpty || contract["type"] == selectedType;
      bool matchesCustomer = selectedCustomer.isEmpty || contract["customerName"] == selectedCustomer;

      return matchesSearch && matchesStatus && matchesType && matchesCustomer;
    }).toList();

    // Sort contracts
    filtered.sort((a, b) {
      switch (sortBy) {
        case "value":
          return (b["value"] as double).compareTo(a["value"] as double);
        case "customer":
          return "${a["customerName"]}".compareTo("${b["customerName"]}");
        case "status":
          return "${a["status"]}".compareTo("${b["status"]}");
        case "type":
          return "${a["type"]}".compareTo("${b["type"]}");
        case "date":
        default:
          return "${b["startDate"]}".compareTo("${a["startDate"]}");
      }
    });

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "Expired":
        return dangerColor;
      case "Draft":
        return infoColor;
      case "Suspended":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
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

  Widget _buildSummaryCards() {
    int totalContracts = contracts.length;
    int activeContracts = contracts.where((c) => c["status"] == "Active").length;
    double totalValue = contracts.fold(0.0, (sum, c) => sum + (c["value"] as double));
    int expiringContracts = contracts.where((c) => c["status"] == "Active" && 
        DateTime.parse("${c["endDate"]}").isBefore(DateTime.now().add(Duration(days: 30)))).length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
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
                    Icon(Icons.description, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Total Contracts",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "$totalContracts",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
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
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Active",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "$activeContracts",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
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
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.attach_money, color: warningColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Total Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "\$${(totalValue / 1000).toStringAsFixed(0)}K",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
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
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning, color: dangerColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Expiring",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "$expiringContracts",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Search Contracts",
            value: searchQuery,
            hint: "Search by ID, customer, or type...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
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
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Customer",
                  items: customerItems,
                  value: selectedCustomer,
                  onChanged: (value, label) {
                    selectedCustomer = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Sort By",
                  items: sortItems,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
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

  Widget _buildContractCard(Map<String, dynamic> contract) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${contract["status"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${contract["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${contract["customerName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor("${contract["status"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${contract["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor("${contract["status"]}"),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs / 2),
                    decoration: BoxDecoration(
                      color: _getPriorityColor("${contract["priority"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${contract["priority"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getPriorityColor("${contract["priority"]}"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.category, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Type: ${contract["type"]}",
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
                        Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "SLA: ${contract["slaResponse"]}",
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
                        Icon(Icons.refresh, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${contract["billingCycle"]} Billing",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((contract["value"] as double)).currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${contract["startDate"]} - ${contract["endDate"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.build, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Services: ${(contract["servicesIncluded"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.precision_manufacturing, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Equipment: ${(contract["equipment"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to contract details
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Edit Contract",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to edit contract
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  // Show more options
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Contracts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add contract
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildSummaryCards(),
            _buildFilters(),
            Container(
              padding: EdgeInsets.all(spSm),
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
                        "Contracts (${filteredContracts.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "New Contract",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to create contract
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  if (filteredContracts.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No contracts found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your search or filters",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredContracts.map((contract) {
                        return _buildContractCard(contract);
                      }).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add contract
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
