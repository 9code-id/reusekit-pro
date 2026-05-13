import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCustomerSegmentsView extends StatefulWidget {
  const CrmCustomerSegmentsView({super.key});

  @override
  State<CrmCustomerSegmentsView> createState() => _CrmCustomerSegmentsViewState();
}

class _CrmCustomerSegmentsViewState extends State<CrmCustomerSegmentsView> {
  bool loading = false;
  String selectedSegment = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> segments = [
    {
      "id": "vip",
      "name": "VIP Customers",
      "description": "High-value customers with premium spending",
      "color": Colors.purple,
      "criteria": "Total spent > \$10,000",
      "customerCount": 156,
      "totalValue": 2450000.00,
      "averageOrderValue": 1850.50,
      "icon": Icons.star
    },
    {
      "id": "enterprise",
      "name": "Enterprise",
      "description": "Large business customers",
      "color": Colors.blue,
      "criteria": "Company size > 100 employees",
      "customerCount": 89,
      "totalValue": 1800000.00,
      "averageOrderValue": 2200.00,
      "icon": Icons.business
    },
    {
      "id": "regular",
      "name": "Regular Customers",
      "description": "Standard recurring customers",
      "color": Colors.green,
      "criteria": "2+ orders in last 6 months",
      "customerCount": 1245,
      "totalValue": 890000.00,
      "averageOrderValue": 650.00,
      "icon": Icons.people
    },
    {
      "id": "new",
      "name": "New Customers",
      "description": "Recently acquired customers",
      "color": Colors.orange,
      "criteria": "First order within 30 days",
      "customerCount": 78,
      "totalValue": 45000.00,
      "averageOrderValue": 576.92,
      "icon": Icons.person_add
    },
    {
      "id": "at_risk",
      "name": "At Risk",
      "description": "Customers with declining activity",
      "color": Colors.red,
      "criteria": "No orders in last 3 months",
      "customerCount": 234,
      "totalValue": 120000.00,
      "averageOrderValue": 512.82,
      "icon": Icons.warning
    },
    {
      "id": "churned",
      "name": "Churned",
      "description": "Inactive customers",
      "color": Colors.grey,
      "criteria": "No orders in last 12 months",
      "customerCount": 167,
      "totalValue": 78000.00,
      "averageOrderValue": 467.07,
      "icon": Icons.block
    }
  ];

  List<Map<String, dynamic>> customers = [
    {
      "id": "CUST-001",
      "firstName": "John",
      "lastName": "Smith",
      "email": "john.smith@email.com",
      "segment": "vip",
      "totalSpent": 15000.00,
      "orderCount": 12,
      "lastOrder": "2024-06-15",
      "profileImage": "https://picsum.photos/200/200?random=1&keyword=person"
    },
    {
      "id": "CUST-002",
      "firstName": "Sarah",
      "lastName": "Johnson",
      "email": "sarah.j@enterprise.com",
      "segment": "enterprise",
      "totalSpent": 8500.00,
      "orderCount": 6,
      "lastOrder": "2024-06-12",
      "profileImage": "https://picsum.photos/200/200?random=2&keyword=person"
    },
    {
      "id": "CUST-003",
      "firstName": "Mike",
      "lastName": "Wilson",
      "email": "mike.wilson@gmail.com",
      "segment": "regular",
      "totalSpent": 2200.00,
      "orderCount": 4,
      "lastOrder": "2024-06-08",
      "profileImage": "https://picsum.photos/200/200?random=3&keyword=person"
    },
    {
      "id": "CUST-004",
      "firstName": "Emma",
      "lastName": "Davis",
      "email": "emma.davis@company.com",
      "segment": "new",
      "totalSpent": 650.00,
      "orderCount": 1,
      "lastOrder": "2024-06-18",
      "profileImage": "https://picsum.photos/200/200?random=4&keyword=person"
    },
    {
      "id": "CUST-005",
      "firstName": "David",
      "lastName": "Brown",
      "email": "david.brown@email.com",
      "segment": "at_risk",
      "totalSpent": 3200.00,
      "orderCount": 8,
      "lastOrder": "2024-03-15",
      "profileImage": "https://picsum.photos/200/200?random=5&keyword=person"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Segments"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _createSegment(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _viewAnalytics(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Segments Overview
                _buildSegmentsOverview(),
                
                // Search and Filter
                _buildSearchFilter(),
                
                // Customer List
                Expanded(
                  child: _buildCustomerList(),
                ),
              ],
            ),
    );
  }

  Widget _buildSegmentsOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Segment Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QHorizontalScroll(
            children: segments.map((segment) => _buildSegmentCard(segment)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentCard(Map<String, dynamic> segment) {
    bool isSelected = selectedSegment == segment["id"];
    
    return GestureDetector(
      onTap: () {
        selectedSegment = segment["id"];
        _filterCustomers();
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? (segment["color"] as Color).withAlpha(20) : Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: isSelected ? (segment["color"] as Color) : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (segment["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    segment["icon"] as IconData,
                    color: segment["color"] as Color,
                    size: 20,
                  ),
                ),
                Spacer(),
                Text(
                  "${segment["customerCount"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: segment["color"] as Color,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Text(
              "${segment["name"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${segment["description"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Total Value",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${((segment["totalValue"] as double) / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Avg Order",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${(segment["averageOrderValue"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
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
      ),
    );
  }

  Widget _buildSearchFilter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search customers",
                  value: searchQuery,
                  hint: "Search by name, email, or ID",
                  onChanged: (value) {
                    searchQuery = value;
                    _filterCustomers();
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () => _showFilterOptions(),
              ),
            ],
          ),
          if (selectedSegment != "all") ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: _getSelectedSegmentColor().withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getSelectedSegmentIcon(),
                    color: _getSelectedSegmentColor(),
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Filtered by: ${_getSelectedSegmentName()}",
                    style: TextStyle(
                      fontSize: 12,
                      color: _getSelectedSegmentColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: spXs),
                  GestureDetector(
                    onTap: () {
                      selectedSegment = "all";
                      _filterCustomers();
                    },
                    child: Icon(
                      Icons.close,
                      color: _getSelectedSegmentColor(),
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCustomerList() {
    List<Map<String, dynamic>> filteredCustomers = _getFilteredCustomers();
    
    if (filteredCustomers.isEmpty) {
      return Center(
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try adjusting your filters or search criteria",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Customers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredCustomers.length} customers",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...filteredCustomers.map((customer) => _buildCustomerItem(customer)),
        ],
      ),
    );
  }

  Widget _buildCustomerItem(Map<String, dynamic> customer) {
    Map<String, dynamic> segment = segments.firstWhere(
      (s) => s["id"] == customer["segment"],
      orElse: () => segments[0]
    );
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          // Profile Image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusMd),
              child: Image.network(
                "${customer["profileImage"]}",
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
                Text(
                  "${customer["firstName"]} ${customer["lastName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${customer["email"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: (segment["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${segment["name"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: segment["color"] as Color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${customer["orderCount"]} orders",
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
          
          // Stats and Actions
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${(customer["totalSpent"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Last: ${DateTime.parse(customer["lastOrder"]).dMMMy}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _viewCustomerProfile(customer["id"]),
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.person,
                        color: primaryColor,
                        size: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  GestureDetector(
                    onTap: () => _contactCustomer(customer["id"]),
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.email,
                        color: infoColor,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCustomers() {
    List<Map<String, dynamic>> filtered = customers;
    
    // Filter by segment
    if (selectedSegment != "all") {
      filtered = filtered.where((customer) => customer["segment"] == selectedSegment).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((customer) {
        String fullName = "${customer["firstName"]} ${customer["lastName"]}".toLowerCase();
        String email = customer["email"].toLowerCase();
        String id = customer["id"].toLowerCase();
        String query = searchQuery.toLowerCase();
        
        return fullName.contains(query) || email.contains(query) || id.contains(query);
      }).toList();
    }
    
    return filtered;
  }

  Color _getSelectedSegmentColor() {
    if (selectedSegment == "all") return primaryColor;
    
    Map<String, dynamic> segment = segments.firstWhere(
      (s) => s["id"] == selectedSegment,
      orElse: () => segments[0]
    );
    
    return segment["color"] as Color;
  }

  IconData _getSelectedSegmentIcon() {
    if (selectedSegment == "all") return Icons.people;
    
    Map<String, dynamic> segment = segments.firstWhere(
      (s) => s["id"] == selectedSegment,
      orElse: () => segments[0]
    );
    
    return segment["icon"] as IconData;
  }

  String _getSelectedSegmentName() {
    if (selectedSegment == "all") return "All Segments";
    
    Map<String, dynamic> segment = segments.firstWhere(
      (s) => s["id"] == selectedSegment,
      orElse: () => segments[0]
    );
    
    return segment["name"];
  }

  void _filterCustomers() {
    setState(() {});
  }

  void _createSegment() {
    si("Create new customer segment");
  }

  void _viewAnalytics() {
    si("View segment analytics");
  }

  void _showFilterOptions() {
    si("Show filter options");
  }

  void _viewCustomerProfile(String customerId) {
    si("View profile for customer: $customerId");
  }

  void _contactCustomer(String customerId) {
    si("Contact customer: $customerId");
  }
}
