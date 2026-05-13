import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaStockLevelsView extends StatefulWidget {
  const LtaStockLevelsView({super.key});

  @override
  State<LtaStockLevelsView> createState() => _LtaStockLevelsViewState();
}

class _LtaStockLevelsViewState extends State<LtaStockLevelsView> {
  String selectedLocation = "All Locations";
  String selectedCategory = "All Categories";
  String searchQuery = "";
  String sortBy = "name";
  bool showLowStock = false;

  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "all"},
    {"label": "Warehouse A", "value": "warehouse_a"},
    {"label": "Warehouse B", "value": "warehouse_b"},
    {"label": "Store Front", "value": "store_front"},
    {"label": "Distribution Center", "value": "distribution"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Food & Beverage", "value": "food"},
    {"label": "Office Supplies", "value": "office"},
    {"label": "Hardware", "value": "hardware"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name A-Z", "value": "name"},
    {"label": "Stock Level", "value": "stock"},
    {"label": "Last Updated", "value": "updated"},
    {"label": "Category", "value": "category"},
  ];

  List<Map<String, dynamic>> stockItems = [
    {
      "id": "ITM001",
      "name": "Laptop Dell Inspiron",
      "category": "Electronics",
      "location": "Warehouse A",
      "currentStock": 25,
      "minStock": 10,
      "maxStock": 100,
      "unit": "pcs",
      "lastUpdated": "2024-01-15 14:30",
      "status": "adequate",
      "supplier": "Tech Solutions Ltd",
      "price": 1200.00,
    },
    {
      "id": "ITM002",
      "name": "Office Chair Ergonomic",
      "category": "Office Supplies",
      "location": "Warehouse B",
      "currentStock": 5,
      "minStock": 15,
      "maxStock": 50,
      "unit": "pcs",
      "lastUpdated": "2024-01-15 12:15",
      "status": "low",
      "supplier": "Furniture Pro",
      "price": 350.00,
    },
    {
      "id": "ITM003",
      "name": "Printer Paper A4",
      "category": "Office Supplies",
      "location": "Store Front",
      "currentStock": 200,
      "minStock": 50,
      "maxStock": 500,
      "unit": "reams",
      "lastUpdated": "2024-01-15 16:45",
      "status": "adequate",
      "supplier": "Paper World",
      "price": 8.50,
    },
    {
      "id": "ITM004",
      "name": "Coffee Beans Premium",
      "category": "Food & Beverage",
      "location": "Distribution Center",
      "currentStock": 2,
      "minStock": 20,
      "maxStock": 100,
      "unit": "kg",
      "lastUpdated": "2024-01-15 09:20",
      "status": "critical",
      "supplier": "Coffee Roasters Inc",
      "price": 45.00,
    },
    {
      "id": "ITM005",
      "name": "Steel Bolts M8x50",
      "category": "Hardware",
      "location": "Warehouse A",
      "currentStock": 150,
      "minStock": 100,
      "maxStock": 1000,
      "unit": "pcs",
      "lastUpdated": "2024-01-15 11:10",
      "status": "adequate",
      "supplier": "Hardware Supply Co",
      "price": 0.25,
    },
    {
      "id": "ITM006",
      "name": "T-Shirt Cotton Blue",
      "category": "Clothing",
      "location": "Store Front",
      "currentStock": 80,
      "minStock": 30,
      "maxStock": 200,
      "unit": "pcs",
      "lastUpdated": "2024-01-15 13:55",
      "status": "adequate",
      "supplier": "Fashion Wholesale",
      "price": 15.99,
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> filtered = stockItems.where((item) {
      bool matchesLocation = selectedLocation == "All Locations" || 
          "${item["location"]}" == selectedLocation;
      bool matchesCategory = selectedCategory == "All Categories" || 
          "${item["category"]}" == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty ||
          "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${item["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesLowStock = !showLowStock || "${item["status"]}" == "low" || 
          "${item["status"]}" == "critical";
      
      return matchesLocation && matchesCategory && matchesSearch && matchesLowStock;
    }).toList();

    // Sort items
    filtered.sort((a, b) {
      switch (sortBy) {
        case "stock":
          return (b["currentStock"] as int).compareTo(a["currentStock"] as int);
        case "updated":
          return "${b["lastUpdated"]}".compareTo("${a["lastUpdated"]}");
        case "category":
          return "${a["category"]}".compareTo("${b["category"]}");
        default:
          return "${a["name"]}".compareTo("${b["name"]}");
      }
    });

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "critical":
        return dangerColor;
      case "low":
        return warningColor;
      case "adequate":
        return successColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "critical":
        return "Critical";
      case "low":
        return "Low Stock";
      case "adequate":
        return "Adequate";
      default:
        return "Unknown";
    }
  }

  void _showStockDetail(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
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
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "ID: ${item["id"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor("${item["status"]}").withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      _getStatusText("${item["status"]}"),
                      style: TextStyle(
                        color: _getStatusColor("${item["status"]}"),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stock Information
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Stock Information",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
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
                                      "Current Stock",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "${item["currentStock"]} ${item["unit"]}",
                                      style: TextStyle(
                                        fontSize: fsH5,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor("${item["status"]}"),
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
                                      "Min Stock",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "${item["minStock"]} ${item["unit"]}",
                                      style: TextStyle(
                                        fontSize: 16,
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
                                      "Max Stock",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "${item["maxStock"]} ${item["unit"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    // Item Details
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailItem("Category", "${item["category"]}"),
                        ),
                        Expanded(
                          child: _buildDetailItem("Location", "${item["location"]}"),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailItem("Supplier", "${item["supplier"]}"),
                        ),
                        Expanded(
                          child: _buildDetailItem("Unit Price", "\$${((item["price"] as double)).currency}"),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    _buildDetailItem("Last Updated", "${item["lastUpdated"]}"),
                    
                    SizedBox(height: spLg),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Update Stock",
                            size: bs.md,
                            onPressed: () {
                              back();
                              ss("Stock update feature would open here");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Reorder",
                            size: bs.md,
                            onPressed: () {
                              back();
                              ss("Reorder feature would open here");
                            },
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
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStockCard(Map<String, dynamic> item) {
    double stockPercentage = (item["currentStock"] as int) / (item["maxStock"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusMd),
          onTap: () => _showStockDetail(item),
          child: Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "ID: ${item["id"]} • ${item["category"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${item["status"]}").withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        _getStatusText("${item["status"]}"),
                        style: TextStyle(
                          color: _getStatusColor("${item["status"]}"),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Stock Level Bar
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
                          "${item["currentStock"]} / ${item["maxStock"]} ${item["unit"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7 * stockPercentage,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _getStatusColor("${item["status"]}"),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${item["location"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Updated: ${item["lastUpdated"]}".split(' ')[0],
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Levels"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Stock data refreshed");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Search Bar
                QTextField(
                  label: "Search items...",
                  value: searchQuery,
                  hint: "Search by name or ID",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                
                // Filter Dropdowns
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Location",
                        items: locations,
                        value: selectedLocation,
                        onChanged: (value, label) {
                          selectedLocation = label!;
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
                          selectedCategory = label!;
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
                      child: QDropdownField(
                        label: "Sort By",
                        items: sortOptions,
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value!;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Low Stock Only",
                            "value": true,
                            "checked": showLowStock,
                          }
                        ],
                        value: [
                          if (showLowStock)
                            {
                              "label": "Low Stock Only",
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
          
          // Stock Summary
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${stockItems.where((item) => item["status"] == "adequate").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Adequate",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${stockItems.where((item) => item["status"] == "low").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Low Stock",
                          style: TextStyle(
                            color: warningColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${stockItems.where((item) => item["status"] == "critical").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Critical",
                          style: TextStyle(
                            color: dangerColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Stock Items List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return _buildStockCard(item);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ss("Add new item feature would open here");
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
