import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsMenuItemsView extends StatefulWidget {
  const RfsMenuItemsView({super.key});

  @override
  State<RfsMenuItemsView> createState() => _RfsMenuItemsViewState();
}

class _RfsMenuItemsViewState extends State<RfsMenuItemsView> {
  String selectedCategory = "All";
  String selectedStatus = "All";
  String sortBy = "Name";
  String searchQuery = "";
  
  List<String> categories = ["All", "Appetizers", "Main Course", "Beverages", "Desserts", "Salads", "Pizza", "Seafood"];
  List<String> statusOptions = ["All", "Active", "Inactive", "Out of Stock"];
  List<String> sortOptions = ["Name", "Price", "Category", "Popularity", "Date Added"];
  
  List<Map<String, dynamic>> menuItems = [
    {
      "id": "ITEM001",
      "name": "Grilled Salmon with Herbs",
      "category": "Main Course",
      "price": 28.99,
      "status": "Active",
      "description": "Fresh Atlantic salmon grilled to perfection with garden herbs and lemon",
      "ingredients": ["Salmon", "Mixed Herbs", "Lemon", "Olive Oil", "Garlic"],
      "allergens": ["Fish"],
      "calories": 320,
      "preparationTime": "15 min",
      "cookingInstructions": "Grill salmon for 6-8 minutes each side. Season with herbs.",
      "image": "https://picsum.photos/300/200?random=1&keyword=salmon",
      "popularity": 95,
      "stockStatus": "In Stock",
      "cost": 12.50,
      "margin": 132,
      "dateAdded": "2024-01-10",
      "lastModified": "2024-01-15",
      "nutritionInfo": {
        "protein": "25g",
        "carbs": "2g",
        "fat": "18g",
        "fiber": "0g",
      },
    },
    {
      "id": "ITEM002",
      "name": "Caesar Salad Classic",
      "category": "Appetizers",
      "price": 14.99,
      "status": "Active",
      "description": "Crisp romaine lettuce with classic Caesar dressing, parmesan, and croutons",
      "ingredients": ["Romaine Lettuce", "Parmesan Cheese", "Croutons", "Caesar Dressing", "Anchovies"],
      "allergens": ["Dairy", "Gluten", "Fish"],
      "calories": 180,
      "preparationTime": "5 min",
      "cookingInstructions": "Toss lettuce with dressing, add cheese and croutons.",
      "image": "https://picsum.photos/300/200?random=2&keyword=salad",
      "popularity": 87,
      "stockStatus": "In Stock",
      "cost": 4.50,
      "margin": 233,
      "dateAdded": "2024-01-08",
      "lastModified": "2024-01-12",
      "nutritionInfo": {
        "protein": "8g",
        "carbs": "12g",
        "fat": "14g",
        "fiber": "4g",
      },
    },
    {
      "id": "ITEM003",
      "name": "Chocolate Lava Cake",
      "category": "Desserts",
      "price": 9.99,
      "status": "Active",
      "description": "Warm chocolate cake with molten center, served with vanilla ice cream",
      "ingredients": ["Dark Chocolate", "Butter", "Eggs", "Flour", "Sugar", "Vanilla Ice Cream"],
      "allergens": ["Dairy", "Eggs", "Gluten"],
      "calories": 450,
      "preparationTime": "12 min",
      "cookingInstructions": "Bake for 12 minutes at 425°F. Serve immediately with ice cream.",
      "image": "https://picsum.photos/300/200?random=3&keyword=chocolate",
      "popularity": 92,
      "stockStatus": "In Stock",
      "cost": 3.25,
      "margin": 207,
      "dateAdded": "2024-01-05",
      "lastModified": "2024-01-14",
      "nutritionInfo": {
        "protein": "6g",
        "carbs": "58g",
        "fat": "22g",
        "fiber": "3g",
      },
    },
    {
      "id": "ITEM004",
      "name": "Fresh Orange Juice",
      "category": "Beverages",
      "price": 4.99,
      "status": "Out of Stock",
      "description": "Freshly squeezed orange juice from premium Valencia oranges",
      "ingredients": ["Fresh Oranges"],
      "allergens": [],
      "calories": 110,
      "preparationTime": "2 min",
      "cookingInstructions": "Squeeze oranges fresh to order. Serve over ice.",
      "image": "https://picsum.photos/300/200?random=4&keyword=orange",
      "popularity": 78,
      "stockStatus": "Out of Stock",
      "cost": 1.50,
      "margin": 233,
      "dateAdded": "2024-01-12",
      "lastModified": "2024-01-16",
      "nutritionInfo": {
        "protein": "2g",
        "carbs": "26g",
        "fat": "0g",
        "fiber": "0g",
      },
    },
    {
      "id": "ITEM005",
      "name": "Beef Burger Deluxe",
      "category": "Main Course",
      "price": 19.99,
      "status": "Active",
      "description": "Premium beef patty with aged cheddar, lettuce, tomato, and special sauce",
      "ingredients": ["Beef Patty", "Cheddar Cheese", "Lettuce", "Tomato", "Special Sauce", "Brioche Bun"],
      "allergens": ["Dairy", "Gluten", "Eggs"],
      "calories": 580,
      "preparationTime": "10 min",
      "cookingInstructions": "Grill patty to medium. Toast bun. Assemble with fresh toppings.",
      "image": "https://picsum.photos/300/200?random=5&keyword=burger",
      "popularity": 89,
      "stockStatus": "Low Stock",
      "cost": 8.75,
      "margin": 128,
      "dateAdded": "2024-01-07",
      "lastModified": "2024-01-13",
      "nutritionInfo": {
        "protein": "32g",
        "carbs": "45g",
        "fat": "28g",
        "fiber": "3g",
      },
    },
    {
      "id": "ITEM006",
      "name": "Margherita Pizza",
      "category": "Pizza",
      "price": 16.99,
      "status": "Inactive",
      "description": "Classic Neapolitan pizza with San Marzano tomatoes, fresh mozzarella, and basil",
      "ingredients": ["Pizza Dough", "San Marzano Tomatoes", "Fresh Mozzarella", "Fresh Basil", "Olive Oil"],
      "allergens": ["Dairy", "Gluten"],
      "calories": 290,
      "preparationTime": "18 min",
      "cookingInstructions": "Bake in wood-fired oven at 900°F for 90 seconds.",
      "image": "https://picsum.photos/300/200?random=6&keyword=pizza",
      "popularity": 85,
      "stockStatus": "In Stock",
      "cost": 6.25,
      "margin": 172,
      "dateAdded": "2024-01-03",
      "lastModified": "2024-01-11",
      "nutritionInfo": {
        "protein": "12g",
        "carbs": "36g",
        "fat": "12g",
        "fiber": "2g",
      },
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> filtered = menuItems.where((item) {
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || 
                          (selectedStatus == "Out of Stock" ? item["stockStatus"] == "Out of Stock" : item["status"] == selectedStatus);
      bool matchesSearch = searchQuery.isEmpty || 
          item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["ingredients"] as List).any((ingredient) => 
              ingredient.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      
      return matchesCategory && matchesStatus && matchesSearch;
    }).toList();

    // Sort filtered items
    filtered.sort((a, b) {
      switch (sortBy) {
        case "Name":
          return a["name"].toString().compareTo(b["name"].toString());
        case "Price":
          return (a["price"] as num).compareTo(b["price"] as num);
        case "Category":
          return a["category"].toString().compareTo(b["category"].toString());
        case "Popularity":
          return (b["popularity"] as num).compareTo(a["popularity"] as num);
        case "Date Added":
          return DateTime.parse(b["dateAdded"]).compareTo(DateTime.parse(a["dateAdded"]));
        default:
          return 0;
      }
    });

    return filtered;
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

  void _viewItemDetails(Map<String, dynamic> item) {
    si("View details for: ${item["name"]}");
    // Navigate to item details view
  }

  void _editItem(Map<String, dynamic> item) {
    si("Edit item: ${item["name"]}");
    // Navigate to edit item view
  }

  void _toggleItemStatus(String itemId) {
    setState(() {
      int index = menuItems.indexWhere((item) => item["id"] == itemId);
      if (index != -1) {
        String currentStatus = menuItems[index]["status"];
        menuItems[index]["status"] = currentStatus == "Active" ? "Inactive" : "Active";
        menuItems[index]["lastModified"] = DateTime.now().toString().split(' ')[0];
      }
    });
    ss("Item status updated successfully");
  }

  void _duplicateItem(Map<String, dynamic> item) {
    setState(() {
      Map<String, dynamic> newItem = Map.from(item);
      newItem["id"] = "ITEM${DateTime.now().millisecondsSinceEpoch}";
      newItem["name"] = "${item["name"]} (Copy)";
      newItem["dateAdded"] = DateTime.now().toString().split(' ')[0];
      newItem["lastModified"] = DateTime.now().toString().split(' ')[0];
      menuItems.add(newItem);
    });
    ss("Item duplicated successfully");
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
        title: Text("Menu Items"),
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search items...",
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
                
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories.map((cat) => {
                          "label": cat,
                          "value": cat,
                        }).toList(),
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
                        items: statusOptions.map((status) => {
                          "label": status,
                          "value": status,
                        }).toList(),
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort by",
                        items: sortOptions.map((sort) => {
                          "label": sort,
                          "value": sort,
                        }).toList(),
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: primaryColor.withAlpha(10),
            child: Row(
              children: [
                Text(
                  "${filteredItems.length} items found",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Sorted by $sortBy",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 120,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                bottomLeft: Radius.circular(radiusMd),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                bottomLeft: Radius.circular(radiusMd),
                              ),
                              child: Image.network(
                                "${item["image"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${item["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(
                                            item["stockStatus"] == "Out of Stock" 
                                                ? item["stockStatus"] 
                                                : item["status"]
                                          ).withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          item["stockStatus"] == "Out of Stock" 
                                              ? "${item["stockStatus"]}" 
                                              : "${item["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor(
                                              item["stockStatus"] == "Out of Stock" 
                                                  ? item["stockStatus"] 
                                                  : item["status"]
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                                  SizedBox(height: spXs),
                                  
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        size: 12,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${item["preparationTime"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        Icons.local_fire_department,
                                        size: 12,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${item["calories"]} cal",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Popularity: ${item["popularity"]}%",
                                        style: TextStyle(
                                          fontSize: 10,
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radiusMd),
                            bottomRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Details",
                                size: bs.sm,
                                onPressed: () => _viewItemDetails(item),
                              ),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () => _editItem(item),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.copy,
                              size: bs.sm,
                              onPressed: () => _duplicateItem(item),
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
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
