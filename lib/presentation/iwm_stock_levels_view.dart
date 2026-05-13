import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmStockLevelsView extends StatefulWidget {
  const IwmStockLevelsView({super.key});

  @override
  State<IwmStockLevelsView> createState() => _IwmStockLevelsViewState();
}

class _IwmStockLevelsViewState extends State<IwmStockLevelsView> {
  int currentTab = 0;
  String selectedLocation = "All";
  String selectedSeverity = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "All"},
    {"label": "Warehouse A", "value": "Warehouse A"},
    {"label": "Warehouse B", "value": "Warehouse B"},
    {"label": "Office - Floor 1", "value": "Office - Floor 1"},
    {"label": "Office - Floor 2", "value": "Office - Floor 2"},
    {"label": "Storage Room", "value": "Storage Room"},
  ];

  List<Map<String, dynamic>> severityOptions = [
    {"label": "All Levels", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "Low", "value": "Low"},
    {"label": "Normal", "value": "Normal"},
    {"label": "Overstocked", "value": "Overstocked"},
  ];

  List<Map<String, dynamic>> stockItems = [
    {
      "id": "STK001",
      "name": "Printer Paper A4",
      "sku": "PPR-A4-001",
      "category": "Office Supplies",
      "location": "Office - Floor 1",
      "currentStock": 5,
      "minStock": 50,
      "maxStock": 200,
      "reorderPoint": 25,
      "unitPrice": 8.50,
      "supplier": "Office Depot",
      "lastRestocked": "2024-11-20",
      "turnoverRate": 85,
      "severity": "Critical",
      "image": "https://picsum.photos/60/60?random=1&keyword=paper",
    },
    {
      "id": "STK002",
      "name": "Blue Ink Pens",
      "sku": "PEN-BLU-002",
      "category": "Office Supplies",
      "location": "Supply Room",
      "currentStock": 12,
      "minStock": 30,
      "maxStock": 100,
      "reorderPoint": 20,
      "unitPrice": 1.25,
      "supplier": "Staples",
      "lastRestocked": "2024-12-01",
      "turnoverRate": 65,
      "severity": "Low",
      "image": "https://picsum.photos/60/60?random=2&keyword=pen",
    },
    {
      "id": "STK003",
      "name": "Wireless Mouse",
      "sku": "MSE-WL-003",
      "category": "Electronics",
      "location": "Warehouse A",
      "currentStock": 125,
      "minStock": 50,
      "maxStock": 200,
      "reorderPoint": 75,
      "unitPrice": 25.99,
      "supplier": "Tech Supply Co",
      "lastRestocked": "2024-12-10",
      "turnoverRate": 92,
      "severity": "Normal",
      "image": "https://picsum.photos/60/60?random=3&keyword=mouse",
    },
    {
      "id": "STK004",
      "name": "Office Chairs",
      "sku": "CHR-OFF-004",
      "category": "Furniture",
      "location": "Warehouse B",
      "currentStock": 180,
      "minStock": 20,
      "maxStock": 80,
      "reorderPoint": 30,
      "unitPrice": 199.99,
      "supplier": "Furniture Plus",
      "lastRestocked": "2024-11-15",
      "turnoverRate": 45,
      "severity": "Overstocked",
      "image": "https://picsum.photos/60/60?random=4&keyword=chair",
    },
    {
      "id": "STK005",
      "name": "USB Cables",
      "sku": "CBL-USB-005",
      "category": "Electronics",
      "location": "IT Storage",
      "currentStock": 8,
      "minStock": 25,
      "maxStock": 75,
      "reorderPoint": 15,
      "unitPrice": 12.99,
      "supplier": "Cable World",
      "lastRestocked": "2024-10-28",
      "turnoverRate": 78,
      "severity": "Critical",
      "image": "https://picsum.photos/60/60?random=5&keyword=cable",
    },
    {
      "id": "STK006",
      "name": "Whiteboard Markers",
      "sku": "MRK-WB-006",
      "category": "Office Supplies",
      "location": "Office - Floor 2",
      "currentStock": 22,
      "minStock": 40,
      "maxStock": 120,
      "reorderPoint": 30,
      "unitPrice": 3.75,
      "supplier": "Office Depot",
      "lastRestocked": "2024-11-30",
      "turnoverRate": 58,
      "severity": "Low",
      "image": "https://picsum.photos/60/60?random=6&keyword=marker",
    },
  ];

  List<Map<String, dynamic>> reorderSuggestions = [
    {
      "item": "Printer Paper A4",
      "sku": "PPR-A4-001",
      "currentStock": 5,
      "suggestedQuantity": 150,
      "estimatedCost": 1275.00,
      "supplier": "Office Depot",
      "leadTime": "3-5 days",
      "priority": "High",
    },
    {
      "item": "USB Cables",
      "sku": "CBL-USB-005",
      "currentStock": 8,
      "suggestedQuantity": 50,
      "estimatedCost": 649.50,
      "supplier": "Cable World",
      "leadTime": "7-10 days",
      "priority": "High",
    },
    {
      "item": "Blue Ink Pens",
      "sku": "PEN-BLU-002",
      "currentStock": 12,
      "suggestedQuantity": 75,
      "estimatedCost": 93.75,
      "supplier": "Staples",
      "leadTime": "2-3 days",
      "priority": "Medium",
    },
    {
      "item": "Whiteboard Markers",
      "sku": "MRK-WB-006",
      "currentStock": 22,
      "suggestedQuantity": 60,
      "estimatedCost": 225.00,
      "supplier": "Office Depot",
      "leadTime": "3-5 days",
      "priority": "Medium",
    },
  ];

  List<Map<String, dynamic>> get filteredStockItems {
    List<Map<String, dynamic>> filtered = List.from(stockItems);

    // Filter by location
    if (selectedLocation != "All") {
      filtered = filtered.where((item) => item["location"] == selectedLocation).toList();
    }

    // Filter by severity
    if (selectedSeverity != "All") {
      filtered = filtered.where((item) => item["severity"] == selectedSeverity).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) =>
        item["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        item["sku"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Critical":
        return dangerColor;
      case "Low":
        return warningColor;
      case "Normal":
        return successColor;
      case "Overstocked":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  double _getStockPercentage(Map<String, dynamic> item) {
    int current = item["currentStock"];
    int max = item["maxStock"];
    return (current / max) * 100;
  }

  void _updateMinMax(Map<String, dynamic> item) {
    // Navigate to update min/max levels
    //navigateTo('update_stock_levels', arguments: item)
  }

  void _createReorderRequest(Map<String, dynamic> suggestion) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Reorder request created for ${suggestion["item"]}");
  }

  void _adjustStock(Map<String, dynamic> item) {
    // Navigate to stock adjustment page
    //navigateTo('adjust_stock', arguments: item)
  }

  void _exportStockReport() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Stock levels report exported successfully");
  }

  Widget _buildStockLevelCard(Map<String, dynamic> item) {
    double stockPercentage = _getStockPercentage(item);
    bool isBelowReorder = (item["currentStock"] as int) <= (item["reorderPoint"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isBelowReorder 
            ? Border.all(color: dangerColor.withAlpha(100), width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Header
          Row(
            children: [
              // Item Image
              Container(
                width: 50,
                height: 50,
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
              
              SizedBox(width: spSm),
              
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
                  ],
                ),
              ),
              
              // Severity Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: _getSeverityColor(item["severity"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["severity"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getSeverityColor(item["severity"]),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Stock Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Current: ${item["currentStock"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Max: ${item["maxStock"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Stack(
                children: [
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: stockPercentage / 100,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getSeverityColor(item["severity"]),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                  // Reorder Point Indicator
                  if ((item["reorderPoint"] as int) > 0)
                    Positioned(
                      left: ((item["reorderPoint"] as int) / (item["maxStock"] as int)) * 
                            MediaQuery.of(context).size.width * 0.8,
                      child: Container(
                        width: 2,
                        height: 8,
                        color: warningColor,
                      ),
                    ),
                ],
              ),
              SizedBox(height: spXs),
              Row(
                children: [
                  Text(
                    "Min: ${item["minStock"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Reorder at: ${item["reorderPoint"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Additional Info
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
                      "Turnover Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${item["turnoverRate"]}%",
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
                      "Last Restocked",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${item["lastRestocked"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (isBelowReorder) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: dangerColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: dangerColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Below reorder point - Consider restocking",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          SizedBox(height: spMd),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Adjust Stock",
                  size: bs.sm,
                  onPressed: () => _adjustStock(item),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Update Levels",
                  size: bs.sm,
                  onPressed: () => _updateMinMax(item),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReorderCard(Map<String, dynamic> suggestion) {
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${suggestion["item"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "SKU: ${suggestion["sku"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                  color: _getPriorityColor(suggestion["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${suggestion["priority"]} Priority",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor(suggestion["priority"]),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Reorder Details
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Stock",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${suggestion["currentStock"]} units",
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
                            "Suggested Quantity",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${suggestion["suggestedQuantity"]} units",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
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
                            "Estimated Cost",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(suggestion["estimatedCost"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: successColor,
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
                            "Lead Time",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${suggestion["leadTime"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
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
          
          Row(
            children: [
              Expanded(
                child: Text(
                  "Supplier: ${suggestion["supplier"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
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
                  label: "Create Order",
                  size: bs.sm,
                  onPressed: () => _createReorderRequest(suggestion),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Modify",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockLevelsTab() {
    List<Map<String, dynamic>> items = filteredStockItems;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${stockItems.where((item) => item["severity"] == "Critical").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Critical",
                        style: TextStyle(
                          fontSize: 14,
                          color: dangerColor,
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
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${stockItems.where((item) => item["severity"] == "Low").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Low Stock",
                        style: TextStyle(
                          fontSize: 14,
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${stockItems.where((item) => item["severity"] == "Normal").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Normal",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Filters
          Container(
            padding: EdgeInsets.all(spMd),
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
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: _exportStockReport,
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
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
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Severity",
                        items: severityOptions,
                        value: selectedSeverity,
                        onChanged: (value, label) {
                          selectedSeverity = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
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
                  "Showing ${items.length} of ${stockItems.length} items",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                if (searchQuery.isNotEmpty || selectedLocation != "All" || selectedSeverity != "All")
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        searchQuery = "";
                        selectedLocation = "All";
                        selectedSeverity = "All";
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
            ),
          ),
          
          // Stock Items List
          ...items.map((item) => _buildStockLevelCard(item)).toList(),
          
          // Empty State
          if (items.isEmpty)
            Container(
              padding: EdgeInsets.all(sp2xl),
              child: Column(
                children: [
                  Icon(
                    Icons.inventory,
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
    );
  }

  Widget _buildReorderTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Reorder Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [warningColor, warningColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reorder Suggestions",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${reorderSuggestions.length} items need restocking",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          
          // Total Estimated Cost
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Estimated Cost",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${reorderSuggestions.fold(0.0, (sum, item) => sum + (item["estimatedCost"] as double)).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Create All Orders",
                  size: bs.sm,
                  onPressed: () {
                    for (var suggestion in reorderSuggestions) {
                      _createReorderRequest(suggestion);
                    }
                  },
                ),
              ],
            ),
          ),
          
          // Reorder Suggestions List
          ...reorderSuggestions.map((suggestion) => _buildReorderCard(suggestion)).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Stock Levels",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Stock Levels", icon: Icon(Icons.inventory)),
        Tab(text: "Reorder", icon: Icon(Icons.shopping_cart)),
      ],
      tabChildren: [
        _buildStockLevelsTab(),
        _buildReorderTab(),
      ],
    );
  }
}
