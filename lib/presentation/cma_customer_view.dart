import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomerView extends StatefulWidget {
  const CmaCustomerView({super.key});

  @override
  State<CmaCustomerView> createState() => _CmaCustomerViewState();
}

class _CmaCustomerViewState extends State<CmaCustomerView> {
  int selectedTab = 0;
  bool loading = false;
  String searchQuery = "";

  List<Map<String, dynamic>> customers = [
    {
      "id": "CUST001",
      "name": "John Doe",
      "email": "john.doe@email.com",
      "phone": "+1 (555) 123-4567",
      "company": "Tech Solutions Inc.",
      "status": "active",
      "totalOrders": 25,
      "totalSpent": 15750.00,
      "lastOrderDate": "2025-06-15T10:30:00",
      "joinDate": "2024-01-15T09:00:00",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=person",
      "customerType": "premium",
      "creditLimit": 50000.00,
      "outstandingBalance": 2500.00,
      "preferredPayment": "Credit Card",
      "address": "123 Business Street, Tech City, TC 12345",
      "tags": ["VIP", "Tech", "Regular"],
    },
    {
      "id": "CUST002",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 (555) 987-6543",
      "company": "Creative Agency",
      "status": "active",
      "totalOrders": 18,
      "totalSpent": 8950.00,
      "lastOrderDate": "2025-06-18T14:20:00",
      "joinDate": "2024-03-10T11:30:00",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=woman",
      "customerType": "standard",
      "creditLimit": 25000.00,
      "outstandingBalance": 0.00,
      "preferredPayment": "Bank Transfer",
      "address": "456 Creative Ave, Art District, AD 67890",
      "tags": ["Design", "Loyal"],
    },
    {
      "id": "CUST003",
      "name": "Michael Chen",
      "email": "michael.chen@email.com",
      "phone": "+1 (555) 456-7890",
      "company": "Global Enterprises",
      "status": "inactive",
      "totalOrders": 45,
      "totalSpent": 32100.00,
      "lastOrderDate": "2025-04-20T09:15:00",
      "joinDate": "2023-08-20T16:45:00",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=man",
      "customerType": "enterprise",
      "creditLimit": 100000.00,
      "outstandingBalance": 5000.00,
      "preferredPayment": "Net 30",
      "address": "789 Enterprise Blvd, Business Park, BP 13579",
      "tags": ["Enterprise", "High Value"],
    },
    {
      "id": "CUST004",
      "name": "Emma Williams",
      "email": "emma.williams@email.com",
      "phone": "+1 (555) 234-5678",
      "company": "Startup Hub",
      "status": "active",
      "totalOrders": 12,
      "totalSpent": 4200.00,
      "lastOrderDate": "2025-06-19T08:30:00",
      "joinDate": "2024-11-05T13:20:00",
      "avatar": "https://picsum.photos/80/80?random=4&keyword=professional",
      "customerType": "startup",
      "creditLimit": 15000.00,
      "outstandingBalance": 1200.00,
      "preferredPayment": "Credit Card",
      "address": "321 Innovation St, Startup Valley, SV 24680",
      "tags": ["New", "Growing"],
    },
  ];

  List<Map<String, dynamic>> get filteredCustomers {
    List<Map<String, dynamic>> filtered = customers;

    // Filter by tab
    switch (selectedTab) {
      case 0: // All
        break;
      case 1: // Active
        filtered = filtered.where((c) => c["status"] == "active").toList();
        break;
      case 2: // Inactive
        filtered = filtered.where((c) => c["status"] == "inactive").toList();
        break;
      case 3: // VIP
        filtered = filtered.where((c) => (c["tags"] as List).contains("VIP") || c["customerType"] == "premium").toList();
        break;
    }

    // Filter by search
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((customer) {
        return customer["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               customer["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               customer["company"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  int get activeCount => customers.where((c) => c["status"] == "active").length;
  int get inactiveCount => customers.where((c) => c["status"] == "inactive").length;
  int get vipCount => customers.where((c) => (c["tags"] as List).contains("VIP") || c["customerType"] == "premium").length;
  double get totalRevenue => customers.fold(0.0, (sum, c) => sum + (c["totalSpent"] as double));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Management"),
        actions: [
          GestureDetector(
            onTap: () => _showCustomerFilters(),
            child: Container(
              margin: EdgeInsets.only(right: spSm),
              child: Icon(Icons.filter_list),
            ),
          ),
          GestureDetector(
            onTap: () => _addNewCustomer(),
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.person_add),
            ),
          ),
        ],
      ),
      body: loading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              // Tab Bar
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedTab = 0;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTab == 0 ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "All (${customers.length})",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedTab = 1;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTab == 1 ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Active ($activeCount)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedTab = 2;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTab == 2 ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Inactive ($inactiveCount)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selectedTab == 2 ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedTab = 3;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTab == 3 ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "VIP ($vipCount)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selectedTab == 3 ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Container(
                margin: EdgeInsets.symmetric(horizontal: spMd),
                child: Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search customers...",
                        value: searchQuery,
                        hint: "Name, email, or company",
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
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Summary Stats
              Container(
                margin: EdgeInsets.symmetric(horizontal: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${customers.length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Customers",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "$activeCount",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Active",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "\$${totalRevenue.currency}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Total Revenue",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Customers List
              Expanded(
                child: filteredCustomers.isEmpty
                  ? Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No customers found",
                            style: TextStyle(
                              fontSize: fsH6,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            searchQuery.isNotEmpty
                              ? "Try adjusting your search terms"
                              : "Add your first customer to get started",
                            style: TextStyle(
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: spMd),
                      itemCount: filteredCustomers.length,
                      itemBuilder: (context, index) {
                        final customer = filteredCustomers[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                            border: customer["customerType"] == "premium" || (customer["tags"] as List).contains("VIP")
                              ? Border(
                                  left: BorderSide(width: 4, color: warningColor),
                                )
                              : null,
                          ),
                          child: InkWell(
                            onTap: () => _viewCustomerDetail(customer),
                            borderRadius: BorderRadius.circular(radiusMd),
                            child: Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(radiusLg),
                                        child: Image.network(
                                          "${customer["avatar"]}",
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if ((customer["tags"] as List).contains("VIP"))
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: warningColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.star,
                                              size: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(width: spMd),
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
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spSm,
                                                vertical: spXs,
                                              ),
                                              decoration: BoxDecoration(
                                                color: customer["status"] == "active"
                                                  ? successColor.withAlpha(20)
                                                  : dangerColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "${customer["status"]}".toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: customer["status"] == "active"
                                                    ? successColor
                                                    : dangerColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${customer["company"]}",
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${customer["email"]}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(height: spSm),
                                        Row(
                                          children: [
                                            Icon(Icons.shopping_cart, size: 16, color: primaryColor),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${customer["totalOrders"]} orders",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: primaryColor,
                                              ),
                                            ),
                                            SizedBox(width: spMd),
                                            Icon(Icons.attach_money, size: 16, color: successColor),
                                            SizedBox(width: spXs),
                                            Text(
                                              "\$${((customer["totalSpent"] as double)).currency}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: successColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        if ((customer["outstandingBalance"] as double) > 0)
                                          Container(
                                            margin: EdgeInsets.only(top: spXs),
                                            child: Row(
                                              children: [
                                                Icon(Icons.warning, size: 16, color: warningColor),
                                                SizedBox(width: spXs),
                                                Text(
                                                  "Outstanding: \$${((customer["outstandingBalance"] as double)).currency}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: warningColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => _contactCustomer(customer),
                                        child: Container(
                                          padding: EdgeInsets.all(spSm),
                                          decoration: BoxDecoration(
                                            color: primaryColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Icon(
                                            Icons.phone,
                                            color: primaryColor,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: spSm),
                                      GestureDetector(
                                        onTap: () => _showCustomerActions(customer),
                                        child: Icon(
                                          Icons.more_vert,
                                          color: disabledBoldColor,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              ),
            ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewCustomer,
        backgroundColor: primaryColor,
        child: Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }

  void _viewCustomerDetail(Map<String, dynamic> customer) {
    ss("Opening customer detail for ${customer["name"]}");
  }

  void _contactCustomer(Map<String, dynamic> customer) {
    ss("Contacting ${customer["name"]} at ${customer["phone"]}");
  }

  void _addNewCustomer() {
    ss("Opening add customer form");
  }

  void _showCustomerActions(Map<String, dynamic> customer) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusLg),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _editCustomer(customer);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.edit, color: primaryColor),
                    SizedBox(width: spMd),
                    Text("Edit Customer", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _viewOrderHistory(customer);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.history, color: successColor),
                    SizedBox(width: spMd),
                    Text("Order History", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _sendEmail(customer);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.email, color: infoColor),
                    SizedBox(width: spMd),
                    Text("Send Email", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            if (customer["status"] == "inactive")
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _activateCustomer(customer);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      Icon(Icons.play_arrow, color: successColor),
                      SizedBox(width: spMd),
                      Text("Activate Customer", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            if (customer["status"] == "active")
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _deactivateCustomer(customer);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      Icon(Icons.pause, color: warningColor),
                      SizedBox(width: spMd),
                      Text("Deactivate Customer", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showCustomerFilters() {
    ss("Customer filters opened");
  }

  void _editCustomer(Map<String, dynamic> customer) {
    ss("Editing customer: ${customer["name"]}");
  }

  void _viewOrderHistory(Map<String, dynamic> customer) {
    ss("Viewing order history for ${customer["name"]}");
  }

  void _sendEmail(Map<String, dynamic> customer) {
    ss("Sending email to ${customer["email"]}");
  }

  void _activateCustomer(Map<String, dynamic> customer) {
    customer["status"] = "active";
    setState(() {});
    ss("Customer ${customer["name"]} activated");
  }

  void _deactivateCustomer(Map<String, dynamic> customer) async {
    bool isConfirmed = await confirm("Deactivate customer ${customer["name"]}?");
    if (isConfirmed) {
      customer["status"] = "inactive";
      setState(() {});
      ss("Customer ${customer["name"]} deactivated");
    }
  }
}
