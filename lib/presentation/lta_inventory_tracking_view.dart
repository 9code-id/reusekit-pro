import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaInventoryTrackingView extends StatefulWidget {
  const LtaInventoryTrackingView({super.key});

  @override
  State<LtaInventoryTrackingView> createState() => _LtaInventoryTrackingViewState();
}

class _LtaInventoryTrackingViewState extends State<LtaInventoryTrackingView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> inventoryCategories = [
    {"label": "All", "value": "All"},
    {"label": "Vehicles", "value": "Vehicles"},
    {"label": "Spare Parts", "value": "Spare Parts"},
    {"label": "Fuel", "value": "Fuel"},
    {"label": "Tools", "value": "Tools"},
    {"label": "Equipment", "value": "Equipment"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "In Stock", "value": "In Stock"},
    {"label": "Low Stock", "value": "Low Stock"},
    {"label": "Out of Stock", "value": "Out of Stock"},
    {"label": "Maintenance", "value": "Maintenance"}
  ];

  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": "INV001",
      "name": "Engine Oil 20W-50",
      "category": "Spare Parts",
      "currentStock": 45,
      "minStock": 20,
      "maxStock": 100,
      "unit": "Liters",
      "location": "Warehouse A - Shelf 12",
      "status": "In Stock",
      "lastUpdated": "2024-12-15 14:30",
      "cost": 2500.0,
      "supplier": "Shell Lubricants"
    },
    {
      "id": "INV002", 
      "name": "Brake Pads Set",
      "category": "Spare Parts",
      "currentStock": 8,
      "minStock": 10,
      "maxStock": 50,
      "unit": "Sets",
      "location": "Warehouse B - Rack 5",
      "status": "Low Stock",
      "lastUpdated": "2024-12-15 11:45",
      "cost": 4500.0,
      "supplier": "Bosch Auto Parts"
    },
    {
      "id": "INV003",
      "name": "Diesel Fuel",
      "category": "Fuel",
      "currentStock": 0,
      "minStock": 500,
      "maxStock": 2000,
      "unit": "Liters",
      "location": "Fuel Tank 1",
      "status": "Out of Stock",
      "lastUpdated": "2024-12-15 09:15",
      "cost": 95.5,
      "supplier": "Pertamina Fuel"
    },
    {
      "id": "INV004",
      "name": "Hydraulic Jack",
      "category": "Tools",
      "currentStock": 12,
      "minStock": 5,
      "maxStock": 25,
      "unit": "Units",
      "location": "Tool Room - Cabinet 3",
      "status": "In Stock",
      "lastUpdated": "2024-12-15 16:20",
      "cost": 850000.0,
      "supplier": "Tekiro Tools"
    },
    {
      "id": "INV005",
      "name": "GPS Tracker Device",
      "category": "Equipment",
      "currentStock": 3,
      "minStock": 8,
      "maxStock": 30,
      "unit": "Units",
      "location": "Electronics Storage",
      "status": "Low Stock",
      "lastUpdated": "2024-12-15 13:10",
      "cost": 750000.0,
      "supplier": "Garmin Indonesia"
    },
    {
      "id": "INV006",
      "name": "Truck Tire 295/80R22.5",
      "category": "Spare Parts",
      "currentStock": 24,
      "minStock": 12,
      "maxStock": 60,
      "unit": "Pieces",
      "location": "Tire Storage Area",
      "status": "In Stock",
      "lastUpdated": "2024-12-15 10:30",
      "cost": 2800000.0,
      "supplier": "Bridgestone"
    }
  ];

  List<Map<String, dynamic>> get filteredItems {
    return inventoryItems.where((item) {
      bool matchesSearch = searchQuery.isEmpty || 
          (item["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || item["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
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
      case "Maintenance":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add inventory
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search inventory...",
                    value: searchQuery,
                    hint: "Search by name or ID",
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
                    items: inventoryCategories,
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

            // Stock Summary Cards
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
                        Icon(Icons.inventory, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${inventoryItems.where((item) => item["status"] == "In Stock").length}",
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${inventoryItems.where((item) => item["status"] == "Low Stock").length}",
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.error, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${inventoryItems.where((item) => item["status"] == "Out of Stock").length}",
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
                      children: [
                        Text(
                          "Inventory Items",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredItems.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _getStatusColor(item["status"] as String).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.inventory_2,
                                color: _getStatusColor(item["status"] as String),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${item["name"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(item["status"] as String).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${item["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: _getStatusColor(item["status"] as String),
                                            fontWeight: FontWeight.w600,
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
                                        "Stock: ${item["currentStock"]}/${item["maxStock"]} ${item["unit"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Rp ${((item["cost"] as double) * (item["currentStock"] as int)).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 12, color: disabledBoldColor),
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
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Column(
                              children: [
                                QButton(
                                  icon: Icons.edit,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to edit inventory
                                  },
                                ),
                                SizedBox(height: spXs),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {},
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
