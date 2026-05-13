import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomerCategoriesView extends StatefulWidget {
  const CmaCustomerCategoriesView({super.key});

  @override
  State<CmaCustomerCategoriesView> createState() => _CmaCustomerCategoriesViewState();
}

class _CmaCustomerCategoriesViewState extends State<CmaCustomerCategoriesView> {
  String searchQuery = "";
  bool showAddDialog = false;
  String newCategoryName = "";
  String newCategoryDescription = "";
  String selectedCategoryColor = "#2196F3";

  List<Map<String, dynamic>> categories = [
    {
      "id": "1",
      "name": "Premium Customers",
      "description": "High-value customers with premium service requirements",
      "color": "#4CAF50",
      "customerCount": 342,
      "totalRevenue": 2450000.0,
      "avgOrderValue": 7160.0,
      "lastUpdated": "2024-12-15",
      "isActive": true,
    },
    {
      "id": "2", 
      "name": "Standard Customers",
      "description": "Regular customers with standard service needs",
      "color": "#2196F3",
      "customerCount": 1256,
      "totalRevenue": 1890000.0,
      "avgOrderValue": 1505.0,
      "lastUpdated": "2024-12-14",
      "isActive": true,
    },
    {
      "id": "3",
      "name": "VIP Clients", 
      "description": "Exclusive VIP clients with personalized service",
      "color": "#FF9800",
      "customerCount": 89,
      "totalRevenue": 1340000.0,
      "avgOrderValue": 15056.0,
      "lastUpdated": "2024-12-13",
      "isActive": true,
    },
    {
      "id": "4",
      "name": "Enterprise Accounts",
      "description": "Large enterprise customers with bulk orders",
      "color": "#9C27B0",
      "customerCount": 67,
      "totalRevenue": 3200000.0,
      "avgOrderValue": 47761.0,
      "lastUpdated": "2024-12-12",
      "isActive": true,
    },
    {
      "id": "5",
      "name": "New Customers",
      "description": "Recently acquired customers in probation period",
      "color": "#00BCD4",
      "customerCount": 445,
      "totalRevenue": 234000.0,
      "avgOrderValue": 526.0,
      "lastUpdated": "2024-12-11",
      "isActive": true,
    },
    {
      "id": "6",
      "name": "Inactive Customers",
      "description": "Customers with no recent activity",
      "color": "#757575",
      "customerCount": 234,
      "totalRevenue": 0.0,
      "avgOrderValue": 0.0,
      "lastUpdated": "2024-11-20",
      "isActive": false,
    },
  ];

  List<String> colorOptions = [
    "#2196F3", "#4CAF50", "#FF9800", "#F44336", "#9C27B0", 
    "#00BCD4", "#FFC107", "#795548", "#607D8B", "#E91E63"
  ];

  List<Map<String, dynamic>> get filteredCategories {
    if (searchQuery.isEmpty) return categories;
    return categories.where((category) {
      return category["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             category["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Category"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Category Name",
                value: newCategoryName,
                onChanged: (value) {
                  newCategoryName = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Description",
                value: newCategoryDescription,
                onChanged: (value) {
                  newCategoryDescription = value;
                  setState(() {});
                },
              ),
              Text(
                "Select Color",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: colorOptions.map((color) {
                  return GestureDetector(
                    onTap: () {
                      selectedCategoryColor = color;
                      setState(() {});
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(int.parse(color.substring(1), radix: 16) + 0xFF000000),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: selectedCategoryColor == color ? primaryColor : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: selectedCategoryColor == color 
                        ? Icon(Icons.check, color: Colors.white, size: 20)
                        : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              newCategoryName = "";
              newCategoryDescription = "";
              selectedCategoryColor = "#2196F3";
            },
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Category",
            size: bs.sm,
            onPressed: () {
              if (newCategoryName.isNotEmpty) {
                categories.add({
                  "id": DateTime.now().millisecondsSinceEpoch.toString(),
                  "name": newCategoryName,
                  "description": newCategoryDescription,
                  "color": selectedCategoryColor,
                  "customerCount": 0,
                  "totalRevenue": 0.0,
                  "avgOrderValue": 0.0,
                  "lastUpdated": DateTime.now().toIso8601String().substring(0, 10),
                  "isActive": true,
                });
                Navigator.pop(context);
                newCategoryName = "";
                newCategoryDescription = "";
                selectedCategoryColor = "#2196F3";
                setState(() {});
                ss("Category added successfully");
              }
            },
          ),
        ],
      ),
    );
  }

  void _deleteCategory(String categoryId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this category?");
    if (isConfirmed) {
      categories.removeWhere((category) => category["id"] == categoryId);
      setState(() {});
      ss("Category deleted successfully");
    }
  }

  Color _getColorFromHex(String hexColor) {
    return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Categories"),
        actions: [
          IconButton(
            onPressed: _showAddCategoryDialog,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.category,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Organize customers into categories for better management and targeted marketing",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Categories",
                    value: searchQuery,
                    hint: "Search by name or description...",
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
                  onPressed: () {
                    // Search functionality already implemented via filteredCategories
                  },
                ),
              ],
            ),

            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(color: successColor.withAlpha(100)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Active: ${categories.where((c) => c["isActive"] == true).length}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(color: disabledColor.withAlpha(100)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Inactive: ${categories.where((c) => c["isActive"] == false).length}",
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
            ),

            Column(
              spacing: spSm,
              children: filteredCategories.map((category) {
                Color categoryColor = _getColorFromHex(category["color"]);
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: categoryColor,
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: categoryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${category["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (category["isActive"] as bool) ? successColor.withAlpha(30) : disabledColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              (category["isActive"] as bool) ? "Active" : "Inactive",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: (category["isActive"] as bool) ? successColor : disabledBoldColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          PopupMenuButton(
                            icon: Icon(Icons.more_vert, color: disabledBoldColor, size: 20),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, size: 16),
                                    SizedBox(width: spXs),
                                    Text("Edit"),
                                  ],
                                ),
                                onTap: () {
                                  // Handle edit category
                                },
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: dangerColor, size: 16),
                                    SizedBox(width: spXs),
                                    Text("Delete", style: TextStyle(color: dangerColor)),
                                  ],
                                ),
                                onTap: () => _deleteCategory(category["id"]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      Text(
                        "${category["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${(category["customerCount"] as int).toString()}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Customers",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "\$${((category["totalRevenue"] as num).toDouble() / 1000).toStringAsFixed(0)}K",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "Revenue",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "\$${((category["avgOrderValue"] as num).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                  Text(
                                    "Avg Order",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Last updated: ${DateTime.parse(category["lastUpdated"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            if (filteredCategories.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No categories found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search terms or add a new category",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
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
