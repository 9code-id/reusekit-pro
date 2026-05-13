import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmVendorManagementView extends StatefulWidget {
  const IwmVendorManagementView({super.key});

  @override
  State<IwmVendorManagementView> createState() => _IwmVendorManagementViewState();
}

class _IwmVendorManagementViewState extends State<IwmVendorManagementView> {
  String searchQuery = "";
  String selectedCategory = "All Vendors";
  String selectedStatus = "Active";
  bool loading = false;

  List<Map<String, dynamic>> vendors = [
    {
      "id": "VEN001",
      "name": "Global Supply Co.",
      "category": "Electronics",
      "email": "contact@globalsupply.com",
      "phone": "+1-555-0123",
      "rating": 4.8,
      "totalOrders": 156,
      "totalValue": 2850000,
      "status": "Active",
      "lastOrder": "2024-06-15",
      "paymentTerms": "Net 30",
      "location": "New York, NY",
      "contactPerson": "John Smith",
    },
    {
      "id": "VEN002",
      "name": "Tech Components Ltd.",
      "category": "Components",
      "email": "orders@techcomp.com",
      "phone": "+1-555-0234",
      "rating": 4.6,
      "totalOrders": 89,
      "totalValue": 1650000,
      "status": "Active",
      "lastOrder": "2024-06-12",
      "paymentTerms": "Net 15",
      "location": "San Francisco, CA",
      "contactPerson": "Sarah Johnson",
    },
    {
      "id": "VEN003",
      "name": "Industrial Materials Inc.",
      "category": "Raw Materials",
      "email": "sales@indmat.com",
      "phone": "+1-555-0345",
      "rating": 4.4,
      "totalOrders": 234,
      "totalValue": 4200000,
      "status": "Active",
      "lastOrder": "2024-06-18",
      "paymentTerms": "Net 45",
      "location": "Chicago, IL",
      "contactPerson": "Mike Wilson",
    },
    {
      "id": "VEN004",
      "name": "Premium Parts Corp.",
      "category": "Components",
      "email": "info@premiumparts.com",
      "phone": "+1-555-0456",
      "rating": 4.2,
      "totalOrders": 67,
      "totalValue": 980000,
      "status": "Pending",
      "lastOrder": "2024-05-28",
      "paymentTerms": "Net 30",
      "location": "Austin, TX",
      "contactPerson": "Lisa Brown",
    },
    {
      "id": "VEN005",
      "name": "Swift Logistics",
      "category": "Logistics",
      "email": "dispatch@swiftlog.com",
      "phone": "+1-555-0567",
      "rating": 4.7,
      "totalOrders": 345,
      "totalValue": 1890000,
      "status": "Active",
      "lastOrder": "2024-06-19",
      "paymentTerms": "Net 15",
      "location": "Denver, CO",
      "contactPerson": "Alex Chen",
    },
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Vendors", "value": "All Vendors"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Components", "value": "Components"},
    {"label": "Raw Materials", "value": "Raw Materials"},
    {"label": "Logistics", "value": "Logistics"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  List<Map<String, dynamic>> get filteredVendors {
    return vendors.where((vendor) {
      bool matchesSearch = vendor["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          vendor["contactPerson"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All Vendors" || vendor["category"] == selectedCategory;
      bool matchesStatus = vendor["status"] == selectedStatus;
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Widget _buildVendorCard(Map<String, dynamic> vendor) {
    Color statusColor = vendor["status"] == "Active" 
        ? successColor 
        : vendor["status"] == "Pending"
            ? warningColor
            : dangerColor;

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
            color: statusColor,
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
                      "${vendor["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${vendor["id"]} • ${vendor["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${vendor["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${vendor["contactPerson"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${vendor["location"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.email, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${vendor["email"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Icon(Icons.phone, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${vendor["phone"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.star, size: 16, color: warningColor),
              SizedBox(width: spXs),
              Text(
                "${vendor["rating"]}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "Orders: ${vendor["totalOrders"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "Total Value: ",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${((vendor["totalValue"] as int).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Spacer(),
              Text(
                "Terms: ${vendor["paymentTerms"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
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
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Create Order",
                  size: bs.sm,
                  onPressed: () {},
                ),
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
        title: Text("Vendor Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
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
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search vendors...",
                          value: searchQuery,
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
                          label: "Category",
                          items: categoryItems,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
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
                    ],
                  ),

                  // Summary Cards
                  ResponsiveGridView(
                    padding: EdgeInsets.all(0),
                    minItemWidth: 200,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.business, color: primaryColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Total Vendors",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${vendors.length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.trending_up, color: successColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Active Vendors",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${vendors.where((v) => v["status"] == "Active").length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.attach_money, color: warningColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Total Value",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "\$${((vendors.fold(0, (sum, v) => sum + (v["totalValue"] as int))) / 1000000).toStringAsFixed(1)}M",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, color: infoColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Avg Rating",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${(vendors.fold(0.0, (sum, v) => sum + (v["rating"] as double)) / vendors.length).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Vendors List
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Vendors (${filteredVendors.length})",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "Export",
                              icon: Icons.download,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        ...filteredVendors.map((vendor) => _buildVendorCard(vendor)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
