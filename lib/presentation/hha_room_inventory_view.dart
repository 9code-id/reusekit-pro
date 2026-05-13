import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaRoomInventoryView extends StatefulWidget {
  const HhaRoomInventoryView({super.key});

  @override
  State<HhaRoomInventoryView> createState() => _HhaRoomInventoryViewState();
}

class _HhaRoomInventoryViewState extends State<HhaRoomInventoryView> {
  int currentTab = 0;
  String selectedRoom = "all";
  String selectedCategory = "all";
  String selectedStatus = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> inventory = [
    {
      "id": "INV001",
      "roomNumber": "101",
      "floor": 1,
      "type": "Standard",
      "category": "linens",
      "item": "Bed Sheets",
      "currentStock": 4,
      "requiredStock": 6,
      "status": "low",
      "lastRestocked": "2024-06-10",
      "supplier": "Hotel Linens Co",
      "unitCost": 25.0,
      "expiryDate": null,
      "condition": "good"
    },
    {
      "id": "INV002",
      "roomNumber": "101",
      "floor": 1,
      "type": "Standard",
      "category": "amenities",
      "item": "Shampoo Bottles",
      "currentStock": 8,
      "requiredStock": 12,
      "status": "low",
      "lastRestocked": "2024-06-12",
      "supplier": "Luxury Amenities Ltd",
      "unitCost": 8.5,
      "expiryDate": "2025-06-01",
      "condition": "good"
    },
    {
      "id": "INV003",
      "roomNumber": "205",
      "floor": 2,
      "type": "Deluxe",
      "category": "electronics",
      "item": "TV Remote",
      "currentStock": 1,
      "requiredStock": 2,
      "status": "critical",
      "lastRestocked": "2024-05-20",
      "supplier": "Electronics Supply",
      "unitCost": 15.0,
      "expiryDate": null,
      "condition": "damaged"
    },
    {
      "id": "INV004",
      "roomNumber": "312",
      "floor": 3,
      "type": "Suite",
      "category": "furniture",
      "item": "Desk Chair",
      "currentStock": 2,
      "requiredStock": 2,
      "status": "adequate",
      "lastRestocked": "2024-03-15",
      "supplier": "Office Furniture Pro",
      "unitCost": 180.0,
      "expiryDate": null,
      "condition": "good"
    },
    {
      "id": "INV005",
      "roomNumber": "418",
      "floor": 4,
      "type": "Executive",
      "category": "beverages",
      "item": "Coffee Pods",
      "currentStock": 0,
      "requiredStock": 20,
      "status": "out_of_stock",
      "lastRestocked": "2024-06-08",
      "supplier": "Premium Coffee Co",
      "unitCost": 1.2,
      "expiryDate": "2024-12-31",
      "condition": "good"
    },
    {
      "id": "INV006",
      "roomNumber": "523",
      "floor": 5,
      "type": "Presidential",
      "category": "linens",
      "item": "Luxury Towels",
      "currentStock": 12,
      "requiredStock": 10,
      "status": "overstocked",
      "lastRestocked": "2024-06-14",
      "supplier": "Premium Linens",
      "unitCost": 45.0,
      "expiryDate": null,
      "condition": "excellent"
    }
  ];

  List<Map<String, dynamic>> roomOptions = [
    {"label": "All Rooms", "value": "all"},
    {"label": "Room 101", "value": "101"},
    {"label": "Room 205", "value": "205"},
    {"label": "Room 312", "value": "312"},
    {"label": "Room 418", "value": "418"},
    {"label": "Room 523", "value": "523"}
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Linens", "value": "linens"},
    {"label": "Amenities", "value": "amenities"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Furniture", "value": "furniture"},
    {"label": "Beverages", "value": "beverages"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Out of Stock", "value": "out_of_stock"},
    {"label": "Critical", "value": "critical"},
    {"label": "Low", "value": "low"},
    {"label": "Adequate", "value": "adequate"},
    {"label": "Overstocked", "value": "overstocked"}
  ];

  List<Map<String, dynamic>> get filteredInventory {
    return inventory.where((item) {
      bool matchesRoom = selectedRoom == "all" || item["roomNumber"] == selectedRoom;
      bool matchesCategory = selectedCategory == "all" || item["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "all" || item["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty || 
          (item["item"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["roomNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesRoom && matchesCategory && matchesStatus && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'out_of_stock':
        return dangerColor;
      case 'critical':
        return dangerColor;
      case 'low':
        return warningColor;
      case 'adequate':
        return successColor;
      case 'overstocked':
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case 'excellent':
        return successColor;
      case 'good':
        return infoColor;
      case 'fair':
        return warningColor;
      case 'damaged':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Room Inventory",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Items", icon: Icon(Icons.inventory)),
        Tab(text: "Low Stock", icon: Icon(Icons.warning)),
        Tab(text: "Restocking", icon: Icon(Icons.refresh)),
      ],
      tabChildren: [
        _buildAllItemsTab(),
        _buildLowStockTab(),
        _buildRestockingTab(),
      ],
    );
  }

  Widget _buildAllItemsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter Section
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search items or rooms...",
                  value: searchQuery,
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
          
          // Filter Options
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              QDropdownField(
                label: "Room",
                items: roomOptions,
                value: selectedRoom,
                onChanged: (value, label) {
                  selectedRoom = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Category",
                items: categoryOptions,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ],
          ),

          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSummaryCard(
                "Total Items",
                "${inventory.length}",
                Icons.inventory,
                primaryColor,
              ),
              _buildSummaryCard(
                "Out of Stock",
                "${inventory.where((i) => i["status"] == "out_of_stock").length}",
                Icons.remove_circle,
                dangerColor,
              ),
              _buildSummaryCard(
                "Low Stock",
                "${inventory.where((i) => i["status"] == "low" || i["status"] == "critical").length}",
                Icons.warning,
                warningColor,
              ),
              _buildSummaryCard(
                "Total Value",
                "\$${inventory.fold(0.0, (sum, item) => sum + ((item["currentStock"] as int) * (item["unitCost"] as double))).toStringAsFixed(0)}",
                Icons.attach_money,
                successColor,
              ),
            ],
          ),

          // Inventory List
          ...filteredInventory.map((item) => _buildInventoryCard(item)),
        ],
      ),
    );
  }

  Widget _buildLowStockTab() {
    List<Map<String, dynamic>> lowStockItems = inventory.where((item) => 
        item["status"] == "out_of_stock" || 
        item["status"] == "critical" || 
        item["status"] == "low"
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Low Stock Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(60)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: warningColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Low Stock Alert",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "${lowStockItems.length} items need restocking",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Order All",
                  size: bs.sm,
                  onPressed: () {
                    // Order all low stock items
                  },
                ),
              ],
            ),
          ),

          // Priority Items
          ...lowStockItems.map((item) => _buildLowStockCard(item)),
        ],
      ),
    );
  }

  Widget _buildRestockingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Restock Actions
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildQuickActionCard(
                "Scan QR Code",
                "Scan item to update stock",
                Icons.qr_code_scanner,
                primaryColor,
                () {
                  // Scan QR code
                },
              ),
              _buildQuickActionCard(
                "Bulk Update",
                "Update multiple items",
                Icons.edit_note,
                infoColor,
                () {
                  // Bulk update
                },
              ),
              _buildQuickActionCard(
                "Generate Report",
                "Export inventory report",
                Icons.assessment,
                successColor,
                () {
                  // Generate report
                },
              ),
              _buildQuickActionCard(
                "Order History",
                "View past orders",
                Icons.history,
                warningColor,
                () {
                  // View order history
                },
              ),
            ],
          ),

          // Recent Restocking
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Restocking",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                ...inventory.take(3).map((item) => _buildRecentRestockItem(item)),
              ],
            ),
          ),

          // Supplier Information
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Suppliers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                ..._getUniqueSuppliers().map((supplier) => _buildSupplierItem(supplier)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryCard(Map<String, dynamic> item) {
    double stockPercentage = (item["currentStock"] as int) / (item["requiredStock"] as int);
    
    return Container(
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
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(item["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["item"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(item["status"]),
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(item["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["status"]}".toUpperCase().replaceAll("_", " "),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(item["status"]),
                  ),
                ),
              ),
            ],
          ),

          // Room and Category Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Room ${item["roomNumber"]} • ${item["category"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${item["type"]} - Floor ${item["floor"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((item["unitCost"] as double) * (item["currentStock"] as int)).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "\$${(item["unitCost"] as double).toStringAsFixed(2)} each",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Stock Information
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Stock Level",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${item["currentStock"]}/${item["requiredStock"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: stockPercentage > 1 ? 1 : stockPercentage,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getStatusColor(item["status"]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Additional Information
          Row(
            children: [
              Icon(Icons.business, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${item["supplier"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getConditionColor(item["condition"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["condition"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getConditionColor(item["condition"]),
                  ),
                ),
              ),
            ],
          ),

          // Expiry Date (if applicable)
          if (item["expiryDate"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Expires: ${item["expiryDate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w500,
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
                  label: "Update Stock",
                  size: bs.sm,
                  onPressed: () {
                    _showUpdateStockDialog(item);
                  },
                ),
              ),
              SizedBox(width: spSm),
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
  }

  Widget _buildLowStockCard(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: _getStatusColor(item["status"]).withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                item["status"] == "out_of_stock" ? Icons.remove_circle : Icons.warning,
                color: _getStatusColor(item["status"]),
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "${item["item"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(item["status"]),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(item["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["status"]}".toUpperCase().replaceAll("_", " "),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(item["status"]),
                  ),
                ),
              ),
            ],
          ),

          Text(
            "Room ${item["roomNumber"]} • ${item["category"]}".toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current: ${item["currentStock"]} / Required: ${item["requiredStock"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Need: ${(item["requiredStock"] as int) - (item["currentStock"] as int)} units",
                      style: TextStyle(
                        fontSize: 12,
                        color: _getStatusColor(item["status"]),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((item["unitCost"] as double) * ((item["requiredStock"] as int) - (item["currentStock"] as int))).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "to restock",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Order Now",
                  size: bs.sm,
                  onPressed: () {
                    // Order item
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  _showUpdateStockDialog(item);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spXs),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentRestockItem(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.inventory, color: successColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["item"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Room ${item["roomNumber"]} • ${item["lastRestocked"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "+${item["currentStock"]}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplierItem(String supplier) {
    int itemCount = inventory.where((item) => item["supplier"] == supplier).length;
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.business, color: primaryColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  supplier,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "$itemCount items",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.phone,
            size: bs.sm,
            onPressed: () {
              // Contact supplier
            },
          ),
        ],
      ),
    );
  }

  List<String> _getUniqueSuppliers() {
    return inventory.map((item) => item["supplier"] as String).toSet().toList();
  }

  void _showUpdateStockDialog(Map<String, dynamic> item) {
    String newStock = item["currentStock"].toString();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Stock"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${item["item"]} - Room ${item["roomNumber"]}"),
            SizedBox(height: spMd),
            QNumberField(
              label: "Current Stock",
              value: newStock,
              onChanged: (value) {
                newStock = value;
              },
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Update",
            size: bs.sm,
            onPressed: () {
              // Update stock
              Navigator.pop(context);
              ss("Stock updated successfully");
            },
          ),
        ],
      ),
    );
  }
}
