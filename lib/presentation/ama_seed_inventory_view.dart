import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSeedInventoryView extends StatefulWidget {
  const AmaSeedInventoryView({super.key});

  @override
  State<AmaSeedInventoryView> createState() => _AmaSeedInventoryViewState();
}

class _AmaSeedInventoryViewState extends State<AmaSeedInventoryView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String sortBy = "name";
  bool showLowStock = false;

  List<Map<String, dynamic>> seedInventory = [
    {
      "id": "WH001",
      "name": "Premium Wheat",
      "variety": "HD-2967",
      "category": "Cereals",
      "quantity": 150,
      "unit": "kg",
      "minStock": 50,
      "maxStock": 200,
      "pricePerUnit": 45.0,
      "supplier": "AgriSeeds Ltd",
      "expiryDate": "2025-06-15",
      "lastUpdated": "2024-12-10",
      "germinationRate": 95,
      "storage": "Warehouse A",
      "status": "In Stock",
      "image": "https://picsum.photos/100/100?random=1&keyword=wheat",
    },
    {
      "id": "RC002",
      "name": "Basmati Rice",
      "variety": "Pusa-1121",
      "category": "Cereals",
      "quantity": 25,
      "unit": "kg",
      "minStock": 30,
      "maxStock": 150,
      "pricePerUnit": 85.0,
      "supplier": "Rice Tech",
      "expiryDate": "2025-04-20",
      "lastUpdated": "2024-12-08",
      "germinationRate": 92,
      "storage": "Warehouse B",
      "status": "Low Stock",
      "image": "https://picsum.photos/100/100?random=2&keyword=rice",
    },
    {
      "id": "CN003",
      "name": "Hybrid Corn",
      "variety": "Pioneer-3394",
      "category": "Cereals",
      "quantity": 80,
      "unit": "kg",
      "minStock": 40,
      "maxStock": 120,
      "pricePerUnit": 120.0,
      "supplier": "Pioneer Seeds",
      "expiryDate": "2025-08-30",
      "lastUpdated": "2024-12-12",
      "germinationRate": 98,
      "storage": "Warehouse A",
      "status": "In Stock",
      "image": "https://picsum.photos/100/100?random=3&keyword=corn",
    },
    {
      "id": "TM004",
      "name": "Cherry Tomato",
      "variety": "Sweet-100",
      "category": "Vegetables",
      "quantity": 5,
      "unit": "kg",
      "minStock": 10,
      "maxStock": 30,
      "pricePerUnit": 2500.0,
      "supplier": "Veggie Seeds Co",
      "expiryDate": "2025-03-15",
      "lastUpdated": "2024-12-11",
      "germinationRate": 88,
      "storage": "Cold Storage",
      "status": "Critical",
      "image": "https://picsum.photos/100/100?random=4&keyword=tomato",
    },
    {
      "id": "PT005",
      "name": "Seed Potatoes",
      "variety": "Russet-Burbank",
      "category": "Vegetables",
      "quantity": 200,
      "unit": "kg",
      "minStock": 100,
      "maxStock": 300,
      "pricePerUnit": 35.0,
      "supplier": "Potato Growers",
      "expiryDate": "2025-01-30",
      "lastUpdated": "2024-12-09",
      "germinationRate": 90,
      "storage": "Cool Storage",
      "status": "In Stock",
      "image": "https://picsum.photos/100/100?random=5&keyword=potato",
    },
    {
      "id": "SB006",
      "name": "Soybeans",
      "variety": "Williams-82",
      "category": "Legumes",
      "quantity": 45,
      "unit": "kg",
      "minStock": 50,
      "maxStock": 150,
      "pricePerUnit": 95.0,
      "supplier": "Legume Solutions",
      "expiryDate": "2025-07-10",
      "lastUpdated": "2024-12-07",
      "germinationRate": 94,
      "storage": "Warehouse B",
      "status": "Low Stock",
      "image": "https://picsum.photos/100/100?random=6&keyword=soybean",
    },
  ];

  List<Map<String, dynamic>> get filteredSeeds {
    List<Map<String, dynamic>> filtered = seedInventory;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((seed) {
        return seed["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               seed["variety"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               seed["category"].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by category
    if (selectedCategory != "all") {
      filtered = filtered.where((seed) {
        return seed["category"].toLowerCase() == selectedCategory.toLowerCase();
      }).toList();
    }

    // Filter by low stock
    if (showLowStock) {
      filtered = filtered.where((seed) {
        return (seed["quantity"] as int) <= (seed["minStock"] as int);
      }).toList();
    }

    // Sort
    filtered.sort((a, b) {
      switch (sortBy) {
        case "name":
          return a["name"].compareTo(b["name"]);
        case "quantity":
          return (b["quantity"] as int).compareTo(a["quantity"] as int);
        case "expiry":
          return DateTime.parse(a["expiryDate"]).compareTo(DateTime.parse(b["expiryDate"]));
        default:
          return 0;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seed Inventory"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              _addNewSeed();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInventoryStats(),
            _buildFiltersSection(),
            _buildInventoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryStats() {
    int totalItems = seedInventory.length;
    int lowStockItems = seedInventory.where((seed) => 
      (seed["quantity"] as int) <= (seed["minStock"] as int)).length;
    int criticalItems = seedInventory.where((seed) => 
      seed["status"] == "Critical").length;
    double totalValue = seedInventory.fold(0.0, (sum, seed) => 
      sum + ((seed["quantity"] as int) * (seed["pricePerUnit"] as double)));

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(80)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem("Total Items", "$totalItems", Icons.inventory, Colors.white),
              _buildStatItem("Low Stock", "$lowStockItems", Icons.warning, Colors.orange),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem("Critical", "$criticalItems", Icons.error, Colors.red),
              _buildStatItem("Total Value", "₹${((totalValue)).currency}", Icons.attach_money, Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersSection() {
    return Column(
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
        SizedBox(height: spSm),
        QTextField(
          label: "Search Seeds",
          value: searchQuery,
          hint: "Search by name, variety, or category",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Category",
                items: [
                  {"label": "All Categories", "value": "all"},
                  {"label": "Cereals", "value": "cereals"},
                  {"label": "Vegetables", "value": "vegetables"},
                  {"label": "Legumes", "value": "legumes"},
                  {"label": "Fruits", "value": "fruits"},
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
                label: "Sort By",
                items: [
                  {"label": "Name", "value": "name"},
                  {"label": "Quantity", "value": "quantity"},
                  {"label": "Expiry Date", "value": "expiry"},
                ],
                value: sortBy,
                onChanged: (value, label) {
                  sortBy = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        QSwitch(
          items: [
            {
              "label": "Show only low stock items",
              "value": true,
              "checked": showLowStock,
            }
          ],
          value: [if (showLowStock) {"label": "Show only low stock items", "value": true, "checked": true}],
          onChanged: (values, ids) {
            showLowStock = values.isNotEmpty;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildInventoryList() {
    final filtered = filteredSeeds;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Inventory Items (${filtered.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        if (filtered.isEmpty)
          _buildEmptyState()
        else
          ...filtered.map((seed) => _buildSeedCard(seed)),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: disabledBoldColor,
          ),
          SizedBox(height: spSm),
          Text(
            "No seeds found",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Try adjusting your search criteria",
            style: TextStyle(
              fontSize: 14,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeedCard(Map<String, dynamic> seed) {
    Color statusColor = _getStatusColor(seed["status"]);
    bool isLowStock = (seed["quantity"] as int) <= (seed["minStock"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: isLowStock ? Border.all(color: warningColor.withAlpha(50)) : null,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: Image.network(
                  "${seed["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${seed["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${seed["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Variety: ${seed["variety"]} | ID: ${seed["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.inventory_2, size: 16, color: primaryColor),
                        SizedBox(width: spXs),
                        Text(
                          "${seed["quantity"]} ${seed["unit"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${seed["storage"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
              Expanded(
                child: _buildDetailRow("Price", "₹${((seed["pricePerUnit"] as double)).currency}/${seed["unit"]}", Icons.attach_money),
              ),
              Expanded(
                child: _buildDetailRow("Germination", "${seed["germinationRate"]}%", Icons.eco),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: _buildDetailRow("Expiry", DateTime.parse(seed["expiryDate"]).dMMMy, Icons.event),
              ),
              Expanded(
                child: _buildDetailRow("Supplier", "${seed["supplier"]}", Icons.business),
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
                    _updateStock(seed);
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showSeedOptions(seed);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: disabledBoldColor),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "in stock":
        return successColor;
      case "low stock":
        return warningColor;
      case "critical":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addNewSeed() {
    ss("Add new seed functionality");
  }

  void _updateStock(Map<String, dynamic> seed) {
    ss("Update stock for ${seed["name"]}");
  }

  void _showSeedOptions(Map<String, dynamic> seed) {
    ss("Seed options for ${seed["name"]}");
  }
}
