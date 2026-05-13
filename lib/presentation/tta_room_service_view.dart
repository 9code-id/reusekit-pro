import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaRoomServiceView extends StatefulWidget {
  const TtaRoomServiceView({super.key});

  @override
  State<TtaRoomServiceView> createState() => _TtaRoomServiceViewState();
}

class _TtaRoomServiceViewState extends State<TtaRoomServiceView> {
  String selectedCategory = "All";
  String searchQuery = "";
  List<Map<String, dynamic>> cartItems = [];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Breakfast", "value": "Breakfast"},
    {"label": "Main Course", "value": "Main Course"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Desserts", "value": "Desserts"},
    {"label": "Snacks", "value": "Snacks"},
  ];

  List<Map<String, dynamic>> menuItems = [
    {
      "id": "1",
      "name": "Continental Breakfast",
      "description": "Fresh croissants, fruits, coffee, and juice",
      "category": "Breakfast",
      "price": 25.00,
      "image": "https://picsum.photos/300/200?random=1&keyword=breakfast",
      "preparationTime": 15,
      "rating": 4.8,
      "available": true,
      "quantity": 0,
    },
    {
      "id": "2",
      "name": "Grilled Salmon",
      "description": "Fresh Atlantic salmon with herbs and vegetables",
      "category": "Main Course",
      "price": 35.00,
      "image": "https://picsum.photos/300/200?random=2&keyword=salmon",
      "preparationTime": 25,
      "rating": 4.9,
      "available": true,
      "quantity": 0,
    },
    {
      "id": "3",
      "name": "Premium Coffee",
      "description": "Freshly brewed coffee from premium beans",
      "category": "Beverages",
      "price": 8.00,
      "image": "https://picsum.photos/300/200?random=3&keyword=coffee",
      "preparationTime": 5,
      "rating": 4.6,
      "available": true,
      "quantity": 0,
    },
    {
      "id": "4",
      "name": "Chocolate Cake",
      "description": "Rich chocolate cake with vanilla ice cream",
      "category": "Desserts",
      "price": 15.00,
      "image": "https://picsum.photos/300/200?random=4&keyword=chocolate",
      "preparationTime": 10,
      "rating": 4.7,
      "available": true,
      "quantity": 0,
    },
    {
      "id": "5",
      "name": "Caesar Salad",
      "description": "Fresh romaine lettuce with Caesar dressing",
      "category": "Main Course",
      "price": 18.00,
      "image": "https://picsum.photos/300/200?random=5&keyword=salad",
      "preparationTime": 10,
      "rating": 4.5,
      "available": true,
      "quantity": 0,
    },
    {
      "id": "6",
      "name": "Fresh Juice",
      "description": "Selection of fresh fruit juices",
      "category": "Beverages",
      "price": 12.00,
      "image": "https://picsum.photos/300/200?random=6&keyword=juice",
      "preparationTime": 5,
      "rating": 4.4,
      "available": false,
      "quantity": 0,
    },
    {
      "id": "7",
      "name": "Club Sandwich",
      "description": "Triple-layered sandwich with fries",
      "category": "Snacks",
      "price": 22.00,
      "image": "https://picsum.photos/300/200?random=7&keyword=sandwich",
      "preparationTime": 15,
      "rating": 4.6,
      "available": true,
      "quantity": 0,
    },
    {
      "id": "8",
      "name": "Ice Cream Sundae",
      "description": "Vanilla ice cream with chocolate sauce",
      "category": "Desserts",
      "price": 12.00,
      "image": "https://picsum.photos/300/200?random=8&keyword=icecream",
      "preparationTime": 5,
      "rating": 4.3,
      "available": true,
      "quantity": 0,
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return menuItems.where((item) {
      bool categoryMatch = selectedCategory == "All" || 
                          item["category"] == selectedCategory;
      bool searchMatch = searchQuery.isEmpty ||
                        (item["name"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  double get totalAmount {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  void addToCart(Map<String, dynamic> item) {
    final existingIndex = cartItems.indexWhere((cartItem) => 
        cartItem["id"] == item["id"]);
    
    if (existingIndex >= 0) {
      cartItems[existingIndex]["quantity"] = 
          (cartItems[existingIndex]["quantity"] as int) + 1;
    } else {
      cartItems.add({
        ...item,
        "quantity": 1,
      });
    }
    
    // Update original item quantity
    final originalIndex = menuItems.indexWhere((menuItem) => 
        menuItem["id"] == item["id"]);
    if (originalIndex >= 0) {
      menuItems[originalIndex]["quantity"] = 
          (menuItems[originalIndex]["quantity"] as int) + 1;
    }
    
    setState(() {});
    ss("${item["name"]} added to cart");
  }

  void removeFromCart(Map<String, dynamic> item) {
    final existingIndex = cartItems.indexWhere((cartItem) => 
        cartItem["id"] == item["id"]);
    
    if (existingIndex >= 0) {
      if ((cartItems[existingIndex]["quantity"] as int) > 1) {
        cartItems[existingIndex]["quantity"] = 
            (cartItems[existingIndex]["quantity"] as int) - 1;
      } else {
        cartItems.removeAt(existingIndex);
      }
    }
    
    // Update original item quantity
    final originalIndex = menuItems.indexWhere((menuItem) => 
        menuItem["id"] == item["id"]);
    if (originalIndex >= 0) {
      menuItems[originalIndex]["quantity"] = 
          (menuItems[originalIndex]["quantity"] as int) - 1;
    }
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Room Service"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  _showCartBottomSheet();
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      "${cartItems.length}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search menu...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Category Filter
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QCategoryPicker(
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),

          SizedBox(height: spSm),

          // Menu Items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                final isAvailable = item["available"] as bool;
                final quantity = item["quantity"] as int;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isAvailable 
                          ? disabledOutlineBorderColor 
                          : disabledColor,
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
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
                            if (!isAvailable)
                              Positioned.fill(
                                child: Container(
                                  color: Colors.black.withAlpha(120),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spMd,
                                        vertical: spSm,
                                      ),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "Not Available",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Content
                      Padding(
                        padding: EdgeInsets.all(spMd),
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
                                      color: isAvailable 
                                          ? primaryColor 
                                          : disabledColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${((item["price"] as double)).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isAvailable 
                                        ? primaryColor 
                                        : disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${item["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: isAvailable 
                                    ? disabledBoldColor 
                                    : disabledColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isAvailable 
                                        ? disabledBoldColor 
                                        : disabledColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(
                                  Icons.schedule,
                                  color: infoColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["preparationTime"]} min",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isAvailable 
                                        ? disabledBoldColor 
                                        : disabledColor,
                                  ),
                                ),
                                Spacer(),
                                if (isAvailable && quantity > 0)
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => removeFromCart(item),
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: dangerColor.withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            color: dangerColor,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "$quantity",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      GestureDetector(
                                        onTap: () => addToCart(item),
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: primaryColor.withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: primaryColor,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                else if (isAvailable)
                                  QButton(
                                    label: "Add to Cart",
                                    size: bs.sm,
                                    onPressed: () => addToCart(item),
                                  ),
                              ],
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
      floatingActionButton: cartItems.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                _showCartBottomSheet();
              },
              backgroundColor: primaryColor,
              label: Text(
                "View Cart (\$${totalAmount.toStringAsFixed(2)})",
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(Icons.shopping_cart, color: Colors.white),
            )
          : null,
    );
  }

  void _showCartBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Your Order",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusMd),
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$${((item["price"] as double)).toStringAsFixed(2)} x ${item["quantity"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${(((item["price"] as double) * (item["quantity"] as int))).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Total Amount:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${totalAmount.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
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
                        label: "Place Order",
                        size: bs.md,
                        onPressed: () {
                          Navigator.pop(context);
                          ss("Order placed successfully!");
                          cartItems.clear();
                          // Reset all quantities
                          for (var item in menuItems) {
                            item["quantity"] = 0;
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
