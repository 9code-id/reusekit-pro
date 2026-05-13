import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCart7View extends StatefulWidget {
  @override
  State<GrlCart7View> createState() => _GrlCart7ViewState();
}

class _GrlCart7ViewState extends State<GrlCart7View> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Mediterranean Chicken Bowl",
      "restaurant": "Healthy Bites",
      "price": 14.99,
      "originalPrice": 16.99,
      "quantity": 2,
      "image": "https://picsum.photos/120/120?random=1&keyword=food",
      "category": "Healthy",
      "preparationTime": "15-20 min",
      "rating": 4.8,
      "calories": 520,
      "customizations": ["Extra Hummus", "No Onions"],
      "allergens": ["Contains Sesame"],
    },
    {
      "id": 2,
      "name": "Margherita Pizza",
      "restaurant": "Tony's Pizzeria",
      "price": 18.99,
      "originalPrice": 20.99,
      "quantity": 1,
      "image": "https://picsum.photos/120/120?random=2&keyword=pizza",
      "category": "Italian",
      "preparationTime": "20-25 min",
      "rating": 4.6,
      "calories": 890,
      "customizations": ["Large Size", "Extra Cheese"],
      "allergens": ["Contains Gluten", "Contains Dairy"],
    },
    {
      "id": 3,
      "name": "Green Smoothie",
      "restaurant": "Fresh Juice Co.",
      "price": 8.99,
      "originalPrice": 9.99,
      "quantity": 1,
      "image": "https://picsum.photos/120/120?random=3&keyword=smoothie",
      "category": "Beverages",
      "preparationTime": "5-10 min",
      "rating": 4.9,
      "calories": 180,
      "customizations": ["Add Protein Powder"],
      "allergens": [],
    },
  ];

  List<Map<String, dynamic>> nearbyOffers = [
    {
      "id": 4,
      "name": "Caesar Salad",
      "restaurant": "Garden Fresh",
      "price": 12.99,
      "image": "https://picsum.photos/100/100?random=4&keyword=salad",
      "discount": "20% OFF",
      "rating": 4.4,
    },
    {
      "id": 5,
      "name": "Beef Burger",
      "restaurant": "Burger House",
      "price": 15.99,
      "image": "https://picsum.photos/100/100?random=5&keyword=burger",
      "discount": "Buy 1 Get 1",
      "rating": 4.7,
    },
  ];

  String deliveryAddress = "123 Main Street, Downtown";
  String deliveryTime = "30-45 min";
  double deliveryFee = 3.99;
  double serviceFee = 2.49;
  double tip = 0.0;
  List<double> tipOptions = [0.0, 2.0, 3.0, 5.0];

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get total {
    return subtotal + deliveryFee + serviceFee + tip;
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

  void _addNearbyOffer(Map<String, dynamic> offer) {
    cartItems.add({
      "id": offer["id"],
      "name": offer["name"],
      "restaurant": offer["restaurant"],
      "price": offer["price"],
      "originalPrice": offer["price"],
      "quantity": 1,
      "image": offer["image"],
      "category": "Special Offer",
      "preparationTime": "15-20 min",
      "rating": offer["rating"],
      "calories": 400,
      "customizations": [],
      "allergens": [],
    });
    nearbyOffers.removeWhere((item) => item["id"] == offer["id"]);
    setState(() {});
    ss("${offer["name"]} added to cart");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Delivery"),
        actions: [
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              //navigateTo('order_history')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildDeliveryHeader(),
            _buildCartItems(),
            _buildTipSection(),
            if (nearbyOffers.isNotEmpty) _buildNearbyOffers(),
            _buildOrderSummary(),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildCheckoutBar(),
    );
  }

  Widget _buildDeliveryHeader() {
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
                      "Delivering to",
                      style: TextStyle(
                        color: Colors.white.withAlpha(220),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      deliveryAddress,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  //navigateTo('address_selection')
                },
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
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Text(
                  "Estimated delivery: $deliveryTime",
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Order",
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
                      "${item["restaurant"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
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
                          "${item["calories"]} cal",
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
          if ((item["customizations"] as List).isNotEmpty) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customizations:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    (item["customizations"] as List).join(", "),
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if ((item["allergens"] as List).isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    size: 16,
                    color: warningColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Allergens: ${(item["allergens"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildTipSection() {
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
          Row(
            children: [
              Icon(
                Icons.volunteer_activism,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Add Tip for Delivery Partner",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: List.generate(tipOptions.length, (index) {
              final tipAmount = tipOptions[index];
              final isSelected = tip == tipAmount;
              
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    tip = tipAmount;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: index < tipOptions.length - 1 ? spSm : 0),
                    padding: EdgeInsets.symmetric(vertical: spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      tipAmount == 0 ? "No Tip" : "\$${tipAmount.currency}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyOffers() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add More from Nearby",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: List.generate(nearbyOffers.length, (index) {
              final offer = nearbyOffers[index];
              return _buildNearbyOfferItem(offer);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyOfferItem(Map<String, dynamic> offer) {
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
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${offer["image"]}",
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${offer["discount"]}",
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
          SizedBox(height: spSm),
          Text(
            "${offer["name"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${offer["restaurant"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
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
                "${offer["rating"]}",
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
              Text(
                "\$${((offer["price"] as double)).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () => _addNearbyOffer(offer),
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
            "Bill Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          _buildSummaryRow("Item total", "\$${subtotal.currency}"),
          _buildSummaryRow("Delivery fee", "\$${deliveryFee.currency}"),
          _buildSummaryRow("Service fee", "\$${serviceFee.currency}"),
          if (tip > 0)
            _buildSummaryRow("Tip for delivery partner", "\$${tip.currency}", color: successColor),
          Divider(height: spLg),
          _buildSummaryRow(
            "Total Amount", 
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
          label: "Place Order • \$${total.currency}",
          onPressed: () {
            //navigateTo('order_confirmation')
          },
        ),
      ),
    );
  }
}
