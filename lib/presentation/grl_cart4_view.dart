import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCart4View extends StatefulWidget {
  @override
  State<GrlCart4View> createState() => _GrlCart4ViewState();
}

class _GrlCart4ViewState extends State<GrlCart4View> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Organic Bananas",
      "category": "Fruits",
      "price": 2.99,
      "unit": "per lb",
      "quantity": 2.5,
      "image": "https://picsum.photos/100/100?random=1&keyword=banana",
      "organic": true,
      "freshness": "Best by 3 days",
      "nutrition": "High in Potassium",
    },
    {
      "id": 2,
      "name": "Fresh Milk",
      "category": "Dairy",
      "price": 4.49,
      "unit": "per gallon",
      "quantity": 1,
      "image": "https://picsum.photos/100/100?random=2&keyword=milk",
      "organic": false,
      "freshness": "Best by 7 days",
      "nutrition": "High in Calcium",
    },
    {
      "id": 3,
      "name": "Whole Wheat Bread",
      "category": "Bakery",
      "price": 3.99,
      "unit": "per loaf",
      "quantity": 2,
      "image": "https://picsum.photos/100/100?random=3&keyword=bread",
      "organic": true,
      "freshness": "Best by 5 days",
      "nutrition": "High in Fiber",
    },
    {
      "id": 4,
      "name": "Farm Fresh Eggs",
      "category": "Dairy",
      "price": 5.99,
      "unit": "per dozen",
      "quantity": 1,
      "image": "https://picsum.photos/100/100?random=4&keyword=eggs",
      "organic": true,
      "freshness": "Best by 14 days",
      "nutrition": "High in Protein",
    },
  ];

  List<Map<String, dynamic>> suggestedItems = [
    {
      "id": 5,
      "name": "Greek Yogurt",
      "price": 6.99,
      "unit": "per container",
      "image": "https://picsum.photos/80/80?random=5&keyword=yogurt",
      "tag": "Goes well with bananas",
    },
    {
      "id": 6,
      "name": "Peanut Butter",
      "price": 4.99,
      "unit": "per jar",
      "image": "https://picsum.photos/80/80?random=6&keyword=peanut",
      "tag": "Perfect for bread",
    },
    {
      "id": 7,
      "name": "Orange Juice",
      "price": 3.99,
      "unit": "per bottle",
      "image": "https://picsum.photos/80/80?random=7&keyword=juice",
      "tag": "Fresh squeezed",
    },
  ];

  String deliveryTime = "today";
  String storeLocation = "Downtown Store";
  double deliveryFee = 5.99;
  double bagFee = 0.10;

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as num).toDouble()));
  }

  double get total {
    return subtotal + deliveryFee + bagFee;
  }

  void _updateQuantity(int index, double newQuantity) {
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

  void _addSuggestedItem(Map<String, dynamic> item) {
    cartItems.add({
      "id": item["id"],
      "name": item["name"],
      "category": "Suggested",
      "price": item["price"],
      "unit": item["unit"],
      "quantity": 1,
      "image": item["image"],
      "organic": false,
      "freshness": "Fresh",
      "nutrition": "Nutritious",
    });
    suggestedItems.removeWhere((suggested) => suggested["id"] == item["id"]);
    setState(() {});
    ss("${item["name"]} added to cart");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery Cart"),
        actions: [
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              _showDeliveryTimeSheet();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDeliveryInfo(),
            _buildCartItems(),
            if (suggestedItems.isNotEmpty) _buildSuggestedItems(),
            _buildOrderSummary(),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildCheckoutBar(),
    );
  }

  Widget _buildDeliveryInfo() {
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
            Icons.location_on,
            color: Colors.white,
            size: 28,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery to $storeLocation",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  deliveryTime == "today" 
                      ? "Today, 2:00 PM - 4:00 PM"
                      : "Tomorrow, 10:00 AM - 12:00 PM",
                  style: TextStyle(
                    color: Colors.white.withAlpha(220),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _showDeliveryTimeSheet,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Text(
                "Change",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Items (${cartItems.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ...List.generate(cartItems.length, (index) {
            final item = cartItems[index];
            return _buildCartItem(item, index);
          }),
        ],
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
      child: Row(
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
              if (item["organic"] as bool)
                Positioned(
                  top: spXs,
                  left: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "ORGANIC",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                  "${item["nutrition"]} • ${item["freshness"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
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
                        Text(
                          "${item["unit"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    _buildQuantitySelector(item, index),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Fresh delivery guaranteed",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
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

  Widget _buildQuantitySelector(Map<String, dynamic> item, int index) {
    final isDecimal = item["category"] == "Fruits" || item["category"] == "Vegetables";
    
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              final currentQty = (item["quantity"] as num).toDouble();
              final newQty = isDecimal ? currentQty - 0.5 : currentQty - 1;
              _updateQuantity(index, newQty);
            },
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
              isDecimal 
                  ? "${(item["quantity"] as num).toStringAsFixed(1)}"
                  : "${(item["quantity"] as num).toInt()}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final currentQty = (item["quantity"] as num).toDouble();
              final newQty = isDecimal ? currentQty + 0.5 : currentQty + 1;
              _updateQuantity(index, newQty);
            },
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

  Widget _buildSuggestedItems() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You might also like",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: List.generate(suggestedItems.length, (index) {
              final item = suggestedItems[index];
              return _buildSuggestedItem(item);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedItem(Map<String, dynamic> item) {
    return Container(
      width: 160,
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
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${item["name"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${item["tag"]}",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${((item["price"] as double)).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () => _addSuggestedItem(item),
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
          _buildSummaryRow("Delivery fee", "\$${deliveryFee.currency}"),
          _buildSummaryRow("Bag fee", "\$${bagFee.currency}"),
          _buildSummaryRow("Service fee", "FREE", color: successColor),
          Divider(height: spLg),
          _buildSummaryRow(
            "Total", 
            "\$${total.currency}",
            isTotal: true,
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.eco,
                  color: successColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "This order includes ${cartItems.where((item) => item["organic"] as bool).length} organic items",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${total.currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              flex: 2,
              child: QButton(
                label: "Place Order",
                onPressed: () {
                  //navigateTo('checkout')
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeliveryTimeSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Delivery Time",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spLg),
              ...["today", "tomorrow"].map((time) {
                return GestureDetector(
                  onTap: () {
                    deliveryTime = time;
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: deliveryTime == time ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: deliveryTime == time ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Text(
                      time == "today" ? "Today (2:00 PM - 4:00 PM)" : "Tomorrow (10:00 AM - 12:00 PM)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: deliveryTime == time ? primaryColor : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
