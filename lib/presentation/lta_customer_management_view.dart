import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaCustomerManagementView extends StatefulWidget {
  const LtaCustomerManagementView({super.key});

  @override
  State<LtaCustomerManagementView> createState() => _LtaCustomerManagementViewState();
}

class _LtaCustomerManagementViewState extends State<LtaCustomerManagementView> {
  bool loading = true;
  String searchQuery = "";
  String selectedStatus = "All Status";
  String selectedType = "All Types";
  String selectedSort = "Recent";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Suspended", "value": "Suspended"},
    {"label": "Pending", "value": "Pending"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Individual", "value": "Individual"},
    {"label": "Business", "value": "Business"},
    {"label": "Corporate", "value": "Corporate"},
    {"label": "Enterprise", "value": "Enterprise"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recent", "value": "Recent"},
    {"label": "Name A-Z", "value": "Name A-Z"},
    {"label": "Name Z-A", "value": "Name Z-A"},
    {"label": "Revenue High-Low", "value": "Revenue High-Low"},
    {"label": "Revenue Low-High", "value": "Revenue Low-High"},
  ];

  List<Map<String, dynamic>> customers = [
    {
      "id": "cust_001",
      "name": "ABC Manufacturing Corp",
      "email": "contact@abcmanufacturing.com",
      "phone": "+1 (555) 123-4567",
      "type": "Corporate",
      "status": "Active",
      "join_date": "2023-06-15",
      "last_order": "2024-01-10",
      "total_orders": 145,
      "total_revenue": 87500.50,
      "credit_limit": 50000.00,
      "outstanding_balance": 12450.75,
      "rating": 4.8,
      "address": {
        "street": "1234 Industrial Blvd",
        "city": "Chicago",
        "state": "IL",
        "zip": "60601",
        "country": "USA"
      },
      "billing_address": {
        "street": "1234 Industrial Blvd",
        "city": "Chicago",
        "state": "IL", 
        "zip": "60601",
        "country": "USA"
      },
      "contact_person": "John Smith",
      "contact_title": "Logistics Manager"
    },
    {
      "id": "cust_002",
      "name": "Tech Solutions Inc",
      "email": "orders@techsolutions.com",
      "phone": "+1 (555) 987-6543",
      "type": "Business",
      "status": "Active",
      "join_date": "2023-08-22",
      "last_order": "2024-01-08",
      "total_orders": 89,
      "total_revenue": 45780.25,
      "credit_limit": 25000.00,
      "outstanding_balance": 5670.50,
      "rating": 4.5,
      "address": {
        "street": "789 Tech Park Dr",
        "city": "Austin",
        "state": "TX",
        "zip": "73301",
        "country": "USA"
      },
      "billing_address": {
        "street": "789 Tech Park Dr",
        "city": "Austin",
        "state": "TX",
        "zip": "73301",
        "country": "USA"
      },
      "contact_person": "Sarah Johnson",
      "contact_title": "Operations Director"
    },
    {
      "id": "cust_003",
      "name": "Global Retailers Ltd",
      "email": "logistics@globalretail.com", 
      "phone": "+1 (555) 456-7890",
      "type": "Enterprise",
      "status": "Active",
      "join_date": "2022-11-10",
      "last_order": "2024-01-12",
      "total_orders": 312,
      "total_revenue": 156780.90,
      "credit_limit": 100000.00,
      "outstanding_balance": 23890.40,
      "rating": 4.9,
      "address": {
        "street": "456 Commerce Center",
        "city": "New York",
        "state": "NY",
        "zip": "10001",
        "country": "USA"
      },
      "billing_address": {
        "street": "456 Commerce Center",
        "city": "New York",
        "state": "NY",
        "zip": "10001",
        "country": "USA"
      },
      "contact_person": "Michael Chen",
      "contact_title": "Supply Chain Manager"
    },
    {
      "id": "cust_004",
      "name": "Emma Rodriguez",
      "email": "emma.rodriguez@email.com",
      "phone": "+1 (555) 234-5678",
      "type": "Individual",
      "status": "Active",
      "join_date": "2023-12-05",
      "last_order": "2024-01-05",
      "total_orders": 12,
      "total_revenue": 1250.75,
      "credit_limit": 2000.00,
      "outstanding_balance": 0.00,
      "rating": 4.2,
      "address": {
        "street": "123 Residential Ave",
        "city": "Miami",
        "state": "FL",
        "zip": "33101",
        "country": "USA"
      },
      "billing_address": {
        "street": "123 Residential Ave",
        "city": "Miami",
        "state": "FL",
        "zip": "33101",
        "country": "USA"
      },
      "contact_person": "Emma Rodriguez",
      "contact_title": "Customer"
    },
    {
      "id": "cust_005",
      "name": "Sunrise Medical Supplies",
      "email": "procurement@sunrisemedical.com",
      "phone": "+1 (555) 345-6789",
      "type": "Business",
      "status": "Suspended",
      "join_date": "2023-03-18",
      "last_order": "2023-12-15",
      "total_orders": 67,
      "total_revenue": 34560.80,
      "credit_limit": 15000.00,
      "outstanding_balance": 8900.25,
      "rating": 3.8,
      "address": {
        "street": "987 Medical Plaza",
        "city": "Phoenix",
        "state": "AZ",
        "zip": "85001",
        "country": "USA"
      },
      "billing_address": {
        "street": "987 Medical Plaza",
        "city": "Phoenix",
        "state": "AZ",
        "zip": "85001",
        "country": "USA"
      },
      "contact_person": "Dr. Patricia Wilson",
      "contact_title": "Procurement Manager"
    }
  ];

  Map<String, dynamic> customerStats = {
    "total_customers": 1247,
    "active_customers": 892,
    "new_this_month": 67,
    "total_revenue": 2847580.75,
    "avg_order_value": 285.50,
    "top_customer_revenue": 156780.90
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    setState(() {});
  }

  void _showAddCustomerDialog() {
    String name = "";
    String email = "";
    String phone = "";
    String type = "Individual";
    String contactPerson = "";
    String contactTitle = "";
    String street = "";
    String city = "";
    String state = "";
    String zip = "";
    String country = "USA";
    double creditLimit = 0;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Customer"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Customer Name",
                value: name,
                onChanged: (value) => name = value,
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Email",
                      value: email,
                      onChanged: (value) => email = value,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Phone",
                      value: phone,
                      onChanged: (value) => phone = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Customer Type",
                items: typeOptions.where((item) => item["value"] != "All Types").toList(),
                value: type,
                onChanged: (value, label) => type = value,
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Contact Person",
                      value: contactPerson,
                      onChanged: (value) => contactPerson = value,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Contact Title",
                      value: contactTitle,
                      onChanged: (value) => contactTitle = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Street Address",
                value: street,
                onChanged: (value) => street = value,
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "City",
                      value: city,
                      onChanged: (value) => city = value,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "State",
                      value: state,
                      onChanged: (value) => state = value,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "ZIP",
                      value: zip,
                      onChanged: (value) => zip = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Credit Limit (\$)",
                value: creditLimit.toString(),
                onChanged: (value) => creditLimit = double.tryParse(value) ?? 0,
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
            label: "Add Customer",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Customer added successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showCustomerDetails(Map<String, dynamic> customer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${customer["name"]}"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow("Customer ID", "${customer["id"]}"),
              _buildDetailRow("Email", "${customer["email"]}"),
              _buildDetailRow("Phone", "${customer["phone"]}"),
              _buildDetailRow("Type", "${customer["type"]}"),
              _buildDetailRow("Status", "${customer["status"]}"),
              _buildDetailRow("Join Date", "${customer["join_date"]}"),
              _buildDetailRow("Last Order", "${customer["last_order"]}"),
              _buildDetailRow("Total Orders", "${customer["total_orders"]}"),
              _buildDetailRow("Total Revenue", "\$${((customer["total_revenue"] as num).toDouble()).currency}"),
              _buildDetailRow("Credit Limit", "\$${((customer["credit_limit"] as num).toDouble()).currency}"),
              _buildDetailRow("Outstanding Balance", "\$${((customer["outstanding_balance"] as num).toDouble()).currency}"),
              _buildDetailRow("Rating", "${(customer["rating"] as num).toStringAsFixed(1)} ⭐"),
              SizedBox(height: spSm),
              Text(
                "Address:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${(customer["address"] as Map)["street"]}\n${(customer["address"] as Map)["city"]}, ${(customer["address"] as Map)["state"]} ${(customer["address"] as Map)["zip"]}\n${(customer["address"] as Map)["country"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
              if (customer["contact_person"] != null) ...[
                SizedBox(height: spSm),
                Text(
                  "Contact:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${customer["contact_person"]}\n${customer["contact_title"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showEditCustomerDialog(Map<String, dynamic> customer) {
    String name = "${customer["name"]}";
    String email = "${customer["email"]}";
    String phone = "${customer["phone"]}";
    String type = "${customer["type"]}";
    String status = "${customer["status"]}";
    double creditLimit = (customer["credit_limit"] as num).toDouble();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Customer"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Customer Name",
                value: name,
                onChanged: (value) => name = value,
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Email",
                      value: email,
                      onChanged: (value) => email = value,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Phone",
                      value: phone,
                      onChanged: (value) => phone = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Customer Type",
                      items: typeOptions.where((item) => item["value"] != "All Types").toList(),
                      value: type,
                      onChanged: (value, label) => type = value,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: statusOptions.where((item) => item["value"] != "All Status").toList(),
                      value: status,
                      onChanged: (value, label) => status = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Credit Limit (\$)",
                value: creditLimit.toString(),
                onChanged: (value) => creditLimit = double.tryParse(value) ?? 0,
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
            label: "Save Changes",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Customer updated successfully");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String title, String value, String subtitle, IconData icon, Color color) {
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
    bool isActive = customer["status"] == "Active";
    bool hasPendingBalance = (customer["outstanding_balance"] as num) > 0;
    Color statusColor = _getStatusColor(customer["status"]);

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
            color: statusColor,
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
                  color: _getTypeColor(customer["type"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getTypeIcon(customer["type"]),
                  color: _getTypeColor(customer["type"]),
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${customer["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${customer["email"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${customer["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showEditCustomerDialog(customer),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Orders",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${customer["total_orders"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
                      "Total Revenue",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((customer["total_revenue"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: successColor,
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
                      "Rating",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${(customer["rating"] as num).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                    Text(
                      "Credit Limit",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((customer["credit_limit"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
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
                      "Outstanding",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((customer["outstanding_balance"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: hasPendingBalance ? dangerColor : successColor,
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
                      "Last Order",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${customer["last_order"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${(customer["address"] as Map)["city"]}, ${(customer["address"] as Map)["state"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () => _showCustomerDetails(customer),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'inactive':
        return disabledColor;
      case 'suspended':
        return dangerColor;
      case 'pending':
        return warningColor;
      default:
        return primaryColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'individual':
        return primaryColor;
      case 'business':
        return infoColor;
      case 'corporate':
        return successColor;
      case 'enterprise':
        return warningColor;
      default:
        return primaryColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'individual':
        return Icons.person;
      case 'business':
        return Icons.business;
      case 'corporate':
        return Icons.corporate_fare;
      case 'enterprise':
        return Icons.domain;
      default:
        return Icons.business;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Map<String, dynamic>> filteredCustomers = customers.where((customer) {
      bool matchesStatus = selectedStatus == "All Status" || 
                          customer["status"] == selectedStatus;
      bool matchesType = selectedType == "All Types" || 
                        customer["type"] == selectedType;
      bool matchesSearch = searchQuery.isEmpty ||
                          customer["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          customer["email"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesType && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _showAddCustomerDialog,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Statistics
            Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStatsCard(
                        "Total Customers",
                        "${customerStats["total_customers"]}",
                        "All registered customers",
                        Icons.people,
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatsCard(
                        "Active Customers",
                        "${customerStats["active_customers"]}",
                        "Currently active",
                        Icons.people_alt,
                        successColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatsCard(
                        "New This Month",
                        "${customerStats["new_this_month"]}",
                        "New registrations",
                        Icons.person_add,
                        infoColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatsCard(
                        "Total Revenue",
                        "\$${((customerStats["total_revenue"] as num).toDouble()).currency}",
                        "All-time revenue",
                        Icons.attach_money,
                        warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Filters
            QTextField(
              label: "Search customers...",
              value: searchQuery,
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
                    label: "Sort By",
                    items: sortOptions,
                    value: selectedSort,
                    onChanged: (value, label) {
                      selectedSort = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Customer List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Customers (${filteredCustomers.length})",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Add Customer",
                  size: bs.sm,
                  onPressed: _showAddCustomerDialog,
                ),
              ],
            ),
            SizedBox(height: spSm),
            if (filteredCustomers.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 48,
                        color: disabledColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No customers found",
                        style: TextStyle(
                          fontSize: fsH6,
                          color: disabledColor,
                        ),
                      ),
                      Text(
                        "Try adjusting your filters",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Column(
                children: filteredCustomers.map((customer) {
                  return _buildCustomerCard(customer);
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
