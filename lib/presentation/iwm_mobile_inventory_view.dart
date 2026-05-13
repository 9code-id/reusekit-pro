import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmMobileInventoryView extends StatefulWidget {
  const IwmMobileInventoryView({super.key});

  @override
  State<IwmMobileInventoryView> createState() => _IwmMobileInventoryViewState();
}

class _IwmMobileInventoryViewState extends State<IwmMobileInventoryView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedLocation = "all";
  String selectedStatus = "all";
  bool loading = false;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Furniture", "value": "furniture"},
    {"label": "Office Supplies", "value": "supplies"},
    {"label": "Equipment", "value": "equipment"},
  ];
  
  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "all"},
    {"label": "Zone A", "value": "zone_a"},
    {"label": "Zone B", "value": "zone_b"},
    {"label": "Zone C", "value": "zone_c"},
  ];
  
  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "In Stock", "value": "in_stock"},
    {"label": "Low Stock", "value": "low_stock"},
    {"label": "Out of Stock", "value": "out_stock"},
  ];
  
  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": "ITM-001",
      "sku": "LT-001",
      "name": "Laptop Dell XPS 13",
      "category": "Electronics",
      "currentStock": 25,
      "minStock": 10,
      "maxStock": 50,
      "location": "A-01-01",
      "lastUpdated": "2024-01-15 14:30",
      "unitPrice": 1299.99,
      "totalValue": 32499.75,
      "status": "In Stock",
      "supplier": "Tech Solutions Inc",
      "image": "https://picsum.photos/60/60?random=1&keyword=laptop"
    },
    {
      "id": "ITM-002",
      "sku": "CH-002",
      "name": "Office Chair Ergonomic",
      "category": "Furniture",
      "currentStock": 8,
      "minStock": 15,
      "maxStock": 30,
      "location": "B-02-03",
      "lastUpdated": "2024-01-15 13:45",
      "unitPrice": 249.99,
      "totalValue": 1999.92,
      "status": "Low Stock",
      "supplier": "Office Supplies Co",
      "image": "https://picsum.photos/60/60?random=2&keyword=chair"
    },
    {
      "id": "ITM-003",
      "sku": "MS-003",
      "name": "Wireless Mouse",
      "category": "Electronics",
      "currentStock": 0,
      "minStock": 20,
      "maxStock": 100,
      "location": "C-01-05",
      "lastUpdated": "2024-01-14 16:20",
      "unitPrice": 29.99,
      "totalValue": 0.0,
      "status": "Out of Stock",
      "supplier": "Tech Solutions Inc",
      "image": "https://picsum.photos/60/60?random=3&keyword=mouse"
    },
    {
      "id": "ITM-004",
      "sku": "MB-005",
      "name": "Monitor 24 inch",
      "category": "Electronics",
      "currentStock": 15,
      "minStock": 5,
      "maxStock": 25,
      "location": "B-01-02",
      "lastUpdated": "2024-01-15 11:30",
      "unitPrice": 199.99,
      "totalValue": 2999.85,
      "status": "In Stock",
      "supplier": "Hardware Direct",
      "image": "https://picsum.photos/60/60?random=4&keyword=monitor"
    },
  ];
  
  List<Map<String, dynamic>> recentMovements = [
    {
      "type": "IN",
      "item": "Laptop Dell XPS 13",
      "quantity": 5,
      "location": "A-01-01",
      "timestamp": "2024-01-15 14:30",
      "reference": "PO-2024-001",
      "user": "John Smith"
    },
    {
      "type": "OUT",
      "item": "Wireless Mouse",
      "quantity": 3,
      "location": "C-01-05",
      "timestamp": "2024-01-15 13:20",
      "reference": "SO-2024-001",
      "user": "Sarah Johnson"
    },
    {
      "type": "ADJUST",
      "item": "Office Chair Ergonomic",
      "quantity": -2,
      "location": "B-02-03",
      "timestamp": "2024-01-15 12:15",
      "reference": "ADJ-001",
      "user": "Mike Chen"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Mobile Inventory",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Items", icon: Icon(Icons.inventory_2)),
        Tab(text: "Search", icon: Icon(Icons.search)),
        Tab(text: "Movements", icon: Icon(Icons.swap_horiz)),
      ],
      tabChildren: [
        _buildItemsTab(),
        _buildSearchTab(),
        _buildMovementsTab(),
      ],
    );
  }

  Widget _buildItemsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInventoryStats(),
          _buildQuickFilters(),
          _buildInventoryItemsList(),
        ],
      ),
    );
  }

  Widget _buildSearchTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchInterface(),
          _buildAdvancedFilters(),
          _buildSearchResults(),
        ],
      ),
    );
  }

  Widget _buildMovementsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMovementStats(),
          _buildMovementFilters(),
          _buildRecentMovementsList(),
        ],
      ),
    );
  }

  Widget _buildInventoryStats() {
    List<Map<String, dynamic>> stats = [
      {"title": "Total Items", "value": "2,456", "subtitle": "SKUs in system", "icon": Icons.inventory_2, "color": primaryColor},
      {"title": "Low Stock", "value": "23", "subtitle": "Need reorder", "icon": Icons.warning, "color": warningColor},
      {"title": "Out of Stock", "value": "8", "subtitle": "Zero quantity", "icon": Icons.error, "color": dangerColor},
      {"title": "Total Value", "value": "\$127K", "subtitle": "Inventory worth", "icon": Icons.monetization_on, "color": successColor},
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: stats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilters() {
    return QHorizontalScroll(
      children: [
        _buildFilterChip("All Items", selectedStatus == "all"),
        _buildFilterChip("In Stock", selectedStatus == "in_stock"),
        _buildFilterChip("Low Stock", selectedStatus == "low_stock"),
        _buildFilterChip("Out of Stock", selectedStatus == "out_stock"),
        _buildFilterChip("Electronics", selectedCategory == "electronics"),
        _buildFilterChip("Furniture", selectedCategory == "furniture"),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => _applyQuickFilter(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        margin: EdgeInsets.only(right: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(color: isSelected ? primaryColor : disabledOutlineBorderColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : disabledBoldColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildInventoryItemsList() {
    List<Map<String, dynamic>> filteredItems = _getFilteredItems();

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Inventory Items (${filteredItems.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ...filteredItems.map((item) => _buildInventoryItemCard(item)),
      ],
    );
  }

  Widget _buildInventoryItemCard(Map<String, dynamic> item) {
    Color statusColor = _getStockStatusColor(item["status"]);
    double stockPercentage = (item["currentStock"] as int) / (item["maxStock"] as int);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${item["image"]}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
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
                    Text(
                      "SKU: ${item["sku"]} • ${item["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Location: ${item["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Stock: ${item["currentStock"]}/${item["maxStock"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: stockPercentage,
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((item["unitPrice"] as double)).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Total: \$${((item["totalValue"] as double)).toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "Updated: ${item["lastUpdated"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Details",
                size: bs.sm,
                onPressed: () => _viewItemDetails(item),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editItem(item),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInterface() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Search Inventory",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search by name, SKU, or category...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.qr_code_scanner,
                size: bs.sm,
                onPressed: () => _openScanner(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  icon: Icons.search,
                  label: "Search",
                  size: bs.md,
                  onPressed: () => _performSearch(),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.clear,
                size: bs.md,
                onPressed: () => _clearSearch(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Advanced Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
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
          QDropdownField(
            label: "Stock Status",
            items: statusFilters,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchQuery.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              Icons.search,
              size: 48,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "Start typing to search",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 16,
              ),
            ),
            Text(
              "Search by item name, SKU, or category",
              style: TextStyle(
                color: disabledColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    List<Map<String, dynamic>> searchResults = _getSearchResults();

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Search Results (${searchResults.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        if (searchResults.isEmpty)
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.search_off,
                  size: 48,
                  color: disabledColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "No items found",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Try adjusting your search criteria",
                  style: TextStyle(
                    color: disabledColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        else
          ...searchResults.map((item) => _buildInventoryItemCard(item)),
      ],
    );
  }

  Widget _buildMovementStats() {
    List<Map<String, dynamic>> movementStats = [
      {"title": "Today", "value": "24", "subtitle": "Movements", "icon": Icons.today, "color": primaryColor},
      {"title": "Received", "value": "15", "subtitle": "Items in", "icon": Icons.arrow_downward, "color": successColor},
      {"title": "Issued", "value": "8", "subtitle": "Items out", "icon": Icons.arrow_upward, "color": warningColor},
      {"title": "Adjusted", "value": "1", "subtitle": "Stock changes", "icon": Icons.tune, "color": infoColor},
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: movementStats.map((stat) => _buildMovementStatCard(stat)).toList(),
    );
  }

  Widget _buildMovementStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: (stat["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              stat["icon"],
              color: stat["color"],
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${stat["value"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${stat["title"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${stat["subtitle"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovementFilters() {
    return QHorizontalScroll(
      children: [
        _buildFilterChip("All", true),
        _buildFilterChip("Today", false),
        _buildFilterChip("Received", false),
        _buildFilterChip("Issued", false),
        _buildFilterChip("Adjusted", false),
      ],
    );
  }

  Widget _buildRecentMovementsList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Movements",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...recentMovements.map((movement) => _buildMovementCard(movement)),
      ],
    );
  }

  Widget _buildMovementCard(Map<String, dynamic> movement) {
    Color typeColor = _getMovementTypeColor(movement["type"]);
    IconData typeIcon = _getMovementTypeIcon(movement["type"]);
    String quantityText = movement["quantity"] > 0 ? "+${movement["quantity"]}" : "${movement["quantity"]}";

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: typeColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              typeIcon,
              color: typeColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${movement["item"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${movement["type"]} • Qty: $quantityText",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${movement["user"]} • ${movement["timestamp"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${movement["location"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${movement["reference"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredItems() {
    return inventoryItems.where((item) {
      bool matchesCategory = selectedCategory == "all" || item["category"].toString().toLowerCase().contains(selectedCategory);
      bool matchesStatus = selectedStatus == "all" || _getStatusFilter(item["status"]) == selectedStatus;
      return matchesCategory && matchesStatus;
    }).toList();
  }

  List<Map<String, dynamic>> _getSearchResults() {
    if (searchQuery.isEmpty) return [];
    
    return inventoryItems.where((item) {
      bool matchesSearch = item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["sku"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "all" || item["category"].toString().toLowerCase().contains(selectedCategory);
      bool matchesLocation = selectedLocation == "all" || item["location"].toString().contains(selectedLocation.replaceAll('_', ' '));
      bool matchesStatus = selectedStatus == "all" || _getStatusFilter(item["status"]) == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesLocation && matchesStatus;
    }).toList();
  }

  String _getStatusFilter(String status) {
    switch (status.toLowerCase()) {
      case 'in stock':
        return 'in_stock';
      case 'low stock':
        return 'low_stock';
      case 'out of stock':
        return 'out_stock';
      default:
        return 'all';
    }
  }

  void _applyQuickFilter(String filter) {
    switch (filter) {
      case "All Items":
        selectedStatus = "all";
        selectedCategory = "all";
        break;
      case "In Stock":
        selectedStatus = "in_stock";
        break;
      case "Low Stock":
        selectedStatus = "low_stock";
        break;
      case "Out of Stock":
        selectedStatus = "out_stock";
        break;
      case "Electronics":
        selectedCategory = "electronics";
        break;
      case "Furniture":
        selectedCategory = "furniture";
        break;
    }
    setState(() {});
  }

  void _performSearch() {
    if (searchQuery.isEmpty) {
      se("Please enter search criteria");
      return;
    }
    
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 1), () {
      loading = false;
      setState(() {});
      ss("Search completed");
    });
  }

  void _clearSearch() {
    searchQuery = "";
    selectedCategory = "all";
    selectedLocation = "all";
    selectedStatus = "all";
    setState(() {});
  }

  void _openScanner() {
    ss("Opening barcode scanner...");
  }

  void _viewItemDetails(Map<String, dynamic> item) {
    ss("Viewing details for ${item["name"]}");
  }

  void _editItem(Map<String, dynamic> item) {
    ss("Editing ${item["name"]}");
  }

  Color _getStockStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'in stock':
        return successColor;
      case 'low stock':
        return warningColor;
      case 'out of stock':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getMovementTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'in':
        return successColor;
      case 'out':
        return warningColor;
      case 'adjust':
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData _getMovementTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'in':
        return Icons.arrow_downward;
      case 'out':
        return Icons.arrow_upward;
      case 'adjust':
        return Icons.tune;
      default:
        return Icons.swap_horiz;
    }
  }
}
