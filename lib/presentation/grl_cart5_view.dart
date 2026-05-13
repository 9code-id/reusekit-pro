import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCart5View extends StatefulWidget {
  @override
  State<GrlCart5View> createState() => _GrlCart5ViewState();
}

class _GrlCart5ViewState extends State<GrlCart5View> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Premium T-Shirt",
      "brand": "Urban Style",
      "price": 29.99,
      "originalPrice": 39.99,
      "quantity": 2,
      "image": "https://picsum.photos/120/120?random=1&keyword=shirt",
      "color": "Navy Blue",
      "size": "M",
      "inStock": true,
      "rating": 4.5,
      "reviews": 234,
    },
    {
      "id": 2,
      "name": "Denim Jeans",
      "brand": "Classic Fit",
      "price": 79.99,
      "originalPrice": 99.99,
      "quantity": 1,
      "image": "https://picsum.photos/120/120?random=2&keyword=jeans",
      "color": "Dark Blue",
      "size": "32",
      "inStock": true,
      "rating": 4.8,
      "reviews": 456,
    },
    {
      "id": 3,
      "name": "Casual Sneakers",
      "brand": "ComfortStep",
      "price": 89.99,
      "originalPrice": 119.99,
      "quantity": 1,
      "image": "https://picsum.photos/120/120?random=3&keyword=sneakers",
      "color": "White",
      "size": "10",
      "inStock": false,
      "rating": 4.3,
      "reviews": 189,
    },
  ];

  List<Map<String, dynamic>> recentlyViewed = [
    {
      "id": 4,
      "name": "Leather Jacket",
      "brand": "Style Co.",
      "price": 149.99,
      "originalPrice": 199.99,
      "image": "https://picsum.photos/100/100?random=4&keyword=jacket",
      "rating": 4.7,
    },
    {
      "id": 5,
      "name": "Polo Shirt",
      "brand": "Classic Wear",
      "price": 34.99,
      "originalPrice": 44.99,
      "image": "https://picsum.photos/100/100?random=5&keyword=polo",
      "rating": 4.4,
    },
  ];

  String selectedSize = "";
  String selectedColor = "";
  bool showSizeGuide = false;
  String promoCode = "";
  double discountAmount = 0.0;

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get savings {
    return cartItems.fold(0.0, (sum, item) => 
        sum + (((item["originalPrice"] as double) - (item["price"] as double)) * (item["quantity"] as int)));
  }

  double get shipping {
    return subtotal > 50 ? 0.0 : 9.99;
  }

  double get total {
    return subtotal + shipping - discountAmount;
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

  void _applyPromoCode() {
    if (promoCode.toLowerCase() == "save10") {
      discountAmount = subtotal * 0.1;
      ss("10% discount applied!");
    } else if (promoCode.toLowerCase() == "first20") {
      discountAmount = subtotal * 0.2;
      ss("20% first-time discount applied!");
    } else {
      se("Invalid promo code");
      return;
    }
    setState(() {});
  }

  void _addRecentlyViewedItem(Map<String, dynamic> item) {
    cartItems.add({
      "id": item["id"],
      "name": item["name"],
      "brand": item["brand"],
      "price": item["price"],
      "originalPrice": item["originalPrice"],
      "quantity": 1,
      "image": item["image"],
      "color": "Default",
      "size": "M",
      "inStock": true,
      "rating": item["rating"],
      "reviews": 0,
    });
    recentlyViewed.removeWhere((viewed) => viewed["id"] == item["id"]);
    setState(() {});
    ss("${item["name"]} added to cart");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fashion Cart"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              //navigateTo('wishlist')
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              //navigateTo('order_history')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCartHeader(),
            _buildCartItems(),
            _buildPromoCodeSection(),
            if (recentlyViewed.isNotEmpty) _buildRecentlyViewed(),
            _buildOrderSummary(),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildCheckoutBar(),
    );
  }

  Widget _buildCartHeader() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.shopping_bag,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Fashion Cart",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${cartItems.length} items",
                      style: TextStyle(
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),
              if (savings > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "Save \$${savings.currency}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          if (shipping == 0)
            Container(
              margin: EdgeInsets.only(top: spMd),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_shipping,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "FREE shipping on orders over \$50",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
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
      margin: EdgeInsets.symmetric(horizontal: spMd),
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
                        Text(
                          "${item["brand"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
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
                    SizedBox(height: spXs),
                    Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${item["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if ((item["reviews"] as int) > 0) ...[
                          SizedBox(width: spXs),
                          Text(
                            "(${item["reviews"]})",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        _buildVariantChip("Color", "${item["color"]}"),
                        SizedBox(width: spSm),
                        _buildVariantChip("Size", "${item["size"]}"),
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
                    color: (item["inStock"] as bool) ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        (item["inStock"] as bool) ? Icons.check_circle : Icons.warning,
                        size: 16,
                        color: (item["inStock"] as bool) ? successColor : warningColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        (item["inStock"] as bool) ? "In Stock" : "Out of Stock",
                        style: TextStyle(
                          fontSize: 12,
                          color: (item["inStock"] as bool) ? successColor : warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Move to Wishlist",
                size: bs.sm,
                onPressed: () {
                  ss("Item moved to wishlist");
                  _removeItem(index);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVariantChip(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        "$label: $value",
        style: TextStyle(
          fontSize: 12,
          color: disabledBoldColor,
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(Map<String, dynamic> item, int index) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
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
                size: 18,
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
                color: primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _updateQuantity(index, (item["quantity"] as int) + 1),
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(
                Icons.add,
                size: 18,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
      margin: EdgeInsets.all(spMd),
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
            "Promo Code",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Enter promo code",
                  value: promoCode,
                  hint: "SAVE10, FIRST20",
                  onChanged: (value) {
                    promoCode = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Apply",
                size: bs.sm,
                onPressed: promoCode.isNotEmpty ? _applyPromoCode : null,
              ),
            ],
          ),
          if (discountAmount > 0)
            Container(
              margin: EdgeInsets.only(top: spMd),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.discount,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Discount applied: -\$${discountAmount.currency}",
                    style: TextStyle(
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewed() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recently Viewed",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: List.generate(recentlyViewed.length, (index) {
              final item = recentlyViewed[index];
              return _buildRecentlyViewedItem(item);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewedItem(Map<String, dynamic> item) {
    return Container(
      width: 180,
      margin: EdgeInsets.only(right: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${item["image"]}",
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${item["brand"]}",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${item["name"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.star,
                size: 12,
                color: warningColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${item["rating"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  if ((item["originalPrice"] as double) > (item["price"] as double))
                    Text(
                      "\$${((item["originalPrice"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
              GestureDetector(
                onTap: () => _addRecentlyViewedItem(item),
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
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
          if (discountAmount > 0)
            _buildSummaryRow(
              "Promo Discount", 
              "-\$${discountAmount.currency}",
              color: successColor,
            ),
          _buildSummaryRow(
            "Shipping", 
            shipping == 0 ? "FREE" : "\$${shipping.currency}",
            color: shipping == 0 ? successColor : null,
          ),
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
