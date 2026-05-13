import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCustomerListView extends StatefulWidget {
  const PosCustomerListView({super.key});

  @override
  State<PosCustomerListView> createState() => _PosCustomerListViewState();
}

class _PosCustomerListViewState extends State<PosCustomerListView> {
  String selectedTier = "All";
  String selectedStatus = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> tierOptions = [
    {"label": "All", "value": "All"},
    {"label": "VIP", "value": "VIP"},
    {"label": "Gold", "value": "Gold"},
    {"label": "Silver", "value": "Silver"},
    {"label": "Bronze", "value": "Bronze"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Suspended", "value": "Suspended"},
  ];

  List<Map<String, dynamic>> customers = [
    {
      "id": "CUST-001",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 (555) 123-4567",
      "tier": "VIP",
      "status": "Active",
      "totalOrders": 47,
      "totalSpent": 3450.75,
      "lastOrderDate": "2024-06-18",
      "joinDate": "2022-03-15",
      "address": "123 Main St, New York, NY 10001",
      "notes": "Prefers express delivery",
    },
    {
      "id": "CUST-002",
      "name": "Mike Wilson",
      "email": "mike.wilson@email.com",
      "phone": "+1 (555) 234-5678",
      "tier": "Gold",
      "status": "Active",
      "totalOrders": 23,
      "totalSpent": 1875.50,
      "lastOrderDate": "2024-06-17",
      "joinDate": "2023-01-20",
      "address": "456 Oak Ave, Los Angeles, CA 90210",
      "notes": "Bulk buyer, business account",
    },
    {
      "id": "CUST-003",
      "name": "Emma Davis",
      "email": "emma.davis@email.com",
      "phone": "+1 (555) 345-6789",
      "tier": "Silver",
      "status": "Active",
      "totalOrders": 15,
      "totalSpent": 890.25,
      "lastOrderDate": "2024-06-15",
      "joinDate": "2023-08-10",
      "address": "789 Pine St, Chicago, IL 60601",
      "notes": "Frequent returns, handle with care",
    },
    {
      "id": "CUST-004",
      "name": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 (555) 456-7890",
      "tier": "Bronze",
      "status": "Inactive",
      "totalOrders": 8,
      "totalSpent": 320.00,
      "lastOrderDate": "2024-04-22",
      "joinDate": "2023-11-05",
      "address": "321 Elm St, Houston, TX 77001",
      "notes": "Price-sensitive customer",
    },
    {
      "id": "CUST-005",
      "name": "Lisa Chen",
      "email": "lisa.chen@email.com",
      "phone": "+1 (555) 567-8901",
      "tier": "Gold",
      "status": "Active",
      "totalOrders": 31,
      "totalSpent": 2150.80,
      "lastOrderDate": "2024-06-16",
      "joinDate": "2022-09-12",
      "address": "654 Birch Rd, Phoenix, AZ 85001",
      "notes": "Loyalty program member",
    },
    {
      "id": "CUST-006",
      "name": "David Brown",
      "email": "david.brown@email.com",
      "phone": "+1 (555) 678-9012",
      "tier": "Silver",
      "status": "Suspended",
      "totalOrders": 12,
      "totalSpent": 567.40,
      "lastOrderDate": "2024-05-10",
      "joinDate": "2023-04-18",
      "address": "987 Cedar Ave, Miami, FL 33101",
      "notes": "Payment issues, account suspended",
    },
  ];

  List<Map<String, dynamic>> get filteredCustomers {
    return customers.where((customer) {
      bool matchesTier = selectedTier == "All" || customer["tier"] == selectedTier;
      bool matchesStatus = selectedStatus == "All" || customer["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty ||
          customer["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          customer["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          customer["phone"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          customer["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesTier && matchesStatus && matchesSearch;
    }).toList();
  }

  Color getTierColor(String tier) {
    switch (tier) {
      case "VIP":
        return dangerColor;
      case "Gold":
        return warningColor;
      case "Silver":
        return disabledBoldColor;
      case "Bronze":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return disabledBoldColor;
      case "Suspended":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('PosAddCustomerView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters Section
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
                      Expanded(
                        child: QTextField(
                          label: "Search Customers",
                          value: searchQuery,
                          hint: "Search by name, email, phone, or ID",
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
                          label: "Filter by Tier",
                          items: tierOptions,
                          value: selectedTier,
                          onChanged: (value, label) {
                            selectedTier = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
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
                    ],
                  ),
                ],
              ),
            ),

            // Summary Statistics
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
                  Text(
                    "Customer Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${filteredCustomers.length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${customers.where((c) => c["status"] == "Active").length}",
                              style: TextStyle(
                                fontSize: fsH5,
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
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${customers.where((c) => c["tier"] == "VIP").length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "VIP",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${((customers.fold(0.0, (sum, c) => sum + (c["totalSpent"] as num).toDouble()) / customers.length)).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Avg Spent",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Customers List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.people,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
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
                  ...filteredCustomers.map((customer) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: spSm,
                        right: spSm,
                        bottom: spSm,
                      ),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
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
                                      "${customer["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${customer["id"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: getTierColor(customer["tier"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${customer["tier"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: getTierColor(customer["tier"]),
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: getStatusColor(customer["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${customer["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: getStatusColor(customer["status"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                size: 14,
                                color: disabledBoldColor,
                              ),
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
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${customer["phone"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${customer["address"].toString().split(',').take(2).join(', ')}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${customer["totalOrders"]} orders",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "\$${((customer["totalSpent"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Last order: ${DateTime.parse(customer["lastOrderDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          if (customer["notes"].toString().isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${customer["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          Row(
                            children: [
                              Text(
                                "Member since: ${DateTime.parse(customer["joinDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  QButton(
                                    icon: Icons.visibility,
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('PosCustomerProfileView')
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.edit,
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('EditCustomerView')
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.history,
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('PosCustomerHistoryView')
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('PosAddCustomerView')
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
