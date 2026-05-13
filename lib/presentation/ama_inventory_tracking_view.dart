import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaInventoryTrackingView extends StatefulWidget {
  const AmaInventoryTrackingView({super.key});

  @override
  State<AmaInventoryTrackingView> createState() => _AmaInventoryTrackingViewState();
}

class _AmaInventoryTrackingViewState extends State<AmaInventoryTrackingView> {
  String selectedCategory = "All";
  String selectedLocation = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": "INV001",
      "name": "Wheat Seeds",
      "category": "Seeds",
      "quantity": 50,
      "unit": "kg",
      "minQuantity": 20,
      "location": "Warehouse A",
      "batchNumber": "WS-2024-001",
      "expiryDate": "2024-12-15",
      "costPerUnit": 25.50,
      "totalValue": 1275.00,
      "status": "In Stock",
      "supplier": "AgriSeeds Co.",
      "lastUpdated": "2024-03-15",
    },
    {
      "id": "INV002",
      "name": "NPK Fertilizer",
      "category": "Fertilizers",
      "quantity": 15,
      "unit": "bags",
      "minQuantity": 20,
      "location": "Storage B",
      "batchNumber": "NPK-2024-002",
      "expiryDate": "2025-06-20",
      "costPerUnit": 45.00,
      "totalValue": 675.00,
      "status": "Low Stock",
      "supplier": "FertilizerMax",
      "lastUpdated": "2024-03-14",
    },
    {
      "id": "INV003",
      "name": "Pesticide Spray",
      "category": "Pesticides",
      "quantity": 8,
      "unit": "liters",
      "minQuantity": 5,
      "location": "Chemical Store",
      "batchNumber": "PS-2024-003",
      "expiryDate": "2024-08-30",
      "costPerUnit": 35.75,
      "totalValue": 286.00,
      "status": "In Stock",
      "supplier": "ChemCorp Ltd",
      "lastUpdated": "2024-03-16",
    },
    {
      "id": "INV004",
      "name": "Irrigation Pipes",
      "category": "Equipment",
      "quantity": 0,
      "unit": "meters",
      "minQuantity": 100,
      "location": "Equipment Yard",
      "batchNumber": "IP-2024-004",
      "expiryDate": "N/A",
      "costPerUnit": 12.00,
      "totalValue": 0.00,
      "status": "Out of Stock",
      "supplier": "AquaTech Systems",
      "lastUpdated": "2024-03-12",
    },
    {
      "id": "INV005",
      "name": "Organic Compost",
      "category": "Fertilizers",
      "quantity": 25,
      "unit": "tons",
      "minQuantity": 10,
      "location": "Compost Area",
      "batchNumber": "OC-2024-005",
      "expiryDate": "2024-09-10",
      "costPerUnit": 150.00,
      "totalValue": 3750.00,
      "status": "In Stock",
      "supplier": "GreenEarth Organic",
      "lastUpdated": "2024-03-13",
    },
    {
      "id": "INV006",
      "name": "Corn Seeds",
      "category": "Seeds",
      "quantity": 35,
      "unit": "kg",
      "minQuantity": 25,
      "location": "Warehouse A",
      "batchNumber": "CS-2024-006",
      "expiryDate": "2024-11-25",
      "costPerUnit": 18.50,
      "totalValue": 647.50,
      "status": "In Stock",
      "supplier": "CornTech Seeds",
      "lastUpdated": "2024-03-15",
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Seeds", "value": "Seeds"},
    {"label": "Fertilizers", "value": "Fertilizers"},
    {"label": "Pesticides", "value": "Pesticides"},
    {"label": "Equipment", "value": "Equipment"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All", "value": "All"},
    {"label": "Warehouse A", "value": "Warehouse A"},
    {"label": "Storage B", "value": "Storage B"},
    {"label": "Chemical Store", "value": "Chemical Store"},
    {"label": "Equipment Yard", "value": "Equipment Yard"},
    {"label": "Compost Area", "value": "Compost Area"},
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'in stock':
        return successColor;
      case 'low stock':
        return warningColor;
      case 'out of stock':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> get filteredItems {
    return inventoryItems.where((item) {
      bool matchesCategory = selectedCategory == "All" || "${item["category"]}" == selectedCategory;
      bool matchesLocation = selectedLocation == "All" || "${item["location"]}" == selectedLocation;
      bool matchesSearch = searchQuery.isEmpty || 
                          "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesLocation && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate summary stats
    double totalValue = filteredItems.fold(0.0, (sum, item) => sum + (item["totalValue"] as double));
    int lowStockCount = filteredItems.where((item) => "${item["status"]}" == "Low Stock").length;
    int outOfStockCount = filteredItems.where((item) => "${item["status"]}" == "Out of Stock").length;
    int inStockCount = filteredItems.where((item) => "${item["status"]}" == "In Stock").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new inventory item
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              // Export inventory report
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Cards
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.inventory,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Items",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${filteredItems.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
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
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Value",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${totalValue.currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Stock Status Summary
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "In Stock",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "$inStockCount",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
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
                                  "$lowStockCount",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Out of Stock",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "$outOfStockCount",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Filters
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

            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search items or ID",
                    value: searchQuery,
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

            // Inventory Items List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Inventory Items",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${filteredItems.length} items",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredItems.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        "ID: ${item["id"]} • ${item["category"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
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
                                        "Quantity",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${item["quantity"]} ${item["unit"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                                        "Value",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(item["totalValue"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
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
                                        "Batch: ${item["batchNumber"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "Min Qty: ${item["minQuantity"]} ${item["unit"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
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
                                        "Supplier: ${item["supplier"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "Updated: ${item["lastUpdated"]}",
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
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Update Stock",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Update stock quantity
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      // View item details
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
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
