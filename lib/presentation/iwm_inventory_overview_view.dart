import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmInventoryOverviewView extends StatefulWidget {
  const IwmInventoryOverviewView({super.key});

  @override
  State<IwmInventoryOverviewView> createState() => _IwmInventoryOverviewViewState();
}

class _IwmInventoryOverviewViewState extends State<IwmInventoryOverviewView> {
  String selectedCategory = "All";
  String selectedLocation = "All";
  String searchQuery = "";
  String sortBy = "name";

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Office Supplies", "value": "Office Supplies"},
    {"label": "Furniture", "value": "Furniture"},
    {"label": "Equipment", "value": "Equipment"},
    {"label": "Consumables", "value": "Consumables"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "All"},
    {"label": "Warehouse A", "value": "Warehouse A"},
    {"label": "Warehouse B", "value": "Warehouse B"},
    {"label": "Office - Floor 1", "value": "Office - Floor 1"},
    {"label": "Office - Floor 2", "value": "Office - Floor 2"},
    {"label": "Storage Room", "value": "Storage Room"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name (A-Z)", "value": "name"},
    {"label": "Stock Level", "value": "stock"},
    {"label": "Value", "value": "value"},
    {"label": "Last Updated", "value": "updated"},
  ];

  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": "INV001",
      "name": "Wireless Mouse",
      "sku": "MSE-WL-001",
      "category": "Electronics",
      "location": "Warehouse A",
      "currentStock": 125,
      "minStock": 50,
      "maxStock": 200,
      "unitPrice": 25.99,
      "totalValue": 3248.75,
      "lastUpdated": "2024-12-15",
      "status": "In Stock",
      "image": "https://picsum.photos/80/80?random=1&keyword=mouse",
    },
    {
      "id": "INV002",
      "name": "Office Chair",
      "sku": "CHR-OFF-002",
      "category": "Furniture",
      "location": "Warehouse B",
      "currentStock": 45,
      "minStock": 20,
      "maxStock": 80,
      "unitPrice": 199.99,
      "totalValue": 8999.55,
      "lastUpdated": "2024-12-14",
      "status": "In Stock",
      "image": "https://picsum.photos/80/80?random=2&keyword=chair",
    },
    {
      "id": "INV003",
      "name": "Printer Paper A4",
      "sku": "PPR-A4-003",
      "category": "Office Supplies",
      "location": "Office - Floor 1",
      "currentStock": 15,
      "minStock": 50,
      "maxStock": 200,
      "unitPrice": 8.50,
      "totalValue": 127.50,
      "lastUpdated": "2024-12-13",
      "status": "Low Stock",
      "image": "https://picsum.photos/80/80?random=3&keyword=paper",
    },
    {
      "id": "INV004",
      "name": "Standing Desk",
      "sku": "DSK-STD-004",
      "category": "Furniture",
      "location": "Warehouse A",
      "currentStock": 12,
      "minStock": 10,
      "maxStock": 30,
      "unitPrice": 399.99,
      "totalValue": 4799.88,
      "lastUpdated": "2024-12-12",
      "status": "In Stock",
      "image": "https://picsum.photos/80/80?random=4&keyword=desk",
    },
    {
      "id": "INV005",
      "name": "Laptop Bag",
      "sku": "BAG-LAP-005",
      "category": "Electronics",
      "location": "Storage Room",
      "currentStock": 28,
      "minStock": 25,
      "maxStock": 75,
      "unitPrice": 45.00,
      "totalValue": 1260.00,
      "lastUpdated": "2024-12-11",
      "status": "In Stock",
      "image": "https://picsum.photos/80/80?random=5&keyword=bag",
    },
    {
      "id": "INV006",
      "name": "USB Cable",
      "sku": "CBL-USB-006",
      "category": "Electronics",
      "location": "Office - Floor 2",
      "currentStock": 8,
      "minStock": 30,
      "maxStock": 100,
      "unitPrice": 12.99,
      "totalValue": 103.92,
      "lastUpdated": "2024-12-10",
      "status": "Low Stock",
      "image": "https://picsum.photos/80/80?random=6&keyword=cable",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> filtered = List.from(inventoryItems);

    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }

    // Filter by location
    if (selectedLocation != "All") {
      filtered = filtered.where((item) => item["location"] == selectedLocation).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) =>
        item["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        item["sku"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    // Sort items
    switch (sortBy) {
      case "name":
        filtered.sort((a, b) => a["name"].compareTo(b["name"]));
        break;
      case "stock":
        filtered.sort((a, b) => (b["currentStock"] as int).compareTo(a["currentStock"] as int));
        break;
      case "value":
        filtered.sort((a, b) => (b["totalValue"] as double).compareTo(a["totalValue"] as double));
        break;
      case "updated":
        filtered.sort((a, b) => b["lastUpdated"].compareTo(a["lastUpdated"]));
        break;
    }

    return filtered;
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

  double _getStockPercentage(Map<String, dynamic> item) {
    int current = item["currentStock"];
    int max = item["maxStock"];
    return (current / max) * 100;
  }

  void _exportInventory() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Inventory exported successfully");
  }

  void _addNewItem() {
    // Navigate to add item page
    //navigateTo('add_item')
  }

  void _editItem(Map<String, dynamic> item) {
    // Navigate to edit item page
    //navigateTo('edit_item', arguments: item)
  }

  void _viewItemDetails(Map<String, dynamic> item) {
    // Navigate to item details page
    //navigateTo('item_details', arguments: item)
  }

  Widget _buildInventoryStats() {
    int totalItems = inventoryItems.length;
    int lowStockItems = inventoryItems.where((item) => item["status"] == "Low Stock").length;
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
          Text(
            "Inventory Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$totalItems",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Items",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
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
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$lowStockItems",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Low Stock",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
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
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${(totalValue / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Value",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
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
          Text(
            "Filters & Search",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search items...",
                  value: searchQuery,
                  hint: "Search by name or SKU",
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
          
          // Filter Dropdowns
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
                  label: "Location",
                  items: locationOptions,
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
          
          // Sort and Actions
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Sort by",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add Item",
                icon: Icons.add,
                size: bs.sm,
                onPressed: _addNewItem,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryItem(Map<String, dynamic> item) {
    double stockPercentage = _getStockPercentage(item);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Header
          Row(
            children: [
              // Item Image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowXs],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${item["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              SizedBox(width: spMd),
              
              // Item Info
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
                      "SKU: ${item["sku"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(item["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(item["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Actions Menu
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _editItem(item),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Stock Level Progress
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Stock Level: ${item["currentStock"]} / ${item["maxStock"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${stockPercentage.toStringAsFixed(0)}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(item["status"]),
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
                  widthFactor: stockPercentage / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _getStatusColor(item["status"]),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Item Details
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
                      "Unit Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(item["unitPrice"] as double).toStringAsFixed(2)}",
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
                      "Total Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(item["totalValue"] as double).toStringAsFixed(2)}",
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
          
          SizedBox(height: spMd),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewItemDetails(item),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Update Stock",
                  size: bs.sm,
                  onPressed: () => _editItem(item),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = filteredItems;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Overview"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _exportInventory,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Inventory Stats
            _buildInventoryStats(),
            
            // Filters
            _buildFilters(),
            
            // Results Count
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Text(
                    "Showing ${items.length} of ${inventoryItems.length} items",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  if (searchQuery.isNotEmpty || selectedCategory != "All" || selectedLocation != "All") ...[
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          searchQuery = "";
                          selectedCategory = "All";
                          selectedLocation = "All";
                          sortBy = "name";
                        });
                      },
                      child: Text(
                        "Clear Filters",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            // Inventory Items List
            ...items.map((item) => _buildInventoryItem(item)).toList(),
            
            // Empty State
            if (items.isEmpty)
              Container(
                padding: EdgeInsets.all(sp2xl),
                child: Column(
                  children: [
                    Icon(
                      Icons.inventory_2,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No items found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters or search terms",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
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
