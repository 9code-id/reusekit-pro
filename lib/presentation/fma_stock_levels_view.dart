import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaStockLevelsView extends StatefulWidget {
  const FmaStockLevelsView({super.key});

  @override
  State<FmaStockLevelsView> createState() => _FmaStockLevelsViewState();
}

class _FmaStockLevelsViewState extends State<FmaStockLevelsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Vegetables", "value": "Vegetables"},
    {"label": "Meat", "value": "Meat"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Grains", "value": "Grains"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Condiments", "value": "Condiments"},
    {"label": "Frozen", "value": "Frozen"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "In Stock", "value": "In Stock"},
    {"label": "Low Stock", "value": "Low Stock"},
    {"label": "Out of Stock", "value": "Out of Stock"},
    {"label": "Overstocked", "value": "Overstocked"},
  ];

  List<Map<String, dynamic>> stockItems = [
    {
      "id": "1",
      "name": "Tomatoes",
      "category": "Vegetables",
      "currentStock": 25,
      "minThreshold": 10,
      "maxThreshold": 50,
      "unit": "kg",
      "costPerUnit": 3.50,
      "supplier": "Fresh Farm Co",
      "lastRestocked": "2024-06-15",
      "expiryDate": "2024-06-25",
      "location": "Cooler A",
      "status": "In Stock",
      "image": "https://picsum.photos/80/80?random=1&keyword=tomato"
    },
    {
      "id": "2",
      "name": "Ground Beef",
      "category": "Meat",
      "currentStock": 5,
      "minThreshold": 8,
      "maxThreshold": 30,
      "unit": "kg",
      "costPerUnit": 12.99,
      "supplier": "Premium Meats",
      "lastRestocked": "2024-06-18",
      "expiryDate": "2024-06-22",
      "location": "Freezer B",
      "status": "Low Stock",
      "image": "https://picsum.photos/80/80?random=2&keyword=meat"
    },
    {
      "id": "3",
      "name": "Mozzarella Cheese",
      "category": "Dairy",
      "currentStock": 0,
      "minThreshold": 5,
      "maxThreshold": 20,
      "unit": "kg",
      "costPerUnit": 8.75,
      "supplier": "Dairy Delights",
      "lastRestocked": "2024-06-10",
      "expiryDate": "2024-06-20",
      "location": "Cooler C",
      "status": "Out of Stock",
      "image": "https://picsum.photos/80/80?random=3&keyword=cheese"
    },
    {
      "id": "4",
      "name": "Pasta",
      "category": "Grains",
      "currentStock": 45,
      "minThreshold": 15,
      "maxThreshold": 40,
      "unit": "boxes",
      "costPerUnit": 2.25,
      "supplier": "Italian Imports",
      "lastRestocked": "2024-06-12",
      "expiryDate": "2024-12-31",
      "location": "Pantry A",
      "status": "Overstocked",
      "image": "https://picsum.photos/80/80?random=4&keyword=pasta"
    },
    {
      "id": "5",
      "name": "Olive Oil",
      "category": "Condiments",
      "currentStock": 12,
      "minThreshold": 5,
      "maxThreshold": 25,
      "unit": "bottles",
      "costPerUnit": 15.50,
      "supplier": "Mediterranean Oils",
      "lastRestocked": "2024-06-14",
      "expiryDate": "2024-09-30",
      "location": "Pantry B",
      "status": "In Stock",
      "image": "https://picsum.photos/80/80?random=5&keyword=oil"
    },
    {
      "id": "6",
      "name": "Orange Juice",
      "category": "Beverages",
      "currentStock": 8,
      "minThreshold": 10,
      "maxThreshold": 30,
      "unit": "liters",
      "costPerUnit": 4.25,
      "supplier": "Fresh Squeeze Co",
      "lastRestocked": "2024-06-17",
      "expiryDate": "2024-06-24",
      "location": "Cooler D",
      "status": "Low Stock",
      "image": "https://picsum.photos/80/80?random=6&keyword=juice"
    },
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": "1",
      "itemName": "Ground Beef",
      "type": "Used",
      "quantity": 3,
      "unit": "kg",
      "date": "2024-06-19 14:30:00",
      "user": "Chef John",
      "notes": "For today's special burgers"
    },
    {
      "id": "2",
      "itemName": "Tomatoes",
      "type": "Restocked",
      "quantity": 15,
      "unit": "kg",
      "date": "2024-06-19 10:15:00",
      "user": "Manager",
      "notes": "Fresh delivery from supplier"
    },
    {
      "id": "3",
      "itemName": "Pasta",
      "type": "Used",
      "quantity": 5,
      "unit": "boxes",
      "date": "2024-06-19 08:45:00",
      "user": "Chef Mary",
      "notes": "Lunch preparation"
    },
    {
      "id": "4",
      "itemName": "Orange Juice",
      "type": "Expired",
      "quantity": 2,
      "unit": "liters",
      "date": "2024-06-18 16:00:00",
      "user": "Stock Manager",
      "notes": "Removed expired items"
    },
  ];

  List<Map<String, dynamic>> get filteredStockItems {
    return stockItems.where((item) {
      bool matchesSearch = item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["supplier"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || item["status"] == selectedStatus;
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Stock": return successColor;
      case "Low Stock": return warningColor;
      case "Out of Stock": return dangerColor;
      case "Overstocked": return infoColor;
      default: return disabledBoldColor;
    }
  }

  Color _getTransactionTypeColor(String type) {
    switch (type) {
      case "Restocked": return successColor;
      case "Used": return primaryColor;
      case "Expired": return dangerColor;
      case "Adjusted": return warningColor;
      default: return disabledBoldColor;
    }
  }

  double _getStockPercentage(Map<String, dynamic> item) {
    int current = item["currentStock"] as int;
    int max = item["maxThreshold"] as int;
    return current / max;
  }

  Widget _buildOverviewTab() {
    int totalItems = stockItems.length;
    int lowStockItems = stockItems.where((item) => item["status"] == "Low Stock").length;
    int outOfStockItems = stockItems.where((item) => item["status"] == "Out of Stock").length;
    double totalStockValue = stockItems.map((item) => 
        (item["currentStock"] as int) * (item["costPerUnit"] as double)
    ).reduce((a, b) => a + b);
    
    Map<String, int> categoryStats = {};
    for (var item in stockItems) {
      String category = item["category"];
      categoryStats[category] = (categoryStats[category] ?? 0) + 1;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Stats Cards
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
                  children: [
                    Icon(Icons.inventory, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$totalItems",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Items",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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
                  children: [
                    Icon(Icons.warning, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$lowStockItems",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Low Stock",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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
                  children: [
                    Icon(Icons.error, color: dangerColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$outOfStockItems",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Out of Stock",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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
                  children: [
                    Icon(Icons.attach_money, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "\$${(totalStockValue / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Stock Value",
                      textAlign: TextAlign.center,
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

          // Critical Stock Items
          Text(
            "Critical Stock Levels",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spSm,
            children: stockItems.where((item) => 
                item["status"] == "Low Stock" || item["status"] == "Out of Stock"
            ).map((item) {
              double percentage = _getStockPercentage(item);
              
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(item["status"]),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${item["image"]}",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
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
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(item["status"]).withAlpha(51),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${item["status"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(item["status"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Current: ${item["currentStock"]} ${item["unit"]} • Min: ${item["minThreshold"]} ${item["unit"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(102),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: percentage.clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: percentage > 0.3 ? warningColor : dangerColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Recent Transactions
          Text(
            "Recent Stock Transactions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spSm,
            children: recentTransactions.map((transaction) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getTransactionTypeColor(transaction["type"]).withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        transaction["type"] == "Restocked" ? Icons.add_circle :
                        transaction["type"] == "Used" ? Icons.remove_circle :
                        transaction["type"] == "Expired" ? Icons.delete :
                        Icons.edit,
                        color: _getTransactionTypeColor(transaction["type"]),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${transaction["itemName"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${transaction["type"]}: ${transaction["quantity"]} ${transaction["unit"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "By ${transaction["user"]} • ${transaction["date"].toString().substring(0, 16)}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getTransactionTypeColor(transaction["type"]).withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${transaction["type"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _getTransactionTypeColor(transaction["type"]),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Column(
            spacing: spSm,
            children: [
              QTextField(
                label: "Search items...",
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
            ],
          ),

          // Add New Item Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Item",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                ss("Add new inventory item");
              },
            ),
          ),

          // Inventory Items List
          Column(
            spacing: spSm,
            children: filteredStockItems.map((item) {
              double percentage = _getStockPercentage(item);
              double itemValue = (item["currentStock"] as int) * (item["costPerUnit"] as double);
              
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: item["status"] == "Out of Stock" || item["status"] == "Low Stock"
                      ? Border(
                          left: BorderSide(
                            width: 4,
                            color: _getStatusColor(item["status"]),
                          ),
                        )
                      : null,
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${item["image"]}",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
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
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(item["status"]).withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${item["status"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(item["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(51),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${item["category"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Supplier: ${item["supplier"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Location: ${item["location"]}",
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
                    
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${item["currentStock"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${item["unit"]} in stock",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "\$${((item["costPerUnit"] as double)).currency}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "per ${item["unit"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "\$${(itemValue).currency}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Total Value",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Stock Level",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${item["currentStock"]}/${item["maxThreshold"]} ${item["unit"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(102),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: percentage.clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: percentage > 0.8 ? infoColor :
                                       percentage > 0.3 ? successColor :
                                       percentage > 0.1 ? warningColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last Restocked: ${item["lastRestocked"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledColor,
                              ),
                            ),
                            Text(
                              "Expires: ${item["expiryDate"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          "Min: ${item["minThreshold"]} ${item["unit"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Update Stock",
                            size: bs.sm,
                            onPressed: () {
                              ss("Updating ${item["name"]} stock");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              ss("Viewing ${item["name"]} details");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Stock Levels",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Inventory", icon: Icon(Icons.inventory)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildInventoryTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
