import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaVendorManagementView extends StatefulWidget {
  const HhaVendorManagementView({super.key});

  @override
  State<HhaVendorManagementView> createState() => _HhaVendorManagementViewState();
}

class _HhaVendorManagementViewState extends State<HhaVendorManagementView> {
  String selectedCategory = "All";
  String selectedStatus = "All";
  String selectedRating = "All";
  String searchQuery = "";
  bool showFilters = false;

  List<Map<String, dynamic>> vendors = [
    {
      "id": "VND001",
      "name": "MedSupply Pro",
      "category": "Medical Equipment",
      "status": "Active",
      "rating": 4.8,
      "contact": "contact@medsupplypro.com",
      "phone": "+1 555-0123",
      "address": "123 Medical District, Boston, MA",
      "totalOrders": 156,
      "totalValue": 285000.00,
      "lastOrder": "2024-01-15",
      "contractExpiry": "2024-12-31",
      "paymentTerms": "Net 30",
      "deliveryRating": 4.9,
      "qualityRating": 4.7,
      "serviceRating": 4.8,
      "primaryProducts": ["Surgical Equipment", "Monitoring Devices"],
      "certifications": ["FDA", "ISO 13485"],
      "onTimeDelivery": 95.2
    },
    {
      "id": "VND002",
      "name": "CleanTech Solutions",
      "category": "Cleaning Supplies",
      "status": "Active",
      "rating": 4.5,
      "contact": "sales@cleantech.com",
      "phone": "+1 555-0124",
      "address": "456 Industrial Ave, Chicago, IL",
      "totalOrders": 89,
      "totalValue": 125000.00,
      "lastOrder": "2024-01-12",
      "contractExpiry": "2025-06-30",
      "paymentTerms": "Net 15",
      "deliveryRating": 4.6,
      "qualityRating": 4.4,
      "serviceRating": 4.5,
      "primaryProducts": ["Disinfectants", "Janitorial Equipment"],
      "certifications": ["EPA", "Green Seal"],
      "onTimeDelivery": 88.7
    },
    {
      "id": "VND003",
      "name": "FoodService Express",
      "category": "Food & Catering",
      "status": "Active",
      "rating": 4.2,
      "contact": "orders@foodservice.com",
      "phone": "+1 555-0125",
      "address": "789 Culinary Blvd, New York, NY",
      "totalOrders": 234,
      "totalValue": 180000.00,
      "lastOrder": "2024-01-14",
      "contractExpiry": "2024-08-15",
      "paymentTerms": "Net 7",
      "deliveryRating": 4.3,
      "qualityRating": 4.1,
      "serviceRating": 4.2,
      "primaryProducts": ["Fresh Produce", "Packaged Foods"],
      "certifications": ["HACCP", "USDA"],
      "onTimeDelivery": 82.5
    },
    {
      "id": "VND004",
      "name": "TechCare Systems",
      "category": "IT Equipment",
      "status": "Inactive",
      "rating": 3.8,
      "contact": "support@techcare.com",
      "phone": "+1 555-0126",
      "address": "321 Tech Park, Austin, TX",
      "totalOrders": 45,
      "totalValue": 95000.00,
      "lastOrder": "2023-11-28",
      "contractExpiry": "2024-03-31",
      "paymentTerms": "Net 45",
      "deliveryRating": 3.9,
      "qualityRating": 3.7,
      "serviceRating": 3.8,
      "primaryProducts": ["Computers", "Network Equipment"],
      "certifications": ["CompTIA", "Cisco"],
      "onTimeDelivery": 76.3
    },
    {
      "id": "VND005",
      "name": "Linen & More",
      "category": "Textiles",
      "status": "Pending",
      "rating": 4.6,
      "contact": "info@linenmore.com",
      "phone": "+1 555-0127",
      "address": "654 Textile Way, Charlotte, NC",
      "totalOrders": 67,
      "totalValue": 75000.00,
      "lastOrder": "2024-01-10",
      "contractExpiry": "2024-09-30",
      "paymentTerms": "Net 30",
      "deliveryRating": 4.7,
      "qualityRating": 4.5,
      "serviceRating": 4.6,
      "primaryProducts": ["Bedding", "Uniforms"],
      "certifications": ["OEKO-TEX", "Fair Trade"],
      "onTimeDelivery": 91.8
    },
    {
      "id": "VND006",
      "name": "Pharma Direct",
      "category": "Pharmaceuticals",
      "status": "Active",
      "rating": 4.9,
      "contact": "orders@pharmadirect.com",
      "phone": "+1 555-0128",
      "address": "987 Pharmacy Row, Miami, FL",
      "totalOrders": 312,
      "totalValue": 450000.00,
      "lastOrder": "2024-01-16",
      "contractExpiry": "2025-12-31",
      "paymentTerms": "Net 30",
      "deliveryRating": 4.9,
      "qualityRating": 4.9,
      "serviceRating": 4.9,
      "primaryProducts": ["Prescription Drugs", "OTC Medications"],
      "certifications": ["FDA", "DEA", "USP"],
      "onTimeDelivery": 97.8
    }
  ];

  List<Map<String, dynamic>> get filteredVendors {
    return vendors.where((vendor) {
      if (selectedCategory != "All" && (vendor["category"] as String) != selectedCategory) return false;
      if (selectedStatus != "All" && (vendor["status"] as String) != selectedStatus) return false;
      if (selectedRating != "All") {
        double rating = vendor["rating"] as double;
        switch (selectedRating) {
          case "5 Stars":
            if (rating < 4.5) return false;
            break;
          case "4+ Stars":
            if (rating < 4.0) return false;
            break;
          case "3+ Stars":
            if (rating < 3.0) return false;
            break;
        }
      }
      if (searchQuery.isNotEmpty) {
        String query = searchQuery.toLowerCase();
        String name = (vendor["name"] as String).toLowerCase();
        String category = (vendor["category"] as String).toLowerCase();
        if (!name.contains(query) && !category.contains(query)) return false;
      }
      return true;
    }).toList();
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
        return disabledColor;
    }
  }

  Widget _buildVendorCard(Map<String, dynamic> vendor) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Header with vendor name and status
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusSm),
                topRight: Radius.circular(radiusSm),
              ),
            ),
            child: Row(
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
                    color: _getStatusColor(vendor["status"] as String).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${vendor["status"]}",
                    style: TextStyle(
                      color: _getStatusColor(vendor["status"] as String),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              children: [
                // Rating and delivery stats
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: warningColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${(vendor["rating"] as double).toStringAsFixed(1)} Rating",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(vendor["onTimeDelivery"] as double).toStringAsFixed(1)}% On-time",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${vendor["totalOrders"]} Orders",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${((vendor["totalValue"] as double) / 1000).toStringAsFixed(0)}K Total",
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

                SizedBox(height: spSm),

                // Contact information
                Row(
                  children: [
                    Icon(Icons.email, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${vendor["contact"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${vendor["phone"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Primary products
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (vendor["primaryProducts"] as List<String>).map((product) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        product,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: spSm),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to vendor details
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.phone,
                      size: bs.sm,
                      onPressed: () {
                        ss("Calling ${vendor["name"]}");
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.email,
                      size: bs.sm,
                      onPressed: () {
                        ss("Email sent to ${vendor["name"]}");
                      },
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

  Widget _buildStatsCard() {
    int totalVendors = vendors.length;
    int activeVendors = vendors.where((v) => v["status"] == "Active").length;
    double avgRating = vendors.fold(0.0, (sum, v) => sum + (v["rating"] as double)) / totalVendors;
    double totalValue = vendors.fold(0.0, (sum, v) => sum + (v["totalValue"] as double));

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vendor Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildStatItem("Total Vendors", "$totalVendors", Icons.business, primaryColor),
              _buildStatItem("Active", "$activeVendors", Icons.check_circle, successColor),
              _buildStatItem("Avg. Rating", "${avgRating.toStringAsFixed(1)}", Icons.star, warningColor),
              _buildStatItem("Total Value", "\$${(totalValue / 1000).toStringAsFixed(0)}K", Icons.trending_up, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    if (!showFilters) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filters",
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
                child: QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Active", "value": "Active"},
                    {"label": "Inactive", "value": "Inactive"},
                    {"label": "Pending", "value": "Pending"},
                  ],
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
                  label: "Rating",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "5 Stars", "value": "5 Stars"},
                    {"label": "4+ Stars", "value": "4+ Stars"},
                    {"label": "3+ Stars", "value": "3+ Stars"},
                  ],
                  value: selectedRating,
                  onChanged: (value, label) {
                    selectedRating = value;
                    setState(() {});
                  },
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
            onPressed: () {
              // Navigate to add vendor
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Search bar
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
                SizedBox(width: spSm),
                QButton(
                  icon: showFilters ? Icons.filter_list_off : Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    showFilters = !showFilters;
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Filters
            _buildFilters(),

            // Stats overview
            _buildStatsCard(),

            // Category filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  "All",
                  "Medical Equipment",
                  "Cleaning Supplies",
                  "Food & Catering",
                  "IT Equipment",
                  "Textiles",
                  "Pharmaceuticals"
                ].map((category) {
                  bool isSelected = selectedCategory == category;
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        selectedCategory = category;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: spMd),

            // Results count
            Row(
              children: [
                Text(
                  "${filteredVendors.length} vendors found",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.sort,
                  size: bs.sm,
                  onPressed: () {
                    // Show sort options
                  },
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Vendor list
            ...filteredVendors.map((vendor) => _buildVendorCard(vendor)).toList(),

            if (filteredVendors.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.business_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No vendors found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
