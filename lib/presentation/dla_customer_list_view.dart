import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaCustomerListView extends StatefulWidget {
  const DlaCustomerListView({super.key});

  @override
  State<DlaCustomerListView> createState() => _DlaCustomerListViewState();
}

class _DlaCustomerListViewState extends State<DlaCustomerListView> {
  String searchQuery = "";
  String selectedType = "all";
  String selectedStatus = "all";
  String sortBy = "name";
  bool loading = false;

  List<Map<String, dynamic>> customerTypeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Business", "value": "business"},
    {"label": "Individual", "value": "individual"},
    {"label": "Government", "value": "government"},
    {"label": "Non-Profit", "value": "nonprofit"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Suspended", "value": "suspended"},
    {"label": "Pending", "value": "pending"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Sort by Name", "value": "name"},
    {"label": "Sort by Date", "value": "date"},
    {"label": "Sort by Deliveries", "value": "deliveries"},
    {"label": "Sort by Type", "value": "type"},
  ];

  List<Map<String, dynamic>> customerList = [
    {
      "id": "CUST-001",
      "name": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1234567890",
      "company": null,
      "type": "individual",
      "status": "active",
      "address": "123 Main St, Anytown, ST 12345",
      "preferred_time": "morning",
      "total_deliveries": 15,
      "last_delivery": "2024-01-14",
      "created_at": "2023-06-15T10:30:00Z",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
      "sms_notifications": true,
      "email_notifications": true,
      "rating": 4.8,
    },
    {
      "id": "CUST-002",
      "name": "Sarah Johnson",
      "email": "s.johnson@techcorp.com",
      "phone": "+1234567891",
      "company": "TechCorp Solutions",
      "type": "business",
      "status": "active",
      "address": "456 Business Blvd, Corporate City, ST 67890",
      "preferred_time": "afternoon",
      "total_deliveries": 45,
      "last_delivery": "2024-01-13",
      "created_at": "2023-03-20T14:15:00Z",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=business",
      "sms_notifications": true,
      "email_notifications": true,
      "rating": 4.9,
    },
    {
      "id": "CUST-003",
      "name": "Michael Chen",
      "email": "m.chen@healthdept.gov",
      "phone": "+1234567892",
      "company": "Department of Health",
      "type": "government",
      "status": "active",
      "address": "789 Government Ave, Capital City, ST 13579",
      "preferred_time": "morning",
      "total_deliveries": 28,
      "last_delivery": "2024-01-12",
      "created_at": "2023-08-10T09:45:00Z",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=office",
      "sms_notifications": false,
      "email_notifications": true,
      "rating": 4.7,
    },
    {
      "id": "CUST-004",
      "name": "Lisa Rodriguez",
      "email": "l.rodriguez@helpinghand.org",
      "phone": "+1234567893",
      "company": "Helping Hand Foundation",
      "type": "nonprofit",
      "status": "active",
      "address": "321 Charity Lane, Helper City, ST 24680",
      "preferred_time": "flexible",
      "total_deliveries": 32,
      "last_delivery": "2024-01-11",
      "created_at": "2023-05-05T16:20:00Z",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=nonprofit",
      "sms_notifications": true,
      "email_notifications": true,
      "rating": 4.6,
    },
    {
      "id": "CUST-005",
      "name": "David Wilson",
      "email": "david.wilson@email.com",
      "phone": "+1234567894",
      "company": null,
      "type": "individual",
      "status": "inactive",
      "address": "654 Residential St, Suburbia, ST 97531",
      "preferred_time": "evening",
      "total_deliveries": 8,
      "last_delivery": "2023-12-20",
      "created_at": "2023-09-12T11:30:00Z",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=person",
      "sms_notifications": false,
      "email_notifications": false,
      "rating": 4.2,
    },
    {
      "id": "CUST-006",
      "name": "Emily Carter",
      "email": "e.carter@startup.io",
      "phone": "+1234567895",
      "company": "Startup Innovations",
      "type": "business",
      "status": "pending",
      "address": "987 Innovation Dr, Tech Valley, ST 86420",
      "preferred_time": "afternoon",
      "total_deliveries": 3,
      "last_delivery": "2024-01-10",
      "created_at": "2024-01-08T13:45:00Z",
      "avatar": "https://picsum.photos/100/100?random=6&keyword=startup",
      "sms_notifications": true,
      "email_notifications": true,
      "rating": 4.0,
    },
  ];

  List<Map<String, dynamic>> get filteredCustomers {
    return customerList.where((customer) {
      bool matchesSearch = customer["name"]
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          customer["email"]
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          customer["id"]
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          (customer["company"] != null &&
              customer["company"]
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()));

      bool matchesType = selectedType == "all" || customer["type"] == selectedType;
      bool matchesStatus = selectedStatus == "all" || customer["status"] == selectedStatus;

      return matchesSearch && matchesType && matchesStatus;
    }).toList()..sort((a, b) {
      switch (sortBy) {
        case "name":
          return a["name"].toString().compareTo(b["name"].toString());
        case "date":
          return DateTime.parse(b["created_at"]).compareTo(DateTime.parse(a["created_at"]));
        case "deliveries":
          return (b["total_deliveries"] as int).compareTo(a["total_deliveries"] as int);
        case "type":
          return a["type"].toString().compareTo(b["type"].toString());
        default:
          return 0;
      }
    });
  }

  Color _getCustomerTypeColor(String type) {
    switch (type) {
      case "business":
        return primaryColor;
      case "individual":
        return successColor;
      case "government":
        return warningColor;
      case "nonprofit":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return disabledColor;
      case "suspended":
        return dangerColor;
      case "pending":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  void _refreshData() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});
    ss("Customer list refreshed successfully");
  }

  void _exportData() {
    ss("Customer data export initiated");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer List"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _exportData,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('dla_customer_view')
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
                children: [
                  // Search and Filters
                  Container(
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
                            Icon(Icons.search, color: primaryColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Search customers...",
                                value: searchQuery,
                                hint: "Search by name, email, ID, or company",
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
                            Expanded(
                              child: QDropdownField(
                                label: "Customer Type",
                                items: customerTypeOptions,
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
                            SizedBox(width: spSm),
                            Expanded(
                              child: QDropdownField(
                                label: "Sort By",
                                items: sortOptions,
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
                  ),

                  // Statistics Cards
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildStatCard(
                        "Total Customers",
                        "${customerList.length}",
                        Icons.people,
                        primaryColor,
                      ),
                      _buildStatCard(
                        "Active",
                        "${customerList.where((c) => c["status"] == "active").length}",
                        Icons.check_circle,
                        successColor,
                      ),
                      _buildStatCard(
                        "Business",
                        "${customerList.where((c) => c["type"] == "business").length}",
                        Icons.business,
                        primaryColor,
                      ),
                      _buildStatCard(
                        "Total Deliveries",
                        "${customerList.fold(0, (sum, c) => sum + (c["total_deliveries"] as int))}",
                        Icons.local_shipping,
                        warningColor,
                      ),
                    ],
                  ),

                  // Customer Type Distribution
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
                            Icon(Icons.pie_chart, color: primaryColor),
                            SizedBox(width: spSm),
                            Text(
                              "Customer Distribution",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            _buildTypeIndicator("Business", "business"),
                            SizedBox(width: spMd),
                            _buildTypeIndicator("Individual", "individual"),
                            SizedBox(width: spMd),
                            _buildTypeIndicator("Government", "government"),
                            SizedBox(width: spMd),
                            _buildTypeIndicator("Non-Profit", "nonprofit"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Customer List
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.list, color: primaryColor),
                              SizedBox(width: spSm),
                              Text(
                                "Customers (${filteredCustomers.length})",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (filteredCustomers.isEmpty)
                          Container(
                            padding: EdgeInsets.all(spXl),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: disabledColor,
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "No customers found",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
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
                            ),
                          )
                        else
                          ...filteredCustomers.map((customer) => _buildCustomerCard(customer)),
                      ],
                    ),
                  ),
                ],
              ),
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
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
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
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeIndicator(String label, String type) {
    int count = customerList.where((c) => c["type"] == type).length;
    Color color = _getCustomerTypeColor(type);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          "$label ($count)",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusLg),
              child: Image.network(
                "${customer["avatar"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          
          // Customer Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${customer["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(customer["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${customer["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(customer["status"]),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${customer["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getCustomerTypeColor(customer["type"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${customer["type"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getCustomerTypeColor(customer["type"]),
                        ),
                      ),
                    ),
                  ],
                ),
                if (customer["company"] != null) ...[
                  SizedBox(height: spXs),
                  Text(
                    "${customer["company"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.email, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${customer["email"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Icon(Icons.phone, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${customer["phone"]}",
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
                    Icon(Icons.local_shipping, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${customer["total_deliveries"]} deliveries",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.star, size: 14, color: warningColor),
                    SizedBox(width: spXs),
                    Text(
                      "${(customer["rating"] as double).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Last: ${DateTime.parse(customer["last_delivery"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Action Button
          QButton(
            icon: Icons.arrow_forward,
            size: bs.sm,
            onPressed: () {
              // navigateTo('dla_customer_detail_view')
            },
          ),
        ],
      ),
    );
  }
}
