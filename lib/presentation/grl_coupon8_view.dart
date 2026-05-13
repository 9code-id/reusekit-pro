import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCoupon8View extends StatefulWidget {
  @override
  State<GrlCoupon8View> createState() => _GrlCoupon8ViewState();
}

class _GrlCoupon8ViewState extends State<GrlCoupon8View> {
  int currentStep = 0;
  String selectedCoupon = "";
  String promoCode = "";
  double orderSubtotal = 85.99;
  double deliveryFee = 5.99;
  double discount = 0.0;
  double tax = 6.88;
  
  List<Map<String, dynamic>> availableCoupons = [
    {
      "id": "1",
      "title": "First Order Discount",
      "description": "Save 25% on your first order",
      "discount": "25% OFF",
      "discountPercent": 25,
      "minOrder": 20.0,
      "maxDiscount": 20.0,
      "code": "FIRST25",
      "validUntil": "Dec 31, 2024",
      "isApplicable": true,
      "color": Color(0xFF4CAF50),
      "icon": Icons.star,
    },
    {
      "id": "2",
      "title": "Free Delivery",
      "description": "No delivery charges on this order",
      "discount": "FREE",
      "discountValue": 5.99,
      "minOrder": 30.0,
      "code": "FREEDEL",
      "validUntil": "Jan 15, 2025",
      "isApplicable": true,
      "color": Color(0xFF2196F3),
      "icon": Icons.local_shipping,
    },
    {
      "id": "3",
      "title": "Premium Member",
      "description": "Exclusive 30% discount for premium members",
      "discount": "30% OFF",
      "discountPercent": 30,
      "minOrder": 50.0,
      "maxDiscount": 25.0,
      "code": "PREMIUM30",
      "validUntil": "Feb 28, 2025",
      "isApplicable": true,
      "color": Color(0xFFFF9800),
      "icon": Icons.workspace_premium,
    },
    {
      "id": "4",
      "title": "Weekend Special",
      "description": "Special weekend offer",
      "discount": "20% OFF",
      "discountPercent": 20,
      "minOrder": 100.0,
      "maxDiscount": 15.0,
      "code": "WEEKEND20",
      "validUntil": "Dec 25, 2024",
      "isApplicable": false,
      "color": Color(0xFF9C27B0),
      "icon": Icons.weekend,
    },
  ];

  List<Map<String, dynamic>> orderItems = [
    {
      "name": "Grilled Chicken Burger",
      "description": "Juicy grilled chicken with fresh lettuce",
      "price": 12.99,
      "quantity": 2,
      "image": "https://picsum.photos/60/60?random=1&keyword=burger",
    },
    {
      "name": "Caesar Salad",
      "description": "Fresh romaine lettuce with caesar dressing",
      "price": 8.99,
      "quantity": 1,
      "image": "https://picsum.photos/60/60?random=2&keyword=salad",
    },
    {
      "name": "French Fries",
      "description": "Crispy golden french fries",
      "price": 4.99,
      "quantity": 3,
      "image": "https://picsum.photos/60/60?random=3&keyword=fries",
    },
    {
      "name": "Chocolate Milkshake",
      "description": "Rich and creamy chocolate shake",
      "price": 5.99,
      "quantity": 2,
      "image": "https://picsum.photos/60/60?random=4&keyword=milkshake",
    },
  ];

  double get totalAfterDiscount {
    return orderSubtotal + deliveryFee - discount + tax;
  }

  void applyCoupon(Map<String, dynamic> coupon) {
    setState(() {
      selectedCoupon = coupon["id"];
      
      if (coupon["discountPercent"] != null) {
        double discountAmount = (orderSubtotal * (coupon["discountPercent"] as int)) / 100;
        discount = discountAmount > (coupon["maxDiscount"] as double) 
            ? (coupon["maxDiscount"] as double) 
            : discountAmount;
      } else if (coupon["discountValue"] != null) {
        discount = coupon["discountValue"] as double;
        if (coupon["code"] == "FREEDEL") {
          deliveryFee = 0.0;
          discount = 5.99;
        }
      }
      
      promoCode = coupon["code"];
      currentStep = 1;
    });
  }

  void removeCoupon() {
    setState(() {
      selectedCoupon = "";
      discount = 0.0;
      deliveryFee = 5.99;
      promoCode = "";
      currentStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Coupon"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Stepper
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Row(
              children: [
                // Step 1: Select Coupon
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: currentStep >= 0 ? primaryColor : disabledColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: currentStep > 0 
                              ? Icon(Icons.check, color: Colors.white, size: 20)
                              : Text(
                                  "1",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Select Coupon",
                          style: TextStyle(
                            fontSize: 12,
                            color: currentStep >= 0 ? primaryColor : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Progress Line
                Container(
                  height: 2,
                  width: 30,
                  color: currentStep >= 1 ? primaryColor : disabledColor,
                ),
                
                // Step 2: Review Order
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: currentStep >= 1 ? primaryColor : disabledColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "2",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Review Order",
                          style: TextStyle(
                            fontSize: 12,
                            color: currentStep >= 1 ? primaryColor : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentStep == 0) ...[
                    // Manual Promo Code Entry
                    Container(
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
                            "Have a promo code?",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QTextField(
                                  label: "Enter promo code",
                                  value: promoCode,
                                  hint: "e.g. SAVE20",
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
                                onPressed: promoCode.isNotEmpty ? () {
                                  // Validate and apply manual code
                                  var foundCoupon = availableCoupons.firstWhere(
                                    (c) => c["code"] == promoCode.toUpperCase(),
                                    orElse: () => {},
                                  );
                                  
                                  if (foundCoupon.isNotEmpty) {
                                    if (foundCoupon["isApplicable"] as bool) {
                                      applyCoupon(foundCoupon);
                                      ss("Promo code applied successfully!");
                                    } else {
                                      se("This coupon doesn't meet minimum order requirements");
                                    }
                                  } else {
                                    se("Invalid promo code");
                                  }
                                } : null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Available Coupons
                    Text(
                      "Available Coupons",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    ...availableCoupons.map((coupon) {
                      bool isApplicable = coupon["isApplicable"] as bool;
                      bool isSelected = selectedCoupon == coupon["id"];
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                          border: isSelected 
                              ? Border.all(color: primaryColor, width: 2)
                              : !isApplicable 
                                  ? Border.all(color: disabledOutlineBorderColor)
                                  : null,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Icon
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: (coupon["color"] as Color).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        coupon["icon"] as IconData,
                                        color: isApplicable ? coupon["color"] as Color : disabledBoldColor,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  
                                  SizedBox(width: spMd),
                                  
                                  // Coupon Info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${coupon["title"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isApplicable ? primaryColor : disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "${coupon["description"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        if (coupon["minOrder"] != null)
                                          Text(
                                            "Min. order: \$${((coupon["minOrder"] as double)).currency}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  
                                  // Discount Badge and Apply Button
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: isApplicable 
                                              ? coupon["color"] as Color 
                                              : disabledColor,
                                          borderRadius: BorderRadius.circular(radiusLg),
                                        ),
                                        child: Text(
                                          "${coupon["discount"]}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: spSm),
                                      QButton(
                                        label: "Apply",
                                        size: bs.sm,
                                        onPressed: isApplicable ? () {
                                          applyCoupon(coupon);
                                          ss("Coupon applied successfully!");
                                        } : null,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              
                              // Terms
                              if (coupon["validUntil"] != null) ...[
                                SizedBox(height: spSm),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Valid until ${coupon["validUntil"]} • Code: ${coupon["code"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              
                              // Not Applicable Message
                              if (!isApplicable) ...[
                                SizedBox(height: spSm),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(
                                      color: warningColor.withAlpha(100),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.warning_amber,
                                        size: 16,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Minimum order requirement not met",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: warningColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                  
                  if (currentStep == 1) ...[
                    // Applied Coupon Summary
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: successColor.withAlpha(100),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Coupon Applied Successfully!",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ),
                              QButton(
                                label: "Remove",
                                size: bs.sm,
                                onPressed: removeCoupon,
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Code: $promoCode • You saved \$${discount.currency}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Order Items
                    Text(
                      "Order Items",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: orderItems.map((item) {
                          double itemTotal = (item["price"] as double) * (item["quantity"] as int);
                          return Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: disabledOutlineBorderColor,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${item["image"]}",
                                    width: 50,
                                    height: 50,
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
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "${item["description"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Qty: ${item["quantity"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${itemTotal.currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Order Summary
                    Container(
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
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spMd),
                          
                          // Subtotal
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Subtotal",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${orderSubtotal.currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Delivery Fee
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Fee",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                deliveryFee == 0 ? "FREE" : "\$${deliveryFee.currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: deliveryFee == 0 ? successColor : primaryColor,
                                  decoration: deliveryFee == 0 ? TextDecoration.none : null,
                                ),
                              ),
                            ],
                          ),
                          
                          // Discount
                          if (discount > 0) ...[
                            SizedBox(height: spSm),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Discount Applied",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "-\$${discount.currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: successColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          
                          SizedBox(height: spSm),
                          
                          // Tax
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tax",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${tax.currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          
                          Divider(height: spLg),
                          
                          // Total
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "\$${totalAfterDiscount.currency}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          
                          if (discount > 0) ...[
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "🎉 You saved \$${discount.currency} with this coupon!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          // Bottom Action
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                if (currentStep == 1) ...[
                  Expanded(
                    child: QButton(
                      label: "Back to Coupons",
                      size: bs.md,
                      onPressed: () {
                        currentStep = 0;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                ],
                Expanded(
                  child: QButton(
                    label: currentStep == 0 
                        ? "Continue without Coupon" 
                        : "Proceed to Payment",
                    size: bs.md,
                    onPressed: () {
                      if (currentStep == 0) {
                        currentStep = 1;
                        setState(() {});
                      } else {
                        ss("Proceeding to payment...");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
