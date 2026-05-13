import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaIngredientTrackingView extends StatefulWidget {
  const RmaIngredientTrackingView({super.key});

  @override
  State<RmaIngredientTrackingView> createState() => _RmaIngredientTrackingViewState();
}

class _RmaIngredientTrackingViewState extends State<RmaIngredientTrackingView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedSupplier = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> ingredients = [
    {
      "id": "ING001",
      "name": "Organic Tomatoes",
      "category": "Vegetables",
      "supplier": "FreshCorp",
      "currentStock": 25.5,
      "unit": "kg",
      "minThreshold": 10.0,
      "maxThreshold": 50.0,
      "costPerUnit": 4.50,
      "lastOrderDate": "2024-01-15",
      "expiryDate": "2024-01-25",
      "batchNumber": "TC240115",
      "status": "In Stock",
      "location": "Cold Storage A",
      "usageRate": 3.2,
      "daysToExpiry": 8,
      "allergens": ["None"],
      "certifications": ["Organic", "Local"]
    },
    {
      "id": "ING002",
      "name": "Premium Beef Tenderloin",
      "category": "Meat",
      "supplier": "PrimeMeats Ltd",
      "currentStock": 12.8,
      "unit": "kg",
      "minThreshold": 5.0,
      "maxThreshold": 30.0,
      "costPerUnit": 28.75,
      "lastOrderDate": "2024-01-16",
      "expiryDate": "2024-01-22",
      "batchNumber": "BT240116",
      "status": "Low Stock",
      "location": "Freezer B",
      "usageRate": 2.1,
      "daysToExpiry": 4,
      "allergens": ["None"],
      "certifications": ["Grass-Fed", "Hormone-Free"]
    },
    {
      "id": "ING003",
      "name": "Extra Virgin Olive Oil",
      "category": "Oils & Condiments",
      "supplier": "Mediterranean Imports",
      "currentStock": 8.2,
      "unit": "L",
      "minThreshold": 5.0,
      "maxThreshold": 25.0,
      "costPerUnit": 15.25,
      "lastOrderDate": "2024-01-10",
      "expiryDate": "2024-12-15",
      "batchNumber": "EVO240110",
      "status": "Low Stock",
      "location": "Pantry A",
      "usageRate": 0.8,
      "daysToExpiry": 328,
      "allergens": ["None"],
      "certifications": ["Organic", "Cold-Pressed"]
    },
    {
      "id": "ING004",
      "name": "Fresh Atlantic Salmon",
      "category": "Seafood",
      "supplier": "Ocean Fresh Co",
      "currentStock": 18.5,
      "unit": "kg",
      "minThreshold": 8.0,
      "maxThreshold": 40.0,
      "costPerUnit": 22.90,
      "lastOrderDate": "2024-01-17",
      "expiryDate": "2024-01-20",
      "batchNumber": "AS240117",
      "status": "Critical",
      "location": "Fish Cooler",
      "usageRate": 4.5,
      "daysToExpiry": 2,
      "allergens": ["Fish"],
      "certifications": ["Wild-Caught", "MSC Certified"]
    },
    {
      "id": "ING005",
      "name": "Aged Parmesan Cheese",
      "category": "Dairy",
      "supplier": "Artisan Dairy",
      "currentStock": 6.3,
      "unit": "kg",
      "minThreshold": 3.0,
      "maxThreshold": 15.0,
      "costPerUnit": 32.50,
      "lastOrderDate": "2024-01-12",
      "expiryDate": "2024-03-15",
      "batchNumber": "PC240112",
      "status": "In Stock",
      "location": "Cheese Vault",
      "usageRate": 0.6,
      "daysToExpiry": 56,
      "allergens": ["Milk"],
      "certifications": ["Aged 24 Months", "DOP"]
    },
    {
      "id": "ING006",
      "name": "Organic Free-Range Eggs",
      "category": "Dairy",
      "supplier": "Happy Farm",
      "currentStock": 180,
      "unit": "pieces",
      "minThreshold": 60,
      "maxThreshold": 300,
      "costPerUnit": 0.45,
      "lastOrderDate": "2024-01-16",
      "expiryDate": "2024-01-28",
      "batchNumber": "EG240116",
      "status": "In Stock",
      "location": "Refrigerator C",
      "usageRate": 24,
      "daysToExpiry": 10,
      "allergens": ["Eggs"],
      "certifications": ["Free-Range", "Organic"]
    },
    {
      "id": "ING007",
      "name": "Arborio Rice",
      "category": "Grains",
      "supplier": "Italian Imports",
      "currentStock": 22.8,
      "unit": "kg",
      "minThreshold": 15.0,
      "maxThreshold": 50.0,
      "costPerUnit": 6.75,
      "lastOrderDate": "2024-01-08",
      "expiryDate": "2024-08-15",
      "batchNumber": "AR240108",
      "status": "In Stock",
      "location": "Dry Storage",
      "usageRate": 1.8,
      "daysToExpiry": 198,
      "allergens": ["None"],
      "certifications": ["Italian Origin", "Non-GMO"]
    },
    {
      "id": "ING008",
      "name": "Fresh Basil",
      "category": "Herbs & Spices",
      "supplier": "Green Herbs Co",
      "currentStock": 2.1,
      "unit": "kg",
      "minThreshold": 1.0,
      "maxThreshold": 5.0,
      "costPerUnit": 18.50,
      "lastOrderDate": "2024-01-17",
      "expiryDate": "2024-01-22",
      "batchNumber": "FB240117",
      "status": "In Stock",
      "location": "Herb Cooler",
      "usageRate": 0.3,
      "daysToExpiry": 4,
      "allergens": ["None"],
      "certifications": ["Organic", "Locally Grown"]
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Vegetables", "value": "Vegetables"},
    {"label": "Meat", "value": "Meat"},
    {"label": "Seafood", "value": "Seafood"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Grains", "value": "Grains"},
    {"label": "Oils & Condiments", "value": "Oils & Condiments"},
    {"label": "Herbs & Spices", "value": "Herbs & Spices"},
  ];

  List<Map<String, dynamic>> suppliers = [
    {"label": "All", "value": "All"},
    {"label": "FreshCorp", "value": "FreshCorp"},
    {"label": "PrimeMeats Ltd", "value": "PrimeMeats Ltd"},
    {"label": "Mediterranean Imports", "value": "Mediterranean Imports"},
    {"label": "Ocean Fresh Co", "value": "Ocean Fresh Co"},
    {"label": "Artisan Dairy", "value": "Artisan Dairy"},
    {"label": "Happy Farm", "value": "Happy Farm"},
    {"label": "Italian Imports", "value": "Italian Imports"},
    {"label": "Green Herbs Co", "value": "Green Herbs Co"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "In Stock", "value": "In Stock"},
    {"label": "Low Stock", "value": "Low Stock"},
    {"label": "Critical", "value": "Critical"},
    {"label": "Out of Stock", "value": "Out of Stock"},
  ];

  List<Map<String, dynamic>> get filteredIngredients {
    return ingredients.where((ingredient) {
      bool matchesSearch = ingredient["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          ingredient["id"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          ingredient["batchNumber"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || ingredient["category"] == selectedCategory;
      bool matchesSupplier = selectedSupplier == "All" || ingredient["supplier"] == selectedSupplier;
      bool matchesStatus = selectedStatus == "All" || ingredient["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesSupplier && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Stock":
        return successColor;
      case "Low Stock":
        return warningColor;
      case "Critical":
        return dangerColor;
      case "Out of Stock":
        return disabledColor;
      default:
        return disabledBoldColor;
    }
  }

  int get totalIngredients => ingredients.length;
  int get lowStockCount => ingredients.where((i) => i["status"] == "Low Stock").length;
  int get criticalCount => ingredients.where((i) => i["status"] == "Critical").length;
  double get totalValue => ingredients.fold(0.0, (sum, ingredient) => 
      sum + ((ingredient["currentStock"] as num).toDouble() * (ingredient["costPerUnit"] as num).toDouble()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingredient Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(AddIngredientView())
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Ingredient report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
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
                          Icon(Icons.inventory, color: primaryColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Total Ingredients",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${totalIngredients}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(Icons.warning, color: warningColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Low Stock Items",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${lowStockCount}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(Icons.error, color: dangerColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Critical Items",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${criticalCount}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(Icons.attach_money, color: successColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Total Value",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${totalValue.currency}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
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
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.filter_list, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Search ingredients",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
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
                      Expanded(
                        child: QDropdownField(
                          label: "Supplier",
                          items: suppliers,
                          value: selectedSupplier,
                          onChanged: (value, label) {
                            selectedSupplier = value;
                            setState(() {});
                          },
                        ),
                      ),
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
                ],
              ),
            ),

            // Ingredients List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredIngredients.length,
              itemBuilder: (context, index) {
                final ingredient = filteredIngredients[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getStatusColor(ingredient["status"]),
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${ingredient["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "ID: ${ingredient["id"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(ingredient["status"]).withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${ingredient["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: _getStatusColor(ingredient["status"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${(ingredient["currentStock"] as num).toStringAsFixed(1)} ${ingredient["unit"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "\$${((ingredient["currentStock"] as num) * (ingredient["costPerUnit"] as num)).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      // Stock Level Progress Bar
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
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${((ingredient["currentStock"] as num) / (ingredient["maxThreshold"] as num) * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: (ingredient["currentStock"] as num) / (ingredient["maxThreshold"] as num),
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(ingredient["status"])),
                          ),
                        ],
                      ),

                      Row(
                        spacing: spMd,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Category",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${ingredient["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
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
                                  "Supplier",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${ingredient["supplier"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
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
                                  "Expires",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${(ingredient["daysToExpiry"] as int)} days",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: (ingredient["daysToExpiry"] as int) <= 5 ? dangerColor : primaryColor,
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
                                  "Location",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${ingredient["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
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
                                // navigateTo(IngredientDetailView(ingredient: ingredient))
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo(EditIngredientView(ingredient: ingredient))
                            },
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.add_shopping_cart,
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo(OrderIngredientView(ingredient: ingredient))
                            },
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
    );
  }
}
