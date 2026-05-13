import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaInventoryView extends StatefulWidget {
  const RmaInventoryView({super.key});

  @override
  State<RmaInventoryView> createState() => _RmaInventoryViewState();
}

class _RmaInventoryViewState extends State<RmaInventoryView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String stockStatus = "all";
  String sortBy = "name";
  bool showLowStock = false;
  
  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": "INV-001",
      "name": "Ribeye Steak",
      "category": "meat",
      "currentStock": 25,
      "minStock": 10,
      "maxStock": 50,
      "unit": "pieces",
      "unitCost": 18.50,
      "totalValue": 462.50,
      "supplier": "Prime Meats Co.",
      "lastRestocked": "2024-03-14",
      "expirationDate": "2024-03-18",
      "location": "Freezer A",
      "status": "in_stock",
      "dailyUsage": 12,
      "weeklyUsage": 78,
    },
    {
      "id": "INV-002",
      "name": "Fresh Salmon",
      "category": "seafood",
      "currentStock": 8,
      "minStock": 15,
      "maxStock": 30,
      "unit": "kg",
      "unitCost": 24.00,
      "totalValue": 192.00,
      "supplier": "Ocean Fresh",
      "lastRestocked": "2024-03-13",
      "expirationDate": "2024-03-16",
      "location": "Cooler B",
      "status": "low_stock",
      "dailyUsage": 8,
      "weeklyUsage": 45,
    },
    {
      "id": "INV-003",
      "name": "Olive Oil",
      "category": "pantry",
      "currentStock": 45,
      "minStock": 20,
      "maxStock": 60,
      "unit": "bottles",
      "unitCost": 12.75,
      "totalValue": 573.75,
      "supplier": "Mediterranean Goods",
      "lastRestocked": "2024-03-10",
      "expirationDate": "2024-09-15",
      "location": "Pantry A",
      "status": "in_stock",
      "dailyUsage": 3,
      "weeklyUsage": 18,
    },
    {
      "id": "INV-004",
      "name": "Tomatoes",
      "category": "vegetables",
      "currentStock": 0,
      "minStock": 25,
      "maxStock": 100,
      "unit": "kg",
      "unitCost": 3.50,
      "totalValue": 0.00,
      "supplier": "Fresh Farm",
      "lastRestocked": "2024-03-12",
      "expirationDate": null,
      "location": "Cooler A",
      "status": "out_of_stock",
      "dailyUsage": 15,
      "weeklyUsage": 95,
    },
    {
      "id": "INV-005",
      "name": "Red Wine",
      "category": "beverages",
      "currentStock": 35,
      "minStock": 12,
      "maxStock": 48,
      "unit": "bottles",
      "unitCost": 22.00,
      "totalValue": 770.00,
      "supplier": "Fine Wines Ltd",
      "lastRestocked": "2024-03-11",
      "expirationDate": "2026-12-31",
      "location": "Wine Cellar",
      "status": "in_stock",
      "dailyUsage": 5,
      "weeklyUsage": 28,
    },
    {
      "id": "INV-006",
      "name": "Parmesan Cheese",
      "category": "dairy",
      "currentStock": 3,
      "minStock": 8,
      "maxStock": 20,
      "unit": "kg",
      "unitCost": 28.00,
      "totalValue": 84.00,
      "supplier": "Artisan Dairy",
      "lastRestocked": "2024-03-09",
      "expirationDate": "2024-03-25",
      "location": "Cooler A",
      "status": "low_stock",
      "dailyUsage": 2,
      "weeklyUsage": 12,
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Meat", "value": "meat"},
    {"label": "Seafood", "value": "seafood"},
    {"label": "Vegetables", "value": "vegetables"},
    {"label": "Dairy", "value": "dairy"},
    {"label": "Pantry", "value": "pantry"},
    {"label": "Beverages", "value": "beverages"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "In Stock", "value": "in_stock"},
    {"label": "Low Stock", "value": "low_stock"},
    {"label": "Out of Stock", "value": "out_of_stock"},
    {"label": "Expired", "value": "expired"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "name"},
    {"label": "Stock Level", "value": "stock"},
    {"label": "Value", "value": "value"},
    {"label": "Expiration", "value": "expiration"},
    {"label": "Usage", "value": "usage"},
  ];

  Widget _buildInventoryStats() {
    final totalItems = inventoryItems.length;
    final lowStockItems = inventoryItems.where((i) => i["status"] == "low_stock").length;
    final outOfStockItems = inventoryItems.where((i) => i["status"] == "out_of_stock").length;
    final totalValue = inventoryItems.map((i) => i["totalValue"] as double).reduce((a, b) => a + b);
    
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
          Text(
            "Inventory Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildStatCard(
                "Total Items",
                "$totalItems",
                Icons.inventory,
                primaryColor,
              ),
              _buildStatCard(
                "Low Stock",
                "$lowStockItems",
                Icons.warning,
                warningColor,
              ),
              _buildStatCard(
                "Out of Stock",
                "$outOfStockItems",
                Icons.error,
                dangerColor,
              ),
              _buildStatCard(
                "Total Value",
                "\$${totalValue.currency}",
                Icons.attach_money,
                successColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
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
                  label: "Search Items",
                  value: searchQuery,
                  hint: "Item name or supplier",
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
                  items: categoryOptions,
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
                  label: "Stock Status",
                  items: statusOptions,
                  value: stockStatus,
                  onChanged: (value, label) {
                    stockStatus = value;
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
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Low Stock Only",
                      "value": true,
                      "checked": showLowStock,
                    }
                  ],
                  value: [
                    if (showLowStock)
                      {
                        "label": "Low Stock Only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showLowStock = values.isNotEmpty;
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

  Widget _buildInventoryCard(Map<String, dynamic> item) {
    final statusColor = item["status"] == "in_stock" ? successColor :
                       item["status"] == "low_stock" ? warningColor :
                       item["status"] == "out_of_stock" ? dangerColor :
                       disabledBoldColor;

    final stockPercentage = (item["currentStock"] as int) / (item["maxStock"] as int);
    final isExpiringSoon = item["expirationDate"] != null && 
                          DateTime.parse(item["expirationDate"]).difference(DateTime.now()).inDays <= 3;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
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
                    Row(
                      children: [
                        Text(
                          "${item["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${item["status"]}".replaceAll("_", " ").toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                        if (isExpiringSoon) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "EXPIRING",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.category, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${item["category"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.location_on, color: primaryColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${item["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${item["currentStock"]} ${item["unit"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${((item["totalValue"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Text(
                "Stock Level:",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: LinearProgressIndicator(
                  value: stockPercentage,
                  backgroundColor: Colors.grey.withAlpha(50),
                  valueColor: AlwaysStoppedAnimation(statusColor),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${(stockPercentage * 100).round()}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 120,
            children: [
              _buildItemMetric("Min Stock", "${item["minStock"]}", Icons.remove),
              _buildItemMetric("Max Stock", "${item["maxStock"]}", Icons.add),
              _buildItemMetric("Unit Cost", "\$${((item["unitCost"] as double)).currency}", Icons.attach_money),
              _buildItemMetric("Daily Usage", "${item["dailyUsage"]}", Icons.trending_down),
              _buildItemMetric("Weekly Usage", "${item["weeklyUsage"]}", Icons.analytics),
              _buildItemMetric("Last Restocked", "${item["lastRestocked"]}", Icons.update),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.local_shipping, color: infoColor, size: 16),
                SizedBox(width: spSm),
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
                      if (item["expirationDate"] != null) ...[
                        SizedBox(height: spXs),
                        Text(
                          "Expires: ${item["expirationDate"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: isExpiringSoon ? dangerColor : disabledBoldColor,
                          ),
                        ),
                      ],
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
                child: QButton(
                  label: "Restock",
                  icon: Icons.add_shopping_cart,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('RestockItem')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('EditItem')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.history,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('ItemHistory')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.remove,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('AdjustStock')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 16,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> filtered = List.from(inventoryItems);
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) {
        final name = "${item["name"]}".toLowerCase();
        final supplier = "${item["supplier"]}".toLowerCase();
        final query = searchQuery.toLowerCase();
        return name.contains(query) || supplier.contains(query);
      }).toList();
    }
    
    // Apply category filter
    if (selectedCategory != "all") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }
    
    // Apply status filter
    if (stockStatus != "all") {
      filtered = filtered.where((item) => item["status"] == stockStatus).toList();
    }
    
    // Apply low stock filter
    if (showLowStock) {
      filtered = filtered.where((item) => item["status"] == "low_stock" || item["status"] == "out_of_stock").toList();
    }
    
    // Apply sorting
    switch (sortBy) {
      case "name":
        filtered.sort((a, b) => a["name"].compareTo(b["name"]));
        break;
      case "stock":
        filtered.sort((a, b) => (a["currentStock"] as int).compareTo(b["currentStock"] as int));
        break;
      case "value":
        filtered.sort((a, b) => (b["totalValue"] as double).compareTo(a["totalValue"] as double));
        break;
      case "expiration":
        filtered.sort((a, b) {
          if (a["expirationDate"] == null && b["expirationDate"] == null) return 0;
          if (a["expirationDate"] == null) return 1;
          if (b["expirationDate"] == null) return -1;
          return a["expirationDate"].compareTo(b["expirationDate"]);
        });
        break;
      case "usage":
        filtered.sort((a, b) => (b["dailyUsage"] as int).compareTo(a["dailyUsage"] as int));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('AddInventoryItem')
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('InventoryAnalytics')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildInventoryStats(),
            _buildFilters(),
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
                  Row(
                    children: [
                      Text(
                        "Inventory Items (${filteredItems.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Add Item",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('AddInventoryItem')
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (filteredItems.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.inventory_2,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No inventory items found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredItems.map((item) => _buildInventoryCard(item)).toList(),
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
