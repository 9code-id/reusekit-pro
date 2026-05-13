import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsOnlineOrderingView extends StatefulWidget {
  const RfsOnlineOrderingView({super.key});

  @override
  State<RfsOnlineOrderingView> createState() => _RfsOnlineOrderingViewState();
}

class _RfsOnlineOrderingViewState extends State<RfsOnlineOrderingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedStatus = "all";
  Map<String, int> cartItems = {};
  double totalAmount = 0.0;

  List<Map<String, dynamic>> menuItems = [
    {
      "id": "M001",
      "name": "Margherita Pizza",
      "description": "Fresh tomato sauce, mozzarella cheese, and basil",
      "price": 18.99,
      "category": "pizza",
      "image": "https://picsum.photos/150/150?random=1&keyword=pizza",
      "ingredients": ["Tomato sauce", "Mozzarella", "Basil", "Olive oil"],
      "allergens": ["Gluten", "Dairy"],
      "calories": 320,
      "prep_time": 15,
      "available": true,
      "rating": 4.8,
      "reviews": 126
    },
    {
      "id": "M002",
      "name": "Grilled Salmon",
      "description": "Fresh Atlantic salmon with lemon herb seasoning",
      "price": 26.99,
      "category": "seafood",
      "image": "https://picsum.photos/150/150?random=2&keyword=salmon",
      "ingredients": ["Salmon fillet", "Lemon", "Herbs", "Olive oil"],
      "allergens": ["Fish"],
      "calories": 280,
      "prep_time": 20,
      "available": true,
      "rating": 4.9,
      "reviews": 89
    },
    {
      "id": "M003",
      "name": "Caesar Salad",
      "description": "Crisp romaine lettuce with Caesar dressing and croutons",
      "price": 12.99,
      "category": "salad",
      "image": "https://picsum.photos/150/150?random=3&keyword=salad",
      "ingredients": ["Romaine lettuce", "Caesar dressing", "Croutons", "Parmesan"],
      "allergens": ["Gluten", "Dairy", "Eggs"],
      "calories": 180,
      "prep_time": 10,
      "available": true,
      "rating": 4.5,
      "reviews": 67
    },
    {
      "id": "M004",
      "name": "Chocolate Lava Cake",
      "description": "Warm chocolate cake with molten center and vanilla ice cream",
      "price": 8.99,
      "category": "dessert",
      "image": "https://picsum.photos/150/150?random=4&keyword=cake",
      "ingredients": ["Dark chocolate", "Butter", "Eggs", "Flour", "Vanilla ice cream"],
      "allergens": ["Gluten", "Dairy", "Eggs"],
      "calories": 450,
      "prep_time": 12,
      "available": false,
      "rating": 4.7,
      "reviews": 203
    }
  ];

  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD-2024-001",
      "customer_name": "John Smith",
      "customer_phone": "+1-555-0123",
      "customer_email": "john@example.com",
      "items": [
        {"name": "Margherita Pizza", "quantity": 2, "price": 18.99},
        {"name": "Caesar Salad", "quantity": 1, "price": 12.99}
      ],
      "total": 50.97,
      "status": "preparing",
      "order_time": "2024-06-19T12:30:00",
      "estimated_time": "25 mins",
      "delivery_address": "123 Main St, City, State 12345",
      "payment_method": "Credit Card",
      "special_instructions": "Extra cheese on pizza"
    },
    {
      "id": "ORD-2024-002",
      "customer_name": "Sarah Johnson",
      "customer_phone": "+1-555-0456",
      "customer_email": "sarah@example.com",
      "items": [
        {"name": "Grilled Salmon", "quantity": 1, "price": 26.99},
        {"name": "Chocolate Lava Cake", "quantity": 2, "price": 8.99}
      ],
      "total": 44.97,
      "status": "ready",
      "order_time": "2024-06-19T12:15:00",
      "estimated_time": "Ready",
      "delivery_address": "456 Oak Ave, City, State 12345",
      "payment_method": "PayPal",
      "special_instructions": ""
    },
    {
      "id": "ORD-2024-003",
      "customer_name": "Mike Davis",
      "customer_phone": "+1-555-0789",
      "customer_email": "mike@example.com",
      "items": [
        {"name": "Caesar Salad", "quantity": 3, "price": 12.99}
      ],
      "total": 38.97,
      "status": "delivered",
      "order_time": "2024-06-19T11:45:00",
      "estimated_time": "Delivered",
      "delivery_address": "789 Pine Rd, City, State 12345",
      "payment_method": "Cash",
      "special_instructions": "Leave at door"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Items", "value": "all"},
    {"label": "Pizza", "value": "pizza"},
    {"label": "Seafood", "value": "seafood"},
    {"label": "Salad", "value": "salad"},
    {"label": "Dessert", "value": "dessert"},
    {"label": "Beverages", "value": "beverages"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Orders", "value": "all"},
    {"label": "Preparing", "value": "preparing"},
    {"label": "Ready", "value": "ready"},
    {"label": "Out for Delivery", "value": "out_for_delivery"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Cancelled", "value": "cancelled"}
  ];

  List<Map<String, dynamic>> get filteredMenuItems {
    return menuItems.where((item) {
      bool matchesSearch = item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || item["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  List<Map<String, dynamic>> get filteredOrders {
    return orders.where((order) {
      bool matchesStatus = selectedStatus == "all" || order["status"] == selectedStatus;
      return matchesStatus;
    }).toList();
  }

  void _addToCart(Map<String, dynamic> item) {
    String itemId = item["id"];
    cartItems[itemId] = (cartItems[itemId] ?? 0) + 1;
    _calculateTotal();
    ss("${item["name"]} added to cart");
  }

  void _removeFromCart(String itemId) {
    if (cartItems.containsKey(itemId)) {
      cartItems[itemId] = (cartItems[itemId]! - 1);
      if (cartItems[itemId]! <= 0) {
        cartItems.remove(itemId);
      }
      _calculateTotal();
      setState(() {});
    }
  }

  void _calculateTotal() {
    totalAmount = 0.0;
    cartItems.forEach((itemId, quantity) {
      Map<String, dynamic>? item = menuItems.firstWhere((item) => item["id"] == itemId);
      totalAmount += (item["price"] as double) * quantity;
    });
    setState(() {});
  }

  void _updateOrderStatus(Map<String, dynamic> order, String newStatus) {
    order["status"] = newStatus;
    setState(() {});
    ss("Order ${order["id"]} status updated to $newStatus");
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "preparing": return warningColor;
      case "ready": return infoColor;
      case "out_for_delivery": return primaryColor;
      case "delivered": return successColor;
      case "cancelled": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Online Ordering",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Menu", icon: Icon(Icons.restaurant_menu)),
        Tab(text: "Orders", icon: Icon(Icons.receipt_long)),
        Tab(text: "Cart", icon: Icon(Icons.shopping_cart)),
      ],
      tabChildren: [
        _buildMenuTab(),
        _buildOrdersTab(),
        _buildCartTab(),
      ],
    );
  }

  Widget _buildMenuTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filter
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                QTextField(
                  label: "Search menu items",
                  value: searchQuery,
                  hint: "Enter dish name or description",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QCategoryPicker(
                  label: "Filter by Category",
                  items: categories,
                  value: selectedCategory,
                  onChanged: (index, label, value, item) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Menu Items Grid
          Text(
            "Menu Items (${filteredMenuItems.length})",
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
            children: filteredMenuItems.map((item) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item Image
                  Container(
                    width: double.infinity,
                    height: 120,
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
                      child: Stack(
                        children: [
                          Image.network(
                            "${item["image"]}",
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          if (!item["available"])
                            Container(
                              width: double.infinity,
                              height: 120,
                              color: Colors.black.withAlpha(150),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "UNAVAILABLE",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "\$${(item["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Item Details
                  Padding(
                    padding: EdgeInsets.all(spSm),
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
                        SizedBox(height: spXs),
                        Text(
                          "${item["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spSm),
                        
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  " (${item["reviews"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Icon(Icons.access_time, color: infoColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["prep_time"]} min",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["calories"]} cal",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            if (cartItems.containsKey(item["id"])) ...[
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => _removeFromCart(item["id"]),
                                    child: Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(Icons.remove, color: Colors.white, size: 16),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${cartItems[item["id"]]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  GestureDetector(
                                    onTap: () => _addToCart(item),
                                    child: Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(Icons.add, color: Colors.white, size: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ] else ...[
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: item["available"] ? "Add to Cart" : "Unavailable",
                                  size: bs.sm,
                                  onPressed: item["available"] ? () => _addToCart(item) : null,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: QDropdownField(
              label: "Filter by Status",
              items: statusOptions,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(height: spMd),

          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: warningColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.kitchen, color: warningColor, size: 32),
                      SizedBox(height: spSm),
                      Text(
                        "${orders.where((o) => o["status"] == "preparing").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Preparing",
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: infoColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, color: infoColor, size: 32),
                      SizedBox(height: spSm),
                      Text(
                        "${orders.where((o) => o["status"] == "ready").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Ready",
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.delivery_dining, color: successColor, size: 32),
                      SizedBox(height: spSm),
                      Text(
                        "${orders.where((o) => o["status"] == "delivered").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Delivered",
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
          SizedBox(height: spMd),

          // Orders List
          Text(
            "Orders (${filteredOrders.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ...filteredOrders.map((order) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getStatusColor(order["status"]),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${order["id"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${order["customer_name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${order["customer_phone"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor(order["status"]),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${order["status"]}".replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Order Items
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Items:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...(order["items"] as List).map((item) => Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Text(
                              "${item["quantity"]}x ",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${item["name"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Text(
                              "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                      Divider(),
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            "Total: \$${(order["total"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(Icons.access_time, color: infoColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${DateTime.parse(order["order_time"]).dMMMykkss}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${order["estimated_time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                if (order["special_instructions"].toString().isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Special Instructions:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "${order["special_instructions"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    if (order["status"] == "preparing")
                      Expanded(
                        child: QButton(
                          label: "Mark Ready",
                          size: bs.sm,
                          onPressed: () => _updateOrderStatus(order, "ready"),
                        ),
                      ),
                    if (order["status"] == "ready") ...[
                      Expanded(
                        child: QButton(
                          label: "Out for Delivery",
                          size: bs.sm,
                          onPressed: () => _updateOrderStatus(order, "out_for_delivery"),
                        ),
                      ),
                    ],
                    if (order["status"] == "out_for_delivery")
                      Expanded(
                        child: QButton(
                          label: "Mark Delivered",
                          size: bs.sm,
                          onPressed: () => _updateOrderStatus(order, "delivered"),
                        ),
                      ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () => _showOrderActions(order),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildCartTab() {
    List<Map<String, dynamic>> cartItemDetails = [];
    cartItems.forEach((itemId, quantity) {
      Map<String, dynamic>? item = menuItems.firstWhere((item) => item["id"] == itemId);
      cartItemDetails.add({
        ...item,
        "cart_quantity": quantity,
        "total_price": (item["price"] as double) * quantity,
      });
    });

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shopping Cart (${cartItems.length} items)",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          if (cartItemDetails.isEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Icon(Icons.shopping_cart_outlined, color: disabledBoldColor, size: 64),
                  SizedBox(height: spMd),
                  Text(
                    "Your cart is empty",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Add items from the menu to get started",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ...cartItemDetails.map((item) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${item["image"]}",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
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
                        SizedBox(height: spXs),
                        Text(
                          "\$${(item["price"] as double).toStringAsFixed(2)} each",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => _removeFromCart(item["id"]),
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(Icons.remove, color: Colors.white, size: 16),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${item["cart_quantity"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () => _addToCart(item),
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(Icons.add, color: Colors.white, size: 16),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${(item["total_price"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Cart Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Subtotal:",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${totalAmount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "Delivery Fee:",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$2.99",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "Tax:",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${(totalAmount * 0.08).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${(totalAmount + 2.99 + (totalAmount * 0.08)).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Proceed to Checkout",
                      onPressed: () => _showCheckoutDialog(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showOrderActions(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.call, color: primaryColor),
              title: Text("Call Customer"),
              onTap: () {
                Navigator.pop(context);
                ss("Calling ${order["customer_name"]}...");
              },
            ),
            ListTile(
              leading: Icon(Icons.message, color: successColor),
              title: Text("Send Message"),
              onTap: () {
                Navigator.pop(context);
                ss("Message sent to ${order["customer_name"]}");
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: infoColor),
              title: Text("View Address"),
              onTap: () {
                Navigator.pop(context);
                _showAddressDialog(order);
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel, color: dangerColor),
              title: Text("Cancel Order"),
              onTap: () {
                Navigator.pop(context);
                _cancelOrder(order);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delivery Address"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${order["customer_name"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "${order["delivery_address"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _cancelOrder(Map<String, dynamic> order) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this order?");
    if (isConfirmed) {
      _updateOrderStatus(order, "cancelled");
    }
  }

  void _showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Checkout"),
        content: Text("This would normally integrate with a payment system."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Complete Order",
            onPressed: () {
              Navigator.pop(context);
              cartItems.clear();
              totalAmount = 0.0;
              setState(() {});
              ss("Order placed successfully!");
            },
          ),
        ],
      ),
    );
  }
}
