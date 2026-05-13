import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmInventoryManagementView extends StatefulWidget {
  const FsmInventoryManagementView({super.key});

  @override
  State<FsmInventoryManagementView> createState() => _FsmInventoryManagementViewState();
}

class _FsmInventoryManagementViewState extends State<FsmInventoryManagementView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedLocation = "Main Warehouse";
  bool showLowStock = false;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electrical", "value": "Electrical"},
    {"label": "Mechanical", "value": "Mechanical"},
    {"label": "Tools", "value": "Tools"},
    {"label": "Safety", "value": "Safety"},
    {"label": "Consumables", "value": "Consumables"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "Main Warehouse", "value": "Main Warehouse"},
    {"label": "Workshop A", "value": "Workshop A"},
    {"label": "Workshop B", "value": "Workshop B"},
    {"label": "Mobile Unit 1", "value": "Mobile Unit 1"},
    {"label": "Mobile Unit 2", "value": "Mobile Unit 2"},
  ];

  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": "PART001",
      "name": "Circuit Breaker 20A",
      "category": "Electrical",
      "location": "Main Warehouse",
      "currentStock": 25,
      "minStock": 10,
      "maxStock": 50,
      "unitPrice": 45.99,
      "supplier": "ElectroSupply Corp",
      "lastUpdated": "2025-06-18",
      "status": "In Stock",
    },
    {
      "id": "PART002", 
      "name": "Hydraulic Pump",
      "category": "Mechanical",
      "location": "Workshop A",
      "currentStock": 3,
      "minStock": 5,
      "maxStock": 15,
      "unitPrice": 289.50,
      "supplier": "MechParts Ltd",
      "lastUpdated": "2025-06-17",
      "status": "Low Stock",
    },
    {
      "id": "PART003",
      "name": "Safety Helmet",
      "category": "Safety",
      "location": "Main Warehouse",
      "currentStock": 42,
      "minStock": 20,
      "maxStock": 60,
      "unitPrice": 28.75,
      "supplier": "SafetyFirst Inc",
      "lastUpdated": "2025-06-18",
      "status": "In Stock",
    },
    {
      "id": "PART004",
      "name": "Drill Bit Set",
      "category": "Tools",
      "location": "Mobile Unit 1",
      "currentStock": 0,
      "minStock": 5,
      "maxStock": 20,
      "unitPrice": 67.99,
      "supplier": "ToolMaster Co",
      "lastUpdated": "2025-06-15",
      "status": "Out of Stock",
    },
    {
      "id": "PART005",
      "name": "Industrial Lubricant",
      "category": "Consumables",
      "location": "Workshop B",
      "currentStock": 18,
      "minStock": 12,
      "maxStock": 30,
      "unitPrice": 15.25,
      "supplier": "ChemSupply Inc",
      "lastUpdated": "2025-06-18",
      "status": "In Stock",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return inventoryItems.where((item) {
      bool matchesSearch = "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesLocation = selectedLocation == "All" || item["location"] == selectedLocation;
      bool matchesStockFilter = !showLowStock || (item["currentStock"] as int) <= (item["minStock"] as int);
      
      return matchesSearch && matchesCategory && matchesLocation && matchesStockFilter;
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
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add new item
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show more options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Search Field
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search items or part numbers",
                          value: searchQuery,
                          hint: "Enter item name or part number",
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
                          // Perform search
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  // Filter Row
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
                          label: "Location",
                          items: locations,
                          value: selectedLocation,
                          onChanged: (value, label) {
                            selectedLocation = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  // Low Stock Filter
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Show only low stock items",
                              "value": true,
                              "checked": showLowStock,
                            }
                          ],
                          value: [
                            if (showLowStock)
                              {
                                "label": "Show only low stock items",
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
            ),
            SizedBox(height: spMd),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
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
                          Icon(
                            Icons.inventory,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Items",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${inventoryItems.length}",
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Low Stock",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${inventoryItems.where((item) => (item["currentStock"] as int) <= (item["minStock"] as int)).length}",
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.error,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Out of Stock",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${inventoryItems.where((item) => (item["currentStock"] as int) == 0).length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
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
                          Icon(
                            Icons.attach_money,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Value",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${(inventoryItems.fold(0.0, (sum, item) => sum + ((item["currentStock"] as int).toDouble() * (item["unitPrice"] as double)))).currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Items List
            Text(
              "Inventory Items (${filteredItems.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredItems.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Part #: ${item["id"]}",
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
                            color: _getStatusColor("${item["status"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${item["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor("${item["status"]}"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Category",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["category"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
                                "Location",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["location"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Current Stock",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["currentStock"]} units",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusColor("${item["status"]}"),
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
                                "Unit Price",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(item["unitPrice"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Min: ${item["minStock"]} | Max: ${item["maxStock"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Edit item
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.add_shopping_cart,
                          size: bs.sm,
                          onPressed: () {
                            // Order more
                          },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new inventory item
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
