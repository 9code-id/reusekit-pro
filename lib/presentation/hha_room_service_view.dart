import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaRoomServiceView extends StatefulWidget {
  const HhaRoomServiceView({super.key});

  @override
  State<HhaRoomServiceView> createState() => _HhaRoomServiceViewState();
}

class _HhaRoomServiceViewState extends State<HhaRoomServiceView> {
  String selectedCategory = "all";
  List<Map<String, dynamic>> cart = [];
  String specialInstructions = "";
  String deliveryTime = "asap";

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Items", "value": "all"},
    {"label": "Breakfast", "value": "breakfast"},
    {"label": "Main Course", "value": "main"},
    {"label": "Desserts", "value": "dessert"},
    {"label": "Beverages", "value": "beverage"},
    {"label": "Snacks", "value": "snack"},
  ];

  List<Map<String, dynamic>> deliveryTimeItems = [
    {"label": "As Soon as Possible", "value": "asap"},
    {"label": "In 30 minutes", "value": "30min"},
    {"label": "In 1 hour", "value": "1hour"},
    {"label": "In 2 hours", "value": "2hour"},
    {"label": "Custom time", "value": "custom"},
  ];

  List<Map<String, dynamic>> menuItems = [
    {
      "id": "item_001",
      "name": "Classic Breakfast",
      "description": "Scrambled eggs, bacon, toast, fresh fruit, and coffee",
      "price": 28.00,
      "category": "breakfast",
      "image": "https://picsum.photos/200/150?random=1&keyword=breakfast",
      "preparation_time": "15-20 minutes",
      "dietary_info": ["Gluten-Free Available"],
      "rating": 4.8,
      "popular": true,
    },
    {
      "id": "item_002",
      "name": "Grilled Salmon",
      "description": "Fresh Atlantic salmon with seasonal vegetables and lemon butter sauce",
      "price": 42.00,
      "category": "main",
      "image": "https://picsum.photos/200/150?random=2&keyword=salmon",
      "preparation_time": "25-30 minutes",
      "dietary_info": ["Gluten-Free", "Keto-Friendly"],
      "rating": 4.9,
      "popular": true,
    },
    {
      "id": "item_003",
      "name": "Caesar Salad",
      "description": "Crisp romaine lettuce, parmesan cheese, croutons, and caesar dressing",
      "price": 18.00,
      "category": "main",
      "image": "https://picsum.photos/200/150?random=3&keyword=salad",
      "preparation_time": "10-15 minutes",
      "dietary_info": ["Vegetarian"],
      "rating": 4.5,
      "popular": false,
    },
    {
      "id": "item_004",
      "name": "Chocolate Lava Cake",
      "description": "Warm chocolate cake with molten center, served with vanilla ice cream",
      "price": 15.00,
      "category": "dessert",
      "image": "https://picsum.photos/200/150?random=4&keyword=chocolate",
      "preparation_time": "20-25 minutes",
      "dietary_info": ["Contains Nuts"],
      "rating": 4.7,
      "popular": true,
    },
    {
      "id": "item_005",
      "name": "Fresh Orange Juice",
      "description": "Freshly squeezed orange juice (16 oz)",
      "price": 8.00,
      "category": "beverage",
      "image": "https://picsum.photos/200/150?random=5&keyword=orange",
      "preparation_time": "5 minutes",
      "dietary_info": ["Vegan", "No Sugar Added"],
      "rating": 4.6,
      "popular": false,
    },
    {
      "id": "item_006",
      "name": "Artisan Sandwiches",
      "description": "Selection of gourmet sandwiches with premium ingredients",
      "price": 24.00,
      "category": "snack",
      "image": "https://picsum.photos/200/150?random=6&keyword=sandwich",
      "preparation_time": "10-15 minutes",
      "dietary_info": ["Vegetarian Option"],
      "rating": 4.4,
      "popular": false,
    },
    {
      "id": "item_007",
      "name": "Premium Coffee",
      "description": "Single-origin espresso, cappuccino, or latte",
      "price": 6.00,
      "category": "beverage",
      "image": "https://picsum.photos/200/150?random=7&keyword=coffee",
      "preparation_time": "5-8 minutes",
      "dietary_info": ["Dairy-Free Available"],
      "rating": 4.3,
      "popular": true,
    },
    {
      "id": "item_008",
      "name": "Beef Tenderloin",
      "description": "Premium beef tenderloin with truffle mashed potatoes and red wine reduction",
      "price": 55.00,
      "category": "main",
      "image": "https://picsum.photos/200/150?random=8&keyword=beef",
      "preparation_time": "35-40 minutes",
      "dietary_info": ["Gluten-Free"],
      "rating": 4.9,
      "popular": true,
    },
  ];

  List<Map<String, dynamic>> get filteredMenuItems {
    if (selectedCategory == "all") {
      return menuItems;
    }
    return menuItems.where((item) => item["category"] == selectedCategory).toList();
  }

  double get totalAmount {
    return cart.fold(0.0, (total, item) => total + ((item["price"] as double) * (item["quantity"] as int)));
  }

  int get totalItems {
    return cart.fold(0, (total, item) => total + (item["quantity"] as int));
  }

  void _addToCart(Map<String, dynamic> item) {
    final existingIndex = cart.indexWhere((cartItem) => cartItem["id"] == item["id"]);
    
    if (existingIndex >= 0) {
      cart[existingIndex]["quantity"] = (cart[existingIndex]["quantity"] as int) + 1;
    } else {
      cart.add({
        ...item,
        "quantity": 1,
      });
    }
    
    setState(() {});
    ss("Added ${item["name"]} to cart");
  }

  void _removeFromCart(String itemId) {
    final existingIndex = cart.indexWhere((cartItem) => cartItem["id"] == itemId);
    
    if (existingIndex >= 0) {
      if ((cart[existingIndex]["quantity"] as int) > 1) {
        cart[existingIndex]["quantity"] = (cart[existingIndex]["quantity"] as int) - 1;
      } else {
        cart.removeAt(existingIndex);
      }
      setState(() {});
    }
  }

  void _clearCart() async {
    bool isConfirmed = await confirm("Are you sure you want to clear your cart?");
    if (isConfirmed) {
      cart.clear();
      setState(() {});
      si("Cart cleared");
    }
  }

  void _placeOrder() async {
    if (cart.isEmpty) {
      se("Your cart is empty");
      return;
    }

    showLoading();
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    ss("Order placed successfully! Estimated delivery: 30-45 minutes");
    
    // Clear cart after successful order
    cart.clear();
    specialInstructions = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Room Service"),
        actions: [
          if (cart.isNotEmpty)
            Container(
              margin: EdgeInsets.only(right: spMd),
              child: Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      // Show cart modal or navigate to cart
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "$totalItems",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.room_service,
                  size: 40,
                  color: primaryColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "24/7 Room Service",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Delicious meals delivered to your room",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Category Filter
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QDropdownField(
              label: "Filter by Category",
              items: categoryItems,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredMenuItems.length,
              itemBuilder: (context, index) {
                final item = filteredMenuItems[index];
                return _buildMenuItemCard(item);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: cart.isNotEmpty
          ? Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowMd],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: spMd,
                children: [
                  // Cart Summary
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$totalItems items",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${totalAmount.currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  // Action Buttons
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Cart",
                          size: bs.sm,
                          onPressed: () {
                            _showCartModal();
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Place Order",
                          size: bs.sm,
                          onPressed: _placeOrder,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _buildMenuItemCard(Map<String, dynamic> item) {
    final isInCart = cart.any((cartItem) => cartItem["id"] == item["id"]);
    final cartItem = cart.firstWhere(
      (cartItem) => cartItem["id"] == item["id"],
      orElse: () => {},
    );
    final quantity = cartItem.isNotEmpty ? (cartItem["quantity"] as int) : 0;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Item Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusMd),
                      bottomLeft: Radius.circular(radiusMd),
                    ),
                    child: Image.network(
                      "${item["image"]}",
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (item["popular"] as bool)
                    Positioned(
                      top: spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Popular",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              
              // Item Details
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
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
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      Row(
                        children: [
                          Icon(Icons.timer, size: 14, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${item["preparation_time"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          SizedBox(width: spXs),
                          Text(
                            "${(item["rating"] as double).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "\$${((item["price"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Dietary Information
          if ((item["dietary_info"] as List).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
              ),
              child: Wrap(
                spacing: spSm,
                children: (item["dietary_info"] as List).map((info) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$info",
                      style: TextStyle(
                        fontSize: 10,
                        color: infoColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

          // Add to Cart Section
          Container(
            padding: EdgeInsets.all(spMd),
            child: isInCart
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => _removeFromCart(item["id"]),
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: dangerColor,
                                size: 16,
                              ),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Text(
                            "$quantity",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          GestureDetector(
                            onTap: () => _addToCart(item),
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.add,
                                color: successColor,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(((item["price"] as double) * quantity)).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  )
                : Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Add to Cart",
                      size: bs.sm,
                      onPressed: () => _addToCart(item),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _showCartModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            // Modal Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Order ($totalItems items)",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _clearCart,
                        child: Text(
                          "Clear",
                          style: TextStyle(
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close, color: disabledBoldColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Cart Items
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(spMd),
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: disabledOutlineBorderColor),
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
                            spacing: spXs,
                            children: [
                              Text(
                                "${item["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "\$${((item["price"] as double)).currency} each",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => _removeFromCart(item["id"]),
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: dangerColor,
                                  size: 16,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${item["quantity"]}",
                              style: TextStyle(
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
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: successColor,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Order Customization
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Column(
                spacing: spMd,
                children: [
                  QDropdownField(
                    label: "Delivery Time",
                    items: deliveryTimeItems,
                    value: deliveryTime,
                    onChanged: (value, label) {
                      deliveryTime = value;
                      setState(() {});
                    },
                  ),
                  QMemoField(
                    label: "Special Instructions",
                    value: specialInstructions,
                    hint: "Any special requests or dietary requirements?",
                    onChanged: (value) {
                      specialInstructions = value;
                      setState(() {});
                    },
                  ),
                  
                  // Total and Place Order
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${totalAmount.currency}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 150,
                        child: QButton(
                          label: "Place Order",
                          size: bs.md,
                          onPressed: () {
                            Navigator.pop(context);
                            _placeOrder();
                          },
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
    );
  }
}
