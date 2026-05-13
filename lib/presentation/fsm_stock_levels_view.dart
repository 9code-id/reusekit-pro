import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmStockLevelsView extends StatefulWidget {
  const FsmStockLevelsView({super.key});

  @override
  State<FsmStockLevelsView> createState() => _FsmStockLevelsViewState();
}

class _FsmStockLevelsViewState extends State<FsmStockLevelsView> {
  String selectedLocation = "All Locations";
  String selectedCategory = "All";
  String alertLevel = "All Alerts";
  bool showChart = true;
  
  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "All Locations"},
    {"label": "Main Warehouse", "value": "Main Warehouse"},
    {"label": "Workshop A", "value": "Workshop A"},
    {"label": "Workshop B", "value": "Workshop B"},
    {"label": "Mobile Unit 1", "value": "Mobile Unit 1"},
    {"label": "Mobile Unit 2", "value": "Mobile Unit 2"},
    {"label": "Emergency Stock", "value": "Emergency Stock"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Critical Parts", "value": "Critical Parts"},
    {"label": "Electrical", "value": "Electrical"},
    {"label": "Mechanical", "value": "Mechanical"},
    {"label": "Safety", "value": "Safety"},
    {"label": "Tools", "value": "Tools"},
    {"label": "Consumables", "value": "Consumables"},
  ];

  List<Map<String, dynamic>> alertLevels = [
    {"label": "All Alerts", "value": "All Alerts"},
    {"label": "Critical", "value": "Critical"},
    {"label": "Low Stock", "value": "Low Stock"},
    {"label": "Overstock", "value": "Overstock"},
    {"label": "Normal", "value": "Normal"},
  ];

  List<Map<String, dynamic>> stockItems = [
    {
      "id": "PART001",
      "name": "Variable Frequency Drive",
      "category": "Electrical",
      "location": "Main Warehouse",
      "currentStock": 5,
      "minLevel": 8,
      "maxLevel": 25,
      "reorderPoint": 10,
      "unitCost": 1250.00,
      "avgUsage": 2,
      "leadTime": 14,
      "alertLevel": "Critical",
      "trend": "decreasing",
      "lastRestock": "2025-05-15",
      "supplier": "Siemens AG",
    },
    {
      "id": "PART002",
      "name": "Safety Helmets",
      "category": "Safety",
      "location": "Main Warehouse",
      "currentStock": 15,
      "minLevel": 10,
      "maxLevel": 50,
      "reorderPoint": 15,
      "unitCost": 28.75,
      "avgUsage": 5,
      "leadTime": 7,
      "alertLevel": "Low Stock",
      "trend": "stable",
      "lastRestock": "2025-06-10",
      "supplier": "SafetyFirst Inc",
    },
    {
      "id": "PART003",
      "name": "Ball Bearings SKF-6205",
      "category": "Mechanical",
      "location": "Workshop A",
      "currentStock": 35,
      "minLevel": 20,
      "maxLevel": 40,
      "reorderPoint": 25,
      "unitCost": 45.99,
      "avgUsage": 8,
      "leadTime": 5,
      "alertLevel": "Normal",
      "trend": "decreasing",
      "lastRestock": "2025-06-05",
      "supplier": "SKF Group",
    },
    {
      "id": "PART004",
      "name": "Hydraulic Oil Filter",
      "category": "Consumables",
      "location": "Workshop B",
      "currentStock": 85,
      "minLevel": 30,
      "maxLevel": 60,
      "reorderPoint": 40,
      "unitCost": 35.50,
      "avgUsage": 12,
      "leadTime": 3,
      "alertLevel": "Overstock",
      "trend": "increasing",
      "lastRestock": "2025-06-01",
      "supplier": "HydroFilters Ltd",
    },
    {
      "id": "PART005",
      "name": "Digital Multimeter",
      "category": "Tools",
      "location": "Mobile Unit 1",
      "currentStock": 2,
      "minLevel": 3,
      "maxLevel": 8,
      "reorderPoint": 4,
      "unitCost": 425.00,
      "avgUsage": 1,
      "leadTime": 10,
      "alertLevel": "Critical",
      "trend": "stable",
      "lastRestock": "2025-04-20",
      "supplier": "Fluke Corporation",
    },
    {
      "id": "PART006",
      "name": "Emergency Stop Switches",
      "category": "Critical Parts",
      "location": "Emergency Stock",
      "currentStock": 12,
      "minLevel": 15,
      "maxLevel": 30,
      "reorderPoint": 18,
      "unitCost": 89.99,
      "avgUsage": 3,
      "leadTime": 7,
      "alertLevel": "Low Stock",
      "trend": "stable",
      "lastRestock": "2025-05-28",
      "supplier": "EmergencyParts Co",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return stockItems.where((item) {
      bool matchesLocation = selectedLocation == "All Locations" || item["location"] == selectedLocation;
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesAlert = alertLevel == "All Alerts" || item["alertLevel"] == alertLevel;
      
      return matchesLocation && matchesCategory && matchesAlert;
    }).toList();
  }

  Color _getAlertColor(String alert) {
    switch (alert) {
      case "Critical":
        return dangerColor;
      case "Low Stock":
        return warningColor;
      case "Overstock":
        return infoColor;
      case "Normal":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "increasing":
        return successColor;
      case "decreasing":
        return dangerColor;
      case "stable":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "increasing":
        return Icons.trending_up;
      case "decreasing":
        return Icons.trending_down;
      case "stable":
        return Icons.trending_flat;
      default:
        return Icons.remove;
    }
  }

  double _getStockPercentage(Map<String, dynamic> item) {
    int current = item["currentStock"] as int;
    int max = item["maxLevel"] as int;
    return (current / max * 100).clamp(0, 100);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> criticalItems = filteredItems.where((item) => item["alertLevel"] == "Critical").toList();
    List<Map<String, dynamic>> lowStockItems = filteredItems.where((item) => item["alertLevel"] == "Low Stock").toList();
    List<Map<String, dynamic>> overstockItems = filteredItems.where((item) => item["alertLevel"] == "Overstock").toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Levels"),
        actions: [
          IconButton(
            icon: Icon(showChart ? Icons.list : Icons.bar_chart),
            onPressed: () {
              showChart = !showChart;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh stock data
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
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
                      SizedBox(width: spSm),
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
                    ],
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Alert Level",
                    items: alertLevels,
                    value: alertLevel,
                    onChanged: (value, label) {
                      alertLevel = value;
                      setState(() {});
                    },
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
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: dangerColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Critical Items",
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
                        "${criticalItems.length}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Items need immediate attention",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: warningColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.inventory_2,
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
                        "${lowStockItems.length}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Items below minimum level",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: infoColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Overstock",
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
                        "${overstockItems.length}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Items above maximum level",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: successColor,
                      ),
                    ),
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
                        "\$${(filteredItems.fold(0.0, (sum, item) => sum + ((item["currentStock"] as int).toDouble() * (item["unitCost"] as double)))).currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Current inventory value",
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
            SizedBox(height: spMd),

            // Stock Items List
            Text(
              "Stock Levels (${filteredItems.length} items)",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredItems.map((item) {
              double stockPercentage = _getStockPercentage(item);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getAlertColor("${item["alertLevel"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
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
                                "${item["id"]} • ${item["category"]}",
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
                            color: _getAlertColor("${item["alertLevel"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${item["alertLevel"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getAlertColor("${item["alertLevel"]}"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Stock Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Stock Level",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${item["currentStock"]} / ${item["maxLevel"]} units",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getAlertColor("${item["alertLevel"]}"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: stockPercentage / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: _getAlertColor("${item["alertLevel"]}"),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Details Grid
                    Row(
                      children: [
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Min / Max",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["minLevel"]} / ${item["maxLevel"]}",
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
                                "Reorder Point",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["reorderPoint"]} units",
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
                                "Trend",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    _getTrendIcon("${item["trend"]}"),
                                    size: 16,
                                    color: _getTrendColor("${item["trend"]}"),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${item["trend"]}".capitalize(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: _getTrendColor("${item["trend"]}"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Last restock: ${item["lastRestock"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        QButton(
                          icon: Icons.shopping_cart,
                          size: bs.sm,
                          onPressed: () {
                            // Reorder item
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Edit stock levels
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
          // Adjust stock levels
        },
        child: Icon(Icons.tune),
      ),
    );
  }
}
