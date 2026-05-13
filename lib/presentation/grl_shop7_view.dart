import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShop7View extends StatefulWidget {
  @override
  State<GrlShop7View> createState() => _GrlShop7ViewState();
}

class _GrlShop7ViewState extends State<GrlShop7View> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Wireless Headphones",
      "price": 299.99,
      "originalPrice": 399.99,
      "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "brand": "TechSound",
      "color": "Black",
      "size": "Standard",
      "quantity": 2,
      "inStock": true,
      "discount": 25,
    },
    {
      "id": 2,
      "name": "Smart Watch Pro",
      "price": 449.99,
      "originalPrice": 599.99,
      "image": "https://picsum.photos/300/300?random=2&keyword=smartwatch",
      "brand": "WatchTech",
      "color": "Silver",
      "size": "42mm",
      "quantity": 1,
      "inStock": true,
      "discount": 25,
    },
    {
      "id": 3,
      "name": "Running Shoes",
      "price": 129.99,
      "originalPrice": 179.99,
      "image": "https://picsum.photos/300/300?random=3&keyword=shoes",
      "brand": "SportMax",
      "color": "Blue",
      "size": "US 10",
      "quantity": 1,
      "inStock": false,
      "discount": 28,
    },
  ];

  List<Map<String, dynamic>> coupons = [
    {
      "id": 1,
      "code": "SAVE20",
      "title": "20% Off",
      "description": "Get 20% off on orders over \$500",
      "discount": 20,
      "minAmount": 500,
      "maxDiscount": 100,
      "validUntil": "2024-12-31",
      "applicable": true,
    },
    {
      "id": 2,
      "code": "FREESHIP",
      "title": "Free Shipping",
      "description": "Free shipping on all orders",
      "discount": 0,
      "minAmount": 0,
      "maxDiscount": 15,
      "validUntil": "2024-12-31",
      "applicable": true,
    },
    {
      "id": 3,
      "code": "NEWUSER50",
      "title": "\$50 Off",
      "description": "First time purchase discount",
      "discount": 50,
      "minAmount": 200,
      "maxDiscount": 50,
      "validUntil": "2024-12-31",
      "applicable": false,
    },
  ];

  String promoCode = "";
  bool showCoupons = false;
  String selectedCoupon = "";
  double shippingCost = 15.99;
  double taxRate = 0.08;

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get discount {
    if (selectedCoupon.isEmpty) return 0.0;
    
    var coupon = coupons.firstWhere((c) => c["code"] == selectedCoupon);
    double discountAmount = 0.0;
    
    if (coupon["discount"] as int > 0) {
      discountAmount = subtotal * ((coupon["discount"] as int) / 100);
      double maxDiscount = (coupon["maxDiscount"] as int).toDouble();
      discountAmount = discountAmount > maxDiscount ? maxDiscount : discountAmount;
    }
    
    return discountAmount;
  }

  double get finalShippingCost {
    if (selectedCoupon == "FREESHIP" || subtotal > 100) return 0.0;
    return shippingCost;
  }

  double get tax {
    return (subtotal - discount) * taxRate;
  }

  double get total {
    return subtotal - discount + finalShippingCost + tax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
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
            "Add some products to get started",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Continue Shopping",
            size: bs.md,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: [
        // Cart Items
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cart Header
                Row(
                  children: [
                    Text(
                      "Cart Items (${cartItems.length})",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Clear cart confirmation
                      },
                      child: Text(
                        "Clear All",
                        style: TextStyle(
                          fontSize: 14,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Cart Items List
                ...cartItems.map((item) => Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusLg),
                              child: Image.network(
                                "${item["image"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          
                          SizedBox(width: spMd),
                          
                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${item["brand"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "Color: ${item["color"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "Size: ${item["size"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spSm),
                                
                                // Price
                                Row(
                                  children: [
                                    Text(
                                      "\$${(item["price"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if ((item["originalPrice"] as double) > (item["price"] as double)) ...[
                                      SizedBox(width: spSm),
                                      Text(
                                        "\$${(item["originalPrice"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: dangerColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "-${item["discount"]}%",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: dangerColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          // Remove Button
                          GestureDetector(
                            onTap: () {
                              cartItems.removeWhere((cartItem) => cartItem["id"] == item["id"]);
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                Icons.delete_outline,
                                color: dangerColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Stock Status and Quantity
                      Row(
                        children: [
                          // Stock Status
                          Row(
                            children: [
                              Icon(
                                item["inStock"] as bool ? Icons.check_circle : Icons.error,
                                color: item["inStock"] as bool ? successColor : dangerColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                item["inStock"] as bool ? "In Stock" : "Out of Stock",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: item["inStock"] as bool ? successColor : dangerColor,
                                ),
                              ),
                            ],
                          ),
                          
                          Spacer(),
                          
                          // Quantity Controls
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if ((item["quantity"] as int) > 1) {
                                    item["quantity"] = (item["quantity"] as int) - 1;
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: (item["quantity"] as int) > 1 ? primaryColor : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 32,
                                margin: EdgeInsets.symmetric(horizontal: spSm),
                                decoration: BoxDecoration(
                                  border: Border.all(color: disabledOutlineBorderColor),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Center(
                                  child: Text(
                                    "${item["quantity"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (item["inStock"] as bool) {
                                    item["quantity"] = (item["quantity"] as int) + 1;
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: item["inStock"] as bool ? primaryColor : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Item Total
                      Row(
                        children: [
                          Text(
                            "Item Total:",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )).toList(),
                
                SizedBox(height: spMd),
                
                // Coupon Section
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
                      Row(
                        children: [
                          Icon(
                            Icons.local_offer,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Promo Code",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              showCoupons = !showCoupons;
                              setState(() {});
                            },
                            child: Text(
                              "View Coupons",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Promo Code Input
                      Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "Enter promo code",
                              value: promoCode,
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
                            onPressed: () {
                              if (promoCode.isNotEmpty) {
                                var coupon = coupons.where((c) => 
                                    c["code"].toString().toLowerCase() == promoCode.toLowerCase());
                                if (coupon.isNotEmpty && coupon.first["applicable"] as bool) {
                                  selectedCoupon = coupon.first["code"];
                                  promoCode = "";
                                  ss("Coupon applied successfully!");
                                } else {
                                  se("Invalid or expired coupon code");
                                }
                                setState(() {});
                              }
                            },
                          ),
                        ],
                      ),
                      
                      if (selectedCoupon.isNotEmpty) ...[
                        SizedBox(height: spMd),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Coupon '$selectedCoupon' applied",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  selectedCoupon = "";
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.close,
                                  color: successColor,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      
                      if (showCoupons) ...[
                        SizedBox(height: spMd),
                        Text(
                          "Available Coupons",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...coupons.where((coupon) => coupon["applicable"] as bool).map((coupon) => 
                          GestureDetector(
                            onTap: () {
                              if (subtotal >= (coupon["minAmount"] as int)) {
                                selectedCoupon = coupon["code"];
                                showCoupons = false;
                                ss("Coupon applied successfully!");
                                setState(() {});
                              } else {
                                se("Minimum order amount is \$${coupon["minAmount"]}");
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: spSm),
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: selectedCoupon == coupon["code"] ? primaryColor : Colors.transparent,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${coupon["code"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${coupon["title"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${coupon["description"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (subtotal < (coupon["minAmount"] as int))
                                    Text(
                                      "Min \$${coupon["minAmount"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: dangerColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ).toList(),
                      ],
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
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
                      
                      _buildSummaryRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
                      if (discount > 0)
                        _buildSummaryRow("Discount", "-\$${discount.toStringAsFixed(2)}", color: successColor),
                      _buildSummaryRow("Shipping", finalShippingCost > 0 ? "\$${finalShippingCost.toStringAsFixed(2)}" : "FREE", 
                          color: finalShippingCost > 0 ? null : successColor),
                      _buildSummaryRow("Tax", "\$${tax.toStringAsFixed(2)}"),
                      
                      Divider(height: spMd * 2),
                      
                      _buildSummaryRow("Total", "\$${total.toStringAsFixed(2)}", 
                          isTotal: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Bottom Checkout Bar
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [shadowMd],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
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
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: 200,
                    child: QButton(
                      label: "Proceed to Checkout",
                      size: bs.md,
                      onPressed: cartItems.any((item) => !(item["inStock"] as bool)) ? null : () {},
                    ),
                  ),
                ],
              ),
              
              if (cartItems.any((item) => !(item["inStock"] as bool))) ...[
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: warningColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Some items are out of stock. Remove them to proceed.",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? color, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? primaryColor : Colors.black,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: color ?? (isTotal ? primaryColor : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
