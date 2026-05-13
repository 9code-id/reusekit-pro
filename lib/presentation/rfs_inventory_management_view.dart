import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsInventoryManagementView extends StatefulWidget {
  const RfsInventoryManagementView({super.key});

  @override
  State<RfsInventoryManagementView> createState() => _RfsInventoryManagementViewState();
}

class _RfsInventoryManagementViewState extends State<RfsInventoryManagementView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStockStatus = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Vegetables", "value": "Vegetables"},
    {"label": "Meat", "value": "Meat"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Grains", "value": "Grains"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Condiments", "value": "Condiments"},
  ];

  List<Map<String, dynamic>> stockStatusOptions = [
    {"label": "All", "value": "All"},
    {"label": "In Stock", "value": "In Stock"},
    {"label": "Low Stock", "value": "Low Stock"},
    {"label": "Out of Stock", "value": "Out of Stock"},
    {"label": "Overstocked", "value": "Overstocked"},
  ];

  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": "INV001",
      "name": "Organic Spinach",
      "category": "Vegetables",
      "brand": "Green Farms",
      "currentStock": 45,
      "minStock": 20,
      "maxStock": 100,
      "unit": "lbs",
      "costPerUnit": 3.25,
      "totalValue": 146.25,
      "location": "Produce Section A",
      "supplier": "Organic Valley Co",
      "lastRestocked": "2025-06-18T00:00:00",
      "stockStatus": "In Stock",
      "reorderPoint": 25,
      "avgWeeklyUsage": 35,
      "daysRemaining": 9,
      "image": "https://picsum.photos/300/200?random=1&keyword=spinach"
    },
    {
      "id": "INV002",
      "name": "Prime Ribeye Steak",
      "category": "Meat",
      "brand": "Premium Cuts",
      "currentStock": 8,
      "minStock": 15,
      "maxStock": 50,
      "unit": "lbs",
      "costPerUnit": 24.99,
      "totalValue": 199.92,
      "location": "Meat Freezer A",
      "supplier": "Premium Meat Co",
      "lastRestocked": "2025-06-16T00:00:00",
      "stockStatus": "Low Stock",
      "reorderPoint": 15,
      "avgWeeklyUsage": 12,
      "daysRemaining": 5,
      "image": "https://picsum.photos/300/200?random=2&keyword=steak"
    },
    {
      "id": "INV003",
      "name": "Whole Milk",
      "category": "Dairy",
      "brand": "Farm Fresh",
      "currentStock": 0,
      "minStock": 24,
      "maxStock": 72,
      "unit": "gallons",
      "costPerUnit": 4.50,
      "totalValue": 0.00,
      "location": "Dairy Cooler",
      "supplier": "Local Dairy Farm",
      "lastRestocked": "2025-06-14T00:00:00",
      "stockStatus": "Out of Stock",
      "reorderPoint": 24,
      "avgWeeklyUsage": 36,
      "daysRemaining": 0,
      "image": "https://picsum.photos/300/200?random=3&keyword=milk"
    },
    {
      "id": "INV004",
      "name": "Basmati Rice",
      "category": "Grains",
      "brand": "Golden Grain",
      "currentStock": 150,
      "minStock": 50,
      "maxStock": 100,
      "unit": "lbs",
      "costPerUnit": 2.75,
      "totalValue": 412.50,
      "location": "Dry Storage",
      "supplier": "Grain Distributors",
      "lastRestocked": "2025-06-17T00:00:00",
      "stockStatus": "Overstocked",
      "reorderPoint": 50,
      "avgWeeklyUsage": 25,
      "daysRemaining": 42,
      "image": "https://picsum.photos/300/200?random=4&keyword=rice"
    },
    {
      "id": "INV005",
      "name": "Orange Juice",
      "category": "Beverages",
      "brand": "Sunny Citrus",
      "currentStock": 32,
      "minStock": 20,
      "maxStock": 60,
      "unit": "cartons",
      "costPerUnit": 3.99,
      "totalValue": 127.68,
      "location": "Beverage Cooler",
      "supplier": "Citrus Co",
      "lastRestocked": "2025-06-18T00:00:00",
      "stockStatus": "In Stock",
      "reorderPoint": 20,
      "avgWeeklyUsage": 28,
      "daysRemaining": 8,
      "image": "https://picsum.photos/300/200?random=5&keyword=orange"
    },
    {
      "id": "INV006",
      "name": "Olive Oil",
      "category": "Condiments",
      "brand": "Mediterranean Gold",
      "currentStock": 6,
      "minStock": 12,
      "maxStock": 36,
      "unit": "bottles",
      "costPerUnit": 8.99,
      "totalValue": 53.94,
      "location": "Pantry Shelf B",
      "supplier": "Gourmet Imports",
      "lastRestocked": "2025-06-15T00:00:00",
      "stockStatus": "Low Stock",
      "reorderPoint": 12,
      "avgWeeklyUsage": 8,
      "daysRemaining": 5,
      "image": "https://picsum.photos/300/200?random=6&keyword=olive"
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return inventoryItems.where((item) {
      bool matchesSearch = "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesStatus = selectedStockStatus == "All" || item["stockStatus"] == selectedStockStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color getStockStatusColor(String status) {
    switch (status) {
      case "In Stock": return successColor;
      case "Low Stock": return warningColor;
      case "Out of Stock": return dangerColor;
      case "Overstocked": return infoColor;
      default: return disabledColor;
    }
  }

  double getStockPercentage(Map<String, dynamic> item) {
    int current = item["currentStock"] as int;
    int max = item["maxStock"] as int;
    return current / max;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Inventory",
                    value: searchQuery,
                    hint: "Search by name or ID...",
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
                    items: stockStatusOptions,
                    value: selectedStockStatus,
                    onChanged: (value, label) {
                      selectedStockStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Statistics Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${inventoryItems.where((item) => item["stockStatus"] == "In Stock").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "In Stock",
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${inventoryItems.where((item) => item["stockStatus"] == "Low Stock").length}",
                          style: TextStyle(
                            fontSize: fsH5,
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: dangerColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.error, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${inventoryItems.where((item) => item["stockStatus"] == "Out of Stock").length}",
                          style: TextStyle(
                            fontSize: fsH5,
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
              ],
            ),

            // Total Inventory Value
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.monetization_on, color: primaryColor, size: 24),
                  SizedBox(width: spSm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Inventory Value",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${((inventoryItems.map((item) => item["totalValue"] as double).reduce((a, b) => a + b)).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Inventory Items List
            ...filteredItems.map((item) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: getStockStatusColor("${item["stockStatus"]}"),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          bottomLeft: Radius.circular(radiusMd),
                        ),
                        child: Image.network(
                          "${item["image"]}",
                          width: 100,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${item["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: getStockStatusColor("${item["stockStatus"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(
                                        color: getStockStatusColor("${item["stockStatus"]}").withAlpha(100),
                                      ),
                                    ),
                                    child: Text(
                                      "${item["stockStatus"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: getStockStatusColor("${item["stockStatus"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "ID: ${item["id"]} • ${item["brand"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "Stock: ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${item["currentStock"]} ${item["unit"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: getStockStatusColor("${item["stockStatus"]}"),
                                    ),
                                  ),
                                  Text(
                                    " / ${item["maxStock"]} ${item["unit"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              // Stock Level Bar
                              Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: disabledColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: getStockPercentage(item).clamp(0.0, 1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: getStockStatusColor("${item["stockStatus"]}"),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.monetization_on, size: 14, color: warningColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "\$${((item["totalValue"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${item["daysRemaining"]} days left",
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
                      ),
                    ],
                  ),
                  
                  // Stock Information Section
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      border: Border(
                        top: BorderSide(color: disabledOutlineBorderColor),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Min Stock",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["minStock"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Current",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["currentStock"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: getStockStatusColor("${item["stockStatus"]}"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Max Stock",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["maxStock"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Weekly Use",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["avgWeeklyUsage"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radiusMd),
                        bottomRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Column(
                      children: [
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
                              "Last Restocked: ${DateTime.parse("${item["lastRestocked"]}").dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.business, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${item["supplier"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "Reorder",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Details",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
