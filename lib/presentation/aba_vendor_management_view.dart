import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaVendorManagementView extends StatefulWidget {
  const AbaVendorManagementView({super.key});

  @override
  State<AbaVendorManagementView> createState() => _AbaVendorManagementViewState();
}

class _AbaVendorManagementViewState extends State<AbaVendorManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "";
  String selectedStatus = "";
  String sortBy = "name";

  List<Map<String, dynamic>> vendors = [
    {
      "id": "V001",
      "name": "Office Supplies Plus",
      "category": "Office Supplies",
      "email": "contact@officesuppliesplus.com",
      "phone": "+1 (555) 123-4567",
      "address": "123 Business Ave, Suite 100",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "status": "Active",
      "totalSpent": 15420.50,
      "lastOrderDate": "2024-12-15",
      "paymentTerms": "Net 30",
      "taxId": "12-3456789",
      "contactPerson": "John Smith",
      "rating": 4.8,
      "orderCount": 47
    },
    {
      "id": "V002", 
      "name": "TechCorp Solutions",
      "category": "Technology",
      "email": "sales@techcorp.com",
      "phone": "+1 (555) 987-6543",
      "address": "456 Tech Drive",
      "city": "San Francisco",
      "state": "CA",
      "zipCode": "94105",
      "status": "Active",
      "totalSpent": 28750.00,
      "lastOrderDate": "2024-12-18",
      "paymentTerms": "Net 15",
      "taxId": "98-7654321",
      "contactPerson": "Sarah Johnson",
      "rating": 4.9,
      "orderCount": 23
    },
    {
      "id": "V003",
      "name": "Green Cleaning Co",
      "category": "Maintenance",
      "email": "info@greenclean.com",
      "phone": "+1 (555) 555-0123",
      "address": "789 Eco Street",
      "city": "Portland",
      "state": "OR",
      "zipCode": "97201",
      "status": "Inactive",
      "totalSpent": 8340.25,
      "lastOrderDate": "2024-11-30",
      "paymentTerms": "Net 30",
      "taxId": "55-9876543",
      "contactPerson": "Mike Wilson",
      "rating": 4.2,
      "orderCount": 18
    }
  ];

  List<Map<String, dynamic>> vendorCategories = [
    {"label": "All Categories", "value": ""},
    {"label": "Office Supplies", "value": "Office Supplies"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Professional Services", "value": "Professional Services"},
    {"label": "Marketing", "value": "Marketing"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Pending", "value": "Pending"}
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name A-Z", "value": "name"},
    {"label": "Total Spent (High-Low)", "value": "totalSpent"},
    {"label": "Last Order Date", "value": "lastOrderDate"},
    {"label": "Rating (High-Low)", "value": "rating"}
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "type": "order",
      "vendor": "Office Supplies Plus",
      "description": "New purchase order #PO-2024-156",
      "amount": 1250.00,
      "date": "2024-12-18 10:30 AM"
    },
    {
      "type": "payment",
      "vendor": "TechCorp Solutions", 
      "description": "Payment processed for invoice #INV-2024-089",
      "amount": 3500.00,
      "date": "2024-12-18 09:15 AM"
    },
    {
      "type": "vendor",
      "vendor": "New Vendor",
      "description": "Marketing Agency XYZ added to vendor list",
      "amount": 0.0,
      "date": "2024-12-17 04:45 PM"
    }
  ];

  List<Map<String, dynamic>> get filteredVendors {
    return vendors.where((vendor) {
      bool matchesSearch = searchQuery.isEmpty ||
          (vendor["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (vendor["category"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory.isEmpty || vendor["category"] == selectedCategory;
      bool matchesStatus = selectedStatus.isEmpty || vendor["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList()..sort((a, b) {
      switch (sortBy) {
        case "name":
          return (a["name"] as String).compareTo(b["name"] as String);
        case "totalSpent":
          return (b["totalSpent"] as double).compareTo(a["totalSpent"] as double);
        case "lastOrderDate":
          return (b["lastOrderDate"] as String).compareTo(a["lastOrderDate"] as String);
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        default:
          return 0;
      }
    });
  }

  void _addVendor() {
    ss("Navigating to Add Vendor form");
  }

  void _viewVendorDetails(Map<String, dynamic> vendor) {
    ss("Viewing details for ${vendor["name"]}");
  }

  void _editVendor(Map<String, dynamic> vendor) {
    ss("Editing vendor: ${vendor["name"]}");
  }

  void _toggleVendorStatus(Map<String, dynamic> vendor) async {
    bool isConfirmed = await confirm("Are you sure you want to ${vendor["status"] == "Active" ? "deactivate" : "activate"} this vendor?");
    if (isConfirmed) {
      setState(() {
        vendor["status"] = vendor["status"] == "Active" ? "Inactive" : "Active";
      });
      ss("Vendor status updated successfully");
    }
  }

  void _deleteVendor(Map<String, dynamic> vendor) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this vendor? This action cannot be undone.");
    if (isConfirmed) {
      setState(() {
        vendors.removeWhere((v) => v["id"] == vendor["id"]);
      });
      ss("Vendor deleted successfully");
    }
  }

  Widget _buildOverviewTab() {
    int activeVendors = vendors.where((v) => v["status"] == "Active").length;
    int inactiveVendors = vendors.where((v) => v["status"] == "Inactive").length;
    double totalSpending = vendors.fold(0.0, (sum, v) => sum + (v["totalSpent"] as double));
    double avgRating = vendors.fold(0.0, (sum, v) => sum + (v["rating"] as double)) / vendors.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.business,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${vendors.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Total Vendors",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "$activeVendors Active, $inactiveVendors Inactive",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.attach_money,
                            color: successColor,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${(totalSpending.toDouble()).currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Total Spending",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "This year to date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.star,
                            color: infoColor,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${avgRating.toStringAsFixed(1)}/5.0",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Average Rating",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Vendor performance",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Recent Activities
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Recent Activities",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => ss("View all activities"),
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                ...recentActivities.map((activity) {
                  IconData activityIcon;
                  Color activityColor;
                  
                  switch (activity["type"]) {
                    case "order":
                      activityIcon = Icons.shopping_cart;
                      activityColor = primaryColor;
                      break;
                    case "payment":
                      activityIcon = Icons.payment;
                      activityColor = successColor;
                      break;
                    case "vendor":
                      activityIcon = Icons.person_add;
                      activityColor = infoColor;
                      break;
                    default:
                      activityIcon = Icons.info;
                      activityColor = disabledBoldColor;
                  }

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: activityColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: activityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            activityIcon,
                            color: activityColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${activity["vendor"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${activity["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${activity["date"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if ((activity["amount"] as double) > 0)
                          Text(
                            "\$${(activity["amount"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Quick Actions
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add New Vendor",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: _addVendor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Export Vendors",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () => ss("Exporting vendor list"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorListTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search vendors...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: vendorCategories,
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
                QDropdownField(
                  label: "Sort by",
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

          // Vendor List
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
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
                      label: "Add Vendor",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: _addVendor,
                    ),
                  ],
                ),
                ...filteredVendors.map((vendor) {
                  Color statusColor = vendor["status"] == "Active" ? successColor : dangerColor;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${vendor["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: statusColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${vendor["status"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: statusColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${vendor["category"]} • ${vendor["contactPerson"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${vendor["email"]} • ${vendor["phone"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: spXs,
                              children: [
                                Text(
                                  "\$${(vendor["totalSpent"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star, color: warningColor, size: 14),
                                    SizedBox(width: 2),
                                    Text(
                                      "${vendor["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () => _viewVendorDetails(vendor),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Edit",
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () => _editVendor(vendor),
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: vendor["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                              size: bs.sm,
                              onPressed: () => _toggleVendorStatus(vendor),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.delete,
                              size: bs.sm,
                              onPressed: () => _deleteVendor(vendor),
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
    );
  }

  Widget _buildAnalyticsTab() {
    Map<String, int> categoryStats = {};
    for (var vendor in vendors) {
      String category = vendor["category"] as String;
      categoryStats[category] = (categoryStats[category] ?? 0) + 1;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Category Distribution
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Vendor Distribution by Category",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...categoryStats.entries.map((entry) {
                  double percentage = (entry.value / vendors.length) * 100;
                  return Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${entry.value} vendors (${percentage.toStringAsFixed(1)}%)",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        value: percentage / 100,
                        backgroundColor: disabledColor.withAlpha(30),
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),

          // Top Vendors by Spending
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Top Vendors by Spending",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...vendors.take(5).map((vendor) {
                  double maxSpending = vendors.map((v) => v["totalSpent"] as double).reduce((a, b) => a > b ? a : b);
                  double percentage = ((vendor["totalSpent"] as double) / maxSpending) * 100;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${vendor["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${(vendor["totalSpent"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: percentage / 100,
                          backgroundColor: disabledColor.withAlpha(30),
                          valueColor: AlwaysStoppedAnimation<Color>(successColor),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Performance Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Average Order Value",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((vendors.fold(0.0, (sum, v) => sum + (v["totalSpent"] as double)) / vendors.fold(0, (sum, v) => sum + (v["orderCount"] as int))).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Per order across all vendors",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Total Orders",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${vendors.fold(0, (sum, v) => sum + (v["orderCount"] as int))}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Across all active vendors",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
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
    return QTabBar(
      title: "Vendor Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Vendor List", icon: Icon(Icons.list)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildVendorListTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
