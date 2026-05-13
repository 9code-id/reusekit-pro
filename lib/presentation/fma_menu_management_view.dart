import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaMenuManagementView extends StatefulWidget {
  const FmaMenuManagementView({super.key});

  @override
  State<FmaMenuManagementView> createState() => _FmaMenuManagementViewState();
}

class _FmaMenuManagementViewState extends State<FmaMenuManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  bool isDietary = false;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All"},
    {"label": "Appetizers", "value": "appetizers"},
    {"label": "Main Course", "value": "main_course"},
    {"label": "Desserts", "value": "desserts"},
    {"label": "Beverages", "value": "beverages"},
    {"label": "Sides", "value": "sides"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Available", "value": "available"},
    {"label": "Unavailable", "value": "unavailable"},
    {"label": "Seasonal", "value": "seasonal"},
  ];

  List<Map<String, dynamic>> menuItems = [
    {
      "id": "MENU001",
      "name": "Grilled Salmon",
      "category": "main_course",
      "price": 24.99,
      "cost": 12.50,
      "description": "Fresh Atlantic salmon grilled to perfection with herbs",
      "preparation_time": 20,
      "calories": 350,
      "ingredients": ["Salmon", "Herbs", "Lemon", "Olive Oil"],
      "allergens": ["Fish"],
      "dietary": ["Gluten-Free", "Keto"],
      "status": "available",
      "popularity": 85,
      "image_url": "https://picsum.photos/200/150?random=1&keyword=salmon",
    },
    {
      "id": "MENU002",
      "name": "Caesar Salad",
      "category": "appetizers",
      "price": 12.99,
      "cost": 4.50,
      "description": "Classic Caesar salad with crispy croutons",
      "preparation_time": 10,
      "calories": 280,
      "ingredients": ["Romaine", "Parmesan", "Croutons", "Caesar Dressing"],
      "allergens": ["Dairy", "Gluten"],
      "dietary": ["Vegetarian"],
      "status": "available",
      "popularity": 92,
      "image_url": "https://picsum.photos/200/150?random=2&keyword=salad",
    },
    {
      "id": "MENU003",
      "name": "Chocolate Lava Cake",
      "category": "desserts",
      "price": 8.99,
      "cost": 3.25,
      "description": "Warm chocolate cake with molten center",
      "preparation_time": 15,
      "calories": 420,
      "ingredients": ["Chocolate", "Flour", "Butter", "Eggs"],
      "allergens": ["Dairy", "Gluten", "Eggs"],
      "dietary": ["Vegetarian"],
      "status": "unavailable",
      "popularity": 78,
      "image_url": "https://picsum.photos/200/150?random=3&keyword=chocolate",
    },
    {
      "id": "MENU004",
      "name": "Fresh Orange Juice",
      "category": "beverages",
      "price": 4.99,
      "cost": 1.50,
      "description": "Freshly squeezed orange juice",
      "preparation_time": 5,
      "calories": 110,
      "ingredients": ["Orange"],
      "allergens": [],
      "dietary": ["Vegan", "Gluten-Free"],
      "status": "seasonal",
      "popularity": 65,
      "image_url": "https://picsum.photos/200/150?random=4&keyword=orange",
    },
  ];

  List<Map<String, dynamic>> nutritionCategories = [
    {"name": "High Protein", "count": 8, "color": successColor},
    {"name": "Low Carb", "count": 12, "color": infoColor},
    {"name": "Gluten-Free", "count": 15, "color": warningColor},
    {"name": "Vegan", "count": 6, "color": primaryColor},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Menu Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Items", icon: Icon(Icons.restaurant_menu)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Nutrition", icon: Icon(Icons.health_and_safety)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildItemsTab(),
        _buildCategoriesTab(),
        _buildNutritionTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildItemsTab() {
    List<Map<String, dynamic>> filteredItems = menuItems.where((item) {
      bool matchesSearch = item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || item["status"] == selectedStatus;
      bool matchesDietary = !isDietary || (item["dietary"] as List).isNotEmpty;
      return matchesSearch && matchesCategory && matchesStatus && matchesDietary;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search Menu Items",
                  value: searchQuery,
                  hint: "Search by item name...",
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
                QSwitch(
                  items: [
                    {
                      "label": "Show Dietary Options Only",
                      "value": true,
                      "checked": isDietary,
                    }
                  ],
                  value: [if (isDietary) {"label": "Show Dietary Options Only", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    isDietary = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Menu Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Menu Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor.withAlpha(100)),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${menuItems.length}",
                              style: TextStyle(
                                fontSize: 24,
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
                          border: Border.all(color: successColor.withAlpha(100)),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${menuItems.where((item) => item["status"] == "available").length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Available",
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
                ),
              ],
            ),
          ),

          // Add New Item Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Menu Item",
              size: bs.md,
              onPressed: () {
                // Navigate to add item form
              },
            ),
          ),

          // Menu Items List
          ...filteredItems.map((item) {
            Color statusColor = _getStatusColor(item["status"]);
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${item["image_url"]}",
                          width: 80,
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
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${item["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: statusColor,
                            fontWeight: FontWeight.w600,
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
                              "Price",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${((item["price"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
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
                              "Prep Time",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${item["preparation_time"]} min",
                              style: TextStyle(
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
                              "Popularity",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${item["popularity"]}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if ((item["dietary"] as List).isNotEmpty)
                    Wrap(
                      spacing: spXs,
                      children: (item["dietary"] as List).map((diet) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$diet",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Edit",
                          size: bs.sm,
                          onPressed: () {
                            // Edit item
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Duplicate",
                          size: bs.sm,
                          onPressed: () {
                            // Duplicate item
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    Map<String, List<Map<String, dynamic>>> categorizedItems = {};
    for (var item in menuItems) {
      String category = item["category"];
      if (!categorizedItems.containsKey(category)) {
        categorizedItems[category] = [];
      }
      categorizedItems[category]!.add(item);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Category Overview
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Category Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...categorizedItems.entries.map((entry) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor.withAlpha(100)),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${entry.key}".replaceAll("_", " ").split(" ").map((word) => word[0].toUpperCase() + word.substring(1)).join(" "),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${entry.value.length} items",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Add Category Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Category",
              size: bs.md,
              onPressed: () {
                // Add new category
              },
            ),
          ),

          // Category Management
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Category Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Reorder Categories",
                    size: bs.md,
                    onPressed: () {
                      // Reorder categories
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Bulk Category Update",
                    size: bs.md,
                    onPressed: () {
                      // Bulk update
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Nutrition Overview
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Nutrition Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...nutritionCategories.map((category) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border.all(color: (category["color"] as Color).withAlpha(100)),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.health_and_safety,
                          color: category["color"] as Color,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${category["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (category["color"] as Color).withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${category["count"]} items",
                            style: TextStyle(
                              fontSize: 10,
                              color: category["color"] as Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Allergen Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Common Allergens",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Wrap(
                  spacing: spSm,
                  runSpacing: spSm,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: dangerColor.withAlpha(100)),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.warning, color: dangerColor, size: 20),
                          SizedBox(height: spXs),
                          Text(
                            "Dairy",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: dangerColor.withAlpha(100)),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.warning, color: dangerColor, size: 20),
                          SizedBox(height: spXs),
                          Text(
                            "Gluten",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: dangerColor.withAlpha(100)),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.warning, color: dangerColor, size: 20),
                          SizedBox(height: spXs),
                          Text(
                            "Nuts",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
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

          // Nutrition Tools
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Nutrition Tools",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Generate Nutrition Report",
                    size: bs.md,
                    onPressed: () {
                      // Generate nutrition report
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Update Nutrition Facts",
                    size: bs.md,
                    onPressed: () {
                      // Update nutrition facts
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Popular Items
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Top Performing Items",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...menuItems.where((item) => (item["popularity"] as int) > 80).map((item) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border.all(color: successColor.withAlpha(100)),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["popularity"]}%",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Revenue Analysis
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Revenue Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "\$2,847.92",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Total menu revenue this month",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Export Options
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Export & Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Export Menu (PDF)",
                    size: bs.md,
                    onPressed: () {
                      // Export menu PDF
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Export Analytics Report",
                    size: bs.md,
                    onPressed: () {
                      // Export analytics
                    },
                  ),
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
      case "available":
        return successColor;
      case "unavailable":
        return dangerColor;
      case "seasonal":
        return warningColor;
      default:
        return primaryColor;
    }
  }
}
