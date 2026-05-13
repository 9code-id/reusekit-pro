import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaStockLevelsView extends StatefulWidget {
  const HhaStockLevelsView({super.key});

  @override
  State<HhaStockLevelsView> createState() => _HhaStockLevelsViewState();
}

class _HhaStockLevelsViewState extends State<HhaStockLevelsView> {
  String selectedCategory = "All";
  String selectedLocation = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  bool showFilters = false;
  String sortBy = "Name";

  List<Map<String, dynamic>> stockItems = [
    {
      "id": "STK001",
      "name": "Surgical Gloves",
      "category": "Medical Supplies",
      "location": "Medical Storage",
      "currentStock": 850,
      "minStock": 200,
      "maxStock": 1000,
      "unitPrice": 12.50,
      "supplier": "MedSupply Pro",
      "lastRestocked": "2024-01-12",
      "expiryDate": "2025-06-30",
      "batchNumber": "SG-2024-001",
      "usage": {
        "daily": 45,
        "weekly": 315,
        "monthly": 1350
      },
      "status": "In Stock",
      "reserved": 150,
      "available": 700,
      "costCenter": "SURGERY"
    },
    {
      "id": "STK002",
      "name": "Hand Sanitizer",
      "category": "Cleaning Supplies",
      "location": "Housekeeping",
      "currentStock": 45,
      "minStock": 50,
      "maxStock": 200,
      "unitPrice": 8.75,
      "supplier": "CleanTech Solutions",
      "lastRestocked": "2024-01-08",
      "expiryDate": "2025-12-31",
      "batchNumber": "HS-2024-003",
      "usage": {
        "daily": 12,
        "weekly": 84,
        "monthly": 360
      },
      "status": "Low Stock",
      "reserved": 20,
      "available": 25,
      "costCenter": "HOUSEKEEPING"
    },
    {
      "id": "STK003",
      "name": "Antibiotics - Amoxicillin",
      "category": "Pharmaceuticals",
      "location": "Pharmacy",
      "currentStock": 0,
      "minStock": 100,
      "maxStock": 500,
      "unitPrice": 25.00,
      "supplier": "Pharma Direct",
      "lastRestocked": "2023-12-15",
      "expiryDate": "2024-08-30",
      "batchNumber": "AMX-2023-012",
      "usage": {
        "daily": 8,
        "weekly": 56,
        "monthly": 240
      },
      "status": "Out of Stock",
      "reserved": 0,
      "available": 0,
      "costCenter": "PHARMACY"
    },
    {
      "id": "STK004",
      "name": "Fresh Vegetables",
      "category": "Food Items",
      "location": "Kitchen Storage",
      "currentStock": 125,
      "minStock": 50,
      "maxStock": 150,
      "unitPrice": 3.20,
      "supplier": "FoodService Express",
      "lastRestocked": "2024-01-14",
      "expiryDate": "2024-01-18",
      "batchNumber": "FV-2024-014",
      "usage": {
        "daily": 35,
        "weekly": 245,
        "monthly": 1050
      },
      "status": "Near Expiry",
      "reserved": 75,
      "available": 50,
      "costCenter": "KITCHEN"
    },
    {
      "id": "STK005",
      "name": "Bed Sheets",
      "category": "Textiles",
      "location": "Linen Storage",
      "currentStock": 320,
      "minStock": 100,
      "maxStock": 400,
      "unitPrice": 18.00,
      "supplier": "Linen & More",
      "lastRestocked": "2024-01-10",
      "expiryDate": "N/A",
      "batchNumber": "BS-2024-001",
      "usage": {
        "daily": 25,
        "weekly": 175,
        "monthly": 750
      },
      "status": "In Stock",
      "reserved": 80,
      "available": 240,
      "costCenter": "HOUSEKEEPING"
    },
    {
      "id": "STK006",
      "name": "Laptop Computers",
      "category": "IT Equipment",
      "location": "IT Storage",
      "currentStock": 8,
      "minStock": 5,
      "maxStock": 20,
      "unitPrice": 1200.00,
      "supplier": "TechCare Systems",
      "lastRestocked": "2023-11-20",
      "expiryDate": "N/A",
      "batchNumber": "LC-2023-011",
      "usage": {
        "daily": 0.2,
        "weekly": 1.4,
        "monthly": 6
      },
      "status": "In Stock",
      "reserved": 2,
      "available": 6,
      "costCenter": "IT"
    },
    {
      "id": "STK007",
      "name": "Disinfectant Wipes",
      "category": "Cleaning Supplies",
      "location": "General Storage",
      "currentStock": 180,
      "minStock": 100,
      "maxStock": 300,
      "unitPrice": 6.50,
      "supplier": "CleanTech Solutions",
      "lastRestocked": "2024-01-11",
      "expiryDate": "2025-08-31",
      "batchNumber": "DW-2024-002",
      "usage": {
        "daily": 22,
        "weekly": 154,
        "monthly": 660
      },
      "status": "In Stock",
      "reserved": 50,
      "available": 130,
      "costCenter": "GENERAL"
    },
    {
      "id": "STK008",
      "name": "Pain Relief Medication",
      "category": "Pharmaceuticals",
      "location": "Pharmacy",
      "currentStock": 65,
      "minStock": 80,
      "maxStock": 300,
      "unitPrice": 32.00,
      "supplier": "Pharma Direct",
      "lastRestocked": "2024-01-05",
      "expiryDate": "2024-12-15",
      "batchNumber": "PRM-2024-001",
      "usage": {
        "daily": 15,
        "weekly": 105,
        "monthly": 450
      },
      "status": "Low Stock",
      "reserved": 25,
      "available": 40,
      "costCenter": "PHARMACY"
    }
  ];

  List<Map<String, dynamic>> get filteredItems {
    return stockItems.where((item) {
      if (selectedCategory != "All" && (item["category"] as String) != selectedCategory) return false;
      if (selectedLocation != "All" && (item["location"] as String) != selectedLocation) return false;
      if (selectedStatus != "All" && (item["status"] as String) != selectedStatus) return false;
      if (searchQuery.isNotEmpty) {
        String query = searchQuery.toLowerCase();
        String name = (item["name"] as String).toLowerCase();
        String id = (item["id"] as String).toLowerCase();
        if (!name.contains(query) && !id.contains(query)) return false;
      }
      return true;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Stock":
        return successColor;
      case "Low Stock":
        return warningColor;
      case "Out of Stock":
        return dangerColor;
      case "Near Expiry":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  double _getStockPercentage(Map<String, dynamic> item) {
    int current = item["currentStock"] as int;
    int max = item["maxStock"] as int;
    return max > 0 ? (current / max) * 100 : 0;
  }

  Widget _buildStockCard(Map<String, dynamic> item) {
    double stockPercentage = _getStockPercentage(item);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor(item["status"] as String),
          ),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusSm),
                topRight: Radius.circular(radiusSm),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${item["id"]} • ${item["category"]}",
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
                        color: _getStatusColor(item["status"] as String).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["status"]}",
                        style: TextStyle(
                          color: _getStatusColor(item["status"] as String),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${item["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Batch: ${item["batchNumber"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              children: [
                // Stock levels
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Current Stock",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${item["currentStock"]} units",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: stockPercentage / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _getStatusColor(item["status"] as String),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Min: ${item["minStock"]} | Max: ${item["maxStock"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Available",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${item["available"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Reserved: ${item["reserved"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Usage statistics
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Usage Statistics",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildUsageItem("Daily", "${(item["usage"]["daily"] as num).toStringAsFixed(1)}"),
                          _buildUsageItem("Weekly", "${(item["usage"]["weekly"] as num).toStringAsFixed(0)}"),
                          _buildUsageItem("Monthly", "${(item["usage"]["monthly"] as num).toStringAsFixed(0)}"),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spSm),

                // Price and expiry info
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Unit Price",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((item["unitPrice"] as double)).currency}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
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
                            "Expiry Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${item["expiryDate"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: (item["expiryDate"] as String) != "N/A" ? 
                                (item["status"] == "Near Expiry" ? dangerColor : primaryColor) : 
                                disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Supplier info
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.business, color: infoColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Supplier: ${item["supplier"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Last restocked: ${item["lastRestocked"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spSm),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Restock",
                        size: bs.sm,
                        onPressed: () {
                          ss("Restock order initiated");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.qr_code,
                      size: bs.sm,
                      onPressed: () {
                        ss("QR code scanned");
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.history,
                      size: bs.sm,
                      onPressed: () {
                        // Show stock history
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
          ),
        ],
      ),
    );
  }

  Widget _buildUsageItem(String period, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          period,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    int totalItems = stockItems.length;
    int lowStockItems = stockItems.where((item) => item["status"] == "Low Stock" || item["status"] == "Out of Stock").length;
    int outOfStockItems = stockItems.where((item) => item["status"] == "Out of Stock").length;
    double totalValue = stockItems.fold(0.0, (sum, item) => sum + ((item["currentStock"] as int) * (item["unitPrice"] as double)));

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
            "Stock Overview",
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
              _buildStatItem("Total Items", "$totalItems", Icons.inventory, primaryColor),
              _buildStatItem("Low Stock", "$lowStockItems", Icons.warning, warningColor),
              _buildStatItem("Out of Stock", "$outOfStockItems", Icons.error, dangerColor),
              _buildStatItem("Total Value", "\$${(totalValue / 1000).toStringAsFixed(0)}K", Icons.attach_money, successColor),
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

    List<String> locations = ["All"] + stockItems.map((item) => item["location"] as String).toSet().toList();

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
                    {"label": "In Stock", "value": "In Stock"},
                    {"label": "Low Stock", "value": "Low Stock"},
                    {"label": "Out of Stock", "value": "Out of Stock"},
                    {"label": "Near Expiry", "value": "Near Expiry"},
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
                  label: "Location",
                  items: locations.map((l) => {"label": l, "value": l}).toList(),
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
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
        title: Text("Stock Levels"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              ss("QR Code Scanner opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add stock
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
                    label: "Search stock items...",
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
                  "Medical Supplies",
                  "Cleaning Supplies",
                  "Pharmaceuticals",
                  "Food Items",
                  "Textiles",
                  "IT Equipment"
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

            // Results count and sort
            Row(
              children: [
                Text(
                  "${filteredItems.length} items found",
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

            // Stock items list
            ...filteredItems.map((item) => _buildStockCard(item)).toList(),

            if (filteredItems.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.inventory_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No stock items found",
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
