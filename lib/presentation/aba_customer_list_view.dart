import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaCustomerListView extends StatefulWidget {
  const AbaCustomerListView({super.key});

  @override
  State<AbaCustomerListView> createState() => _AbaCustomerListViewState();
}

class _AbaCustomerListViewState extends State<AbaCustomerListView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedSegment = "All";
  String sortBy = "Name";
  bool loading = false;

  List<Map<String, dynamic>> customers = [
    {
      "id": "CUST-001",
      "name": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 (555) 123-4567",
      "company": "Acme Corporation",
      "status": "Active",
      "segment": "Enterprise",
      "totalSpent": 45000.00,
      "orders": 28,
      "lastOrder": "2024-01-18",
      "joinDate": "2023-03-15",
      "avatar": "https://picsum.photos/80/80?random=1",
      "location": "New York, NY",
      "tags": ["Premium", "VIP"],
      "notes": "Key enterprise customer with regular bulk orders"
    },
    {
      "id": "CUST-002",
      "name": "Sarah Johnson",
      "email": "s.johnson@globaltech.com",
      "phone": "+1 (555) 987-6543",
      "company": "Global Tech Solutions",
      "status": "Active",
      "segment": "Premium",
      "totalSpent": 38500.00,
      "orders": 22,
      "lastOrder": "2024-01-15",
      "joinDate": "2023-06-20",
      "avatar": "https://picsum.photos/80/80?random=2",
      "location": "Los Angeles, CA",
      "tags": ["Premium"],
      "notes": "Tech company with focus on innovative solutions"
    },
    {
      "id": "CUST-003",
      "name": "Mike Wilson",
      "email": "mike.w@innovationlabs.com",
      "phone": "+1 (555) 456-7890",
      "company": "Innovation Labs",
      "status": "Active",
      "segment": "Premium",
      "totalSpent": 32000.00,
      "orders": 19,
      "lastOrder": "2024-01-20",
      "joinDate": "2023-08-10",
      "avatar": "https://picsum.photos/80/80?random=3",
      "location": "Chicago, IL",
      "tags": ["Premium", "Loyal"],
      "notes": "R&D focused company with consistent ordering patterns"
    },
    {
      "id": "CUST-004",
      "name": "Emily Davis",
      "email": "emily.davis@futuresys.com",
      "phone": "+1 (555) 321-0987",
      "company": "Future Systems",
      "status": "Inactive",
      "segment": "Standard",
      "totalSpent": 28750.00,
      "orders": 16,
      "lastOrder": "2023-11-30",
      "joinDate": "2023-01-25",
      "avatar": "https://picsum.photos/80/80?random=4",
      "location": "Houston, TX",
      "tags": ["Inactive"],
      "notes": "Previously active customer, may need re-engagement"
    },
    {
      "id": "CUST-005",
      "name": "David Brown",
      "email": "d.brown@smartsolutions.com",
      "phone": "+1 (555) 654-3210",
      "company": "Smart Solutions Inc",
      "status": "Active",
      "segment": "Standard",
      "totalSpent": 15200.00,
      "orders": 12,
      "lastOrder": "2024-01-12",
      "joinDate": "2023-09-05",
      "avatar": "https://picsum.photos/80/80?random=5",
      "location": "Miami, FL",
      "tags": ["Standard"],
      "notes": "Growing company with potential for upgrade"
    },
    {
      "id": "CUST-006",
      "name": "Lisa Anderson",
      "email": "lisa.anderson@techstart.com",
      "phone": "+1 (555) 789-0123",
      "company": "TechStart Ventures",
      "status": "Active",
      "segment": "Starter",
      "totalSpent": 8500.00,
      "orders": 8,
      "lastOrder": "2024-01-19",
      "joinDate": "2023-11-12",
      "avatar": "https://picsum.photos/80/80?random=6",
      "location": "Seattle, WA",
      "tags": ["New", "Starter"],
      "notes": "New startup with high growth potential"
    },
    {
      "id": "CUST-007",
      "name": "Robert Martinez",
      "email": "r.martinez@digitalcorp.com",
      "phone": "+1 (555) 246-8135",
      "company": "Digital Corp",
      "status": "Pending",
      "segment": "Standard",
      "totalSpent": 0.00,
      "orders": 0,
      "lastOrder": null,
      "joinDate": "2024-01-21",
      "avatar": "https://picsum.photos/80/80?random=7",
      "location": "Phoenix, AZ",
      "tags": ["New", "Pending"],
      "notes": "Recently registered, awaiting first order"
    }
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Pending", "value": "Pending"}
  ];

  List<Map<String, dynamic>> segmentFilters = [
    {"label": "All", "value": "All"},
    {"label": "Enterprise", "value": "Enterprise"},
    {"label": "Premium", "value": "Premium"},
    {"label": "Standard", "value": "Standard"},
    {"label": "Starter", "value": "Starter"}
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "Name"},
    {"label": "Total Spent", "value": "Total Spent"},
    {"label": "Last Order", "value": "Last Order"},
    {"label": "Join Date", "value": "Join Date"}
  ];

  List<Map<String, dynamic>> get filteredCustomers {
    var filtered = customers.where((customer) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${customer["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${customer["email"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${customer["company"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || customer["status"] == selectedStatus;
      bool matchesSegment = selectedSegment == "All" || customer["segment"] == selectedSegment;
      
      return matchesSearch && matchesStatus && matchesSegment;
    }).toList();

    // Sort filtered results
    switch (sortBy) {
      case "Total Spent":
        filtered.sort((a, b) => (b["totalSpent"] as double).compareTo(a["totalSpent"] as double));
        break;
      case "Last Order":
        filtered.sort((a, b) {
          if (a["lastOrder"] == null && b["lastOrder"] == null) return 0;
          if (a["lastOrder"] == null) return 1;
          if (b["lastOrder"] == null) return -1;
          return DateTime.parse("${b["lastOrder"]}").compareTo(DateTime.parse("${a["lastOrder"]}"));
        });
        break;
      case "Join Date":
        filtered.sort((a, b) => DateTime.parse("${b["joinDate"]}").compareTo(DateTime.parse("${a["joinDate"]}")));
        break;
      default: // Name
        filtered.sort((a, b) => "${a["name"]}".compareTo("${b["name"]}"));
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return dangerColor;
      case "Pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSegmentColor(String segment) {
    switch (segment) {
      case "Enterprise":
        return primaryColor;
      case "Premium":
        return successColor;
      case "Standard":
        return infoColor;
      case "Starter":
        return warningColor;
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
              // navigateTo AddCustomerView
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export customer list
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusFilters,
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
                          label: "Segment",
                          items: segmentFilters,
                          value: selectedSegment,
                          onChanged: (value, label) {
                            selectedSegment = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Summary Statistics
            Row(
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
                      children: [
                        Text(
                          "${filteredCustomers.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Customers",
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
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredCustomers.where((c) => c["status"] == "Active").length}",
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
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${filteredCustomers.fold(0.0, (sum, c) => sum + (c["totalSpent"] as double)).currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Revenue",
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

            // Customer List
            if (loading)
              Center(
                child: CircularProgressIndicator(),
              )
            else if (filteredCustomers.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.people,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No customers found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredCustomers.map((customer) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Customer Header
                      Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              "${customer["avatar"]}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
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
                                  "${customer["company"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: disabledBoldColor,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${customer["status"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${customer["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor("${customer["status"]}"),
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getSegmentColor("${customer["segment"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${customer["segment"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: _getSegmentColor("${customer["segment"]}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Contact Information
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
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
                                      fontSize: 13,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${customer["location"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Customer Metrics
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "\$${(customer["totalSpent"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "Total Spent",
                                    style: TextStyle(
                                      fontSize: 11,
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
                                color: infoColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${customer["orders"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                  Text(
                                    "Orders",
                                    style: TextStyle(
                                      fontSize: 11,
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
                                color: warningColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    customer["lastOrder"] != null 
                                        ? "${DateTime.parse("${customer["lastOrder"]}").dMMMy}"
                                        : "No orders",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                  Text(
                                    "Last Order",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Tags
                      if (customer["tags"] != null && (customer["tags"] as List).isNotEmpty)
                        Wrap(
                          spacing: spXs,
                          children: (customer["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$tag",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                      // Notes
                      if (customer["notes"] != null && "${customer["notes"]}".isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.note,
                                size: 16,
                                color: infoColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${customer["notes"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo CustomerDetailView
                              },
                            ),
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.phone,
                            size: bs.sm,
                            onPressed: () {
                              // Call customer
                            },
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.email,
                            size: bs.sm,
                            onPressed: () {
                              // Email customer
                            },
                          ),
                          SizedBox(width: spXs),
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
              }).toList(),
          ],
        ),
      ),
    );
  }
}
