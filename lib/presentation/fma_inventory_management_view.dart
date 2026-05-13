import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaInventoryManagementView extends StatefulWidget {
  const FmaInventoryManagementView({super.key});

  @override
  State<FmaInventoryManagementView> createState() => _FmaInventoryManagementViewState();
}

class _FmaInventoryManagementViewState extends State<FmaInventoryManagementView> {
  int currentTab = 0;
  String selectedCategory = "All";
  String selectedLocation = "All";
  bool showLowStock = false;

  // Add item form
  String itemName = "";
  String category = "Vegetables";
  String location = "Main Storage";
  int currentStock = 0;
  int minStock = 0;
  int maxStock = 0;
  String unit = "kg";
  String supplier = "";
  String expiryDate = "";

  List<Map<String, dynamic>> categories = [
    {"label": "Vegetables", "value": "Vegetables"},
    {"label": "Fruits", "value": "Fruits"},
    {"label": "Meat", "value": "Meat"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Grains", "value": "Grains"},
    {"label": "Spices", "value": "Spices"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Cleaning", "value": "Cleaning"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "Main Storage", "value": "Main Storage"},
    {"label": "Cold Storage", "value": "Cold Storage"},
    {"label": "Freezer", "value": "Freezer"},
    {"label": "Dry Storage", "value": "Dry Storage"},
    {"label": "Kitchen", "value": "Kitchen"},
  ];

  List<Map<String, dynamic>> units = [
    {"label": "kg", "value": "kg"},
    {"label": "g", "value": "g"},
    {"label": "lbs", "value": "lbs"},
    {"label": "liters", "value": "liters"},
    {"label": "ml", "value": "ml"},
    {"label": "pieces", "value": "pieces"},
    {"label": "boxes", "value": "boxes"},
    {"label": "bags", "value": "bags"},
  ];

  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": "1",
      "name": "Tomatoes",
      "category": "Vegetables",
      "location": "Cold Storage",
      "currentStock": 15,
      "minStock": 20,
      "maxStock": 100,
      "unit": "kg",
      "supplier": "Fresh Farm Co.",
      "expiryDate": "2024-06-20",
      "costPerUnit": 3.50,
      "totalValue": 52.50,
      "lastUpdated": "2024-06-15",
    },
    {
      "id": "2",
      "name": "Chicken Breast",
      "category": "Meat",
      "location": "Freezer",
      "currentStock": 25,
      "minStock": 15,
      "maxStock": 80,
      "unit": "kg",
      "supplier": "Premium Meats",
      "expiryDate": "2024-07-01",
      "costPerUnit": 12.00,
      "totalValue": 300.00,
      "lastUpdated": "2024-06-14",
    },
    {
      "id": "3",
      "name": "Rice",
      "category": "Grains",
      "location": "Dry Storage",
      "currentStock": 45,
      "minStock": 30,
      "maxStock": 200,
      "unit": "kg",
      "supplier": "Grain Masters",
      "expiryDate": "2025-01-15",
      "costPerUnit": 2.80,
      "totalValue": 126.00,
      "lastUpdated": "2024-06-13",
    },
    {
      "id": "4",
      "name": "Milk",
      "category": "Dairy",
      "location": "Cold Storage",
      "currentStock": 8,
      "minStock": 12,
      "maxStock": 50,
      "unit": "liters",
      "supplier": "Dairy Fresh",
      "expiryDate": "2024-06-18",
      "costPerUnit": 1.50,
      "totalValue": 12.00,
      "lastUpdated": "2024-06-15",
    },
    {
      "id": "5",
      "name": "Apples",
      "category": "Fruits",
      "location": "Cold Storage",
      "currentStock": 22,
      "minStock": 15,
      "maxStock": 60,
      "unit": "kg",
      "supplier": "Orchard Valley",
      "expiryDate": "2024-06-25",
      "costPerUnit": 4.20,
      "totalValue": 92.40,
      "lastUpdated": "2024-06-14",
    },
    {
      "id": "6",
      "name": "Olive Oil",
      "category": "Cooking",
      "location": "Main Storage",
      "currentStock": 5,
      "minStock": 10,
      "maxStock": 30,
      "unit": "liters",
      "supplier": "Mediterranean Oils",
      "expiryDate": "2025-03-01",
      "costPerUnit": 15.00,
      "totalValue": 75.00,
      "lastUpdated": "2024-06-12",
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "id": "1",
      "type": "Stock Added",
      "item": "Tomatoes",
      "quantity": 20,
      "unit": "kg",
      "timestamp": "2024-06-15 10:30",
      "user": "John Manager",
    },
    {
      "id": "2",
      "type": "Stock Used",
      "item": "Chicken Breast",
      "quantity": 5,
      "unit": "kg",
      "timestamp": "2024-06-15 08:15",
      "user": "Chef Maria",
    },
    {
      "id": "3",
      "type": "Low Stock Alert",
      "item": "Milk",
      "quantity": 8,
      "unit": "liters",
      "timestamp": "2024-06-15 07:00",
      "user": "System",
    },
    {
      "id": "4",
      "type": "Stock Added",
      "item": "Rice",
      "quantity": 50,
      "unit": "kg",
      "timestamp": "2024-06-14 16:45",
      "user": "Store Keeper",
    },
  ];

  Color _getStockStatusColor(Map<String, dynamic> item) {
    int current = item["currentStock"] as int;
    int min = item["minStock"] as int;
    
    if (current <= min) return dangerColor;
    if (current <= min * 1.5) return warningColor;
    return successColor;
  }

  Widget _buildInventoryTab() {
    List<Map<String, dynamic>> filteredItems = inventoryItems.where((item) {
      bool categoryMatch = selectedCategory == "All" || item["category"] == selectedCategory;
      bool locationMatch = selectedLocation == "All" || item["location"] == selectedLocation;
      bool stockMatch = !showLowStock || (item["currentStock"] as int) <= (item["minStock"] as int);
      return categoryMatch && locationMatch && stockMatch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildSummaryCard("Total Items", "${inventoryItems.length}", primaryColor, Icons.inventory),
              _buildSummaryCard("Low Stock", "${inventoryItems.where((item) => (item["currentStock"] as int) <= (item["minStock"] as int)).length}", dangerColor, Icons.warning),
              _buildSummaryCard("Total Value", "\$${inventoryItems.fold(0.0, (sum, item) => sum + (item["totalValue"] as double)).toStringAsFixed(0)}", successColor, Icons.attach_money),
              _buildSummaryCard("Categories", "${categories.length}", infoColor, Icons.category),
            ],
          ),

          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: [{"label": "All", "value": "All"}, ...categories],
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
                  items: [{"label": "All", "value": "All"}, ...locations],
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

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
                  value: showLowStock ? [{"label": "Show only low stock items", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    showLowStock = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Inventory Items
          ...filteredItems.map((item) {
            Color statusColor = _getStockStatusColor(item);
            double stockPercentage = (item["currentStock"] as int) / (item["maxStock"] as int);
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
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
                spacing: spXs,
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
                            Text(
                              "${item["category"]} • ${item["location"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${item["currentStock"]} ${item["unit"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Stock Level Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Stock Level:",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Min: ${item["minStock"]} • Max: ${item["maxStock"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: stockPercentage > 1.0 ? 1.0 : stockPercentage,
                          child: Container(
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.business, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Supplier: ${item["supplier"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Expires: ${DateTime.parse(item["expiryDate"] as String).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Text(
                        "Value: \$${(item["totalValue"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Update Stock",
                        size: bs.sm,
                        onPressed: () {
                          ss("Stock update dialog opened");
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
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
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

  Widget _buildAlertsTab() {
    List<Map<String, dynamic>> lowStockItems = inventoryItems.where((item) => 
        (item["currentStock"] as int) <= (item["minStock"] as int)).toList();
    
    List<Map<String, dynamic>> expiringItems = inventoryItems.where((item) {
      DateTime expiry = DateTime.parse(item["expiryDate"] as String);
      DateTime now = DateTime.now();
      return expiry.difference(now).inDays <= 7;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          // Alert Summary
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildAlertCard("Low Stock", "${lowStockItems.length}", dangerColor, Icons.warning),
              _buildAlertCard("Expiring Soon", "${expiringItems.length}", warningColor, Icons.schedule),
              _buildAlertCard("Out of Stock", "0", Colors.red.shade900, Icons.error),
              _buildAlertCard("Overstocked", "2", infoColor, Icons.trending_up),
            ],
          ),

          // Low Stock Alerts
          if (lowStockItems.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.warning, color: dangerColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Low Stock Alerts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  
                  ...lowStockItems.map((item) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: dangerColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: dangerColor,
                                  ),
                                ),
                                Text(
                                  "Current: ${item["currentStock"]} ${item["unit"]} • Min: ${item["minStock"]} ${item["unit"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "Reorder",
                            size: bs.sm,
                            onPressed: () {
                              ss("Reorder initiated for ${item["name"]}");
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

          // Expiring Items
          if (expiringItems.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.schedule, color: warningColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Expiring Soon",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  
                  ...expiringItems.map((item) {
                    DateTime expiry = DateTime.parse(item["expiryDate"] as String);
                    int daysLeft = expiry.difference(DateTime.now()).inDays;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                                Text(
                                  "Expires in $daysLeft day${daysLeft != 1 ? 's' : ''} • ${expiry.dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "Use First",
                            size: bs.sm,
                            onPressed: () {
                              ss("${item["name"]} marked for priority use");
                            },
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

  Widget _buildAlertCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
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

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
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
              spacing: spSm,
              children: [
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...recentActivity.map((activity) {
                  Color activityColor = primaryColor;
                  IconData activityIcon = Icons.inventory;
                  
                  switch (activity["type"]) {
                    case "Stock Added":
                      activityColor = successColor;
                      activityIcon = Icons.add_circle;
                      break;
                    case "Stock Used":
                      activityColor = infoColor;
                      activityIcon = Icons.remove_circle;
                      break;
                    case "Low Stock Alert":
                      activityColor = dangerColor;
                      activityIcon = Icons.warning;
                      break;
                  }
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: activityColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: activityColor.withAlpha(20)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: activityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            activityIcon,
                            color: activityColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${activity["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: activityColor,
                                ),
                              ),
                              Text(
                                "${activity["item"]} • ${activity["quantity"]} ${activity["unit"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "By ${activity["user"]} • ${activity["timestamp"]}",
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
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddItemTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
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
              spacing: spSm,
              children: [
                Text(
                  "Add New Inventory Item",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QTextField(
                  label: "Item Name",
                  value: itemName,
                  hint: "e.g., Tomatoes, Chicken Breast",
                  onChanged: (value) {
                    itemName = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories,
                        value: category,
                        onChanged: (value, label) {
                          category = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Storage Location",
                        items: locations,
                        value: location,
                        onChanged: (value, label) {
                          location = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Current Stock",
                        value: currentStock.toString(),
                        onChanged: (value) {
                          currentStock = int.tryParse(value) ?? 0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Unit",
                        items: units,
                        value: unit,
                        onChanged: (value, label) {
                          unit = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Minimum Stock",
                        value: minStock.toString(),
                        onChanged: (value) {
                          minStock = int.tryParse(value) ?? 0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Maximum Stock",
                        value: maxStock.toString(),
                        onChanged: (value) {
                          maxStock = int.tryParse(value) ?? 0;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QTextField(
                  label: "Supplier",
                  value: supplier,
                  hint: "Supplier company name",
                  onChanged: (value) {
                    supplier = value;
                    setState(() {});
                  },
                ),

                QDatePicker(
                  label: "Expiry Date",
                  value: expiryDate.isNotEmpty ? DateTime.parse(expiryDate) : DateTime.now().add(Duration(days: 30)),
                  onChanged: (value) {
                    expiryDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Add to Inventory",
                    size: bs.md,
                    onPressed: () {
                      // Add item to inventory
                      ss("Inventory item added successfully");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Inventory Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Inventory", icon: Icon(Icons.inventory)),
        Tab(text: "Alerts", icon: Icon(Icons.warning)),
        Tab(text: "Activity", icon: Icon(Icons.history)),
        Tab(text: "Add Item", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        _buildInventoryTab(),
        _buildAlertsTab(),
        _buildActivityTab(),
        _buildAddItemTab(),
      ],
    );
  }
}
