import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosStockLevelsView extends StatefulWidget {
  const PosStockLevelsView({super.key});

  @override
  State<PosStockLevelsView> createState() => _PosStockLevelsViewState();
}

class _PosStockLevelsViewState extends State<PosStockLevelsView> {
  int selectedTab = 0;
  String selectedCategory = "all";
  String selectedWarehouse = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Food & Beverages", "value": "food"},
    {"label": "Books", "value": "books"},
    {"label": "Home & Garden", "value": "home"},
  ];

  List<Map<String, dynamic>> warehouses = [
    {"label": "All Warehouses", "value": "all"},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "Store A", "value": "store_a"},
    {"label": "Store B", "value": "store_b"},
    {"label": "Online Warehouse", "value": "online"},
  ];

  List<Map<String, dynamic>> stockData = [
    {
      "id": "prod_001",
      "name": "Wireless Headphones",
      "sku": "WH-001",
      "category": "electronics",
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones",
      "locations": [
        {"warehouse": "main", "stock": 45, "min_stock": 20, "max_stock": 100, "reserved": 5},
        {"warehouse": "store_a", "stock": 12, "min_stock": 10, "max_stock": 50, "reserved": 2},
        {"warehouse": "store_b", "stock": 8, "min_stock": 10, "max_stock": 50, "reserved": 0},
        {"warehouse": "online", "stock": 25, "min_stock": 15, "max_stock": 80, "reserved": 8},
      ],
      "total_stock": 90,
      "total_reserved": 15,
      "available_stock": 75,
      "reorder_point": 30,
      "lead_time_days": 7,
      "last_movement": "2024-06-18",
      "movement_type": "sale"
    },
    {
      "id": "prod_002",
      "name": "Bluetooth Speaker",
      "sku": "BS-002",
      "category": "electronics",
      "image": "https://picsum.photos/80/80?random=2&keyword=speaker",
      "locations": [
        {"warehouse": "main", "stock": 15, "min_stock": 25, "max_stock": 80, "reserved": 3},
        {"warehouse": "store_a", "stock": 6, "min_stock": 8, "max_stock": 40, "reserved": 1},
        {"warehouse": "store_b", "stock": 0, "min_stock": 8, "max_stock": 40, "reserved": 0},
        {"warehouse": "online", "stock": 9, "min_stock": 12, "max_stock": 60, "reserved": 4},
      ],
      "total_stock": 30,
      "total_reserved": 8,
      "available_stock": 22,
      "reorder_point": 40,
      "lead_time_days": 5,
      "last_movement": "2024-06-17",
      "movement_type": "purchase"
    },
    {
      "id": "prod_003",
      "name": "Cotton T-Shirt",
      "sku": "CT-003",
      "category": "clothing",
      "image": "https://picsum.photos/80/80?random=3&keyword=shirt",
      "locations": [
        {"warehouse": "main", "stock": 0, "min_stock": 50, "max_stock": 200, "reserved": 0},
        {"warehouse": "store_a", "stock": 0, "min_stock": 20, "max_stock": 100, "reserved": 0},
        {"warehouse": "store_b", "stock": 3, "min_stock": 20, "max_stock": 100, "reserved": 0},
        {"warehouse": "online", "stock": 0, "min_stock": 30, "max_stock": 150, "reserved": 0},
      ],
      "total_stock": 3,
      "total_reserved": 0,
      "available_stock": 3,
      "reorder_point": 60,
      "lead_time_days": 10,
      "last_movement": "2024-06-16",
      "movement_type": "sale"
    },
    {
      "id": "prod_004",
      "name": "Coffee Beans 1kg",
      "sku": "CB-004",
      "category": "food",
      "image": "https://picsum.photos/80/80?random=4&keyword=coffee",
      "locations": [
        {"warehouse": "main", "stock": 120, "min_stock": 80, "max_stock": 300, "reserved": 15},
        {"warehouse": "store_a", "stock": 25, "min_stock": 20, "max_stock": 100, "reserved": 5},
        {"warehouse": "store_b", "stock": 18, "min_stock": 20, "max_stock": 100, "reserved": 2},
        {"warehouse": "online", "stock": 35, "min_stock": 25, "max_stock": 120, "reserved": 10},
      ],
      "total_stock": 198,
      "total_reserved": 32,
      "available_stock": 166,
      "reorder_point": 100,
      "lead_time_days": 3,
      "last_movement": "2024-06-18",
      "movement_type": "adjustment"
    },
    {
      "id": "prod_005",
      "name": "Programming Book",
      "sku": "PB-005",
      "category": "books",
      "image": "https://picsum.photos/80/80?random=5&keyword=book",
      "locations": [
        {"warehouse": "main", "stock": 8, "min_stock": 15, "max_stock": 60, "reserved": 2},
        {"warehouse": "store_a", "stock": 2, "min_stock": 5, "max_stock": 25, "reserved": 0},
        {"warehouse": "store_b", "stock": 0, "min_stock": 5, "max_stock": 25, "reserved": 0},
        {"warehouse": "online", "stock": 4, "min_stock": 8, "max_stock": 40, "reserved": 1},
      ],
      "total_stock": 14,
      "total_reserved": 3,
      "available_stock": 11,
      "reorder_point": 20,
      "lead_time_days": 14,
      "last_movement": "2024-06-15",
      "movement_type": "sale"
    },
  ];

  List<Map<String, dynamic>> get filteredStockData {
    return stockData.where((product) {
      final matchesCategory = selectedCategory == "all" || product["category"] == selectedCategory;
      final matchesWarehouse = selectedWarehouse == "all" || 
        (product["locations"] as List).any((loc) => loc["warehouse"] == selectedWarehouse);
      final matchesSearch = searchQuery.isEmpty || 
        product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        product["sku"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesWarehouse && matchesSearch;
    }).toList();
  }

  List<Map<String, dynamic>> get lowStockProducts {
    return stockData.where((product) {
      final totalStock = product["total_stock"] as int;
      final reorderPoint = product["reorder_point"] as int;
      return totalStock <= reorderPoint;
    }).toList();
  }

  List<Map<String, dynamic>> get outOfStockProducts {
    return stockData.where((product) {
      final totalStock = product["total_stock"] as int;
      return totalStock == 0;
    }).toList();
  }

  List<Map<String, dynamic>> get overstockProducts {
    return stockData.where((product) {
      final locations = product["locations"] as List;
      return locations.any((loc) => (loc["stock"] as int) > (loc["max_stock"] as int) * 0.8);
    }).toList();
  }

  void _adjustStock(String productId, String warehouse, int newQuantity) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 500));

    final productIndex = stockData.indexWhere((p) => p["id"] == productId);
    if (productIndex != -1) {
      final locations = stockData[productIndex]["locations"] as List;
      final locationIndex = locations.indexWhere((loc) => loc["warehouse"] == warehouse);
      
      if (locationIndex != -1) {
        final oldQuantity = locations[locationIndex]["stock"] as int;
        locations[locationIndex]["stock"] = newQuantity;
        
        // Recalculate totals
        final totalStock = locations.map((loc) => loc["stock"] as int).fold(0, (sum, stock) => sum + stock);
        final totalReserved = locations.map((loc) => loc["reserved"] as int).fold(0, (sum, reserved) => sum + reserved);
        
        stockData[productIndex]["total_stock"] = totalStock;
        stockData[productIndex]["available_stock"] = totalStock - totalReserved;
        stockData[productIndex]["last_movement"] = DateTime.now().toString().substring(0, 10);
        stockData[productIndex]["movement_type"] = "adjustment";
      }
    }

    loading = false;
    setState(() {});
    ss("Stock level adjusted successfully");
  }

  void _transferStock(String productId, String fromWarehouse, String toWarehouse, int quantity) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 800));

    final productIndex = stockData.indexWhere((p) => p["id"] == productId);
    if (productIndex != -1) {
      final locations = stockData[productIndex]["locations"] as List;
      final fromIndex = locations.indexWhere((loc) => loc["warehouse"] == fromWarehouse);
      final toIndex = locations.indexWhere((loc) => loc["warehouse"] == toWarehouse);
      
      if (fromIndex != -1 && toIndex != -1) {
        final fromStock = locations[fromIndex]["stock"] as int;
        if (fromStock >= quantity) {
          locations[fromIndex]["stock"] = fromStock - quantity;
          locations[toIndex]["stock"] = (locations[toIndex]["stock"] as int) + quantity;
          
          stockData[productIndex]["last_movement"] = DateTime.now().toString().substring(0, 10);
          stockData[productIndex]["movement_type"] = "transfer";
        }
      }
    }

    loading = false;
    setState(() {});
    ss("Stock transferred successfully");
  }

  Widget _buildStockLevelStats() {
    final totalProducts = stockData.length;
    final lowStockCount = lowStockProducts.length;
    final outOfStockCount = outOfStockProducts.length;
    final overstockCount = overstockProducts.length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.inventory,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$totalProducts",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Products",
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
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.warning,
                  color: warningColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$lowStockCount",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Low Stock",
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
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.error,
                  color: dangerColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$outOfStockCount",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "Out of Stock",
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
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.trending_up,
                  color: infoColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$overstockCount",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Overstock",
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
    );
  }

  Widget _buildStockLevelsTab() {
    return Column(
      spacing: spMd,
      children: [
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
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search Products",
                      value: searchQuery,
                      hint: "Enter product name or SKU",
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
                      label: "Category",
                      items: categories,
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
                      label: "Warehouse",
                      items: warehouses,
                      value: selectedWarehouse,
                      onChanged: (value, label) {
                        selectedWarehouse = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ...filteredStockData.map((product) => _buildStockLevelCard(product)),
      ],
    );
  }

  Widget _buildStockLevelCard(Map<String, dynamic> product) {
    final totalStock = product["total_stock"] as int;
    final availableStock = product["available_stock"] as int;
    final totalReserved = product["total_reserved"] as int;
    final reorderPoint = product["reorder_point"] as int;
    final locations = product["locations"] as List;

    final isLowStock = totalStock <= reorderPoint;
    final isOutOfStock = totalStock == 0;

    Color statusColor = successColor;
    String statusText = "IN STOCK";
    
    if (isOutOfStock) {
      statusColor = dangerColor;
      statusText = "OUT OF STOCK";
    } else if (isLowStock) {
      statusColor = warningColor;
      statusText = "LOW STOCK";
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: statusColor.withAlpha(50)),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${product["image"]}",
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
                      "${product["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "SKU: ${product["sku"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            statusText,
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "REORDER: $reorderPoint",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.transfer_within_a_station,
                size: bs.sm,
                onPressed: () {
                  _showTransferDialog(product);
                },
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Stock",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "$totalStock",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
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
                      "Available",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "$availableStock",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                      "Reserved",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "$totalReserved",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
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
                      "Last Movement",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${product["last_movement"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stock by Location:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Column(
                  children: locations.map((location) {
                    final warehouseName = location["warehouse"] as String;
                    final stock = location["stock"] as int;
                    final minStock = location["min_stock"] as int;
                    final maxStock = location["max_stock"] as int;
                    final reserved = location["reserved"] as int;
                    
                    final warehouseLabel = warehouses.firstWhere(
                      (w) => w["value"] == warehouseName,
                      orElse: () => {"label": warehouseName}
                    )["label"];

                    Color locationStatusColor = successColor;
                    if (stock == 0) locationStatusColor = dangerColor;
                    else if (stock <= minStock) locationStatusColor = warningColor;

                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: locationStatusColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$warehouseLabel",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Stock: $stock | Reserved: $reserved",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () {
                              _showAdjustStockDialog(product, warehouseName, stock);
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertTab() {
    return Column(
      spacing: spMd,
      children: [
        if (lowStockProducts.isNotEmpty) ...[
          Text(
            "Low Stock Alert (${lowStockProducts.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: warningColor,
            ),
          ),
          ...lowStockProducts.map((product) => _buildAlertCard(product, "low_stock")),
        ],
        if (outOfStockProducts.isNotEmpty) ...[
          Text(
            "Out of Stock Alert (${outOfStockProducts.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: dangerColor,
            ),
          ),
          ...outOfStockProducts.map((product) => _buildAlertCard(product, "out_of_stock")),
        ],
        if (overstockProducts.isNotEmpty) ...[
          Text(
            "Overstock Alert (${overstockProducts.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: infoColor,
            ),
          ),
          ...overstockProducts.map((product) => _buildAlertCard(product, "overstock")),
        ],
        if (lowStockProducts.isEmpty && outOfStockProducts.isEmpty && overstockProducts.isEmpty)
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 32,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "All stock levels are within normal ranges",
                    style: TextStyle(
                      fontSize: 16,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> product, String alertType) {
    final totalStock = product["total_stock"] as int;
    final reorderPoint = product["reorder_point"] as int;
    final leadTimeDays = product["lead_time_days"] as int;

    Color alertColor = warningColor;
    String alertTitle = "Low Stock Alert";
    String alertMessage = "Stock level is below reorder point";

    if (alertType == "out_of_stock") {
      alertColor = dangerColor;
      alertTitle = "Out of Stock Alert";
      alertMessage = "Product is completely out of stock";
    } else if (alertType == "overstock") {
      alertColor = infoColor;
      alertTitle = "Overstock Alert";
      alertMessage = "Stock level exceeds optimal range";
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: alertColor.withAlpha(50)),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(
            alertType == "out_of_stock" ? Icons.error : 
            alertType == "low_stock" ? Icons.warning : Icons.info,
            color: alertColor,
            size: 32,
          ),
          SizedBox(width: spSm),
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${product["image"]}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alertTitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: alertColor,
                  ),
                ),
                Text(
                  "${product["name"]} (${product["sku"]})",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  alertMessage,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Current: $totalStock",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: alertColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Reorder: $reorderPoint",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Lead time: ${leadTimeDays}d",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QButton(
            label: "Reorder",
            icon: Icons.shopping_cart,
            size: bs.sm,
            onPressed: () {
              si("Reorder process initiated for ${product["name"]}");
            },
          ),
        ],
      ),
    );
  }

  void _showAdjustStockDialog(Map<String, dynamic> product, String warehouse, int currentStock) {
    String newStock = currentStock.toString();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Adjust Stock"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Product: ${product["name"]}"),
            Text("Warehouse: ${warehouses.firstWhere((w) => w["value"] == warehouse)["label"]}"),
            SizedBox(height: spSm),
            QNumberField(
              label: "New Stock Quantity",
              value: newStock,
              onChanged: (value) {
                newStock = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Adjust",
            size: bs.sm,
            onPressed: () {
              _adjustStock(product["id"], warehouse, int.tryParse(newStock) ?? 0);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showTransferDialog(Map<String, dynamic> product) {
    String fromWarehouse = "main";
    String toWarehouse = "store_a";
    String transferQuantity = "1";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Transfer Stock"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Product: ${product["name"]}"),
            SizedBox(height: spSm),
            QDropdownField(
              label: "From Warehouse",
              items: warehouses.where((w) => w["value"] != "all").toList(),
              value: fromWarehouse,
              onChanged: (value, label) {
                fromWarehouse = value;
              },
            ),
            QDropdownField(
              label: "To Warehouse",
              items: warehouses.where((w) => w["value"] != "all").toList(),
              value: toWarehouse,
              onChanged: (value, label) {
                toWarehouse = value;
              },
            ),
            QNumberField(
              label: "Transfer Quantity",
              value: transferQuantity,
              onChanged: (value) {
                transferQuantity = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Transfer",
            size: bs.sm,
            onPressed: () {
              _transferStock(product["id"], fromWarehouse, toWarehouse, int.tryParse(transferQuantity) ?? 0);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Stock Levels",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Stock Levels", icon: Icon(Icons.inventory)),
        Tab(text: "Alerts", icon: Icon(Icons.warning)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildStockLevelStats(),
              _buildStockLevelsTab(),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildAlertTab(),
        ),
      ],
    );
  }
}
