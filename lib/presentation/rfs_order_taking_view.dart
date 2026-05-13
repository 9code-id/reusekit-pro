import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsOrderTakingView extends StatefulWidget {
  const RfsOrderTakingView({super.key});

  @override
  State<RfsOrderTakingView> createState() => _RfsOrderTakingViewState();
}

class _RfsOrderTakingViewState extends State<RfsOrderTakingView> {
  int currentTab = 0;
  String selectedTable = "";
  String selectedCategory = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> tableOptions = [
    {"label": "Select Table", "value": ""},
    {"label": "Table 1 (4 seats)", "value": "T001"},
    {"label": "Table 2 (2 seats)", "value": "T002"},
    {"label": "Table 3 (6 seats)", "value": "T003"},
    {"label": "Table 4 (4 seats)", "value": "T004"},
    {"label": "Table 5 (8 seats)", "value": "T005"},
    {"label": "VIP Room 1 (12 seats)", "value": "VIP001"},
    {"label": "Bar Counter (6 seats)", "value": "BAR001"},
  ];

  List<Map<String, dynamic>> activeOrders = [
    {
      "id": "ORD001",
      "tableNumber": "T002",
      "tableName": "Table 2",
      "guestName": "Smith Family",
      "guestCount": 4,
      "orderTime": "7:30 PM",
      "server": "Sarah",
      "status": "In Progress",
      "items": [
        {"name": "Caesar Salad", "quantity": 2, "price": 14.99, "notes": "Extra croutons"},
        {"name": "Grilled Salmon", "quantity": 1, "price": 28.99, "notes": "Medium rare"},
        {"name": "Pasta Alfredo", "quantity": 1, "price": 18.99, "notes": ""},
      ],
      "subtotal": 77.96,
      "specialRequests": "No onions, extra napkins",
    },
    {
      "id": "ORD002",
      "tableNumber": "T005",
      "tableName": "Table 5",
      "guestName": "Johnson Party",
      "guestCount": 6,
      "orderTime": "8:00 PM",
      "server": "Mike",
      "status": "Ready to Serve",
      "items": [
        {"name": "Appetizer Platter", "quantity": 1, "price": 24.99, "notes": ""},
        {"name": "Ribeye Steak", "quantity": 2, "price": 42.99, "notes": "Well done"},
        {"name": "Chicken Parmesan", "quantity": 2, "price": 22.99, "notes": ""},
        {"name": "House Wine", "quantity": 2, "price": 8.99, "notes": "Red wine"},
      ],
      "subtotal": 150.94,
      "specialRequests": "Birthday celebration, candle for dessert",
    },
    {
      "id": "ORD003",
      "tableNumber": "VIP001",
      "tableName": "VIP Room 1",
      "guestName": "Corporate Event",
      "guestCount": 12,
      "orderTime": "6:00 PM",
      "server": "Team A",
      "status": "Served",
      "items": [
        {"name": "Business Lunch Set", "quantity": 12, "price": 35.99, "notes": "Mixed selections"},
        {"name": "Coffee Service", "quantity": 12, "price": 4.99, "notes": "Various options"},
      ],
      "subtotal": 491.76,
      "specialRequests": "Corporate billing, separate receipt",
    },
  ];

  List<Map<String, dynamic>> menuCategories = [
    {"name": "All", "icon": Icons.restaurant_menu},
    {"name": "Appetizers", "icon": Icons.local_dining},
    {"name": "Main Course", "icon": Icons.dinner_dining},
    {"name": "Desserts", "icon": Icons.cake},
    {"name": "Beverages", "icon": Icons.local_cafe},
    {"name": "Specials", "icon": Icons.star},
  ];

  List<Map<String, dynamic>> menuItems = [
    {
      "id": "M001",
      "name": "Caesar Salad",
      "category": "Appetizers",
      "price": 14.99,
      "description": "Crisp romaine lettuce, parmesan cheese, croutons",
      "image": "https://picsum.photos/200/150?random=1&keyword=salad",
      "isAvailable": true,
      "allergens": ["Dairy", "Gluten"],
      "isPopular": true,
    },
    {
      "id": "M002",
      "name": "Grilled Salmon",
      "category": "Main Course",
      "price": 28.99,
      "description": "Fresh Atlantic salmon with seasonal vegetables",
      "image": "https://picsum.photos/200/150?random=2&keyword=salmon",
      "isAvailable": true,
      "allergens": ["Fish"],
      "isPopular": true,
    },
    {
      "id": "M003",
      "name": "Pasta Alfredo",
      "category": "Main Course",
      "price": 18.99,
      "description": "Creamy alfredo sauce with fettuccine pasta",
      "image": "https://picsum.photos/200/150?random=3&keyword=pasta",
      "isAvailable": true,
      "allergens": ["Dairy", "Gluten"],
      "isPopular": false,
    },
    {
      "id": "M004",
      "name": "Ribeye Steak",
      "category": "Main Course",
      "price": 42.99,
      "description": "12oz prime ribeye steak, cooked to perfection",
      "image": "https://picsum.photos/200/150?random=4&keyword=steak",
      "isAvailable": true,
      "allergens": [],
      "isPopular": true,
    },
    {
      "id": "M005",
      "name": "Chocolate Cake",
      "category": "Desserts",
      "price": 8.99,
      "description": "Rich chocolate cake with vanilla ice cream",
      "image": "https://picsum.photos/200/150?random=5&keyword=cake",
      "isAvailable": true,
      "allergens": ["Dairy", "Gluten", "Eggs"],
      "isPopular": true,
    },
    {
      "id": "M006",
      "name": "House Wine",
      "category": "Beverages",
      "price": 8.99,
      "description": "Selection of red and white wines",
      "image": "https://picsum.photos/200/150?random=6&keyword=wine",
      "isAvailable": true,
      "allergens": ["Sulfites"],
      "isPopular": false,
    },
    {
      "id": "M007",
      "name": "Chicken Parmesan",
      "category": "Main Course",
      "price": 22.99,
      "description": "Breaded chicken breast with marinara and mozzarella",
      "image": "https://picsum.photos/200/150?random=7&keyword=chicken",
      "isAvailable": false,
      "allergens": ["Dairy", "Gluten"],
      "isPopular": true,
    },
    {
      "id": "M008",
      "name": "Chef's Special",
      "category": "Specials",
      "price": 35.99,
      "description": "Today's special - ask your server for details",
      "image": "https://picsum.photos/200/150?random=8&keyword=special",
      "isAvailable": true,
      "allergens": ["Varies"],
      "isPopular": true,
    },
  ];

  List<Map<String, dynamic>> currentOrder = [];

  List<Map<String, dynamic>> get filteredMenuItems {
    return menuItems.where((item) {
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          item["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["description"].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<Map<String, dynamic>> get filteredOrders {
    if (selectedTable.isEmpty) return activeOrders;
    return activeOrders.where((order) => order["tableNumber"] == selectedTable).toList();
  }

  double get currentOrderTotal {
    return currentOrder.fold(0.0, (total, item) => total + ((item["price"] as double) * (item["quantity"] as int)));
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Progress":
        return warningColor;
      case "Ready to Serve":
        return successColor;
      case "Served":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  void _addToOrder(Map<String, dynamic> menuItem) {
    setState(() {
      int existingIndex = currentOrder.indexWhere((item) => item["id"] == menuItem["id"]);
      if (existingIndex >= 0) {
        currentOrder[existingIndex]["quantity"]++;
      } else {
        currentOrder.add({
          ...menuItem,
          "quantity": 1,
          "notes": "",
        });
      }
    });
    ss("${menuItem["name"]} added to order");
  }

  void _removeFromOrder(Map<String, dynamic> orderItem) {
    setState(() {
      if (orderItem["quantity"] > 1) {
        orderItem["quantity"]--;
      } else {
        currentOrder.remove(orderItem);
      }
    });
  }

  void _updateItemNotes(Map<String, dynamic> orderItem, String notes) {
    setState(() {
      orderItem["notes"] = notes;
    });
  }

  void _submitOrder() async {
    if (selectedTable.isEmpty) {
      se("Please select a table first");
      return;
    }
    
    if (currentOrder.isEmpty) {
      se("Please add items to the order");
      return;
    }

    bool isConfirmed = await confirm("Submit order for $selectedTable? Total: \$${currentOrderTotal.currency}");
    if (isConfirmed) {
      // Add to active orders
      String tableName = tableOptions.firstWhere((t) => t["value"] == selectedTable)["label"];
      
      setState(() {
        activeOrders.add({
          "id": "ORD${(activeOrders.length + 1).toString().padLeft(3, '0')}",
          "tableNumber": selectedTable,
          "tableName": tableName,
          "guestName": "New Guest",
          "guestCount": 2,
          "orderTime": TimeOfDay.now().kkmm,
          "server": "Current Server",
          "status": "In Progress",
          "items": List.from(currentOrder),
          "subtotal": currentOrderTotal,
          "specialRequests": "",
        });
        
        currentOrder.clear();
        selectedTable = "";
      });

      ss("Order submitted successfully!");
    }
  }

  void _viewOrderDetails(Map<String, dynamic> order) {
    si("Viewing details for order ${order["id"]}");
  }

  void _updateOrderStatus(Map<String, dynamic> order, String newStatus) async {
    bool isConfirmed = await confirm("Update order ${order["id"]} status to $newStatus?");
    if (isConfirmed) {
      setState(() {
        order["status"] = newStatus;
      });
      ss("Order status updated to $newStatus");
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Order Taking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "New Order", icon: Icon(Icons.add_circle)),
        Tab(text: "Active Orders", icon: Icon(Icons.restaurant)),
        Tab(text: "Menu", icon: Icon(Icons.menu_book)),
      ],
      tabChildren: [
        _buildNewOrderTab(),
        _buildActiveOrdersTab(),
        _buildMenuTab(),
      ],
    );
  }

  Widget _buildNewOrderTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table Selection
          QDropdownField(
            label: "Select Table*",
            items: tableOptions,
            value: selectedTable,
            onChanged: (value, label) {
              selectedTable = value;
              setState(() {});
            },
          ),

          // Current Order Summary
          if (currentOrder.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Current Order",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${currentOrderTotal.currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    spacing: spXs,
                    children: currentOrder.map((item) {
                      return Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Center(
                                child: Text(
                                  "${item["quantity"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (item["notes"].isNotEmpty)
                                    Text(
                                      "${item["notes"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${(((item["price"] as double) * (item["quantity"] as int))).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.remove,
                              size: bs.sm,
                              onPressed: () => _removeFromOrder(item),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Submit Order (\$${currentOrderTotal.currency})",
                      onPressed: _submitOrder,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Menu Categories
          QCategoryPicker(
            label: "Menu Categories",
            items: menuCategories.map((cat) => {
              "label": cat["name"],
              "value": cat["name"],
            }).toList(),
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),

          // Search
          QTextField(
            label: "Search Menu",
            value: searchQuery,
            hint: "Search for dishes...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          // Menu Items
          Text(
            "Menu Items (${filteredMenuItems.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: filteredMenuItems.map((item) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Item Image
                    Stack(
                      children: [
                        Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                            child: Image.network(
                              "${item["image"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (item["isPopular"] == true)
                          Positioned(
                            top: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star, color: Colors.white, size: 12),
                                  SizedBox(width: 2),
                                  Text(
                                    "Popular",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (item["isAvailable"] != true)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusSm),
                                  topRight: Radius.circular(radiusSm),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Not Available",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    // Item Details
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        spacing: spXs,
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
                                  ),
                                ),
                              ),
                              Text(
                                "\$${(item["price"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
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

                          if ((item["allergens"] as List).isNotEmpty)
                            Wrap(
                              spacing: 4,
                              children: (item["allergens"] as List).map((allergen) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withAlpha(100),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$allergen",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Add to Order",
                              size: bs.sm,
                              onPressed: item["isAvailable"] == true 
                                ? () => _addToOrder(item)
                                : null,
                            ),
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
    );
  }

  Widget _buildActiveOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter by Table
          QDropdownField(
            label: "Filter by Table",
            items: tableOptions,
            value: selectedTable,
            onChanged: (value, label) {
              selectedTable = value;
              setState(() {});
            },
          ),

          // Orders Summary
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Orders", "${activeOrders.length}", Icons.receipt_long, primaryColor),
              _buildStatCard("In Progress", "${activeOrders.where((o) => o["status"] == "In Progress").length}", Icons.schedule, warningColor),
              _buildStatCard("Ready", "${activeOrders.where((o) => o["status"] == "Ready to Serve").length}", Icons.check_circle, successColor),
              _buildStatCard("Served", "${activeOrders.where((o) => o["status"] == "Served").length}", Icons.done_all, infoColor),
            ],
          ),

          // Active Orders List
          Text(
            "Active Orders (${filteredOrders.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          Column(
            spacing: spSm,
            children: filteredOrders.map((order) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(order["status"]),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    // Order Header
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(order["status"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${order["id"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${order["status"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor(order["status"]),
                          ),
                        ),
                      ],
                    ),

                    // Order Info
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${order["tableName"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${order["guestName"]} (${order["guestCount"]} guests)",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Server: ${order["server"]} • ${order["orderTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${((order["subtotal"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),

                    // Order Items
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Items:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          ...(order["items"] as List).map((item) {
                            return Row(
                              children: [
                                Text(
                                  "${item["quantity"]}x",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "${item["name"]}${item["notes"].isNotEmpty ? " (${item["notes"]})" : ""}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${((item["price"] as double) * (item["quantity"] as int)).currency}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),

                    // Special Requests
                    if (order["specialRequests"].isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.note, size: 12, color: warningColor),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "${order["specialRequests"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: warningColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () => _viewOrderDetails(order),
                          ),
                        ),
                        SizedBox(width: spSm),
                        if (order["status"] == "In Progress") ...[
                          Expanded(
                            child: QButton(
                              label: "Ready to Serve",
                              size: bs.sm,
                              onPressed: () => _updateOrderStatus(order, "Ready to Serve"),
                            ),
                          ),
                        ] else if (order["status"] == "Ready to Serve") ...[
                          Expanded(
                            child: QButton(
                              label: "Mark Served",
                              size: bs.sm,
                              onPressed: () => _updateOrderStatus(order, "Served"),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "Menu Management",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Manage menu items, categories, and pricing",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
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
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
