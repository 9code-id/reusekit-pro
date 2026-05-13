import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsIngredientListView extends StatefulWidget {
  const RfsIngredientListView({super.key});

  @override
  State<RfsIngredientListView> createState() => _RfsIngredientListViewState();
}

class _RfsIngredientListViewState extends State<RfsIngredientListView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedUnit = "All";
  bool lowStockOnly = false;
  String sortBy = "Name";

  final List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Proteins", "value": "Proteins"},
    {"label": "Vegetables", "value": "Vegetables"},
    {"label": "Fruits", "value": "Fruits"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Grains", "value": "Grains"},
    {"label": "Spices", "value": "Spices"},
    {"label": "Condiments", "value": "Condiments"},
  ];

  final List<Map<String, dynamic>> unitItems = [
    {"label": "All", "value": "All"},
    {"label": "Kilograms", "value": "kg"},
    {"label": "Grams", "value": "g"},
    {"label": "Liters", "value": "L"},
    {"label": "Pieces", "value": "pcs"},
    {"label": "Cups", "value": "cups"},
    {"label": "Tablespoons", "value": "tbsp"},
  ];

  final List<Map<String, dynamic>> sortItems = [
    {"label": "Name", "value": "Name"},
    {"label": "Category", "value": "Category"},
    {"label": "Stock Level", "value": "Stock Level"},
    {"label": "Unit Price", "value": "Unit Price"},
    {"label": "Expiry Date", "value": "Expiry Date"},
  ];

  final List<Map<String, dynamic>> ingredients = [
    {
      "id": 1,
      "name": "Fresh Salmon Fillet",
      "category": "Proteins",
      "currentStock": 15.5,
      "minStock": 10.0,
      "maxStock": 50.0,
      "unit": "kg",
      "unitPrice": 25.99,
      "totalValue": 402.345,
      "supplier": "Ocean Fresh Seafood",
      "expiryDate": "2024-12-25",
      "status": "In Stock",
      "lastUpdated": "2024-12-18",
      "image": "https://picsum.photos/100/100?random=1&keyword=salmon",
      "description": "Premium Atlantic salmon fillet, fresh from sustainable farms"
    },
    {
      "id": 2,
      "name": "Organic Tomatoes",
      "category": "Vegetables",
      "currentStock": 25.0,
      "minStock": 20.0,
      "maxStock": 100.0,
      "unit": "kg",
      "unitPrice": 4.99,
      "totalValue": 124.75,
      "supplier": "Green Valley Farms",
      "expiryDate": "2024-12-22",
      "status": "In Stock",
      "lastUpdated": "2024-12-18",
      "image": "https://picsum.photos/100/100?random=2&keyword=tomato",
      "description": "Fresh organic tomatoes, perfect for sauces and salads"
    },
    {
      "id": 3,
      "name": "Extra Virgin Olive Oil",
      "category": "Condiments",
      "currentStock": 2.5,
      "minStock": 5.0,
      "maxStock": 20.0,
      "unit": "L",
      "unitPrice": 15.99,
      "totalValue": 39.975,
      "supplier": "Mediterranean Imports",
      "expiryDate": "2025-06-15",
      "status": "Low Stock",
      "lastUpdated": "2024-12-17",
      "image": "https://picsum.photos/100/100?random=3&keyword=oil",
      "description": "Premium extra virgin olive oil from Italian groves"
    },
    {
      "id": 4,
      "name": "Fresh Mozzarella",
      "category": "Dairy",
      "currentStock": 8.0,
      "minStock": 5.0,
      "maxStock": 30.0,
      "unit": "kg",
      "unitPrice": 12.50,
      "totalValue": 100.0,
      "supplier": "Artisan Cheese Co.",
      "expiryDate": "2024-12-20",
      "status": "In Stock",
      "lastUpdated": "2024-12-18",
      "image": "https://picsum.photos/100/100?random=4&keyword=cheese",
      "description": "Fresh mozzarella cheese made daily"
    },
    {
      "id": 5,
      "name": "Arborio Rice",
      "category": "Grains",
      "currentStock": 50.0,
      "minStock": 25.0,
      "maxStock": 100.0,
      "unit": "kg",
      "unitPrice": 3.99,
      "totalValue": 199.5,
      "supplier": "Italian Grain Imports",
      "expiryDate": "2025-12-01",
      "status": "In Stock",
      "lastUpdated": "2024-12-16",
      "image": "https://picsum.photos/100/100?random=5&keyword=rice",
      "description": "Premium Arborio rice for perfect risotto"
    },
    {
      "id": 6,
      "name": "Black Peppercorns",
      "category": "Spices",
      "currentStock": 0.5,
      "minStock": 1.0,
      "maxStock": 5.0,
      "unit": "kg",
      "unitPrice": 45.00,
      "totalValue": 22.5,
      "supplier": "Spice World",
      "expiryDate": "2025-03-15",
      "status": "Low Stock",
      "lastUpdated": "2024-12-15",
      "image": "https://picsum.photos/100/100?random=6&keyword=pepper",
      "description": "Whole black peppercorns for fresh grinding"
    },
    {
      "id": 7,
      "name": "Fresh Basil Leaves",
      "category": "Vegetables",
      "currentStock": 1.2,
      "minStock": 2.0,
      "maxStock": 10.0,
      "unit": "kg",
      "unitPrice": 18.99,
      "totalValue": 22.788,
      "supplier": "Herb Garden Co.",
      "expiryDate": "2024-12-21",
      "status": "Low Stock",
      "lastUpdated": "2024-12-18",
      "image": "https://picsum.photos/100/100?random=7&keyword=basil",
      "description": "Fresh basil leaves for aromatic dishes"
    },
    {
      "id": 8,
      "name": "Premium Vanilla Extract",
      "category": "Condiments",
      "currentStock": 0.8,
      "minStock": 1.5,
      "maxStock": 5.0,
      "unit": "L",
      "unitPrice": 89.99,
      "totalValue": 71.992,
      "supplier": "Madagascar Vanilla Co.",
      "expiryDate": "2026-01-30",
      "status": "Low Stock",
      "lastUpdated": "2024-12-14",
      "image": "https://picsum.photos/100/100?random=8&keyword=vanilla",
      "description": "Pure Madagascar vanilla extract for desserts"
    }
  ];

  List<Map<String, dynamic>> get filteredIngredients {
    var filtered = ingredients.where((ingredient) {
      bool matchesSearch = ingredient["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || ingredient["category"] == selectedCategory;
      bool matchesUnit = selectedUnit == "All" || ingredient["unit"] == selectedUnit;
      bool matchesStockFilter = !lowStockOnly || ingredient["status"] == "Low Stock";
      
      return matchesSearch && matchesCategory && matchesUnit && matchesStockFilter;
    }).toList();

    // Sort
    switch (sortBy) {
      case "Name":
        filtered.sort((a, b) => a["name"].compareTo(b["name"]));
        break;
      case "Category":
        filtered.sort((a, b) => a["category"].compareTo(b["category"]));
        break;
      case "Stock Level":
        filtered.sort((a, b) => (a["currentStock"] as double).compareTo(b["currentStock"] as double));
        break;
      case "Unit Price":
        filtered.sort((a, b) => (a["unitPrice"] as double).compareTo(b["unitPrice"] as double));
        break;
      case "Expiry Date":
        filtered.sort((a, b) => a["expiryDate"].compareTo(b["expiryDate"]));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingredient Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // navigateTo('AddIngredientView')
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildStockOverview(),
            _buildIngredientList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search ingredients...",
          value: searchQuery,
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
                items: categoryItems,
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
                label: "Unit",
                items: unitItems,
                value: selectedUnit,
                onChanged: (value, label) {
                  selectedUnit = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Sort By",
                items: sortItems,
                value: sortBy,
                onChanged: (value, label) {
                  sortBy = value;
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
                    "checked": lowStockOnly,
                  }
                ],
                value: [if (lowStockOnly) {"label": "Low Stock Only", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  lowStockOnly = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStockOverview() {
    int totalIngredients = ingredients.length;
    int lowStockItems = ingredients.where((i) => i["status"] == "Low Stock").length;
    double totalValue = ingredients.map((i) => i["totalValue"] as double).reduce((a, b) => a + b);
    int expiringSoon = ingredients.where((i) {
      DateTime expiry = DateTime.parse(i["expiryDate"]);
      DateTime now = DateTime.now();
      return expiry.difference(now).inDays <= 7;
    }).length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "$totalIngredients",
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
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "$lowStockItems",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
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
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "\$${totalValue.toStringAsFixed(0)}",
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
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "$expiringSoon",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Expiring",
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
    );
  }

  Widget _buildIngredientList() {
    return Column(
      spacing: spSm,
      children: filteredIngredients.map((ingredient) {
        return _buildIngredientCard(ingredient);
      }).toList(),
    );
  }

  Widget _buildIngredientCard(Map<String, dynamic> ingredient) {
    bool isLowStock = ingredient["status"] == "Low Stock";
    DateTime expiry = DateTime.parse(ingredient["expiryDate"]);
    bool expiringSoon = expiry.difference(DateTime.now()).inDays <= 7;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isLowStock ? Border.all(color: dangerColor.withAlpha(100), width: 1) : null,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${ingredient["image"]}",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
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
                        "${ingredient["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: isLowStock ? dangerColor.withAlpha(20) : successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${ingredient["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: isLowStock ? dangerColor : successColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${ingredient["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.category, size: 14, color: primaryColor),
                    SizedBox(width: 4),
                    Text(
                      "${ingredient["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.business, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${ingredient["supplier"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStockLevelColor(ingredient),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${ingredient["currentStock"]} ${ingredient["unit"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Min: ${ingredient["minStock"]} ${ingredient["unit"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(ingredient["unitPrice"] as double).toStringAsFixed(2)}/${ingredient["unit"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: expiringSoon ? warningColor : disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Exp: ${DateTime.parse(ingredient["expiryDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: expiringSoon ? warningColor : disabledBoldColor,
                        fontWeight: expiringSoon ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Total: \$${(ingredient["totalValue"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            spacing: spXs,
            children: [
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // navigateTo('EditIngredientView')
                },
              ),
              QButton(
                icon: Icons.inventory,
                size: bs.sm,
                onPressed: () {
                  _showStockUpdateDialog(ingredient);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStockLevelColor(Map<String, dynamic> ingredient) {
    double current = ingredient["currentStock"] as double;
    double min = ingredient["minStock"] as double;
    
    if (current <= min) return dangerColor;
    if (current <= min * 1.5) return warningColor;
    return successColor;
  }

  void _showStockUpdateDialog(Map<String, dynamic> ingredient) {
    String newStock = ingredient["currentStock"].toString();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Stock"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${ingredient["name"]}"),
            SizedBox(height: spMd),
            QNumberField(
              label: "New Stock Level (${ingredient["unit"]})",
              value: newStock,
              onChanged: (value) {
                newStock = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Update stock logic
              Navigator.pop(context);
              ss("Stock updated successfully");
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}
