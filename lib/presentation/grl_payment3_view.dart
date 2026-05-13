import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPayment3View extends StatefulWidget {
  @override
  State<GrlPayment3View> createState() => _GrlPayment3ViewState();
}

class _GrlPayment3ViewState extends State<GrlPayment3View> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Wireless Headphones",
      "price": 99.99,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones",
      "category": "Electronics"
    },
    {
      "id": 2,
      "name": "Coffee Maker",
      "price": 149.99,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=2&keyword=coffee",
      "category": "Appliances"
    },
    {
      "id": 3,
      "name": "Running Shoes",
      "price": 79.99,
      "quantity": 2,
      "image": "https://picsum.photos/80/80?random=3&keyword=shoes",
      "category": "Sports"
    },
  ];

  String selectedPaymentMethod = "wallet";
  String deliveryAddress = "";
  String specialInstructions = "";
  String couponCode = "";
  double couponDiscount = 0.0;
  double shippingFee = 15.0;
  double serviceFee = 5.0;
  bool expressDelivery = false;
  
  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "wallet",
      "title": "Digital Wallet",
      "subtitle": "Balance: \$450.00",
      "icon": Icons.account_balance_wallet,
      "color": primaryColor,
    },
    {
      "id": "credit",
      "title": "Credit Card",
      "subtitle": "**** **** **** 4532",
      "icon": Icons.credit_card,
      "color": Colors.blue,
    },
    {
      "id": "bank",
      "title": "Bank Transfer",
      "subtitle": "Direct bank transfer",
      "icon": Icons.account_balance,
      "color": Colors.green,
    },
    {
      "id": "cod",
      "title": "Cash on Delivery",
      "subtitle": "Pay when you receive",
      "icon": Icons.local_shipping,
      "color": Colors.orange,
    },
  ];

  List<Map<String, dynamic>> coupons = [
    {
      "code": "SAVE10",
      "discount": 10.0,
      "type": "percentage",
      "title": "10% Off",
      "description": "Save 10% on your order"
    },
    {
      "code": "FLAT20",
      "discount": 20.0,
      "type": "flat",
      "title": "\$20 Off",
      "description": "Flat \$20 discount"
    },
    {
      "code": "FREESHIP",
      "discount": 15.0,
      "type": "shipping",
      "title": "Free Shipping",
      "description": "Free shipping on orders over \$50"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildOrderItems(),
            _buildDeliveryOptions(),
            _buildPaymentMethods(),
            _buildCouponSection(),
            _buildSpecialInstructions(),
            _buildOrderSummary(),
          ],
        ),
      ),
      bottomNavigationBar: _buildCheckoutBottom(),
    );
  }

  Widget _buildOrderItems() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Items",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${cartItems.length} items",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...cartItems.map((item) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: spSm),
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
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${item["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Qty: ${item["quantity"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Delivery Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QTextField(
            label: "Delivery Address",
            value: deliveryAddress,
            hint: "Enter your delivery address",
            onChanged: (value) {
              deliveryAddress = value;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Express Delivery (+\$10.00)",
                "value": true,
                "checked": expressDelivery,
              }
            ],
            value: [
              if (expressDelivery)
                {
                  "label": "Express Delivery (+\$10.00)",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              expressDelivery = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (expressDelivery)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.flash_on,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Your order will be delivered within 2-4 hours",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Payment Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...paymentMethods.map((method) {
            return GestureDetector(
              onTap: () {
                selectedPaymentMethod = "${method["id"]}";
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spXs),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: selectedPaymentMethod == method["id"]
                        ? primaryColor
                        : disabledOutlineBorderColor,
                    width: selectedPaymentMethod == method["id"] ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: (method["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        method["icon"] as IconData,
                        color: method["color"] as Color,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${method["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${method["subtitle"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (selectedPaymentMethod == method["id"])
                      Icon(
                        Icons.check_circle,
                        color: primaryColor,
                        size: 20,
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCouponSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Coupon & Offers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Coupon Code",
                  value: couponCode,
                  hint: "Enter coupon code",
                  onChanged: (value) {
                    couponCode = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Apply",
                size: bs.sm,
                onPressed: couponCode.isNotEmpty ? () {
                  _applyCoupon();
                } : null,
              ),
            ],
          ),
          if (couponDiscount > 0)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_offer,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Coupon applied successfully! You saved \$${couponDiscount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Text(
            "Available Coupons",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          QHorizontalScroll(
            children: coupons.map((coupon) {
              return Container(
                width: 200,
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(right: spSm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(200)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${coupon["title"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${coupon["description"]}",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(40),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: Colors.white.withAlpha(100)),
                      ),
                      child: Text(
                        "${coupon["code"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
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

  Widget _buildSpecialInstructions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Special Instructions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QMemoField(
            label: "Delivery Instructions",
            value: specialInstructions,
            hint: "Any special instructions for delivery...",
            onChanged: (value) {
              specialInstructions = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    double subtotal = cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
    double deliveryFee = expressDelivery ? shippingFee + 10.0 : shippingFee;
    double total = subtotal + deliveryFee + serviceFee - couponDiscount;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Order Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildSummaryRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
          _buildSummaryRow("Delivery Fee", "\$${deliveryFee.toStringAsFixed(2)}"),
          _buildSummaryRow("Service Fee", "\$${serviceFee.toStringAsFixed(2)}"),
          if (couponDiscount > 0)
            _buildSummaryRow("Coupon Discount", "-\$${couponDiscount.toStringAsFixed(2)}", 
                textColor: successColor),
          Divider(),
          _buildSummaryRow("Total", "\$${total.toStringAsFixed(2)}", 
              isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? textColor, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
            color: textColor ?? (isTotal ? primaryColor : Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutBottom() {
    double subtotal = cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
    double deliveryFee = expressDelivery ? shippingFee + 10.0 : shippingFee;
    double total = subtotal + deliveryFee + serviceFee - couponDiscount;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${total.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              QButton(
                label: "Place Order",
                onPressed: deliveryAddress.isNotEmpty ? () {
                  _placeOrder();
                } : null,
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "By placing this order, you agree to our Terms & Conditions",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _applyCoupon() {
    var coupon = coupons.firstWhere(
      (c) => c["code"].toString().toLowerCase() == couponCode.toLowerCase(),
      orElse: () => {},
    );
    
    if (coupon.isNotEmpty) {
      double subtotal = cartItems.fold(0.0, (sum, item) => 
          sum + ((item["price"] as double) * (item["quantity"] as int)));
      
      if (coupon["type"] == "percentage") {
        couponDiscount = subtotal * ((coupon["discount"] as double) / 100);
      } else if (coupon["type"] == "flat") {
        couponDiscount = coupon["discount"] as double;
      } else if (coupon["type"] == "shipping") {
        couponDiscount = shippingFee;
      }
      
      ss("Coupon applied successfully!");
    } else {
      se("Invalid coupon code");
    }
    setState(() {});
  }

  void _placeOrder() {
    showLoading();
    
    // Simulate order placement
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Order placed successfully!");
    });
  }
}
