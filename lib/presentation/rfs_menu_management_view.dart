import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsMenuManagementView extends StatefulWidget {
  const RfsMenuManagementView({super.key});

  @override
  State<RfsMenuManagementView> createState() => _RfsMenuManagementViewState();
}

class _RfsMenuManagementViewState extends State<RfsMenuManagementView> {
  String selectedCategory = "All";
  String searchQuery = "";
  
  List<String> categories = ["All", "Appetizers", "Main Course", "Beverages", "Desserts"];
  
  List<Map<String, dynamic>> menuStats = [
    {
      "title": "Total Items",
      "value": 124,
      "icon": Icons.restaurant_menu,
      "color": primaryColor,
      "change": "+5 items",
      "isPositive": true,
    },
    {
      "title": "Active Items",
      "value": 118,
      "icon": Icons.check_circle,
      "color": successColor,
      "change": "95%",
      "isPositive": true,
    },
    {
      "title": "Out of Stock",
      "value": 6,
      "icon": Icons.remove_circle,
      "color": dangerColor,
      "change": "-2 items",
      "isPositive": true,
    },
    {
      "title": "Categories",
      "value": 8,
      "icon": Icons.category,
      "color": infoColor,
      "change": "Complete",
      "isPositive": true,
    },
  ];

  List<Map<String, dynamic>> menuItems = [
    {
      "id": "ITEM001",
      "name": "Grilled Salmon with Herbs",
      "category": "Main Course",
      "price": 28.99,
      "status": "Active",
      "description": "Fresh Atlantic salmon grilled to perfection with garden herbs",
      "ingredients": ["Salmon", "Herbs", "Lemon", "Olive Oil"],
      "calories": 320,
      "preparationTime": "15 min",
      "allergens": ["Fish"],
      "image": "https://picsum.photos/200/150?random=1&keyword=salmon",
      "popularity": 95,
      "stockStatus": "In Stock",
    },
    {
      "id": "ITEM002",
      "name": "Caesar Salad Classic",
      "category": "Appetizers",
      "price": 14.99,
      "status": "Active",
      "description": "Crisp romaine lettuce with classic Caesar dressing and croutons",
      "ingredients": ["Romaine", "Parmesan", "Croutons", "Caesar Dressing"],
      "calories": 180,
      "preparationTime": "5 min",
      "allergens": ["Dairy", "Gluten"],
      "image": "https://picsum.photos/200/150?random=2&keyword=salad",
      "popularity": 87,
      "stockStatus": "In Stock",
    },
    {
      "id": "ITEM003",
      "name": "Chocolate Lava Cake",
      "category": "Desserts",
      "price": 9.99,
      "status": "Active",
      "description": "Warm chocolate cake with molten center, served with vanilla ice cream",
      "ingredients": ["Dark Chocolate", "Butter", "Eggs", "Flour", "Ice Cream"],
      "calories": 450,
      "preparationTime": "12 min",
      "allergens": ["Dairy", "Eggs", "Gluten"],
      "image": "https://picsum.photos/200/150?random=3&keyword=chocolate",
      "popularity": 92,
      "stockStatus": "In Stock",
    },
    {
      "id": "ITEM004",
      "name": "Fresh Orange Juice",
      "category": "Beverages",
      "price": 4.99,
      "status": "Out of Stock",
      "description": "Freshly squeezed orange juice from premium oranges",
      "ingredients": ["Fresh Oranges"],
      "calories": 110,
      "preparationTime": "2 min",
      "allergens": [],
      "image": "https://picsum.photos/200/150?random=4&keyword=orange",
      "popularity": 78,
      "stockStatus": "Out of Stock",
    },
    {
      "id": "ITEM005",
      "name": "Beef Burger Deluxe",
      "category": "Main Course",
      "price": 19.99,
      "status": "Active",
      "description": "Premium beef patty with cheese, lettuce, tomato, and special sauce",
      "ingredients": ["Beef Patty", "Cheese", "Lettuce", "Tomato", "Bun"],
      "calories": 580,
      "preparationTime": "10 min",
      "allergens": ["Dairy", "Gluten"],
      "image": "https://picsum.photos/200/150?random=5&keyword=burger",
      "popularity": 89,
      "stockStatus": "Low Stock",
    },
    {
      "id": "ITEM006",
      "name": "Margherita Pizza",
      "category": "Main Course",
      "price": 16.99,
      "status": "Inactive",
      "description": "Classic pizza with tomato sauce, mozzarella, and fresh basil",
      "ingredients": ["Pizza Dough", "Tomato Sauce", "Mozzarella", "Basil"],
      "calories": 290,
      "preparationTime": "18 min",
      "allergens": ["Dairy", "Gluten"],
      "image": "https://picsum.photos/200/150?random=6&keyword=pizza",
      "popularity": 85,
      "stockStatus": "In Stock",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return menuItems.where((item) {
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return warningColor;
      case "Out of Stock":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStockColor(String stockStatus) {
    switch (stockStatus) {
      case "In Stock":
        return successColor;
      case "Low Stock":
        return warningColor;
      case "Out of Stock":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _toggleItemStatus(String itemId) {
    setState(() {
      int index = menuItems.indexWhere((item) => item["id"] == itemId);
      if (index != -1) {
        String currentStatus = menuItems[index]["status"];
        menuItems[index]["status"] = currentStatus == "Active" ? "Inactive" : "Active";
      }
    });
    ss("Item status updated successfully");
  }

  void _editItem(Map<String, dynamic> item) {
    si("Edit item: ${item["name"]}");
    // Navigate to edit item view
  }

  void _deleteItem(String itemId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this menu item?");
    if (isConfirmed) {
      setState(() {
        menuItems.removeWhere((item) => item["id"] == itemId);
      });
      ss("Menu item deleted successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              si("Add new menu item");
              // Navigate to add item view
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
              "Menu Overview",
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
              children: menuStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
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
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (stat["isPositive"] as bool)
                                  ? successColor.withAlpha(30)
                                  : dangerColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${stat["change"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (stat["isPositive"] as bool)
                                    ? successColor
                                    : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    label: "Search menu items...",
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
            SizedBox(height: spSm),
            
            QCategoryPicker(
              label: "Filter by Category",
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            
            Row(
              children: [
                Text(
                  "Menu Items",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredItems.length} items",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredItems.map((item) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                              child: Image.network(
                                "${item["image"]}",
                                fit: BoxFit.cover,
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
                                color: _getStatusColor(item["status"]).withAlpha(200),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spXs,
                            left: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getStockColor(item["stockStatus"]).withAlpha(200),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["stockStatus"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Padding(
                        padding: EdgeInsets.all(spSm),
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
                            
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "\$${((item["price"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            
                            Text(
                              "${item["description"]}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${item["preparationTime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.local_fire_department,
                                  size: 14,
                                  color: warningColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${item["calories"]} cal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            
                            Row(
                              children: [
                                Text(
                                  "Popularity: ${item["popularity"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: item["popularity"] >= 90 
                                        ? successColor 
                                        : item["popularity"] >= 70 
                                            ? warningColor 
                                            : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Edit",
                                    size: bs.sm,
                                    onPressed: () => _editItem(item),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: item["status"] == "Active" 
                                      ? Icons.pause 
                                      : Icons.play_arrow,
                                  size: bs.sm,
                                  onPressed: () => _toggleItemStatus(item["id"]),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.delete,
                                  size: bs.sm,
                                  onPressed: () => _deleteItem(item["id"]),
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
