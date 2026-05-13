import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosMainView extends StatefulWidget {
  const PosMainView({super.key});

  @override
  State<PosMainView> createState() => _PosMainViewState();
}

class _PosMainViewState extends State<PosMainView> {
  int currentTab = 0;
  String searchQuery = "";
  int cartItemCount = 12;
  double cartTotal = 1247.50;
  String selectedCategory = "All";
  bool isOnline = true;

  final List<Map<String, dynamic>> categories = [
    {"label": "All Items", "value": "All"},
    {"label": "Food & Beverage", "value": "Food"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Clothing", "value": "Clothing"},
    {"label": "Home & Garden", "value": "Home"},
    {"label": "Health & Beauty", "value": "Health"},
  ];

  final List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Premium Coffee Beans",
      "category": "Food",
      "price": 24.99,
      "stock": 150,
      "barcode": "123456789012",
      "image": "https://picsum.photos/200/200?random=1&keyword=coffee",
      "description": "Premium arabica coffee beans",
    },
    {
      "id": 2,
      "name": "Wireless Headphones",
      "category": "Electronics",
      "price": 89.99,
      "stock": 75,
      "barcode": "123456789013",
      "image": "https://picsum.photos/200/200?random=2&keyword=headphones",
      "description": "Bluetooth wireless headphones",
    },
    {
      "id": 3,
      "name": "Cotton T-Shirt",
      "category": "Clothing",
      "price": 19.99,
      "stock": 200,
      "barcode": "123456789014",
      "image": "https://picsum.photos/200/200?random=3&keyword=tshirt",
      "description": "100% cotton comfortable t-shirt",
    },
    {
      "id": 4,
      "name": "Hand Sanitizer",
      "category": "Health",
      "price": 5.99,
      "stock": 500,
      "barcode": "123456789015",
      "image": "https://picsum.photos/200/200?random=4&keyword=sanitizer",
      "description": "Alcohol-based hand sanitizer",
    },
    {
      "id": 5,
      "name": "Indoor Plant Pot",
      "category": "Home",
      "price": 12.99,
      "stock": 80,
      "barcode": "123456789016",
      "image": "https://picsum.photos/200/200?random=5&keyword=plant",
      "description": "Ceramic plant pot for indoor plants",
    },
    {
      "id": 6,
      "name": "Energy Drink",
      "category": "Food",
      "price": 3.99,
      "stock": 300,
      "barcode": "123456789017",
      "image": "https://picsum.photos/200/200?random=6&keyword=drink",
      "description": "High-energy sports drink",
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      bool matchesCategory = selectedCategory == "All" || product["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
        product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        product["barcode"].toString().contains(searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POS System"),
        actions: [
          // Connection Status
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            margin: EdgeInsets.only(right: spSm),
            decoration: BoxDecoration(
              color: isOnline ? Colors.green[100] : Colors.red[100],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isOnline ? Icons.wifi : Icons.wifi_off,
                  color: isOnline ? Colors.green[600] : Colors.red[600],
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  isOnline ? "Online" : "Offline",
                  style: TextStyle(
                    color: isOnline ? Colors.green[600] : Colors.red[600],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Settings
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
          // Left Panel - Product Grid
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spSm,
                children: [
                  // Search and Scanner
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search products or scan barcode",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      QButton(
                        icon: Icons.qr_code_scanner,
                        size: bs.md,
                        onPressed: () {
                          // Navigate to barcode scanner
                        },
                      ),
                      QButton(
                        icon: Icons.attach_money,
                        size: bs.md,
                        onPressed: () {
                          // Navigate to custom amount
                        },
                      ),
                    ],
                  ),

                  // Category Filter
                  QCategoryPicker(
                    label: "Product Categories",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),

                  // Product Grid
                  Expanded(
                    child: ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: filteredProducts.map((product) {
                        return _buildProductCard(product);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right Panel - Cart
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // Cart Header
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Current Order",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "$cartItemCount items",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Cart Items
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      children: [
                        // Cart item placeholder
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: disabledBoldColor,
                                size: 40,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Cart items will appear here when you add products",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Cart Total and Actions
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      // Subtotal
                      Row(
                        children: [
                          Text(
                            "Subtotal:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\$${cartTotal.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      
                      // Tax
                      Row(
                        children: [
                          Text(
                            "Tax (8.5%):",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\$${(cartTotal * 0.085).toStringAsFixed(2)}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      Divider(),

                      // Total
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
                            "\$${(cartTotal * 1.085).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Action Buttons
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Cart",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to cart view
                              },
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Checkout",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to checkout
                              },
                            ),
                          ),
                        ],
                      ),

                      // Quick Actions
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Hold Order",
                              size: bs.sm,
                              onPressed: _holdOrder,
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Clear Cart",
                              size: bs.sm,
                              onPressed: _clearCart,
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
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Image.network(
              "${product["image"]}",
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),

          // Product Info
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                Text(
                  "${product["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                Row(
                  children: [
                    Text(
                      "\$${(product["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: (product["stock"] as int) > 10 ? Colors.green[100] : Colors.orange[100],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Stock: ${product["stock"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: (product["stock"] as int) > 10 ? Colors.green[700] : Colors.orange[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spXs),

                // Add to Cart Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Add to Cart",
                    size: bs.sm,
                    onPressed: () => _addToCart(product),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(Map<String, dynamic> product) {
    ss("${product["name"]} added to cart");
    cartItemCount++;
    cartTotal += (product["price"] as double);
    setState(() {});
  }

  void _holdOrder() async {
    bool isConfirmed = await confirm("Hold current order for later?");
    if (isConfirmed) {
      ss("Order held successfully");
      _clearCart();
    }
  }

  void _clearCart() async {
    bool isConfirmed = await confirm("Clear all items from cart?");
    if (isConfirmed) {
      cartItemCount = 0;
      cartTotal = 0.0;
      setState(() {});
      ss("Cart cleared");
    }
  }
}
