import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaMaterialListView extends StatefulWidget {
  const ComaMaterialListView({super.key});

  @override
  State<ComaMaterialListView> createState() => _ComaMaterialListViewState();
}

class _ComaMaterialListViewState extends State<ComaMaterialListView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  bool showLowStock = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Cement", "value": "Cement"},
    {"label": "Steel", "value": "Steel"},
    {"label": "Aggregate", "value": "Aggregate"},
    {"label": "Bricks", "value": "Bricks"},
    {"label": "Timber", "value": "Timber"},
    {"label": "Paint", "value": "Paint"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "In Stock", "value": "In Stock"},
    {"label": "Low Stock", "value": "Low Stock"},
    {"label": "Out of Stock", "value": "Out of Stock"},
  ];

  List<Map<String, dynamic>> materials = [
    {
      "id": "MAT001",
      "name": "Portland Cement",
      "category": "Cement",
      "brand": "Holcim",
      "unit": "bags",
      "quantity": 150,
      "minQuantity": 50,
      "unitPrice": 12.50,
      "totalValue": 1875.00,
      "supplier": "BuildMart Supply",
      "location": "Warehouse A-1",
      "expiryDate": "2024-12-15",
      "status": "In Stock",
      "lastUpdated": "2024-06-18",
      "image": "https://picsum.photos/120/120?random=1&keyword=cement"
    },
    {
      "id": "MAT002",
      "name": "Steel Reinforcement Bar",
      "category": "Steel",
      "brand": "TataSteel",
      "unit": "tons",
      "quantity": 2.5,
      "minQuantity": 1.0,
      "unitPrice": 650.00,
      "totalValue": 1625.00,
      "supplier": "Metal Works Ltd",
      "location": "Yard B-2",
      "expiryDate": null,
      "status": "In Stock",
      "lastUpdated": "2024-06-17",
      "image": "https://picsum.photos/120/120?random=2&keyword=steel"
    },
    {
      "id": "MAT003",
      "name": "River Sand",
      "category": "Aggregate",
      "brand": "Local Supply",
      "unit": "cubic meters",
      "quantity": 8,
      "minQuantity": 15,
      "unitPrice": 25.00,
      "totalValue": 200.00,
      "supplier": "Sand & Gravel Co",
      "location": "Yard C-1",
      "expiryDate": null,
      "status": "Low Stock",
      "lastUpdated": "2024-06-16",
      "image": "https://picsum.photos/120/120?random=3&keyword=sand"
    },
    {
      "id": "MAT004",
      "name": "Red Clay Bricks",
      "category": "Bricks",
      "brand": "Premier Bricks",
      "unit": "pieces",
      "quantity": 0,
      "minQuantity": 500,
      "unitPrice": 0.35,
      "totalValue": 0.00,
      "supplier": "Brick Manufacturing",
      "location": "Warehouse D-1",
      "expiryDate": null,
      "status": "Out of Stock",
      "lastUpdated": "2024-06-15",
      "image": "https://picsum.photos/120/120?random=4&keyword=bricks"
    },
    {
      "id": "MAT005",
      "name": "Pine Timber",
      "category": "Timber",
      "brand": "Forest Products",
      "unit": "cubic meters",
      "quantity": 12,
      "minQuantity": 5,
      "unitPrice": 180.00,
      "totalValue": 2160.00,
      "supplier": "Timber Merchants",
      "location": "Shed E-1",
      "expiryDate": null,
      "status": "In Stock",
      "lastUpdated": "2024-06-18",
      "image": "https://picsum.photos/120/120?random=5&keyword=wood"
    },
    {
      "id": "MAT006",
      "name": "Exterior Paint",
      "category": "Paint",
      "brand": "Dulux",
      "unit": "liters",
      "quantity": 25,
      "minQuantity": 20,
      "unitPrice": 45.00,
      "totalValue": 1125.00,
      "supplier": "Paint Store",
      "location": "Warehouse F-1",
      "expiryDate": "2025-03-20",
      "status": "In Stock",
      "lastUpdated": "2024-06-17",
      "image": "https://picsum.photos/120/120?random=6&keyword=paint"
    },
  ];

  List<Map<String, dynamic>> get filteredMaterials {
    return materials.where((material) {
      bool matchesSearch = searchQuery.isEmpty ||
          (material["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (material["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (material["category"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory == "All" || material["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || material["status"] == selectedStatus;
      bool matchesLowStock = !showLowStock || material["status"] == "Low Stock" || material["status"] == "Out of Stock";

      return matchesSearch && matchesCategory && matchesStatus && matchesLowStock;
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
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Material Inventory"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('add_material')
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search materials...",
              value: searchQuery,
              hint: "Enter material name, ID, or category",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Quick Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: spSm,
                children: [
                  _buildQuickFilter("All", selectedCategory == "All"),
                  _buildQuickFilter("Low Stock", showLowStock),
                  _buildQuickFilter("Cement", selectedCategory == "Cement"),
                  _buildQuickFilter("Steel", selectedCategory == "Steel"),
                  _buildQuickFilter("Aggregate", selectedCategory == "Aggregate"),
                ],
              ),
            ),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Total Items",
                    "${materials.length}",
                    Icons.inventory,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Low Stock",
                    "${materials.where((m) => m["status"] == "Low Stock").length}",
                    Icons.warning,
                    warningColor,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Out of Stock",
                    "${materials.where((m) => m["status"] == "Out of Stock").length}",
                    Icons.error,
                    dangerColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Total Value",
                    "\$${(materials.fold(0.0, (sum, item) => sum + (item["totalValue"] as double))).currency}",
                    Icons.attach_money,
                    successColor,
                  ),
                ),
              ],
            ),

            // Materials List
            Column(
              spacing: spSm,
              children: filteredMaterials.map((material) {
                return _buildMaterialCard(material);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFilter(String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (label == "All") {
          selectedCategory = "All";
          showLowStock = false;
        } else if (label == "Low Stock") {
          showLowStock = !showLowStock;
        } else {
          selectedCategory = isActive ? "All" : label;
          showLowStock = false;
        }
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isActive ? primaryColor : disabledOutlineBorderColor,
          ),
          boxShadow: [shadowSm],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : disabledBoldColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
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
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialCard(Map<String, dynamic> material) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${material["image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${material["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${material["id"]} • ${material["brand"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(material["status"] as String).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${material["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: _getStatusColor(material["status"] as String),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${material["quantity"]} ${material["unit"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${(material["unitPrice"] as double).currency}/${material["unit"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
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
                      "Location: ${material["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Min Qty: ${material["minQuantity"]} ${material["unit"]}",
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Total Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(material["totalValue"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('material_details')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Update Stock",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('update_stock')
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter Materials"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Category",
                items: categories,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
              QSwitch(
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                selectedCategory = "All";
                selectedStatus = "All";
                showLowStock = false;
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Clear"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Apply"),
            ),
          ],
        );
      },
    );
  }
}
