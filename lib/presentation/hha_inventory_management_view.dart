import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaInventoryManagementView extends StatefulWidget {
  const HhaInventoryManagementView({super.key});

  @override
  State<HhaInventoryManagementView> createState() => _HhaInventoryManagementViewState();
}

class _HhaInventoryManagementViewState extends State<HhaInventoryManagementView> {
  String selectedCategory = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  
  List<String> categories = ["All", "Cleaning Supplies", "Linens", "Toiletries", "Kitchen", "Maintenance", "Office"];
  List<String> statusOptions = ["All", "In Stock", "Low Stock", "Out of Stock", "On Order"];

  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": "INV-001",
      "name": "Toilet Paper",
      "description": "2-ply bathroom tissue, 24 rolls per case",
      "category": "Toiletries",
      "currentStock": 45,
      "minStock": 20,
      "maxStock": 100,
      "unit": "rolls",
      "unitCost": 1.25,
      "totalValue": 56.25,
      "supplier": "Hotel Supply Co.",
      "location": "Storage Room A",
      "lastRestocked": "2024-01-10T14:30:00",
      "expiryDate": null,
      "status": "In Stock",
      "barcode": "123456789012",
    },
    {
      "id": "INV-002",
      "name": "All-Purpose Cleaner",
      "description": "Multi-surface cleaning solution, 32oz bottles",
      "category": "Cleaning Supplies",
      "currentStock": 8,
      "minStock": 15,
      "maxStock": 50,
      "unit": "bottles",
      "unitCost": 4.50,
      "totalValue": 36.0,
      "supplier": "CleanPro Industries",
      "location": "Cleaning Closet",
      "lastRestocked": "2024-01-08T09:15:00",
      "expiryDate": "2025-06-15",
      "status": "Low Stock",
      "barcode": "987654321098",
    },
    {
      "id": "INV-003",
      "name": "Bed Sheets Set",
      "description": "Queen size, 300 thread count, white cotton",
      "category": "Linens",
      "currentStock": 0,
      "minStock": 10,
      "maxStock": 30,
      "unit": "sets",
      "unitCost": 35.00,
      "totalValue": 0.0,
      "supplier": "Luxury Linens Ltd.",
      "location": "Linen Storage",
      "lastRestocked": "2023-12-20T16:00:00",
      "expiryDate": null,
      "status": "Out of Stock",
      "barcode": "456789012345",
    },
    {
      "id": "INV-004",
      "name": "Coffee Beans",
      "description": "Premium blend, 5lb bags",
      "category": "Kitchen",
      "currentStock": 12,
      "minStock": 8,
      "maxStock": 25,
      "unit": "bags",
      "unitCost": 18.50,
      "totalValue": 222.0,
      "supplier": "Bean There Coffee",
      "location": "Kitchen Pantry",
      "lastRestocked": "2024-01-12T11:20:00",
      "expiryDate": "2024-07-15",
      "status": "In Stock",
      "barcode": "789012345678",
    },
    {
      "id": "INV-005",
      "name": "Hand Soap",
      "description": "Antibacterial liquid soap, pump bottles",
      "category": "Toiletries",
      "currentStock": 0,
      "minStock": 12,
      "maxStock": 36,
      "unit": "bottles",
      "unitCost": 3.75,
      "totalValue": 0.0,
      "supplier": "Hygiene Solutions",
      "location": "Storage Room B",
      "lastRestocked": "2024-01-05T13:45:00",
      "expiryDate": "2026-01-30",
      "status": "On Order",
      "barcode": "321098765432",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return inventoryItems.where((item) {
      if (selectedCategory != "All" && item["category"] != selectedCategory) return false;
      if (selectedStatus != "All" && item["status"] != selectedStatus) return false;
      if (searchQuery.isNotEmpty && 
          !item["name"].toLowerCase().contains(searchQuery.toLowerCase()) &&
          !item["id"].toLowerCase().contains(searchQuery.toLowerCase())) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () => _showBarcodeScanner(),
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInventorySummary(),
            SizedBox(height: spLg),
            _buildSearchAndFilter(),
            SizedBox(height: spMd),
            _buildInventoryList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemDialog(),
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildInventorySummary() {
    int totalItems = inventoryItems.length;
    int inStockItems = inventoryItems.where((item) => item["status"] == "In Stock").length;
    int lowStockItems = inventoryItems.where((item) => item["status"] == "Low Stock").length;
    int outOfStockItems = inventoryItems.where((item) => item["status"] == "Out of Stock").length;
    double totalValue = inventoryItems.fold(0.0, (sum, item) => sum + (item["totalValue"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.inventory, color: primaryColor, size: 28),
              SizedBox(width: spSm),
              Text(
                "Inventory Overview",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 200,
            children: [
              _buildSummaryCard("Total Items", totalItems, Icons.widgets, primaryColor),
              _buildSummaryCard("In Stock", inStockItems, Icons.check_circle, successColor),
              _buildSummaryCard("Low Stock", lowStockItems, Icons.warning, warningColor),
              _buildSummaryCard("Out of Stock", outOfStockItems, Icons.error, dangerColor),
            ],
          ),
          SizedBox(height: spMd),
          Divider(),
          Row(
            children: [
              Icon(Icons.attach_money, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Total Inventory Value: ",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${totalValue.currency}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, int count, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(77)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: spXs),
          Text(
            "$count",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search items...",
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
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: spSm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip("All", selectedCategory == "All", () {
                selectedCategory = "All";
                setState(() {});
              }),
              _buildFilterChip("Low Stock", selectedStatus == "Low Stock", () {
                selectedStatus = "Low Stock";
                setState(() {});
              }),
              _buildFilterChip("Out of Stock", selectedStatus == "Out of Stock", () {
                selectedStatus = "Out of Stock";
                setState(() {});
              }),
              _buildFilterChip("Cleaning", selectedCategory == "Cleaning Supplies", () {
                selectedCategory = "Cleaning Supplies";
                setState(() {});
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
            border: Border.all(
              color: isSelected ? primaryColor : disabledOutlineBorderColor,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInventoryList() {
    List<Map<String, dynamic>> displayItems = filteredItems;

    if (displayItems.isEmpty) {
      return Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 48, color: disabledColor),
              SizedBox(height: spSm),
              Text(
                "No items found",
                style: TextStyle(
                  fontSize: fsH6,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "Try adjusting your search or filters",
                style: TextStyle(
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Inventory Items (${displayItems.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...displayItems.map((item) => _buildInventoryCard(item)).toList(),
      ],
    );
  }

  Widget _buildInventoryCard(Map<String, dynamic> item) {
    Color statusColor = _getStatusColor(item["status"]);
    int currentStock = item["currentStock"];
    int minStock = item["minStock"];
    int maxStock = item["maxStock"];
    double stockPercentage = maxStock > 0 ? currentStock / maxStock : 0;
    bool isLowStock = currentStock <= minStock;
    DateTime lastRestocked = DateTime.parse(item["lastRestocked"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: isLowStock 
          ? Border.all(color: warningColor.withAlpha(102))
          : null,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(item["category"]).withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getCategoryColor(item["category"]),
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${item["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
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
                            "Stock Level",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: stockPercentage,
                                  backgroundColor: Colors.grey.shade200,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    isLowStock ? warningColor : successColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "$currentStock/${maxStock}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isLowStock ? warningColor : primaryColor,
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
                    SizedBox(width: spMd),
                    Icon(Icons.business, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${item["supplier"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Last restocked: ${lastRestocked.dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if (item["expiryDate"] != null) ...[
                      Icon(Icons.event, size: 16, color: dangerColor),
                      SizedBox(width: spXs),
                      Text(
                        "Expires: ${DateTime.parse(item["expiryDate"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Unit Cost",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${((item["unitCost"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Value",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${((item["totalValue"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    if (isLowStock) ...[
                      Icon(Icons.warning, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Low Stock!",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusSm)),
            ),
            child: Row(
              children: [
                QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _showItemDetails(item),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Update Stock",
                  size: bs.sm,
                  onPressed: () => _showUpdateStockDialog(item),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
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
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Cleaning Supplies":
        return Colors.blue;
      case "Linens":
        return Colors.purple;
      case "Toiletries":
        return Colors.green;
      case "Kitchen":
        return Colors.orange;
      case "Maintenance":
        return Colors.red;
      case "Office":
        return Colors.teal;
      default:
        return primaryColor;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Inventory"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Category",
              items: categories.map((cat) => {
                "label": cat,
                "value": cat,
              }).toList(),
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Status",
              items: statusOptions.map((status) => {
                "label": status,
                "value": status,
              }).toList(),
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showItemDetails(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${item["name"]}"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ID: ${item["id"]}"),
              Text("Category: ${item["category"]}"),
              Text("Description: ${item["description"]}"),
              Text("Current Stock: ${item["currentStock"]} ${item["unit"]}"),
              Text("Minimum Stock: ${item["minStock"]} ${item["unit"]}"),
              Text("Maximum Stock: ${item["maxStock"]} ${item["unit"]}"),
              Text("Unit Cost: \$${((item["unitCost"] as double)).currency}"),
              Text("Total Value: \$${((item["totalValue"] as double)).currency}"),
              Text("Supplier: ${item["supplier"]}"),
              Text("Location: ${item["location"]}"),
              Text("Barcode: ${item["barcode"]}"),
              if (item["expiryDate"] != null)
                Text("Expiry Date: ${DateTime.parse(item["expiryDate"]).dMMMy}"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showUpdateStockDialog(Map<String, dynamic> item) {
    String newStock = item["currentStock"].toString();
    String operation = "Set";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Stock: ${item["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Current Stock: ${item["currentStock"]} ${item["unit"]}"),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Operation",
              items: [
                {"label": "Set to", "value": "Set"},
                {"label": "Add", "value": "Add"},
                {"label": "Remove", "value": "Remove"},
              ],
              value: operation,
              onChanged: (value, label) => operation = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Quantity",
              value: newStock,
              onChanged: (value) => newStock = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update",
            size: bs.sm,
            onPressed: () {
              int quantity = int.tryParse(newStock) ?? 0;
              int currentStock = item["currentStock"];
              
              switch (operation) {
                case "Set":
                  item["currentStock"] = quantity;
                  break;
                case "Add":
                  item["currentStock"] = currentStock + quantity;
                  break;
                case "Remove":
                  item["currentStock"] = (currentStock - quantity).clamp(0, double.infinity).toInt();
                  break;
              }
              
              // Update total value
              item["totalValue"] = (item["currentStock"] * (item["unitCost"] as double));
              
              // Update status based on stock level
              if (item["currentStock"] == 0) {
                item["status"] = "Out of Stock";
              } else if (item["currentStock"] <= item["minStock"]) {
                item["status"] = "Low Stock";
              } else {
                item["status"] = "In Stock";
              }
              
              setState(() {});
              Navigator.pop(context);
              ss("Stock updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showAddItemDialog() {
    String name = "";
    String description = "";
    String category = "Cleaning Supplies";
    String unit = "";
    String unitCost = "";
    String minStock = "";
    String maxStock = "";
    String supplier = "";
    String location = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Item"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Item Name",
                value: name,
                onChanged: (value) => name = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Description",
                value: description,
                onChanged: (value) => description = value,
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Category",
                items: categories.skip(1).map((cat) => {
                  "label": cat,
                  "value": cat,
                }).toList(),
                value: category,
                onChanged: (value, label) => category = value,
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Unit",
                      value: unit,
                      onChanged: (value) => unit = value,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Unit Cost",
                      value: unitCost,
                      onChanged: (value) => unitCost = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Min Stock",
                      value: minStock,
                      onChanged: (value) => minStock = value,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Max Stock",
                      value: maxStock,
                      onChanged: (value) => maxStock = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Supplier",
                value: supplier,
                onChanged: (value) => supplier = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Location",
                value: location,
                onChanged: (value) => location = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Item",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Item added successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showBarcodeScanner() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Barcode Scanner"),
        content: Container(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code_scanner, size: 64, color: primaryColor),
                SizedBox(height: spMd),
                Text(
                  "Barcode scanner feature",
                  style: TextStyle(
                    fontSize: fsH6,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Would integrate with camera",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
