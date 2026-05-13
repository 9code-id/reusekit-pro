import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCustomerSearchView extends StatefulWidget {
  const PosCustomerSearchView({super.key});

  @override
  State<PosCustomerSearchView> createState() => _PosCustomerSearchViewState();
}

class _PosCustomerSearchViewState extends State<PosCustomerSearchView> {
  String searchQuery = "";
  String selectedSearchType = "All";
  String selectedTier = "All";
  String selectedStatus = "All";
  bool isSearching = false;

  List<Map<String, dynamic>> searchTypeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Name", "value": "Name"},
    {"label": "Email", "value": "Email"},
    {"label": "Phone", "value": "Phone"},
    {"label": "Customer ID", "value": "ID"},
  ];

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

  List<Map<String, dynamic>> searchResults = [];

  // Sample data that would come from API
  List<Map<String, dynamic>> allCustomers = [
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
    },
    {
      "id": "CUST-007",
      "name": "Anna Rodriguez",
      "email": "anna.rodriguez@email.com",
      "phone": "+1 (555) 789-0123",
      "tier": "VIP",
      "status": "Active",
      "totalOrders": 62,
      "totalSpent": 4250.90,
      "lastOrderDate": "2024-06-19",
      "joinDate": "2021-11-08",
      "address": "147 Maple Dr, Denver, CO 80201",
    },
    {
      "id": "CUST-008",
      "name": "Robert Taylor",
      "email": "robert.taylor@email.com",
      "phone": "+1 (555) 890-1234",
      "tier": "Bronze",
      "status": "Active",
      "totalOrders": 6,
      "totalSpent": 195.50,
      "lastOrderDate": "2024-06-14",
      "joinDate": "2024-05-20",
      "address": "258 Willow St, Seattle, WA 98101",
    },
  ];

  void _performSearch() async {
    if (searchQuery.trim().isEmpty) {
      se("Please enter a search term");
      return;
    }

    isSearching = true;
    setState(() {});

    // Simulate API call delay
    await Future.delayed(Duration(seconds: 1));

    // Filter customers based on search criteria
    List<Map<String, dynamic>> filteredResults = allCustomers.where((customer) {
      bool matchesQuery = false;
      
      switch (selectedSearchType) {
        case "All":
          matchesQuery = customer["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
              customer["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
              customer["phone"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
              customer["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
          break;
        case "Name":
          matchesQuery = customer["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
          break;
        case "Email":
          matchesQuery = customer["email"].toString().toLowerCase().contains(searchQuery.toLowerCase());
          break;
        case "Phone":
          matchesQuery = customer["phone"].toString().toLowerCase().contains(searchQuery.toLowerCase());
          break;
        case "ID":
          matchesQuery = customer["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
          break;
      }

      bool matchesTier = selectedTier == "All" || customer["tier"] == selectedTier;
      bool matchesStatus = selectedStatus == "All" || customer["status"] == selectedStatus;

      return matchesQuery && matchesTier && matchesStatus;
    }).toList();

    searchResults = filteredResults;
    isSearching = false;
    setState(() {});

    if (searchResults.isEmpty) {
      si("No customers found matching your search criteria");
    } else {
      ss("Found ${searchResults.length} customer(s)");
    }
  }

  void _clearSearch() {
    searchQuery = "";
    searchResults = [];
    setState(() {});
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
        title: Text("Search Customers"),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: _clearSearch,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Form
            Container(
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
                      Icon(
                        Icons.search,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Search Criteria",
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
                        flex: 2,
                        child: QTextField(
                          label: "Search Query",
                          value: searchQuery,
                          hint: "Enter customer name, email, phone, or ID",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Search Type",
                          items: searchTypeOptions,
                          value: selectedSearchType,
                          onChanged: (value, label) {
                            selectedSearchType = value;
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
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Search",
                          icon: Icons.search,
                          onPressed: isSearching ? null : _performSearch,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Clear",
                          icon: Icons.clear,
                          onPressed: _clearSearch,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search Instructions
            if (searchResults.isEmpty && !isSearching)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Search Instructions",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "• Enter customer information in the search field",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "• Use filters to narrow down your search",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "• Search by name, email, phone, or customer ID",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "• Click 'Search' to find matching customers",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),

            // Loading Indicator
            if (isSearching)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(color: primaryColor),
                      SizedBox(height: spSm),
                      Text(
                        "Searching customers...",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Search Results
            if (searchResults.isNotEmpty && !isSearching)
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
                            Icons.list,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Search Results (${searchResults.length})",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...searchResults.map((customer) {
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
    );
  }
}
