import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsMenuCategoriesView extends StatefulWidget {
  const RfsMenuCategoriesView({super.key});

  @override
  State<RfsMenuCategoriesView> createState() => _RfsMenuCategoriesViewState();
}

class _RfsMenuCategoriesViewState extends State<RfsMenuCategoriesView> {
  String searchQuery = "";
  
  List<Map<String, dynamic>> categories = [
    {
      "id": "CAT001",
      "name": "Appetizers",
      "description": "Start your meal with our delicious appetizers",
      "itemCount": 12,
      "status": "Active",
      "sortOrder": 1,
      "color": primaryColor,
      "icon": Icons.restaurant,
      "image": "https://picsum.photos/300/200?random=1&keyword=appetizers",
      "averagePrice": 9.99,
      "popularItems": ["Caesar Salad", "Chicken Wings", "Bruschetta"],
    },
    {
      "id": "CAT002",
      "name": "Main Course",
      "description": "Hearty and satisfying main dishes for every taste",
      "itemCount": 24,
      "status": "Active",
      "sortOrder": 2,
      "color": successColor,
      "icon": Icons.dinner_dining,
      "image": "https://picsum.photos/300/200?random=2&keyword=maincourse",
      "averagePrice": 22.99,
      "popularItems": ["Grilled Salmon", "Beef Burger", "Chicken Alfredo"],
    },
    {
      "id": "CAT003",
      "name": "Beverages",
      "description": "Refreshing drinks to complement your meal",
      "itemCount": 18,
      "status": "Active",
      "sortOrder": 3,
      "color": infoColor,
      "icon": Icons.local_drink,
      "image": "https://picsum.photos/300/200?random=3&keyword=beverages",
      "averagePrice": 4.99,
      "popularItems": ["Fresh Orange Juice", "Coffee", "Iced Tea"],
    },
    {
      "id": "CAT004",
      "name": "Desserts",
      "description": "Sweet endings to your perfect meal",
      "itemCount": 8,
      "status": "Active",
      "sortOrder": 4,
      "color": warningColor,
      "icon": Icons.cake,
      "image": "https://picsum.photos/300/200?random=4&keyword=desserts",
      "averagePrice": 7.99,
      "popularItems": ["Chocolate Lava Cake", "Tiramisu", "Ice Cream"],
    },
    {
      "id": "CAT005",
      "name": "Salads",
      "description": "Fresh and healthy salad options",
      "itemCount": 6,
      "status": "Active",
      "sortOrder": 5,
      "color": successColor,
      "icon": Icons.eco,
      "image": "https://picsum.photos/300/200?random=5&keyword=salads",
      "averagePrice": 12.99,
      "popularItems": ["Greek Salad", "Garden Fresh", "Quinoa Bowl"],
    },
    {
      "id": "CAT006",
      "name": "Pizza",
      "description": "Wood-fired pizzas with premium toppings",
      "itemCount": 10,
      "status": "Inactive",
      "sortOrder": 6,
      "color": dangerColor,
      "icon": Icons.local_pizza,
      "image": "https://picsum.photos/300/200?random=6&keyword=pizza",
      "averagePrice": 16.99,
      "popularItems": ["Margherita", "Pepperoni", "BBQ Chicken"],
    },
    {
      "id": "CAT007",
      "name": "Soups",
      "description": "Warm and comforting soup selections",
      "itemCount": 5,
      "status": "Active",
      "sortOrder": 7,
      "color": warningColor,
      "icon": Icons.soup_kitchen,
      "image": "https://picsum.photos/300/200?random=7&keyword=soup",
      "averagePrice": 8.99,
      "popularItems": ["Tomato Basil", "Chicken Noodle", "Mushroom"],
    },
    {
      "id": "CAT008",
      "name": "Seafood",
      "description": "Fresh seafood prepared to perfection",
      "itemCount": 14,
      "status": "Active",
      "sortOrder": 8,
      "color": infoColor,
      "icon": Icons.set_meal,
      "image": "https://picsum.photos/300/200?random=8&keyword=seafood",
      "averagePrice": 28.99,
      "popularItems": ["Grilled Salmon", "Fish & Chips", "Shrimp Pasta"],
    },
  ];

  List<Map<String, dynamic>> get filteredCategories {
    if (searchQuery.isEmpty) return categories;
    return categories.where((category) {
      return category["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             category["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  List<Map<String, dynamic>> get activeCategoriesStats {
    final activeCategories = categories.where((cat) => cat["status"] == "Active").toList();
    final totalItems = activeCategories.fold(0, (sum, cat) => sum + (cat["itemCount"] as int));
    
    return [
      {
        "title": "Total Categories",
        "value": categories.length,
        "icon": Icons.category,
        "color": primaryColor,
      },
      {
        "title": "Active Categories",
        "value": activeCategories.length,
        "icon": Icons.check_circle,
        "color": successColor,
      },
      {
        "title": "Total Menu Items",
        "value": totalItems,
        "icon": Icons.restaurant_menu,
        "color": infoColor,
      },
      {
        "title": "Avg Items/Category",
        "value": activeCategories.isNotEmpty ? (totalItems / activeCategories.length).round() : 0,
        "icon": Icons.analytics,
        "color": warningColor,
      },
    ];
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _toggleCategoryStatus(String categoryId) {
    setState(() {
      int index = categories.indexWhere((cat) => cat["id"] == categoryId);
      if (index != -1) {
        String currentStatus = categories[index]["status"];
        categories[index]["status"] = currentStatus == "Active" ? "Inactive" : "Active";
      }
    });
    ss("Category status updated successfully");
  }

  void _editCategory(Map<String, dynamic> category) {
    si("Edit category: ${category["name"]}");
    // Navigate to edit category view
  }

  void _deleteCategory(String categoryId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this category?");
    if (isConfirmed) {
      setState(() {
        categories.removeWhere((cat) => cat["id"] == categoryId);
      });
      ss("Category deleted successfully");
    }
  }

  void _viewCategoryItems(Map<String, dynamic> category) {
    si("View items in category: ${category["name"]}");
    // Navigate to category items view
  }

  void _reorderCategories() {
    si("Reorder categories");
    // Show reorder dialog or navigate to reorder view
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Categories"),
        actions: [
          QButton(
            icon: Icons.sort,
            size: bs.sm,
            onPressed: _reorderCategories,
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              si("Add new category");
              // Navigate to add category view
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categories Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: activeCategoriesStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (stat["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          stat["icon"] as IconData,
                          color: stat["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${stat["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),
            
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search categories...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  height: 50,
                  child: QButton(
                    icon: Icons.search,
                    size: bs.sm,
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),
            
            Row(
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredCategories.length} categories",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            Column(
              children: filteredCategories.map((category) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                              child: Image.network(
                                "${category["image"]}",
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusMd),
                                  topRight: Radius.circular(radiusMd),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withAlpha(100),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(category["status"]).withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${category["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: spXs,
                              left: spXs,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: (category["color"] as Color).withAlpha(200),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      category["icon"] as IconData,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${category["name"]}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "${category["itemCount"]} items",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${category["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  size: 16,
                                  color: successColor,
                                ),
                                Text(
                                  "Avg: \$${((category["averagePrice"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Order #${category["sortOrder"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            
                            Text(
                              "Popular Items:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Wrap(
                              spacing: spXs,
                              children: (category["popularItems"] as List).map((item) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$item",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: spSm),
                            
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Items",
                                    size: bs.sm,
                                    onPressed: () => _viewCategoryItems(category),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.edit,
                                  size: bs.sm,
                                  onPressed: () => _editCategory(category),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: category["status"] == "Active" 
                                      ? Icons.pause 
                                      : Icons.play_arrow,
                                  size: bs.sm,
                                  onPressed: () => _toggleCategoryStatus(category["id"]),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.delete,
                                  size: bs.sm,
                                  onPressed: () => _deleteCategory(category["id"]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
