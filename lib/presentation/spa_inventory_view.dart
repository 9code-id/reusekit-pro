import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaInventoryView extends StatefulWidget {
  const SpaInventoryView({super.key});

  @override
  State<SpaInventoryView> createState() => _SpaInventoryViewState();
}

class _SpaInventoryViewState extends State<SpaInventoryView> {
  String searchQuery = "";
  String selectedCategory = "All Categories";
  String selectedStatus = "All Status";
  String sortBy = "Name";
  bool isGridView = true;
  
  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": "inv001",
      "name": "Lavender Essential Oil",
      "category": "Essential Oils",
      "brand": "Serenity Spa",
      "sku": "ESO-LAV-001",
      "currentStock": 24,
      "minStock": 10,
      "maxStock": 50,
      "unitPrice": 25.99,
      "totalValue": 623.76,
      "location": "Storage Room A",
      "supplier": "Aromatherapy Supplies Co.",
      "lastRestocked": "2024-01-15",
      "expiryDate": "2025-01-15",
      "status": "In Stock",
      "image": "https://picsum.photos/150/150?random=1&keyword=lavender",
      "description": "Premium lavender essential oil for aromatherapy treatments",
      "usage": "High",
      "daysToExpiry": 183,
    },
    {
      "id": "inv002",
      "name": "Organic Face Mask",
      "category": "Skincare",
      "brand": "Natural Beauty",
      "sku": "SKN-MSK-002",
      "currentStock": 8,
      "minStock": 15,
      "maxStock": 30,
      "unitPrice": 18.50,
      "totalValue": 148.00,
      "location": "Treatment Room 1",
      "supplier": "Organic Beauty Supplies",
      "lastRestocked": "2024-01-10",
      "expiryDate": "2024-12-31",
      "status": "Low Stock",
      "image": "https://picsum.photos/150/150?random=2&keyword=mask",
      "description": "Organic clay face mask for deep cleansing treatments",
      "usage": "Medium",
      "daysToExpiry": 167,
    },
    {
      "id": "inv003",
      "name": "Massage Lotion",
      "category": "Massage Oils",
      "brand": "Therapeutic Touch",
      "sku": "MSS-LOT-003",
      "currentStock": 0,
      "minStock": 20,
      "maxStock": 40,
      "unitPrice": 12.75,
      "totalValue": 0.00,
      "location": "Massage Room",
      "supplier": "Massage Supply Direct",
      "lastRestocked": "2023-12-20",
      "expiryDate": "2025-06-30",
      "status": "Out of Stock",
      "image": "https://picsum.photos/150/150?random=3&keyword=lotion",
      "description": "Moisturizing massage lotion with natural ingredients",
      "usage": "High",
      "daysToExpiry": 347,
    },
    {
      "id": "inv004",
      "name": "Disposable Towels",
      "category": "Disposables",
      "brand": "SpaEssentials",
      "sku": "DSP-TWL-004",
      "currentStock": 156,
      "minStock": 50,
      "maxStock": 200,
      "unitPrice": 0.85,
      "totalValue": 132.60,
      "location": "Supply Closet",
      "supplier": "Disposable Supplies Inc.",
      "lastRestocked": "2024-01-18",
      "expiryDate": "2026-01-18",
      "status": "In Stock",
      "image": "https://picsum.photos/150/150?random=4&keyword=towels",
      "description": "Soft disposable towels for various spa treatments",
      "usage": "Very High",
      "daysToExpiry": 731,
    },
    {
      "id": "inv005",
      "name": "Cucumber Eye Patches",
      "category": "Skincare",
      "brand": "Eye Care Pro",
      "sku": "EYE-CUC-005",
      "currentStock": 32,
      "minStock": 20,
      "maxStock": 60,
      "unitPrice": 3.25,
      "totalValue": 104.00,
      "location": "Facial Room",
      "supplier": "Skincare Solutions Ltd.",
      "lastRestocked": "2024-01-12",
      "expiryDate": "2024-07-12",
      "status": "Expiring Soon",
      "image": "https://picsum.photos/150/150?random=5&keyword=cucumber",
      "description": "Hydrating cucumber eye patches for facial treatments",
      "usage": "Medium",
      "daysToExpiry": 27,
    },
    {
      "id": "inv006",
      "name": "Hot Stone Set",
      "category": "Equipment",
      "brand": "Stone Therapy",
      "sku": "EQP-STO-006",
      "currentStock": 3,
      "minStock": 2,
      "maxStock": 5,
      "unitPrice": 149.99,
      "totalValue": 449.97,
      "location": "Equipment Storage",
      "supplier": "Spa Equipment World",
      "lastRestocked": "2023-11-15",
      "expiryDate": "N/A",
      "status": "In Stock",
      "image": "https://picsum.photos/150/150?random=6&keyword=stones",
      "description": "Professional hot stone therapy set for massage treatments",
      "usage": "Low",
      "daysToExpiry": 0,
    },
    {
      "id": "inv007",
      "name": "Herbal Tea Blend",
      "category": "Beverages",
      "brand": "Wellness Teas",
      "sku": "BEV-TEA-007",
      "currentStock": 12,
      "minStock": 8,
      "maxStock": 25,
      "unitPrice": 15.50,
      "totalValue": 186.00,
      "location": "Reception Area",
      "supplier": "Herbal Tea Company",
      "lastRestocked": "2024-01-08",
      "expiryDate": "2024-10-08",
      "status": "In Stock",
      "image": "https://picsum.photos/150/150?random=7&keyword=tea",
      "description": "Relaxing herbal tea blend for client refreshments",
      "usage": "Medium",
      "daysToExpiry": 124,
    },
    {
      "id": "inv008",
      "name": "Sanitizing Wipes",
      "category": "Cleaning",
      "brand": "CleanSafe",
      "sku": "CLN-WIP-008",
      "currentStock": 45,
      "minStock": 30,
      "maxStock": 80,
      "unitPrice": 4.99,
      "totalValue": 224.55,
      "location": "All Rooms",
      "supplier": "Cleaning Supply Co.",
      "lastRestocked": "2024-01-20",
      "expiryDate": "2025-01-20",
      "status": "In Stock",
      "image": "https://picsum.photos/150/150?random=8&keyword=wipes",
      "description": "Antibacterial wipes for sanitizing surfaces",
      "usage": "Very High",
      "daysToExpiry": 183,
    }
  ];

  List<String> categories = ["All Categories", "Essential Oils", "Skincare", "Massage Oils", "Disposables", "Equipment", "Beverages", "Cleaning"];
  List<String> statusOptions = ["All Status", "In Stock", "Low Stock", "Out of Stock", "Expiring Soon"];
  List<String> sortOptions = ["Name", "Stock Level", "Value", "Expiry Date", "Usage"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredItems = _getFilteredItems();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Management"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            margin: EdgeInsets.only(right: spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.inventory,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${filteredItems.length} Items",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search inventory...",
                        value: searchQuery,
                        hint: "Enter item name, SKU, or category",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: isGridView ? Icons.list : Icons.grid_view,
                      size: bs.sm,
                      onPressed: () {
                        isGridView = !isGridView;
                        setState(() {});
                      },
                    ),
                  ],
                ),

                // Filter Row
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories.map((cat) => {"label": cat, "value": cat}).toList(),
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
                        items: statusOptions.map((status) => {"label": status, "value": status}).toList(),
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
                        label: "Sort By",
                        items: sortOptions.map((sort) => {"label": sort, "value": sort}).toList(),
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

          // Statistics Cards
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total Items",
                    "${inventoryItems.length}",
                    Icons.inventory_2,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Low Stock",
                    "${inventoryItems.where((item) => item["status"] == "Low Stock").length}",
                    Icons.warning,
                    warningColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Out of Stock",
                    "${inventoryItems.where((item) => item["status"] == "Out of Stock").length}",
                    Icons.error,
                    dangerColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Total Value",
                    "\$${inventoryItems.fold(0.0, (sum, item) => sum + (item["totalValue"] as double)).toStringAsFixed(0)}",
                    Icons.attach_money,
                    successColor,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: filteredItems.isEmpty ? _buildEmptyState() : 
                   isGridView ? _buildGridView(filteredItems) : _buildListView(filteredItems),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>> items) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 200,
        children: items.map((item) => _buildGridItemCard(item)).toList(),
      ),
    );
  }

  Widget _buildGridItemCard(Map<String, dynamic> item) {
    Color statusColor = _getStatusColor(item["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Status
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${item["image"]}",
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${item["status"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Text(
                  "SKU: ${item["sku"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),

                Row(
                  children: [
                    Icon(Icons.inventory, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Stock: ${item["currentStock"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(item["unitPrice"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),

                // Stock Level Indicator
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Stock Level",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${((item["currentStock"] as int) / (item["maxStock"] as int) * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: (item["currentStock"] as int) / (item["maxStock"] as int),
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                    ),
                  ],
                ),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Restock",
                        size: bs.sm,
                        onPressed: () {
                          _restockItem(item);
                        },
                      ),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        _showItemOptions(item);
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

  Widget _buildListView(List<Map<String, dynamic>> items) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: items.map((item) => _buildListItemCard(item)).toList(),
      ),
    );
  }

  Widget _buildListItemCard(Map<String, dynamic> item) {
    Color statusColor = _getStatusColor(item["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${item["image"]}",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${item["status"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Text(
                  "SKU: ${item["sku"]} | ${item["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                
                Row(
                  children: [
                    Text(
                      "Stock: ${item["currentStock"]}/${item["maxStock"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Value: \$${(item["totalValue"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                
                // Progress Bar
                LinearProgressIndicator(
                  value: (item["currentStock"] as int) / (item["maxStock"] as int),
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ],
            ),
          ),
          
          // Actions
          Column(
            children: [
              QButton(
                icon: Icons.add_shopping_cart,
                size: bs.sm,
                onPressed: () {
                  _restockItem(item);
                },
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showItemOptions(item);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: disabledColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No inventory items found",
            style: TextStyle(
              fontSize: fsH6,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Try adjusting your search or filters",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredItems() {
    List<Map<String, dynamic>> filtered = inventoryItems.where((item) {
      bool matchesSearch = searchQuery.isEmpty ||
          (item["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["sku"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["category"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory == "All Categories" || 
          item["category"] == selectedCategory;

      bool matchesStatus = selectedStatus == "All Status" || 
          item["status"] == selectedStatus;

      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();

    // Sort items
    filtered.sort((a, b) {
      switch (sortBy) {
        case "Stock Level":
          return (a["currentStock"] as int).compareTo(b["currentStock"] as int);
        case "Value":
          return (b["totalValue"] as double).compareTo(a["totalValue"] as double);
        case "Expiry Date":
          return (a["daysToExpiry"] as int).compareTo(b["daysToExpiry"] as int);
        case "Usage":
          Map<String, int> usageWeight = {"Very High": 4, "High": 3, "Medium": 2, "Low": 1};
          return (usageWeight[b["usage"]] ?? 0).compareTo(usageWeight[a["usage"]] ?? 0);
        default:
          return (a["name"] as String).compareTo(b["name"] as String);
      }
    });

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Stock":
        return successColor;
      case "Low Stock":
        return warningColor;
      case "Out of Stock":
        return dangerColor;
      case "Expiring Soon":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  void _addNewItem() {
    ss("Add new inventory item");
  }

  void _restockItem(Map<String, dynamic> item) {
    ss("Restocking ${item["name"]}...");
  }

  void _showItemOptions(Map<String, dynamic> item) {
    ss("Options for ${item["name"]}");
  }
}
