import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmCustomerManagementView extends StatefulWidget {
  const FsmCustomerManagementView({super.key});

  @override
  State<FsmCustomerManagementView> createState() => _FsmCustomerManagementViewState();
}

class _FsmCustomerManagementViewState extends State<FsmCustomerManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedType = "all";
  String selectedStatus = "all";
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Enterprise", "value": "enterprise"},
    {"label": "Commercial", "value": "commercial"},
    {"label": "Residential", "value": "residential"},
    {"label": "Government", "value": "government"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Suspended", "value": "suspended"},
  ];
  
  List<Map<String, dynamic>> customers = [
    {
      "id": "CUST001",
      "name": "TechCorp Industries",
      "type": "enterprise",
      "status": "active",
      "contact_person": "John Smith",
      "email": "john.smith@techcorp.com",
      "phone": "+1-555-0123",
      "address": "123 Business Ave, Tech City, TC 12345",
      "locations": 5,
      "equipment": 24,
      "contracts": 3,
      "last_service": "2024-01-10",
      "next_service": "2024-01-20",
      "total_value": 85000.0,
      "priority": "high",
      "service_level": "Premium",
      "account_manager": "Sarah Johnson",
    },
    {
      "id": "CUST002",
      "name": "Metro Hospital Center",
      "type": "commercial",
      "status": "active",
      "contact_person": "Dr. Emily Wilson",
      "email": "emily.wilson@metrohospital.com",
      "phone": "+1-555-0124",
      "address": "456 Health Blvd, Medical District, MD 67890",
      "locations": 3,
      "equipment": 18,
      "contracts": 2,
      "last_service": "2024-01-12",
      "next_service": "2024-01-25",
      "total_value": 120000.0,
      "priority": "critical",
      "service_level": "Premium Plus",
      "account_manager": "Mike Wilson",
    },
    {
      "id": "CUST003",
      "name": "Sunrise Apartments",
      "type": "residential",
      "status": "active",
      "contact_person": "Robert Chen",
      "email": "robert.chen@sunriseapts.com",
      "phone": "+1-555-0125",
      "address": "789 Residential St, Suburb City, SC 11111",
      "locations": 2,
      "equipment": 12,
      "contracts": 1,
      "last_service": "2024-01-08",
      "next_service": "2024-02-15",
      "total_value": 35000.0,
      "priority": "medium",
      "service_level": "Standard",
      "account_manager": "Lisa Park",
    },
    {
      "id": "CUST004",
      "name": "City Government Building",
      "type": "government",
      "status": "inactive",
      "contact_person": "David Brown",
      "email": "david.brown@cityoffice.gov",
      "phone": "+1-555-0126",
      "address": "321 Government Plaza, Downtown, DT 22222",
      "locations": 1,
      "equipment": 8,
      "contracts": 0,
      "last_service": "2023-12-15",
      "next_service": "",
      "total_value": 0.0,
      "priority": "low",
      "service_level": "Basic",
      "account_manager": "Tom Anderson",
    },
  ];

  List<Map<String, dynamic>> get filteredCustomers {
    return customers.where((customer) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${customer["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${customer["contact_person"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${customer["email"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedType == "all" || customer["type"] == selectedType;
      bool matchesStatus = selectedStatus == "all" || customer["status"] == selectedStatus;
      
      return matchesSearch && matchesType && matchesStatus;
    }).toList();
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "enterprise":
        return primaryColor;
      case "commercial":
        return successColor;
      case "residential":
        return infoColor;
      case "government":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return disabledBoldColor;
      case "suspended":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
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
            color: _getTypeColor("${customer["type"]}"),
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
                    Row(
                      children: [
                        Text(
                          "${customer["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getTypeColor("${customer["type"]}").withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${customer["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getTypeColor("${customer["type"]}"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${customer["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor("${customer["status"]}").withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "${customer["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor("${customer["status"]}"),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getPriorityColor("${customer["priority"]}").withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "${customer["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getPriorityColor("${customer["priority"]}"),
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
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${customer["contact_person"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.email,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${customer["email"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${customer["phone"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Locations",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${customer["locations"]}",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Equipment",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${customer["equipment"]}",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contracts",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${customer["contracts"]}",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Value",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((customer["total_value"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if ("${customer["next_service"]}".isNotEmpty) ...[
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 14,
                        color: warningColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Next Service: ${customer["next_service"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to customer detail
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Manage",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to customer management
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Management Overview",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Customers", "${customers.length}", Icons.business, primaryColor),
              _buildStatCard("Active", "${customers.where((c) => c["status"] == "active").length}", Icons.check_circle, successColor),
              _buildStatCard("Enterprise", "${customers.where((c) => c["type"] == "enterprise").length}", Icons.corporate_fare, infoColor),
              _buildStatCard("High Priority", "${customers.where((c) => c["priority"] == "critical" || c["priority"] == "high").length}", Icons.priority_high, dangerColor),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Recent Customers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...filteredCustomers.take(3).map((customer) => _buildCustomerCard(customer)),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Customer",
              onPressed: () {
                // Navigate to add customer
              },
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
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomersTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search customers...",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
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
                      label: "Type",
                      items: typeOptions,
                      value: selectedType,
                      onChanged: (value, label) {
                        selectedType = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
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
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: filteredCustomers.length,
            itemBuilder: (context, index) {
              return _buildCustomerCard(filteredCustomers[index]);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Customers", icon: Icon(Icons.business)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCustomersTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
