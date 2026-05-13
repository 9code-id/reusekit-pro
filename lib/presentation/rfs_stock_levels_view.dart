import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsStockLevelsView extends StatefulWidget {
  const RfsStockLevelsView({super.key});

  @override
  State<RfsStockLevelsView> createState() => _RfsStockLevelsViewState();
}

class _RfsStockLevelsViewState extends State<RfsStockLevelsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedAlertLevel = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Perishables", "value": "Perishables"},
    {"label": "Non-Perishables", "value": "Non-Perishables"},
    {"label": "Frozen", "value": "Frozen"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Condiments", "value": "Condiments"},
  ];

  List<Map<String, dynamic>> alertLevelOptions = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "Low", "value": "Low"},
    {"label": "Normal", "value": "Normal"},
    {"label": "Overstocked", "value": "Overstocked"},
  ];

  List<Map<String, dynamic>> stockItems = [
    {
      "id": "STK001",
      "name": "Fresh Lettuce",
      "category": "Perishables",
      "currentLevel": 5,
      "minLevel": 20,
      "maxLevel": 80,
      "optimalLevel": 50,
      "unit": "heads",
      "alertLevel": "Critical",
      "reorderQuantity": 75,
      "supplier": "Green Valley Farms",
      "leadTime": 2,
      "lastDelivery": "2025-06-16T00:00:00",
      "nextDelivery": "2025-06-20T00:00:00",
      "avgWeeklyConsumption": 40,
      "stockTurnover": 1.5,
      "costPerUnit": 2.25,
      "autoReorder": true,
      "location": "Produce Cooler A",
      "image": "https://picsum.photos/300/200?random=1&keyword=lettuce"
    },
    {
      "id": "STK002",
      "name": "Canned Tomatoes",
      "category": "Non-Perishables",
      "currentLevel": 120,
      "minLevel": 50,
      "maxLevel": 200,
      "optimalLevel": 125,
      "unit": "cans",
      "alertLevel": "Normal",
      "reorderQuantity": 100,
      "supplier": "Pantry Supplies Co",
      "leadTime": 5,
      "lastDelivery": "2025-06-15T00:00:00",
      "nextDelivery": "2025-06-25T00:00:00",
      "avgWeeklyConsumption": 30,
      "stockTurnover": 0.8,
      "costPerUnit": 1.75,
      "autoReorder": false,
      "location": "Dry Storage B",
      "image": "https://picsum.photos/300/200?random=2&keyword=canned"
    },
    {
      "id": "STK003",
      "name": "Frozen Chicken Breast",
      "category": "Frozen",
      "currentLevel": 8,
      "minLevel": 15,
      "maxLevel": 60,
      "optimalLevel": 35,
      "unit": "lbs",
      "alertLevel": "Low",
      "reorderQuantity": 50,
      "supplier": "Premium Poultry",
      "leadTime": 3,
      "lastDelivery": "2025-06-17T00:00:00",
      "nextDelivery": "2025-06-22T00:00:00",
      "avgWeeklyConsumption": 25,
      "stockTurnover": 2.1,
      "costPerUnit": 6.99,
      "autoReorder": true,
      "location": "Freezer Unit A",
      "image": "https://picsum.photos/300/200?random=3&keyword=chicken"
    },
    {
      "id": "STK004",
      "name": "Craft Beer",
      "category": "Beverages",
      "currentLevel": 96,
      "minLevel": 24,
      "maxLevel": 72,
      "optimalLevel": 48,
      "unit": "bottles",
      "alertLevel": "Overstocked",
      "reorderQuantity": 48,
      "supplier": "Local Brewery",
      "leadTime": 7,
      "lastDelivery": "2025-06-12T00:00:00",
      "nextDelivery": "2025-06-26T00:00:00",
      "avgWeeklyConsumption": 18,
      "stockTurnover": 0.6,
      "costPerUnit": 4.50,
      "autoReorder": false,
      "location": "Beverage Cooler",
      "image": "https://picsum.photos/300/200?random=4&keyword=beer"
    },
    {
      "id": "STK005",
      "name": "Sea Salt",
      "category": "Condiments",
      "currentLevel": 32,
      "minLevel": 10,
      "maxLevel": 50,
      "optimalLevel": 30,
      "unit": "containers",
      "alertLevel": "Normal",
      "reorderQuantity": 25,
      "supplier": "Gourmet Seasonings",
      "leadTime": 10,
      "lastDelivery": "2025-06-10T00:00:00",
      "nextDelivery": "2025-06-30T00:00:00",
      "avgWeeklyConsumption": 5,
      "stockTurnover": 0.4,
      "costPerUnit": 3.25,
      "autoReorder": true,
      "location": "Seasoning Rack",
      "image": "https://picsum.photos/300/200?random=5&keyword=salt"
    },
    {
      "id": "STK006",
      "name": "Fresh Salmon",
      "category": "Perishables",
      "currentLevel": 2,
      "minLevel": 10,
      "maxLevel": 30,
      "optimalLevel": 20,
      "unit": "lbs",
      "alertLevel": "Critical",
      "reorderQuantity": 25,
      "supplier": "Ocean Fresh Seafood",
      "leadTime": 1,
      "lastDelivery": "2025-06-18T00:00:00",
      "nextDelivery": "2025-06-20T00:00:00",
      "avgWeeklyConsumption": 15,
      "stockTurnover": 3.2,
      "costPerUnit": 18.99,
      "autoReorder": true,
      "location": "Seafood Cooler",
      "image": "https://picsum.photos/300/200?random=6&keyword=salmon"
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return stockItems.where((item) {
      bool matchesSearch = "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesAlert = selectedAlertLevel == "All" || item["alertLevel"] == selectedAlertLevel;
      
      return matchesSearch && matchesCategory && matchesAlert;
    }).toList();
  }

  Color getAlertLevelColor(String alertLevel) {
    switch (alertLevel) {
      case "Critical": return dangerColor;
      case "Low": return warningColor;
      case "Normal": return successColor;
      case "Overstocked": return infoColor;
      default: return disabledColor;
    }
  }

  double getStockPercentage(Map<String, dynamic> item) {
    int current = item["currentLevel"] as int;
    int max = item["maxLevel"] as int;
    return (current / max).clamp(0.0, 1.0);
  }

  double getOptimalPercentage(Map<String, dynamic> item) {
    int optimal = item["optimalLevel"] as int;
    int max = item["maxLevel"] as int;
    return (optimal / max).clamp(0.0, 1.0);
  }

  int getDaysUntilReorder(Map<String, dynamic> item) {
    int current = item["currentLevel"] as int;
    int min = item["minLevel"] as int;
    int weeklyConsumption = item["avgWeeklyConsumption"] as int;
    
    if (current <= min) return 0;
    
    double dailyConsumption = weeklyConsumption / 7.0;
    return ((current - min) / dailyConsumption).floor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Levels"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
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
                    label: "Search Stock Items",
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
                    label: "Alert Level",
                    items: alertLevelOptions,
                    value: selectedAlertLevel,
                    onChanged: (value, label) {
                      selectedAlertLevel = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Alert Statistics Row
            Row(
              children: [
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
                        Icon(Icons.crisis_alert, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${stockItems.where((item) => item["alertLevel"] == "Critical").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Critical",
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
                          "${stockItems.where((item) => item["alertLevel"] == "Low").length}",
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
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${stockItems.where((item) => item["alertLevel"] == "Normal").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Normal",
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

            // Auto-Reorder Status
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.autorenew, color: infoColor, size: 24),
                  SizedBox(width: spSm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Auto-Reorder Enabled Items",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${stockItems.where((item) => item["autoReorder"] == true).length} of ${stockItems.length} items",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Stock Items List
            ...filteredItems.map((item) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: getAlertLevelColor("${item["alertLevel"]}"),
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
                                      color: getAlertLevelColor("${item["alertLevel"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(
                                        color: getAlertLevelColor("${item["alertLevel"]}").withAlpha(100),
                                      ),
                                    ),
                                    child: Text(
                                      "${item["alertLevel"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: getAlertLevelColor("${item["alertLevel"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "ID: ${item["id"]} • ${item["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "Current: ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${item["currentLevel"]} ${item["unit"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: getAlertLevelColor("${item["alertLevel"]}"),
                                    ),
                                  ),
                                  Text(
                                    " / ${item["maxLevel"]} ${item["unit"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              // Stock Level Progress Bar
                              Stack(
                                children: [
                                  Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: disabledColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: getStockPercentage(item),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: getAlertLevelColor("${item["alertLevel"]}"),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Optimal level indicator
                                  Positioned(
                                    left: (MediaQuery.of(context).size.width - 140) * getOptimalPercentage(item),
                                    child: Container(
                                      width: 2,
                                      height: 8,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  if (item["autoReorder"] == true)
                                    Icon(Icons.autorenew, size: 14, color: infoColor),
                                  if (item["autoReorder"] == true)
                                    SizedBox(width: 4),
                                  if (item["autoReorder"] == true)
                                    Text(
                                      "Auto-reorder",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: infoColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  Spacer(),
                                  Text(
                                    "Reorder in ${getDaysUntilReorder(item)} days",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: warningColor,
                                      fontWeight: FontWeight.w500,
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
                  
                  // Stock Details Section
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
                                "Min Level",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["minLevel"]}",
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
                                "Optimal",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["optimalLevel"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Turnover",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${(item["stockTurnover"] as double).toStringAsFixed(1)}x",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Lead Time",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["leadTime"]} days",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
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
                              "Next Delivery: ${DateTime.parse("${item["nextDelivery"]}").dMMMy}",
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
                              label: "Reorder Now",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Settings",
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
