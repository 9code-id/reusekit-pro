import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaSavedOrdersView extends StatefulWidget {
  const FdaSavedOrdersView({super.key});

  @override
  State<FdaSavedOrdersView> createState() => _FdaSavedOrdersViewState();
}

class _FdaSavedOrdersViewState extends State<FdaSavedOrdersView> {
  String selectedTab = "All";
  
  List<Map<String, dynamic>> tabItems = [
    {"label": "All", "value": "All"},
    {"label": "Favorites", "value": "Favorites"},
    {"label": "Quick Orders", "value": "Quick Orders"},
    {"label": "Custom", "value": "Custom"},
  ];

  List<Map<String, dynamic>> savedOrders = [
    {
      "id": "saved_001",
      "name": "My Usual Breakfast",
      "restaurant": "Cafe Corner",
      "items": [
        {"name": "Avocado Toast", "quantity": 1},
        {"name": "Cappuccino", "quantity": 1},
        {"name": "Fresh Orange Juice", "quantity": 1},
      ],
      "totalPrice": 18.50,
      "lastOrdered": "2 days ago",
      "orderCount": 12,
      "category": "Favorites",
      "image": "https://picsum.photos/80/60?random=1&keyword=breakfast",
      "prepTime": "10-15 mins",
      "rating": 4.8,
      "tags": ["Healthy", "Vegetarian"],
    },
    {
      "id": "saved_002",
      "name": "Weekend Pizza Night",
      "restaurant": "Tony's Pizzeria",
      "items": [
        {"name": "Large Margherita Pizza", "quantity": 1},
        {"name": "Garlic Bread", "quantity": 1},
        {"name": "Caesar Salad", "quantity": 2},
        {"name": "Coca Cola 1.5L", "quantity": 1},
      ],
      "totalPrice": 42.75,
      "lastOrdered": "1 week ago",
      "orderCount": 8,
      "category": "Favorites",
      "image": "https://picsum.photos/80/60?random=2&keyword=pizza",
      "prepTime": "25-30 mins",
      "rating": 4.6,
      "tags": ["Family", "Italian"],
    },
    {
      "id": "saved_003",
      "name": "Quick Lunch",
      "restaurant": "Subway Express",
      "items": [
        {"name": "Turkey Sub 6-inch", "quantity": 1},
        {"name": "Chips", "quantity": 1},
        {"name": "Iced Tea", "quantity": 1},
      ],
      "totalPrice": 12.99,
      "lastOrdered": "Yesterday",
      "orderCount": 15,
      "category": "Quick Orders",
      "image": "https://picsum.photos/80/60?random=3&keyword=sandwich",
      "prepTime": "5-10 mins",
      "rating": 4.3,
      "tags": ["Fast", "Healthy"],
    },
    {
      "id": "saved_004",
      "name": "Sushi Date Night",
      "restaurant": "Sakura Sushi",
      "items": [
        {"name": "Salmon Sashimi Set", "quantity": 1},
        {"name": "California Roll", "quantity": 2},
        {"name": "Miso Soup", "quantity": 2},
        {"name": "Green Tea", "quantity": 2},
      ],
      "totalPrice": 65.00,
      "lastOrdered": "3 days ago",
      "orderCount": 5,
      "category": "Custom",
      "image": "https://picsum.photos/80/60?random=4&keyword=sushi",
      "prepTime": "20-25 mins",
      "rating": 4.9,
      "tags": ["Premium", "Japanese"],
    },
    {
      "id": "saved_005",
      "name": "Post-Workout Smoothie",
      "restaurant": "Juice Bar",
      "items": [
        {"name": "Protein Power Smoothie", "quantity": 1},
        {"name": "Energy Ball (3 pack)", "quantity": 1},
      ],
      "totalPrice": 14.25,
      "lastOrdered": "Today",
      "orderCount": 22,
      "category": "Quick Orders",
      "image": "https://picsum.photos/80/60?random=5&keyword=smoothie",
      "prepTime": "3-5 mins",
      "rating": 4.7,
      "tags": ["Healthy", "Protein"],
    },
    {
      "id": "saved_006",
      "name": "Office Lunch Share",
      "restaurant": "Deli Central",
      "items": [
        {"name": "Mixed Sandwich Platter", "quantity": 1},
        {"name": "Chips Variety Pack", "quantity": 1},
        {"name": "Fruit Salad Large", "quantity": 1},
        {"name": "Assorted Drinks (6 pack)", "quantity": 1},
      ],
      "totalPrice": 89.99,
      "lastOrdered": "4 days ago",
      "orderCount": 3,
      "category": "Custom",
      "image": "https://picsum.photos/80/60?random=6&keyword=catering",
      "prepTime": "45-60 mins",
      "rating": 4.4,
      "tags": ["Catering", "Office"],
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    if (selectedTab == "All") return savedOrders;
    return savedOrders.where((order) => order["category"] == selectedTab).toList();
  }

  void _reorderItem(Map<String, dynamic> order) {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Order has been added to your cart!");
    });
  }

  void _editOrder(Map<String, dynamic> order) {
    // Navigate to edit order
  }

  void _deleteOrder(String orderId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this saved order?");
    if (isConfirmed) {
      savedOrders.removeWhere((order) => order["id"] == orderId);
      setState(() {});
      ss("Saved order deleted successfully");
    }
  }

  void _showOrderOptions(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledOutlineBorderColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "${order["name"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ListTile(
              leading: Icon(Icons.shopping_cart, color: primaryColor),
              title: Text("Reorder"),
              subtitle: Text("Add to cart and checkout"),
              onTap: () {
                Navigator.pop(context);
                _reorderItem(order);
              },
            ),
            
            ListTile(
              leading: Icon(Icons.edit, color: infoColor),
              title: Text("Edit Order"),
              subtitle: Text("Modify items and save"),
              onTap: () {
                Navigator.pop(context);
                _editOrder(order);
              },
            ),
            
            ListTile(
              leading: Icon(Icons.share, color: successColor),
              title: Text("Share Order"),
              subtitle: Text("Share with friends or family"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete"),
              subtitle: Text("Remove from saved orders"),
              onTap: () {
                Navigator.pop(context);
                _deleteOrder(order["id"]);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Summary Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${savedOrders.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Saved Orders",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${savedOrders.fold(0, (sum, order) => sum + (order["orderCount"] as int))}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Reorders",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "\$${((savedOrders.fold(0.0, (sum, order) => sum + (order["totalPrice"] as double))) / savedOrders.length).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Avg. Order",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Category Filter
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Filter by Category",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QCategoryPicker(
                  items: tabItems,
                  value: selectedTab,
                  onChanged: (index, label, value, item) {
                    selectedTab = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Saved Orders List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      selectedTab == "All" ? "All Saved Orders" : selectedTab,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${filteredOrders.length} orders",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                if (filteredOrders.isEmpty)
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.bookmark_border,
                          size: 48,
                          color: disabledBoldColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No saved orders found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Save your favorite orders for quick reordering",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    spacing: spSm,
                    children: filteredOrders.map((order) {
                      final items = order["items"] as List;
                      final tags = order["tags"] as List;
                      
                      return GestureDetector(
                        onTap: () => _showOrderOptions(order),
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            spacing: spSm,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    child: Image.network(
                                      "${order["image"]}",
                                      width: 80,
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
                                                "${order["name"]}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: primaryColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "${order["category"]}",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${order["restaurant"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.star, color: warningColor, size: 12),
                                            SizedBox(width: 2),
                                            Text(
                                              "${order["rating"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            SizedBox(width: spSm),
                                            Icon(Icons.access_time, color: disabledBoldColor, size: 12),
                                            SizedBox(width: 2),
                                            Text(
                                              "${order["prepTime"]}",
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        "\$${(order["totalPrice"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${order["orderCount"]} times",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "Last: ${order["lastOrdered"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              
                              // Items List
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Items (${items.length}):",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    ...items.take(3).map((item) {
                                      return Text(
                                        "• ${item["quantity"]}x ${item["name"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      );
                                    }).toList(),
                                    if (items.length > 3)
                                      Text(
                                        "... and ${items.length - 3} more items",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              
                              // Tags and Action
                              Row(
                                children: [
                                  Expanded(
                                    child: Wrap(
                                      spacing: spXs,
                                      runSpacing: spXs,
                                      children: tags.map((tag) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: successColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "$tag",
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: successColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  QButton(
                                    label: "Reorder",
                                    size: bs.sm,
                                    onPressed: () => _reorderItem(order),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Pro Tips",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Save time by reordering your favorite meals\n• Edit saved orders to try new variations\n• Share your favorite combinations with friends\n• Use quick orders for fast checkout",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
