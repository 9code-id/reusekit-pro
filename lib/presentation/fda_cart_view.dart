import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaCartView extends StatefulWidget {
  const FdaCartView({super.key});

  @override
  State<FdaCartView> createState() => _FdaCartViewState();
}

class _FdaCartViewState extends State<FdaCartView> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": "1",
      "name": "Margherita Pizza",
      "restaurant": "Tony's Italian Kitchen",
      "price": 24.99,
      "originalPrice": 29.99,
      "quantity": 2,
      "size": "Medium",
      "addons": ["Extra Cheese", "Mushrooms"],
      "image": "https://picsum.photos/100/100?random=1&keyword=pizza",
      "prepTime": "25-30 min",
      "isAvailable": true,
      "specialInstructions": "Extra crispy crust",
    },
    {
      "id": "2",
      "name": "Caesar Salad",
      "restaurant": "Green Garden Cafe",
      "price": 12.99,
      "originalPrice": 12.99,
      "quantity": 1,
      "size": "Regular",
      "addons": ["Grilled Chicken"],
      "image": "https://picsum.photos/100/100?random=2&keyword=salad",
      "prepTime": "10-15 min",
      "isAvailable": true,
      "specialInstructions": "",
    },
    {
      "id": "3",
      "name": "Beef Burger",
      "restaurant": "Burger Palace",
      "price": 15.99,
      "originalPrice": 15.99,
      "quantity": 1,
      "size": "Large",
      "addons": ["Bacon", "Extra Pickles"],
      "image": "https://picsum.photos/100/100?random=3&keyword=burger",
      "prepTime": "20-25 min",
      "isAvailable": false,
      "specialInstructions": "Medium rare",
    },
    {
      "id": "4",
      "name": "Chocolate Brownie",
      "restaurant": "Sweet Delights",
      "price": 6.99,
      "originalPrice": 8.99,
      "quantity": 2,
      "size": "Regular",
      "addons": ["Vanilla Ice Cream"],
      "image": "https://picsum.photos/100/100?random=4&keyword=brownie",
      "prepTime": "5-10 min",
      "isAvailable": true,
      "specialInstructions": "",
    },
  ];

  String selectedCouponCode = "";
  double deliveryFee = 3.99;
  double serviceFee = 2.50;
  double taxes = 0.0;
  double couponDiscount = 0.0;
  
  List<Map<String, dynamic>> coupons = [
    {
      "code": "SAVE20",
      "title": "20% Off",
      "description": "Get 20% off on orders above \$30",
      "discount": 20,
      "minOrder": 30,
      "type": "percentage",
    },
    {
      "code": "FREE5",
      "title": "Free Delivery",
      "description": "Free delivery on orders above \$25",
      "discount": 3.99,
      "minOrder": 25,
      "type": "delivery",
    },
    {
      "code": "FLAT10",
      "title": "\$10 Off",
      "description": "Get \$10 off on orders above \$50",
      "discount": 10,
      "minOrder": 50,
      "type": "flat",
    },
  ];

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get discount {
    if (selectedCouponCode.isEmpty) return 0.0;
    
    var coupon = coupons.firstWhere(
      (c) => c["code"] == selectedCouponCode,
      orElse: () => {},
    );
    
    if (coupon.isEmpty || subtotal < (coupon["minOrder"] as num)) return 0.0;
    
    if (coupon["type"] == "percentage") {
      return subtotal * ((coupon["discount"] as num) / 100);
    } else if (coupon["type"] == "flat") {
      return (coupon["discount"] as double);
    } else if (coupon["type"] == "delivery") {
      return deliveryFee;
    }
    return 0.0;
  }

  double get finalDeliveryFee {
    if (selectedCouponCode.isNotEmpty) {
      var coupon = coupons.firstWhere(
        (c) => c["code"] == selectedCouponCode,
        orElse: () => {},
      );
      if (coupon.isNotEmpty && coupon["type"] == "delivery" && subtotal >= (coupon["minOrder"] as num)) {
        return 0.0;
      }
    }
    return deliveryFee;
  }

  double get total {
    taxes = subtotal * 0.08; // 8% tax
    return subtotal + finalDeliveryFee + serviceFee + taxes - discount;
  }

  String get estimatedDeliveryTime {
    if (cartItems.isEmpty) return "0 min";
    List<String> times = cartItems.map((item) => item["prepTime"] as String).toList();
    // Extract max time for estimation
    int maxTime = 30; // Default fallback
    return "$maxTime-${maxTime + 10} min";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart (${cartItems.length})"),
        actions: [
          if (cartItems.isNotEmpty)
            QButton(
              icon: Icons.delete_sweep,
              size: bs.sm,
              color: dangerColor,
              onPressed: () async {
                bool isConfirmed = await confirm("Clear entire cart?");
                if (isConfirmed) {
                  setState(() {
                    cartItems.clear();
                    selectedCouponCode = "";
                  });
                  ss("Cart cleared");
                }
              },
            ),
        ],
      ),
      body: cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      bottomNavigationBar: cartItems.isNotEmpty ? _buildCheckoutBar() : null,
    );
  }

  Widget _buildEmptyCart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
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
            "Add some delicious food to get started",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: disabledColor,
            ),
          ),
          SizedBox(height: spLg),
          QButton(
            label: "Browse Restaurants",
            size: bs.md,
            icon: Icons.restaurant,
            onPressed: () {
              // Navigate to restaurants
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Delivery Time Estimate
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, color: primaryColor),
                SizedBox(width: spSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Estimated Delivery",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      estimatedDeliveryTime,
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Cart Items
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Order",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...cartItems.map((item) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: disabledOutlineBorderColor.withAlpha(100)),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${item["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: item["isAvailable"] as bool ? Colors.black : disabledColor,
                                          ),
                                        ),
                                      ),
                                      if (!(item["isAvailable"] as bool))
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: dangerColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "Unavailable",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    "${item["restaurant"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if ((item["addons"] as List).isNotEmpty)
                                    Text(
                                      "Add-ons: ${(item["addons"] as List).join(", ")}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  if ((item["specialInstructions"] as String).isNotEmpty)
                                    Text(
                                      "Note: ${item["specialInstructions"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Text(
                              "Size: ${item["size"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            // Quantity Controls
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: disabledOutlineBorderColor),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  QButton(
                                    icon: Icons.remove,
                                    size: bs.sm,
                                    onPressed: (item["quantity"] as int) > 1 ? () {
                                      setState(() {
                                        item["quantity"] = (item["quantity"] as int) - 1;
                                      });
                                    } : null,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm),
                                    child: Text(
                                      "${item["quantity"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  QButton(
                                    icon: Icons.add,
                                    size: bs.sm,
                                    onPressed: () {
                                      setState(() {
                                        item["quantity"] = (item["quantity"] as int) + 1;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${(((item["price"] as double) * (item["quantity"] as int))).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if ((item["originalPrice"] as double) > (item["price"] as double))
                                  Text(
                                    "\$${(((item["originalPrice"] as double) * (item["quantity"] as int))).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.delete,
                              size: bs.sm,
                              color: dangerColor,
                              onPressed: () async {
                                bool isConfirmed = await confirm("Remove this item from cart?");
                                if (isConfirmed) {
                                  setState(() {
                                    cartItems.removeWhere((element) => element["id"] == item["id"]);
                                  });
                                  ss("Item removed from cart");
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Coupons Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Offers & Coupons",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QHorizontalScroll(
                  children: coupons.map((coupon) {
                    bool isApplicable = subtotal >= (coupon["minOrder"] as num);
                    bool isSelected = selectedCouponCode == coupon["code"];
                    
                    return GestureDetector(
                      onTap: isApplicable ? () {
                        setState(() {
                          selectedCouponCode = isSelected ? "" : coupon["code"];
                        });
                        ss(isSelected ? "Coupon removed" : "Coupon applied");
                      } : null,
                      child: Container(
                        width: 250,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? successColor.withAlpha(20) :
                                 isApplicable ? primaryColor.withAlpha(20) : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? successColor :
                                   isApplicable ? primaryColor : disabledColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${coupon["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? successColor :
                                             isApplicable ? primaryColor : disabledColor,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(Icons.check_circle, color: successColor, size: 20),
                              ],
                            ),
                            Text(
                              "${coupon["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: isApplicable ? disabledBoldColor : disabledColor,
                              ),
                            ),
                            if (!isApplicable)
                              Text(
                                "Min order: \$${((coupon["minOrder"] as num).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Bill Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bill Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildBillRow("Subtotal", subtotal),
                _buildBillRow("Delivery Fee", finalDeliveryFee),
                _buildBillRow("Service Fee", serviceFee),
                _buildBillRow("Taxes", taxes),
                if (discount > 0)
                  _buildBillRow("Discount", -discount, color: successColor),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "\$${total.currency}",
                      style: TextStyle(
                        fontSize: 20,
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
    );
  }

  Widget _buildBillRow(String label, double amount, {Color? color}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
        ),
        Text(
          "${amount < 0 ? '-' : ''}\$${amount.abs().currency}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color ?? Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutBar() {
    bool hasUnavailableItems = cartItems.any((item) => !(item["isAvailable"] as bool));
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasUnavailableItems)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: dangerColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Some items are unavailable. Remove them to continue.",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total: \$${total.currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${cartItems.length} items • $estimatedDeliveryTime",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Checkout",
                size: bs.md,
                icon: Icons.arrow_forward,
                onPressed: hasUnavailableItems ? null : () {
                  // Navigate to checkout
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
