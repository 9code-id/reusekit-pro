import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmTruckInventoryView extends StatefulWidget {
  const FsmTruckInventoryView({super.key});

  @override
  State<FsmTruckInventoryView> createState() => _FsmTruckInventoryViewState();
}

class _FsmTruckInventoryViewState extends State<FsmTruckInventoryView> {
  String selectedTruck = "All Trucks";
  String selectedCategory = "All";
  String searchQuery = "";
  bool showLowStock = false;

  List<Map<String, dynamic>> trucks = [
    {"label": "All Trucks", "value": "All Trucks"},
    {"label": "Service Truck #001", "value": "Service Truck #001"},
    {"label": "Service Truck #002", "value": "Service Truck #002"},
    {"label": "Service Truck #003", "value": "Service Truck #003"},
    {"label": "Emergency Unit #001", "value": "Emergency Unit #001"},
    {"label": "Maintenance Van #001", "value": "Maintenance Van #001"},
    {"label": "Maintenance Van #002", "value": "Maintenance Van #002"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Tools", "value": "Tools"},
    {"label": "Safety Equipment", "value": "Safety Equipment"},
    {"label": "Electrical Parts", "value": "Electrical Parts"},
    {"label": "Mechanical Parts", "value": "Mechanical Parts"},
    {"label": "Consumables", "value": "Consumables"},
    {"label": "Emergency Supplies", "value": "Emergency Supplies"},
  ];

  List<Map<String, dynamic>> truckInventory = [
    {
      "id": "TRK001-001",
      "itemName": "Digital Multimeter",
      "partNumber": "FLUKE-87V",
      "truck": "Service Truck #001",
      "category": "Tools",
      "currentQty": 2,
      "maxCapacity": 3,
      "unitValue": 425.00,
      "lastUpdated": "2025-06-18",
      "technician": "John Smith",
      "location": "Slot A1",
      "condition": "Good",
      "calibrationDue": "2025-08-15",
      "serialNumber": "FL87V-001234",
    },
    {
      "id": "TRK001-002",
      "itemName": "Safety Harness",
      "partNumber": "SAFE-HARNESS-001",
      "truck": "Service Truck #001",
      "category": "Safety Equipment",
      "currentQty": 1,
      "maxCapacity": 2,
      "unitValue": 89.99,
      "lastUpdated": "2025-06-17",
      "technician": "John Smith",
      "location": "Slot B3",
      "condition": "Excellent",
      "calibrationDue": "",
      "serialNumber": "SH-001789",
    },
    {
      "id": "TRK002-001",
      "itemName": "Circuit Breaker 20A",
      "partNumber": "CB-20A-STD",
      "truck": "Service Truck #002",
      "category": "Electrical Parts",
      "currentQty": 8,
      "maxCapacity": 12,
      "unitValue": 45.99,
      "lastUpdated": "2025-06-18",
      "technician": "Sarah Johnson",
      "location": "Drawer 1A",
      "condition": "New",
      "calibrationDue": "",
      "serialNumber": "",
    },
    {
      "id": "TRK002-002",
      "itemName": "Ball Bearing Set",
      "partNumber": "BB-SET-6205",
      "truck": "Service Truck #002", 
      "category": "Mechanical Parts",
      "currentQty": 5,
      "maxCapacity": 10,
      "unitValue": 15.50,
      "lastUpdated": "2025-06-16",
      "technician": "Sarah Johnson",
      "location": "Drawer 2B",
      "condition": "Good",
      "calibrationDue": "",
      "serialNumber": "",
    },
    {
      "id": "TRK003-001",
      "itemName": "Emergency First Aid Kit",
      "partNumber": "FAK-EMRG-001",
      "truck": "Emergency Unit #001",
      "category": "Emergency Supplies",
      "currentQty": 1,
      "maxCapacity": 1,
      "unitValue": 125.00,
      "lastUpdated": "2025-06-15",
      "technician": "Mike Wilson",
      "location": "Fixed Mount",
      "condition": "Good",
      "calibrationDue": "2025-12-31",
      "serialNumber": "FAK-001456",
    },
    {
      "id": "TRK003-002",
      "itemName": "Emergency Beacon",
      "partNumber": "BEACON-LED-001",
      "truck": "Emergency Unit #001",
      "category": "Emergency Supplies",
      "currentQty": 4,
      "maxCapacity": 6,
      "unitValue": 75.99,
      "lastUpdated": "2025-06-14",
      "technician": "Mike Wilson",
      "location": "Roof Rack",
      "condition": "Excellent",
      "calibrationDue": "",
      "serialNumber": "",
    },
    {
      "id": "VAN001-001",
      "itemName": "Wrench Set",
      "partNumber": "WRENCH-SET-001",
      "truck": "Maintenance Van #001",
      "category": "Tools",
      "currentQty": 0,
      "maxCapacity": 2,
      "unitValue": 89.99,
      "lastUpdated": "2025-06-12",
      "technician": "Lisa Chen",
      "location": "Tool Box A",
      "condition": "Missing",
      "calibrationDue": "",
      "serialNumber": "WS-001234",
    },
    {
      "id": "VAN002-001",
      "itemName": "Hydraulic Oil",
      "partNumber": "HYDR-OIL-5L",
      "truck": "Maintenance Van #002",
      "category": "Consumables",
      "currentQty": 3,
      "maxCapacity": 8,
      "unitValue": 25.50,
      "lastUpdated": "2025-06-18",
      "technician": "David Brown",
      "location": "Storage Bay 1",
      "condition": "Good",
      "calibrationDue": "",
      "serialNumber": "",
    },
  ];

  List<Map<String, dynamic>> get filteredInventory {
    return truckInventory.where((item) {
      bool matchesTruck = selectedTruck == "All Trucks" || item["truck"] == selectedTruck;
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty ||
                          "${item["itemName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["partNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["truck"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesLowStock = !showLowStock || (item["currentQty"] as int) < (item["maxCapacity"] as int) * 0.5;
      
      return matchesTruck && matchesCategory && matchesSearch && matchesLowStock;
    }).toList();
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case "Excellent":
        return successColor;
      case "Good":
        return infoColor;
      case "Fair":
        return warningColor;
      case "Poor":
        return dangerColor;
      case "Missing":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStockLevelColor(int current, int max) {
    double percentage = current / max;
    if (percentage == 0) return dangerColor;
    if (percentage < 0.3) return dangerColor;
    if (percentage < 0.5) return warningColor;
    if (percentage < 0.8) return infoColor;
    return successColor;
  }

  double _getStockPercentage(int current, int max) {
    if (max == 0) return 0;
    return (current / max * 100).clamp(0, 100);
  }

  @override
  Widget build(BuildContext context) {
    // Group by truck for summary
    Map<String, List<Map<String, dynamic>>> truckGroups = {};
    for (var item in truckInventory) {
      String truck = item["truck"] as String;
      if (!truckGroups.containsKey(truck)) {
        truckGroups[truck] = [];
      }
      truckGroups[truck]!.add(item);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Truck Inventory"),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              // Sync inventory
            },
          ),
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // Scan QR code
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
                        child: QTextField(
                          label: "Search items or trucks",
                          value: searchQuery,
                          hint: "Enter item name, part number, or truck",
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
                  
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Truck/Vehicle",
                          items: trucks,
                          value: selectedTruck,
                          onChanged: (value, label) {
                            selectedTruck = value;
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

            // Truck Summary Cards
            Text(
              "Fleet Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: truckGroups.entries.map((entry) {
                String truckName = entry.key;
                List<Map<String, dynamic>> items = entry.value;
                int totalItems = items.length;
                int lowStockItems = items.where((item) => (item["currentQty"] as int) < (item["maxCapacity"] as int) * 0.5).length;
                int missingItems = items.where((item) => (item["currentQty"] as int) == 0).length;
                double totalValue = items.fold(0.0, (sum, item) => sum + ((item["currentQty"] as int).toDouble() * (item["unitValue"] as double)));
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: missingItems > 0 ? dangerColor : (lowStockItems > 0 ? warningColor : successColor),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        truckName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Items",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "$totalItems",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
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
                                  "Low Stock",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "$lowStockItems",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: lowStockItems > 0 ? warningColor : successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      
                      Text(
                        "Value: \$${totalValue.currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      if (missingItems > 0) ...[
                        SizedBox(height: spXs),
                        Text(
                          "$missingItems missing items",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spMd),

            // Inventory Items
            Text(
              "Inventory Items (${filteredInventory.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredInventory.map((item) {
              double stockPercentage = _getStockPercentage(item["currentQty"] as int, item["maxCapacity"] as int);
              
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
                      color: _getStockLevelColor(item["currentQty"] as int, item["maxCapacity"] as int),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["itemName"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${item["partNumber"]} • ${item["category"]}",
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
                            color: _getConditionColor("${item["condition"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${item["condition"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getConditionColor("${item["condition"]}"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Truck and Location
                    Row(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${item["truck"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "Location: ${item["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Stock Level Progress
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
                              "${item["currentQty"]} / ${item["maxCapacity"]} units",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStockLevelColor(item["currentQty"] as int, item["maxCapacity"] as int),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: stockPercentage / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: _getStockLevelColor(item["currentQty"] as int, item["maxCapacity"] as int),
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
                                "Technician",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${item["technician"]}",
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
                                "Unit Value",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(item["unitValue"] as double).currency}",
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
                    
                    if ("${item["serialNumber"]}".isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Text(
                        "Serial: ${item["serialNumber"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                    
                    if ("${item["calibrationDue"]}".isNotEmpty) ...[
                      SizedBox(height: spXs),
                      Text(
                        "Calibration due: ${item["calibrationDue"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    SizedBox(height: spSm),

                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Updated: ${item["lastUpdated"]}",
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
                          icon: Icons.swap_horiz,
                          size: bs.sm,
                          onPressed: () {
                            // Transfer between trucks
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.add_shopping_cart,
                          size: bs.sm,
                          onPressed: () {
                            // Restock
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
          // Add new truck inventory item
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
