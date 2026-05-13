import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomerListView extends StatefulWidget {
  const CmaCustomerListView({super.key});

  @override
  State<CmaCustomerListView> createState() => _CmaCustomerListViewState();
}

class _CmaCustomerListViewState extends State<CmaCustomerListView> {
  bool loading = false;
  String searchQuery = "";
  String sortBy = "name";
  String filterStatus = "all";
  String filterType = "all";
  bool isGridView = false;

  List<Map<String, dynamic>> customers = [
    {
      "id": "CUST001",
      "name": "Alice Johnson",
      "email": "alice.johnson@email.com",
      "phone": "+1 (555) 123-4567",
      "company": "Digital Solutions",
      "status": "active",
      "customerType": "premium",
      "totalOrders": 32,
      "totalSpent": 18750.00,
      "lastOrderDate": "2025-06-18T14:30:00",
      "joinDate": "2023-09-15T10:00:00",
      "avatar": "https://picsum.photos/100/100?random=11&keyword=businesswoman",
      "location": "New York, NY",
      "creditLimit": 75000.00,
      "outstandingBalance": 3500.00,
      "tags": ["VIP", "Technology", "Loyal"],
      "rating": 4.8,
    },
    {
      "id": "CUST002",
      "name": "Robert Miller",
      "email": "robert.miller@email.com",
      "phone": "+1 (555) 987-6543",
      "company": "Miller & Associates",
      "status": "active",
      "customerType": "standard",
      "totalOrders": 24,
      "totalSpent": 12400.00,
      "lastOrderDate": "2025-06-17T11:15:00",
      "joinDate": "2024-02-20T09:30:00",
      "avatar": "https://picsum.photos/100/100?random=12&keyword=businessman",
      "location": "Los Angeles, CA",
      "creditLimit": 35000.00,
      "outstandingBalance": 0.00,
      "tags": ["Regular", "Consulting"],
      "rating": 4.2,
    },
    {
      "id": "CUST003",
      "name": "Sarah Davis",
      "email": "sarah.davis@email.com",
      "phone": "+1 (555) 456-7890",
      "company": "Creative Designs Inc.",
      "status": "inactive",
      "customerType": "standard",
      "totalOrders": 15,
      "totalSpent": 8900.00,
      "lastOrderDate": "2025-03-10T16:45:00",
      "joinDate": "2024-06-01T14:20:00",
      "avatar": "https://picsum.photos/100/100?random=13&keyword=designer",
      "location": "Chicago, IL",
      "creditLimit": 20000.00,
      "outstandingBalance": 1200.00,
      "tags": ["Design", "Creative"],
      "rating": 4.5,
    },
    {
      "id": "CUST004",
      "name": "Michael Wilson",
      "email": "michael.wilson@email.com",
      "phone": "+1 (555) 234-5678",
      "company": "TechStart Solutions",
      "status": "active",
      "customerType": "startup",
      "totalOrders": 8,
      "totalSpent": 3200.00,
      "lastOrderDate": "2025-06-19T09:00:00",
      "joinDate": "2024-12-15T11:45:00",
      "avatar": "https://picsum.photos/100/100?random=14&keyword=entrepreneur",
      "location": "Austin, TX",
      "creditLimit": 15000.00,
      "outstandingBalance": 800.00,
      "tags": ["New", "Startup", "Tech"],
      "rating": 4.0,
    },
    {
      "id": "CUST005",
      "name": "Jennifer Brown",
      "email": "jennifer.brown@email.com",
      "phone": "+1 (555) 345-6789",
      "company": "Global Enterprises",
      "status": "active",
      "customerType": "enterprise",
      "totalOrders": 67,
      "totalSpent": 45600.00,
      "lastOrderDate": "2025-06-19T13:20:00",
      "joinDate": "2023-04-10T08:15:00",
      "avatar": "https://picsum.photos/100/100?random=15&keyword=executive",
      "location": "Seattle, WA",
      "creditLimit": 150000.00,
      "outstandingBalance": 8900.00,
      "tags": ["Enterprise", "High Value", "Strategic"],
      "rating": 4.9,
    },
    {
      "id": "CUST006",
      "name": "David Garcia",
      "email": "david.garcia@email.com",
      "phone": "+1 (555) 567-8901",
      "company": "Local Business Co.",
      "status": "active",
      "customerType": "standard",
      "totalOrders": 19,
      "totalSpent": 9800.00,
      "lastOrderDate": "2025-06-16T15:30:00",
      "joinDate": "2024-08-05T12:00:00",
      "avatar": "https://picsum.photos/100/100?random=16&keyword=manager",
      "location": "Miami, FL",
      "creditLimit": 25000.00,
      "outstandingBalance": 2100.00,
      "tags": ["Local", "Retail"],
      "rating": 4.3,
    },
  ];

  List<Map<String, dynamic>> get filteredCustomers {
    List<Map<String, dynamic>> filtered = List.from(customers);

    // Filter by search
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((customer) {
        return customer["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               customer["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               customer["company"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               customer["location"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by status
    if (filterStatus != "all") {
      filtered = filtered.where((customer) => customer["status"] == filterStatus).toList();
    }

    // Filter by type
    if (filterType != "all") {
      filtered = filtered.where((customer) => customer["customerType"] == filterType).toList();
    }

    // Sort customers
    filtered.sort((a, b) {
      switch (sortBy) {
        case "name":
          return a["name"].toString().compareTo(b["name"].toString());
        case "company":
          return a["company"].toString().compareTo(b["company"].toString());
        case "totalSpent":
          return (b["totalSpent"] as double).compareTo(a["totalSpent"] as double);
        case "totalOrders":
          return (b["totalOrders"] as int).compareTo(a["totalOrders"] as int);
        case "joinDate":
          return DateTime.parse(b["joinDate"] as String).compareTo(DateTime.parse(a["joinDate"] as String));
        case "lastOrder":
          return DateTime.parse(b["lastOrderDate"] as String).compareTo(DateTime.parse(a["lastOrderDate"] as String));
        default:
          return 0;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer List"),
        actions: [
          GestureDetector(
            onTap: () {
              isGridView = !isGridView;
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(right: spSm),
              child: Icon(isGridView ? Icons.list : Icons.grid_view),
            ),
          ),
          GestureDetector(
            onTap: () => _exportCustomerList(),
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.download),
            ),
          ),
        ],
      ),
      body: loading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              // Search and Filter Section
              Container(
                padding: EdgeInsets.all(spMd),
                color: Colors.white,
                child: Column(
                  children: [
                    // Search Bar
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Search customers...",
                            value: searchQuery,
                            hint: "Name, email, company, or location",
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

                    SizedBox(height: spSm),

                    // Filter Row
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Status",
                            items: [
                              {"label": "All Status", "value": "all"},
                              {"label": "Active", "value": "active"},
                              {"label": "Inactive", "value": "inactive"},
                            ],
                            value: filterStatus,
                            onChanged: (value, label) {
                              filterStatus = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Type",
                            items: [
                              {"label": "All Types", "value": "all"},
                              {"label": "Premium", "value": "premium"},
                              {"label": "Enterprise", "value": "enterprise"},
                              {"label": "Standard", "value": "standard"},
                              {"label": "Startup", "value": "startup"},
                            ],
                            value: filterType,
                            onChanged: (value, label) {
                              filterType = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Sort By",
                            items: [
                              {"label": "Name", "value": "name"},
                              {"label": "Company", "value": "company"},
                              {"label": "Total Spent", "value": "totalSpent"},
                              {"label": "Total Orders", "value": "totalOrders"},
                              {"label": "Join Date", "value": "joinDate"},
                              {"label": "Last Order", "value": "lastOrder"},
                            ],
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

              // Results Header
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Text(
                      "Showing ${filteredCustomers.length} of ${customers.length} customers",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if (filteredCustomers.isNotEmpty)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => _selectAllCustomers(),
                            child: Row(
                              children: [
                                Icon(Icons.select_all, size: 16, color: primaryColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Select All",
                                  style: TextStyle(color: primaryColor, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spMd),
                          GestureDetector(
                            onTap: () => _bulkActions(),
                            child: Row(
                              children: [
                                Icon(Icons.more_horiz, size: 16, color: primaryColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Bulk Actions",
                                  style: TextStyle(color: primaryColor, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              // Customer List/Grid
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
                            size: 80,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No customers found",
                            style: TextStyle(
                              fontSize: fsH5,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            searchQuery.isNotEmpty
                              ? "Try adjusting your search or filters"
                              : "Your customer list is empty",
                            style: TextStyle(
                              color: disabledColor,
                            ),
                          ),
                          SizedBox(height: spMd),
                          QButton(
                            label: "Add First Customer",
                            size: bs.sm,
                            onPressed: () => _addNewCustomer(),
                          ),
                        ],
                      ),
                    )
                  : isGridView
                    ? _buildGridView()
                    : _buildListView(),
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

  Widget _buildListView() {
    return ListView.builder(
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
            border: _getCustomerTypeBorder(customer["customerType"] as String),
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
                      if ((customer["tags"] as List).contains("VIP") || customer["customerType"] == "premium")
                        Positioned(
                          bottom: 0,
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
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 12, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${customer["location"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.shopping_cart, size: 14, color: primaryColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${customer["totalOrders"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: spMd),
                            Row(
                              children: [
                                Icon(Icons.attach_money, size: 14, color: successColor),
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
                            SizedBox(width: spMd),
                            Row(
                              children: List.generate(5, (starIndex) {
                                return Icon(
                                  starIndex < (customer["rating"] as double).floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                  size: 12,
                                  color: warningColor,
                                );
                              }),
                            ),
                          ],
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
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      GestureDetector(
                        onTap: () => _showCustomerActions(customer),
                        child: Icon(
                          Icons.more_vert,
                          color: disabledBoldColor,
                          size: 18,
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
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 200,
      children: filteredCustomers.map((customer) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: _getCustomerTypeBorder(customer["customerType"] as String),
          ),
          child: InkWell(
            onTap: () => _viewCustomerDetail(customer),
            borderRadius: BorderRadius.circular(radiusMd),
            child: Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Image.network(
                          "${customer["avatar"]}",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if ((customer["tags"] as List).contains("VIP") || customer["customerType"] == "premium")
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
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${customer["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${customer["company"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spSm),
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
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${customer["totalOrders"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Orders",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Container(width: 1, height: 30, color: disabledOutlineBorderColor),
                      Column(
                        children: [
                          Text(
                            "\$${((customer["totalSpent"] as double) / 1000).toStringAsFixed(1)}K",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Spent",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (starIndex) {
                      return Icon(
                        starIndex < (customer["rating"] as double).floor()
                          ? Icons.star
                          : Icons.star_border,
                        size: 14,
                        color: warningColor,
                      );
                    }),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact",
                          size: bs.sm,
                          onPressed: () => _contactCustomer(customer),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Border? _getCustomerTypeBorder(String customerType) {
    Color? borderColor;
    switch (customerType) {
      case "premium":
        borderColor = warningColor;
        break;
      case "enterprise":
        borderColor = primaryColor;
        break;
      case "startup":
        borderColor = successColor;
        break;
      default:
        return null;
    }
    return Border(left: BorderSide(width: 4, color: borderColor));
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

  void _exportCustomerList() {
    ss("Exporting customer list (${filteredCustomers.length} customers)");
  }

  void _selectAllCustomers() {
    ss("Selected all ${filteredCustomers.length} customers");
  }

  void _bulkActions() {
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
            Text(
              "Bulk Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _bulkEmail();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.email, color: primaryColor),
                    SizedBox(width: spMd),
                    Text("Send Bulk Email", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _bulkStatusUpdate();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.update, color: successColor),
                    SizedBox(width: spMd),
                    Text("Update Status", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _bulkExport();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.download, color: infoColor),
                    SizedBox(width: spMd),
                    Text("Export Selected", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
          ],
        ),
      ),
    );
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

  void _bulkEmail() {
    ss("Sending bulk email to selected customers");
  }

  void _bulkStatusUpdate() {
    ss("Updating status for selected customers");
  }

  void _bulkExport() {
    ss("Exporting selected customers");
  }
}
