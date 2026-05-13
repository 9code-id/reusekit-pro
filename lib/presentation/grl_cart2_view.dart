import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCart2View extends StatefulWidget {
  @override
  State<GrlCart2View> createState() => _GrlCart2ViewState();
}

class _GrlCart2ViewState extends State<GrlCart2View> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Nike Air Max 270",
      "brand": "Nike",
      "price": 129.99,
      "originalPrice": 159.99,
      "quantity": 1,
      "image": "https://picsum.photos/100/100?random=1&keyword=shoes",
      "color": "White/Black",
      "size": "US 9",
      "rating": 4.8,
      "isWishlisted": true,
    },
    {
      "id": 2,
      "name": "Adidas Ultraboost 22",
      "brand": "Adidas",
      "price": 179.99,
      "originalPrice": 199.99,
      "quantity": 1,
      "image": "https://picsum.photos/100/100?random=2&keyword=sneakers",
      "color": "Core Black",
      "size": "US 10",
      "rating": 4.9,
      "isWishlisted": false,
    },
    {
      "id": 3,
      "name": "Puma RS-X",
      "brand": "Puma",
      "price": 89.99,
      "originalPrice": 119.99,
      "quantity": 2,
      "image": "https://picsum.photos/100/100?random=3&keyword=running",
      "color": "Blue/White",
      "size": "US 8.5",
      "rating": 4.6,
      "isWishlisted": true,
    },
  ];

  String selectedDelivery = "standard";
  List<Map<String, dynamic>> deliveryOptions = [
    {
      "id": "standard",
      "name": "Standard Delivery",
      "description": "5-7 business days",
      "price": 9.99,
      "icon": Icons.local_shipping,
    },
    {
      "id": "express",
      "name": "Express Delivery",
      "description": "2-3 business days",
      "price": 19.99,
      "icon": Icons.flash_on,
    },
    {
      "id": "overnight",
      "name": "Overnight Delivery",
      "description": "Next business day",
      "price": 29.99,
      "icon": Icons.rocket_launch,
    },
  ];

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get deliveryFee {
    final option = deliveryOptions.firstWhere((option) => option["id"] == selectedDelivery);
    return option["price"] as double;
  }

  double get total {
    return subtotal + deliveryFee;
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

  void _toggleWishlist(int index) {
    cartItems[index]["isWishlisted"] = !(cartItems[index]["isWishlisted"] as bool);
    setState(() {});
    if (cartItems[index]["isWishlisted"] as bool) {
      ss("Added to wishlist");
    } else {
      ss("Removed from wishlist");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              //navigateTo('wishlist')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCartHeader(),
            _buildCartItems(),
            _buildDeliveryOptions(),
            _buildOrderSummary(),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
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
      child: Row(
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
                  "Shopping Cart",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${cartItems.length} items • \$${subtotal.currency}",
                  style: TextStyle(
                    color: Colors.white.withAlpha(220),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Text(
              "Save 15%",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
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
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${item["image"]}",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: spXs,
                    right: spXs,
                    child: GestureDetector(
                      onTap: () => _toggleWishlist(index),
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [shadowXs],
                        ),
                        child: Icon(
                          (item["isWishlisted"] as bool) ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: (item["isWishlisted"] as bool) ? dangerColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ],
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
                        SizedBox(width: spSm),
                        Text(
                          "•",
                          style: TextStyle(color: disabledColor),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${item["color"]} • ${item["size"]}",
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
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_offer,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Save \$${(((item["originalPrice"] as double) - (item["price"] as double)) * (item["quantity"] as int)).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
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
                  _toggleWishlist(index);
                  _removeItem(index);
                },
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

  Widget _buildDeliveryOptions() {
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
            "Delivery Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ...List.generate(deliveryOptions.length, (index) {
            final option = deliveryOptions[index];
            final isSelected = selectedDelivery == option["id"];
            
            return GestureDetector(
              onTap: () {
                selectedDelivery = option["id"] as String;
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      option["icon"] as IconData,
                      color: isSelected ? primaryColor : disabledBoldColor,
                      size: 24,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${option["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? primaryColor : Colors.black,
                            ),
                          ),
                          Text(
                            "${option["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${((option["price"] as double)).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? primaryColor : Colors.black,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? primaryColor : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledBoldColor,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            );
          }),
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
          _buildSummaryRow("Delivery", "\$${deliveryFee.currency}"),
          _buildSummaryRow("Tax", "\$${(total * 0.08).currency}"),
          Divider(height: spLg),
          _buildSummaryRow(
            "Total", 
            "\$${(total + (total * 0.08)).currency}",
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
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
              color: isTotal ? primaryColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: SafeArea(
        child: QButton(
          label: "Checkout • \$${(total + (total * 0.08)).currency}",
          onPressed: () {
            //navigateTo('checkout')
          },
        ),
      ),
    );
  }
}
