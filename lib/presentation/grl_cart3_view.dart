import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCart3View extends StatefulWidget {
  @override
  State<GrlCart3View> createState() => _GrlCart3ViewState();
}

class _GrlCart3ViewState extends State<GrlCart3View> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "MacBook Pro 14-inch",
      "category": "Laptop",
      "price": 1999.99,
      "originalPrice": 2299.99,
      "quantity": 1,
      "image": "https://picsum.photos/120/120?random=1&keyword=laptop",
      "specifications": "M2 Pro, 16GB RAM, 512GB SSD",
      "warranty": "1 Year Apple Warranty",
      "availability": "In Stock",
      "deliveryTime": "2-3 days",
    },
    {
      "id": 2,
      "name": "iPad Air 5th Gen",
      "category": "Tablet",
      "price": 599.99,
      "originalPrice": 649.99,
      "quantity": 1,
      "image": "https://picsum.photos/120/120?random=2&keyword=tablet",
      "specifications": "10.9-inch, M1 Chip, 64GB",
      "warranty": "1 Year Apple Warranty",
      "availability": "In Stock",
      "deliveryTime": "1-2 days",
    },
    {
      "id": 3,
      "name": "AirPods Pro 2nd Gen",
      "category": "Audio",
      "price": 249.99,
      "originalPrice": 249.99,
      "quantity": 2,
      "image": "https://picsum.photos/120/120?random=3&keyword=earbuds",
      "specifications": "Active Noise Cancellation",
      "warranty": "1 Year Apple Warranty",
      "availability": "Limited Stock",
      "deliveryTime": "3-5 days",
    },
  ];

  List<Map<String, dynamic>> savedItems = [
    {
      "id": 4,
      "name": "Magic Keyboard",
      "category": "Accessory",
      "price": 179.99,
      "originalPrice": 199.99,
      "image": "https://picsum.photos/80/80?random=4&keyword=keyboard",
      "specifications": "For iPad Pro",
    },
    {
      "id": 5,
      "name": "Apple Pencil 2nd Gen",
      "category": "Accessory",
      "price": 129.99,
      "originalPrice": 129.99,
      "image": "https://picsum.photos/80/80?random=5&keyword=pencil",
      "specifications": "Wireless Charging",
    },
  ];

  String currentTab = "cart";
  bool showSavedItems = false;

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get savings {
    return cartItems.fold(0.0, (sum, item) => 
        sum + (((item["originalPrice"] as double) - (item["price"] as double)) * (item["quantity"] as int)));
  }

  double get tax {
    return subtotal * 0.0875; // 8.75% tax
  }

  double get total {
    return subtotal + tax;
  }

  void _updateQuantity(int index, int newQuantity) {
    if (newQuantity <= 0) {
      _removeItem(index);
      return;
    }
    cartItems[index]["quantity"] = newQuantity;
    setState(() {});
  }

  void _removeItem(int index) {
    cartItems.removeAt(index);
    setState(() {});
    ss("Item removed from cart");
  }

  void _saveItemForLater(int index) {
    final item = cartItems[index];
    savedItems.add({
      "id": item["id"],
      "name": item["name"],
      "category": item["category"],
      "price": item["price"],
      "originalPrice": item["originalPrice"],
      "image": item["image"],
      "specifications": item["specifications"],
    });
    cartItems.removeAt(index);
    setState(() {});
    ss("Item saved for later");
  }

  void _moveToCart(int index) {
    final item = savedItems[index];
    cartItems.add({
      "id": item["id"],
      "name": item["name"],
      "category": item["category"],
      "price": item["price"],
      "originalPrice": item["originalPrice"],
      "quantity": 1,
      "image": item["image"],
      "specifications": item["specifications"],
      "warranty": "1 Year Apple Warranty",
      "availability": "In Stock",
      "deliveryTime": "2-3 days",
    });
    savedItems.removeAt(index);
    setState(() {});
    ss("Item moved to cart");
  }

  void _removeSavedItem(int index) {
    savedItems.removeAt(index);
    setState(() {});
    ss("Item removed from saved items");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              showSavedItems = !showSavedItems;
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabSelector(),
          Expanded(
            child: showSavedItems ? _buildSavedItems() : _buildCartContent(),
          ),
        ],
      ),
      bottomNavigationBar: !showSavedItems && cartItems.isNotEmpty ? _buildCheckoutBar() : null,
    );
  }

  Widget _buildTabSelector() {
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                showSavedItems = false;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spMd),
                decoration: BoxDecoration(
                  color: !showSavedItems ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: !showSavedItems ? [shadowXs] : null,
                ),
                child: Text(
                  "Cart (${cartItems.length})",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: !showSavedItems ? primaryColor : disabledBoldColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                showSavedItems = true;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spMd),
                decoration: BoxDecoration(
                  color: showSavedItems ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: showSavedItems ? [shadowXs] : null,
                ),
                child: Text(
                  "Saved (${savedItems.length})",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: showSavedItems ? primaryColor : disabledBoldColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    if (cartItems.isEmpty) {
      return _buildEmptyCart();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          if (savings > 0) _buildSavingsBanner(),
          _buildCartItems(),
          _buildOrderSummary(),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: disabledColor,
          ),
          SizedBox(height: spMd),
          Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Browse our products and add items to cart",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spLg),
          Container(
            width: 200,
            child: QButton(
              label: "Continue Shopping",
              onPressed: () {
                //navigateTo('products')
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [successColor, successColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Icon(
            Icons.savings,
            color: Colors.white,
            size: 28,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You're saving \$${savings.currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Total savings on your current cart",
                  style: TextStyle(
                    color: Colors.white.withAlpha(220),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        children: List.generate(cartItems.length, (index) {
          final item = cartItems[index];
          return _buildCartItem(item, index);
        }),
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${item["image"]}",
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _removeItem(index),
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["specifications"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          size: 14,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${item["warranty"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$${((item["price"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            if ((item["originalPrice"] as double) > (item["price"] as double))
                              Text(
                                "\$${((item["originalPrice"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                        _buildQuantitySelector(item, index),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_shipping,
                        size: 16,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Delivery: ${item["deliveryTime"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Save for Later",
                size: bs.sm,
                onPressed: () => _saveItemForLater(index),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(Map<String, dynamic> item, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _updateQuantity(index, (item["quantity"] as int) - 1),
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(
                Icons.remove,
                size: 16,
                color: primaryColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Text(
              "${item["quantity"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _updateQuantity(index, (item["quantity"] as int) + 1),
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(
                Icons.add,
                size: 16,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedItems() {
    if (savedItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              size: 80,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No saved items",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Items you save for later will appear here",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: List.generate(savedItems.length, (index) {
          final item = savedItems[index];
          return _buildSavedItem(item, index);
        }),
      ),
    );
  }

  Widget _buildSavedItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${item["image"]}",
              width: 80,
              height: 80,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${item["specifications"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "\$${((item["price"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Move to Cart",
                        size: bs.sm,
                        onPressed: () => _moveToCart(index),
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () => _removeSavedItem(index),
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.delete,
                          size: 20,
                          color: dangerColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          _buildSummaryRow("Subtotal", "\$${subtotal.currency}"),
          if (savings > 0)
            _buildSummaryRow(
              "Savings", 
              "-\$${savings.currency}",
              color: successColor,
            ),
          _buildSummaryRow("Tax", "\$${tax.currency}"),
          _buildSummaryRow("Shipping", "FREE", color: successColor),
          Divider(height: spLg),
          _buildSummaryRow(
            "Total", 
            "\$${total.currency}",
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? color, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: FontWeight.bold,
              color: color ?? (isTotal ? primaryColor : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: SafeArea(
        child: QButton(
          label: "Proceed to Checkout • \$${total.currency}",
          onPressed: () {
            //navigateTo('checkout')
          },
        ),
      ),
    );
  }
}
