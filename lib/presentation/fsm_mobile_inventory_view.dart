import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmMobileInventoryView extends StatefulWidget {
  const FsmMobileInventoryView({super.key});

  @override
  State<FsmMobileInventoryView> createState() => _FsmMobileInventoryViewState();
}

class _FsmMobileInventoryViewState extends State<FsmMobileInventoryView> {
  String searchQuery = "";
  String selectedCategory = "";
  String selectedStatus = "";
  String selectedLocation = "";

  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": "INV-001",
      "name": "HVAC Air Filter - MERV 13",
      "sku": "AF-MERV13-20X25",
      "category": "HVAC",
      "description": "High-efficiency air filter for commercial HVAC systems",
      "currentStock": 25,
      "minStock": 10,
      "maxStock": 50,
      "unitPrice": 45.99,
      "totalValue": 1149.75,
      "supplier": "AirTech Solutions",
      "location": "Warehouse A - Aisle 3",
      "status": "In Stock",
      "lastUpdated": "2024-12-20 14:30:00",
      "image": "https://picsum.photos/80/80?random=1&keyword=filter",
      "barcode": "1234567890123",
      "weight": "2.5 lbs",
      "dimensions": "20x25x1 inches",
      "notes": "Premium quality filter for sensitive environments",
    },
    {
      "id": "INV-002",
      "name": "PVC Pipe Elbow - 3/4 inch",
      "sku": "PVC-ELB-075",
      "category": "Plumbing",
      "description": "90-degree elbow connector for water supply lines",
      "currentStock": 8,
      "minStock": 15,
      "maxStock": 100,
      "unitPrice": 3.25,
      "totalValue": 26.0,
      "supplier": "PlumbPro Supply",
      "location": "Mobile Van #12",
      "status": "Low Stock",
      "lastUpdated": "2024-12-20 10:15:00",
      "image": "https://picsum.photos/80/80?random=2&keyword=pipe",
      "barcode": "2345678901234",
      "weight": "0.3 lbs",
      "dimensions": "3.5x3.5x2 inches",
      "notes": "Standard fitting for residential plumbing",
    },
    {
      "id": "INV-003",
      "name": "LED Light Bulb - 60W Equivalent",
      "sku": "LED-60W-DL",
      "category": "Electrical",
      "description": "Energy-efficient LED bulb with daylight color temperature",
      "currentStock": 0,
      "minStock": 20,
      "maxStock": 200,
      "unitPrice": 8.99,
      "totalValue": 0.0,
      "supplier": "LightMax Distributors",
      "location": "Warehouse B - Shelf 5",
      "status": "Out of Stock",
      "lastUpdated": "2024-12-19 16:45:00",
      "image": "https://picsum.photos/80/80?random=3&keyword=bulb",
      "barcode": "3456789012345",
      "weight": "0.2 lbs",
      "dimensions": "2.4x2.4x4.3 inches",
      "notes": "Energy Star certified, 10-year warranty",
    },
    {
      "id": "INV-004",
      "name": "Hydraulic Fluid - 5 Gallon",
      "sku": "HYD-FL-5GAL",
      "category": "Equipment",
      "description": "High-performance hydraulic fluid for heavy machinery",
      "currentStock": 12,
      "minStock": 5,
      "maxStock": 30,
      "unitPrice": 89.50,
      "totalValue": 1074.0,
      "supplier": "Industrial Fluids Corp",
      "location": "Warehouse A - Section B",
      "status": "In Stock",
      "lastUpdated": "2024-12-20 09:00:00",
      "image": "https://picsum.photos/80/80?random=4&keyword=fluid",
      "barcode": "4567890123456",
      "weight": "40 lbs",
      "dimensions": "12x12x14 inches",
      "notes": "Store in temperature-controlled environment",
    },
    {
      "id": "INV-005",
      "name": "Safety Helmet - Hard Hat",
      "sku": "SAFE-HH-WH",
      "category": "Safety",
      "description": "OSHA-compliant hard hat for construction and maintenance work",
      "currentStock": 18,
      "minStock": 12,
      "maxStock": 48,
      "unitPrice": 24.75,
      "totalValue": 445.5,
      "supplier": "SafeWork Equipment",
      "location": "Main Office - Safety Room",
      "status": "In Stock",
      "lastUpdated": "2024-12-20 11:20:00",
      "image": "https://picsum.photos/80/80?random=5&keyword=helmet",
      "barcode": "5678901234567",
      "weight": "1.2 lbs",
      "dimensions": "11x9x6 inches",
      "notes": "Available in white, yellow, and orange",
    },
    {
      "id": "INV-006",
      "name": "Digital Multimeter",
      "sku": "TOOL-DMM-PRO",
      "category": "Tools",
      "description": "Professional-grade digital multimeter for electrical testing",
      "currentStock": 4,
      "minStock": 3,
      "maxStock": 15,
      "unitPrice": 156.99,
      "totalValue": 627.96,
      "supplier": "TechTools Pro",
      "location": "Mobile Van #08",
      "status": "In Stock",
      "lastUpdated": "2024-12-20 13:10:00",
      "image": "https://picsum.photos/80/80?random=6&keyword=multimeter",
      "barcode": "6789012345678",
      "weight": "2.1 lbs",
      "dimensions": "8x4x2 inches",
      "notes": "Includes test leads and carrying case",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return inventoryItems.where((item) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${item["sku"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${item["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory.isEmpty || item["category"] == selectedCategory;
      bool matchesStatus = selectedStatus.isEmpty || item["status"] == selectedStatus;
      bool matchesLocation = selectedLocation.isEmpty || 
          "${item["location"]}".toLowerCase().contains(selectedLocation.toLowerCase());
      return matchesSearch && matchesCategory && matchesStatus && matchesLocation;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "In Stock":
        return successColor;
      case "Low Stock":
        return warningColor;
      case "Out of Stock":
        return dangerColor;
      case "On Order":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "In Stock":
        return Icons.check_circle;
      case "Low Stock":
        return Icons.warning;
      case "Out of Stock":
        return Icons.error;
      case "On Order":
        return Icons.shopping_cart;
      default:
        return Icons.help;
    }
  }

  int get totalItems {
    return inventoryItems.fold(0, (sum, item) => sum + (item["currentStock"] as int));
  }

  double get totalValue {
    return inventoryItems.fold(0.0, (sum, item) => sum + (item["totalValue"] as num).toDouble());
  }

  int get lowStockItems {
    return inventoryItems.where((item) => 
        (item["currentStock"] as int) <= (item["minStock"] as int)).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Inventory"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              ss("Barcode scanner opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {
              // navigateTo('AddInventoryItemView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
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
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search inventory...",
                    value: searchQuery,
                    hint: "Search by name, SKU, or ID",
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
                          items: [
                            {"label": "All Categories", "value": ""},
                            {"label": "HVAC", "value": "HVAC"},
                            {"label": "Plumbing", "value": "Plumbing"},
                            {"label": "Electrical", "value": "Electrical"},
                            {"label": "Equipment", "value": "Equipment"},
                            {"label": "Safety", "value": "Safety"},
                            {"label": "Tools", "value": "Tools"},
                          ],
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
                          items: [
                            {"label": "All Status", "value": ""},
                            {"label": "In Stock", "value": "In Stock"},
                            {"label": "Low Stock", "value": "Low Stock"},
                            {"label": "Out of Stock", "value": "Out of Stock"},
                            {"label": "On Order", "value": "On Order"},
                          ],
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
            ),

            // Inventory Statistics
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.inventory, color: primaryColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "$totalItems",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Items",
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "$lowStockItems",
                          style: TextStyle(
                            fontSize: fsH4,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.attach_money, color: successColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "\$${(totalValue / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Value",
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

            // Quick Actions
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
                      Icon(Icons.flash_on, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Scan Barcode",
                          icon: Icons.qr_code_scanner,
                          size: bs.sm,
                          onPressed: () {
                            ss("Barcode scanner activated");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Quick Count",
                          icon: Icons.fact_check,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('QuickCountView')
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Stock Request",
                          icon: Icons.shopping_cart,
                          color: primaryColor,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('StockRequestView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Transfer Items",
                          icon: Icons.compare_arrows,
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('TransferItemsView')
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Inventory Items List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.inventory_2, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Inventory Items (${filteredItems.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...filteredItems.map((item) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${item["image"]}"),
                                fit: BoxFit.cover,
                              ),
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
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: getStatusColor("${item["status"]}"),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            getStatusIcon("${item["status"]}"),
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${item["status"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "SKU: ${item["sku"]} • ${item["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Stock: ${item["currentStock"]} / ${item["maxStock"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: (item["currentStock"] as int) <= (item["minStock"] as int) 
                                            ? dangerColor : successColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "\$${((item["unitPrice"] as num).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                                    SizedBox(width: 2),
                                    Expanded(
                                      child: Text(
                                        "${item["location"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    QButton(
                                      label: "View Details",
                                      size: bs.sm,
                                      onPressed: () {
                                        // navigateTo('InventoryItemDetailView')
                                      },
                                    ),
                                    SizedBox(width: spSm),
                                    QButton(
                                      label: "Adjust Stock",
                                      size: bs.sm,
                                      color: warningColor,
                                      onPressed: () {
                                        // navigateTo('AdjustStockView')
                                      },
                                    ),
                                    SizedBox(width: spSm),
                                    QButton(
                                      icon: Icons.qr_code,
                                      size: bs.sm,
                                      color: infoColor,
                                      onPressed: () {
                                        ss("Showing barcode for ${item["name"]}");
                                      },
                                    ),
                                  ],
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
      ),
    );
  }
}
