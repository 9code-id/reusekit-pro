import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaLowStockAlertsView extends StatefulWidget {
  const ImaLowStockAlertsView({super.key});

  @override
  State<ImaLowStockAlertsView> createState() => _ImaLowStockAlertsViewState();
}

class _ImaLowStockAlertsViewState extends State<ImaLowStockAlertsView> {
  bool loading = false;
  String searchQuery = "";
  String selectedPriority = "all";
  String selectedCategory = "all";

  List<Map<String, dynamic>> priorityFilters = [
    {"label": "All Priority", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
  ];

  List<Map<String, dynamic>> categoryFilters = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Food & Beverage", "value": "food"},
    {"label": "Home & Garden", "value": "home"},
  ];

  List<Map<String, dynamic>> lowStockItems = [
    {
      "id": "PROD001",
      "name": "MacBook Pro 14-inch",
      "category": "electronics",
      "sku": "MB-PRO-14-001",
      "currentStock": 2,
      "minStockLevel": 10,
      "maxStockLevel": 50,
      "reorderPoint": 15,
      "price": 1999.99,
      "supplier": "Apple Inc.",
      "lastRestocked": "2025-05-15T10:30:00",
      "priority": "critical",
      "status": "critical",
      "image": "https://picsum.photos/80/80?random=1&keyword=laptop",
      "demandRate": 5.2,
      "leadTime": 7,
      "cost": 1500.0,
    },
    {
      "id": "PROD002", 
      "name": "Wireless Headphones",
      "category": "electronics",
      "sku": "WH-001",
      "currentStock": 5,
      "minStockLevel": 20,
      "maxStockLevel": 100,
      "reorderPoint": 30,
      "price": 299.99,
      "supplier": "Sony Corporation",
      "lastRestocked": "2025-06-01T14:20:00",
      "priority": "high",
      "status": "low",
      "image": "https://picsum.photos/80/80?random=2&keyword=headphones",
      "demandRate": 8.5,
      "leadTime": 5,
      "cost": 200.0,
    },
    {
      "id": "PROD003",
      "name": "Summer Dress",
      "category": "clothing",
      "sku": "SD-2025-001",
      "currentStock": 8,
      "minStockLevel": 25,
      "maxStockLevel": 150,
      "reorderPoint": 40,
      "price": 79.99,
      "supplier": "Fashion Hub",
      "lastRestocked": "2025-05-28T09:15:00",
      "priority": "medium",
      "status": "low",
      "image": "https://picsum.photos/80/80?random=3&keyword=dress",
      "demandRate": 12.3,
      "leadTime": 10,
      "cost": 35.0,
    },
    {
      "id": "PROD004",
      "name": "Organic Coffee Beans",
      "category": "food",
      "sku": "OCB-001",
      "currentStock": 3,
      "minStockLevel": 15,
      "maxStockLevel": 80,
      "reorderPoint": 25,
      "price": 24.99,
      "supplier": "Green Coffee Co.",
      "lastRestocked": "2025-06-10T08:00:00",
      "priority": "critical",
      "status": "critical",
      "image": "https://picsum.photos/80/80?random=4&keyword=coffee",
      "demandRate": 15.7,
      "leadTime": 3,
      "cost": 12.0,
    },
    {
      "id": "PROD005",
      "name": "Garden Hose Set",
      "category": "home",
      "sku": "GHS-001",
      "currentStock": 6,
      "minStockLevel": 12,
      "maxStockLevel": 60,
      "reorderPoint": 20,
      "price": 45.99,
      "supplier": "Garden Tools Ltd.",
      "lastRestocked": "2025-05-20T11:45:00",
      "priority": "medium",
      "status": "low",
      "image": "https://picsum.photos/80/80?random=5&keyword=hose",
      "demandRate": 3.8,
      "leadTime": 14,
      "cost": 25.0,
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> filtered = lowStockItems;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) {
        return item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               item["sku"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by priority
    if (selectedPriority != "all") {
      filtered = filtered.where((item) => item["priority"] == selectedPriority).toList();
    }

    // Filter by category
    if (selectedCategory != "all") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }

    return filtered;
  }

  int get criticalCount => lowStockItems.where((item) => item["priority"] == "critical").length;
  int get highCount => lowStockItems.where((item) => item["priority"] == "high").length;
  int get mediumCount => lowStockItems.where((item) => item["priority"] == "medium").length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Low Stock Alerts"),
        actions: [
          GestureDetector(
            onTap: () => _exportReport(),
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.download),
            ),
          ),
        ],
      ),
      body: loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search products...",
                        value: searchQuery,
                        hint: "Product name or SKU",
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
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Filter Row
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Priority",
                        items: priorityFilters,
                        value: selectedPriority,
                        onChanged: (value, label) {
                          selectedPriority = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryFilters,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Statistics Cards
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                          border: Border(
                            left: BorderSide(width: 4, color: dangerColor),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "$criticalCount",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Critical",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
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
                          border: Border(
                            left: BorderSide(width: 4, color: warningColor),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "$highCount",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "High",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
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
                          border: Border(
                            left: BorderSide(width: 4, color: infoColor),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "$mediumCount",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Medium",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Bulk Actions
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Restock All Critical",
                        size: bs.sm,
                        onPressed: () => _bulkRestock("critical"),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Generate Orders",
                        size: bs.sm,
                        onPressed: () => _generatePurchaseOrders(),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Results Header
                Row(
                  children: [
                    Text(
                      "Low Stock Items (${filteredItems.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => _sortItems(),
                      child: Row(
                        children: [
                          Icon(Icons.sort, size: 16, color: primaryColor),
                          SizedBox(width: spXs),
                          Text(
                            "Sort",
                            style: TextStyle(color: primaryColor, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Items List
                if (filteredItems.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      children: [
                        Icon(
                          Icons.inventory_2,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No low stock items found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "All items are well stocked!",
                          style: TextStyle(
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getPriorityColor(item["priority"] as String),
                            ),
                          ),
                        ),
                        child: InkWell(
                          onTap: () => _showItemDetail(item),
                          borderRadius: BorderRadius.circular(radiusMd),
                          child: Padding(
                            padding: EdgeInsets.all(spMd),
                            child: Row(
                              children: [
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${item["name"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: spXs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getPriorityColor(item["priority"] as String).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${item["priority"]}".toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: _getPriorityColor(item["priority"] as String),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "SKU: ${item["sku"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: spSm),
                                      Row(
                                        children: [
                                          Icon(Icons.inventory, size: 16, color: dangerColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Stock: ${item["currentStock"]}",
                                            style: TextStyle(
                                              color: dangerColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(width: spMd),
                                          Icon(Icons.warning, size: 16, color: warningColor),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Min: ${item["minStockLevel"]}",
                                            style: TextStyle(
                                              color: warningColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spSm),
                                      Row(
                                        children: [
                                          Text(
                                            "\$${((item["price"] as double)).currency}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: spMd),
                                          Text(
                                            "Supplier: ${item["supplier"]}",
                                            style: TextStyle(
                                              color: disabledBoldColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _restockItem(item),
                                      child: Container(
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Icon(
                                          Icons.add_shopping_cart,
                                          color: successColor,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spSm),
                                    GestureDetector(
                                      onTap: () => _showItemActions(item),
                                      child: Icon(
                                        Icons.more_vert,
                                        color: disabledBoldColor,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showItemDetail(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusLg),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${item["image"]}",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "SKU: ${item["sku"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: disabledBoldColor),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getPriorityColor(item["priority"] as String).withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${item["currentStock"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text("Current Stock", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${item["minStockLevel"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text("Min Level", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${item["reorderPoint"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text("Reorder Point", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${((item["price"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text("Price", style: TextStyle(fontSize: 12)),
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
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${(item["demandRate"] as double).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text("Demand/Week", style: TextStyle(fontSize: 12)),
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
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${item["leadTime"]} days",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text("Lead Time", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            Text(
              "Supplier: ${item["supplier"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Last Restocked: ${DateTime.parse(item["lastRestocked"] as String).dMMMy}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spLg),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Quick Restock",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                      _restockItem(item);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Create Order",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                      _createPurchaseOrder(item);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showItemActions(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusLg),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _restockItem(item);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.add_shopping_cart, color: successColor),
                    SizedBox(width: spMd),
                    Text("Restock Item", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _createPurchaseOrder(item);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart, color: primaryColor),
                    SizedBox(width: spMd),
                    Text("Create Purchase Order", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _editStockLevels(item);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.edit, color: warningColor),
                    SizedBox(width: spMd),
                    Text("Edit Stock Levels", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _restockItem(Map<String, dynamic> item) {
    ss("Restock initiated for ${item["name"]}");
  }

  void _createPurchaseOrder(Map<String, dynamic> item) {
    ss("Purchase order created for ${item["name"]}");
  }

  void _editStockLevels(Map<String, dynamic> item) {
    ss("Opening stock level editor for ${item["name"]}");
  }

  void _bulkRestock(String priority) async {
    bool isConfirmed = await confirm("Restock all $priority priority items?");
    if (isConfirmed) {
      ss("Bulk restock initiated for $priority items");
    }
  }

  void _generatePurchaseOrders() {
    ss("Generating purchase orders for all low stock items");
  }

  void _exportReport() {
    ss("Exporting low stock report");
  }

  void _sortItems() {
    ss("Sort options opened");
  }
}
