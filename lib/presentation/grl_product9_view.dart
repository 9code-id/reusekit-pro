import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProduct9View extends StatefulWidget {
  @override
  State<GrlProduct9View> createState() => _GrlProduct9ViewState();
}

class _GrlProduct9ViewState extends State<GrlProduct9View> {
  List<Map<String, dynamic>> cartItems = [];
  String promoCode = '';
  double shippingCost = 0.0;
  double taxRate = 0.08;
  String selectedPaymentMethod = 'credit_card';
  String selectedShippingMethod = 'standard';

  List<Map<String, dynamic>> paymentMethods = [
    {"label": "Credit Card", "value": "credit_card", "icon": Icons.credit_card},
    {"label": "PayPal", "value": "paypal", "icon": Icons.payment},
    {"label": "Apple Pay", "value": "apple_pay", "icon": Icons.phone_iphone},
    {"label": "Google Pay", "value": "google_pay", "icon": Icons.account_balance_wallet},
  ];

  List<Map<String, dynamic>> shippingMethods = [
    {"label": "Standard Shipping", "value": "standard", "cost": 0.0, "time": "5-7 business days"},
    {"label": "Express Shipping", "value": "express", "cost": 9.99, "time": "2-3 business days"},
    {"label": "Overnight Shipping", "value": "overnight", "cost": 24.99, "time": "Next business day"},
  ];

  @override
  void initState() {
    super.initState();
    _initializeCart();
  }

  void _initializeCart() {
    cartItems = [
      {
        "id": 1,
        "name": "Wireless Bluetooth Headphones",
        "brand": "TechSound",
        "price": 79.99,
        "originalPrice": 99.99,
        "image": "https://picsum.photos/300/300?random=1&keyword=headphones",
        "quantity": 2,
        "inStock": true,
        "variant": "Midnight Black",
        "warranty": 12,
      },
      {
        "id": 2,
        "name": "Smart Fitness Watch",
        "brand": "FitTech",
        "price": 199.99,
        "originalPrice": 249.99,
        "image": "https://picsum.photos/300/300?random=2&keyword=smartwatch",
        "quantity": 1,
        "inStock": true,
        "variant": "Space Gray",
        "warranty": 24,
      },
      {
        "id": 3,
        "name": "USB-C Fast Charging Cable",
        "brand": "PowerLink",
        "price": 19.99,
        "originalPrice": 29.99,
        "image": "https://picsum.photos/300/300?random=3&keyword=cable",
        "quantity": 3,
        "inStock": true,
        "variant": "3ft Black",
        "warranty": 6,
      },
    ];
  }

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
      sum + ((item["price"] as double) * (item["quantity"] as int))
    );
  }

  double get totalSavings {
    return cartItems.fold(0.0, (sum, item) => 
      sum + (((item["originalPrice"] as double) - (item["price"] as double)) * (item["quantity"] as int))
    );
  }

  double get tax {
    return subtotal * taxRate;
  }

  double get shipping {
    final selectedMethod = shippingMethods.firstWhere(
      (method) => method["value"] == selectedShippingMethod
    );
    return selectedMethod["cost"] as double;
  }

  double get total {
    return subtotal + tax + shipping;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () async {
              bool isConfirmed = await confirm("Clear all items from cart?");
              if (isConfirmed) {
                setState(() {
                  cartItems.clear();
                });
                ss("Cart cleared");
              }
            },
          ),
        ],
      ),
      body: cartItems.isEmpty 
          ? _buildEmptyCart()
          : Column(
              children: [
                // Cart Items
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cart Summary Header
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [primaryColor, successColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.shopping_cart, color: Colors.white, size: 24),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${cartItems.length} Items in Cart",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "You're saving \$${totalSavings.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withAlpha(200),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "\$${subtotal.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: spMd),

                        // Cart Items List
                        ...cartItems.map((item) => _buildCartItem(item)),

                        SizedBox(height: spMd),

                        // Promo Code Section
                        _buildPromoCodeSection(),

                        SizedBox(height: spMd),

                        // Shipping Methods
                        _buildShippingMethodSection(),

                        SizedBox(height: spMd),

                        // Payment Methods
                        _buildPaymentMethodSection(),

                        SizedBox(height: spMd),

                        // Order Summary
                        _buildOrderSummary(),
                      ],
                    ),
                  ),
                ),

                // Checkout Button
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
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
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Continue Shopping",
                              size: bs.md,
                              onPressed: () {
                                // navigateTo(ProductCatalogView());
                              },
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            flex: 2,
                            child: QButton(
                              label: "Proceed to Checkout",
                              size: bs.md,
                              onPressed: () {
                                _processCheckout();
                              },
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

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 120,
              color: disabledBoldColor,
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
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Start Shopping",
              size: bs.md,
              onPressed: () {
                _initializeCart();
                setState(() {});
                ss("Sample products added to cart");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusLg),
              child: Image.network(
                "${item["image"]}",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: spMd),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Variant: ${item["variant"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
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
                      if ((item["originalPrice"] as double) > (item["price"] as double))
                        Padding(
                          padding: EdgeInsets.only(left: spSm),
                          child: Text(
                            "\$${(item["originalPrice"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "${item["warranty"]} months warranty",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      if (!(item["inStock"] as bool))
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
                            "Out of Stock",
                            style: TextStyle(
                              fontSize: 10,
                              color: dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: spMd),

            // Quantity Controls
            Column(
              children: [
                // Quantity Controls
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((item["quantity"] as int) < 10) {
                            setState(() {
                              item["quantity"] = (item["quantity"] as int) + 1;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          child: Icon(Icons.add, size: 16),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        child: Text(
                          "${item["quantity"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if ((item["quantity"] as int) > 1) {
                            setState(() {
                              item["quantity"] = (item["quantity"] as int) - 1;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          child: Icon(Icons.remove, size: 16),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spSm),

                // Item Total
                Text(
                  "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                SizedBox(height: spSm),

                // Remove Button
                GestureDetector(
                  onTap: () async {
                    bool isConfirmed = await confirm("Remove ${item["name"]} from cart?");
                    if (isConfirmed) {
                      setState(() {
                        cartItems.removeWhere((cartItem) => cartItem["id"] == item["id"]);
                      });
                      ss("Item removed from cart");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.delete,
                      size: 16,
                      color: dangerColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
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
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter promo code",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      promoCode = value;
                    },
                  ),
                ),
              ),
              SizedBox(width: spMd),
              QButton(
                label: "Apply",
                size: bs.sm,
                onPressed: () {
                  if (promoCode.isNotEmpty) {
                    ss("Promo code applied successfully!");
                  } else {
                    sw("Please enter a promo code");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShippingMethodSection() {
    return Container(
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
            "Shipping Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ...shippingMethods.map((method) => GestureDetector(
            onTap: () {
              setState(() {
                selectedShippingMethod = method["value"];
              });
            },
            child: Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: selectedShippingMethod == method["value"]
                    ? primaryColor.withAlpha(20)
                    : Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: selectedShippingMethod == method["value"]
                      ? primaryColor
                      : Colors.grey[300]!,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: selectedShippingMethod == method["value"]
                          ? primaryColor
                          : Colors.transparent,
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: selectedShippingMethod == method["value"]
                        ? Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${method["label"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${method["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    (method["cost"] as double) > 0
                        ? "\$${(method["cost"] as double).toStringAsFixed(2)}"
                        : "FREE",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: (method["cost"] as double) > 0 ? primaryColor : successColor,
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Container(
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
            "Payment Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: paymentMethods.map((method) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedPaymentMethod = method["value"];
                });
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: selectedPaymentMethod == method["value"]
                      ? primaryColor.withAlpha(20)
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: selectedPaymentMethod == method["value"]
                        ? primaryColor
                        : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      method["icon"],
                      color: selectedPaymentMethod == method["value"]
                          ? primaryColor
                          : disabledBoldColor,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Text(
                        "${method["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedPaymentMethod == method["value"]
                              ? primaryColor
                              : disabledBoldColor,
                        ),
                      ),
                    ),
                    if (selectedPaymentMethod == method["value"])
                      Icon(Icons.check_circle, color: primaryColor, size: 20),
                  ],
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
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
          _buildSummaryRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
          _buildSummaryRow("Shipping", shipping > 0 ? "\$${shipping.toStringAsFixed(2)}" : "FREE"),
          _buildSummaryRow("Tax", "\$${tax.toStringAsFixed(2)}"),
          if (totalSavings > 0)
            _buildSummaryRow("You Save", "-\$${totalSavings.toStringAsFixed(2)}", color: successColor),
          Divider(),
          _buildSummaryRow(
            "Total",
            "\$${total.toStringAsFixed(2)}",
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
              fontSize: isTotal ? fsH6 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? fsH5 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: color ?? (isTotal ? primaryColor : null),
            ),
          ),
        ],
      ),
    );
  }

  void _processCheckout() {
    if (cartItems.isEmpty) {
      sw("Your cart is empty");
      return;
    }

    if (selectedPaymentMethod.isEmpty) {
      sw("Please select a payment method");
      return;
    }

    // Simulate checkout process
    ss("Order placed successfully! Order confirmation will be sent to your email.");
    
    // Clear cart after successful checkout
    setState(() {
      cartItems.clear();
    });
  }
}
