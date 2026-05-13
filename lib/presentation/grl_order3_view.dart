import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOrder3View extends StatefulWidget {
  @override
  State<GrlOrder3View> createState() => _GrlOrder3ViewState();
}

class _GrlOrder3ViewState extends State<GrlOrder3View> {
  final formKey = GlobalKey<FormState>();
  
  // Customer Information
  String customerName = "";
  String customerEmail = "";
  String customerPhone = "";
  
  // Shipping Information
  String shippingAddress = "";
  String shippingCity = "";
  String shippingState = "";
  String shippingZip = "";
  String shippingCountry = "United States";
  String shippingMethod = "Standard";
  
  // Billing Information
  bool sameAsShipping = true;
  String billingAddress = "";
  String billingCity = "";
  String billingState = "";
  String billingZip = "";
  String billingCountry = "United States";
  
  // Payment Information
  String paymentMethod = "Credit Card";
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";
  
  // Order Items
  List<Map<String, dynamic>> cartItems = [
    {
      "id": "1",
      "name": "Wireless Bluetooth Headphones",
      "price": 79.99,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones"
    },
    {
      "id": "2", 
      "name": "Phone Protective Case",
      "price": 24.99,
      "quantity": 2,
      "image": "https://picsum.photos/80/80?random=2&keyword=phone"
    },
    {
      "id": "3",
      "name": "USB-C Cable 2m",
      "price": 15.99,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=3&keyword=cable"
    }
  ];
  
  List<Map<String, dynamic>> shippingOptions = [
    {"label": "Standard (5-7 days)", "value": "Standard"},
    {"label": "Express (2-3 days)", "value": "Express"},
    {"label": "Overnight (1 day)", "value": "Overnight"},
  ];
  
  List<Map<String, dynamic>> paymentOptions = [
    {"label": "Credit Card", "value": "Credit Card"},
    {"label": "Debit Card", "value": "Debit Card"},
    {"label": "PayPal", "value": "PayPal"},
    {"label": "Apple Pay", "value": "Apple Pay"},
  ];
  
  List<Map<String, dynamic>> countryOptions = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
  ];

  double get subtotal => cartItems.fold(0.0, (sum, item) => sum + ((item["price"] as num).toDouble() * (item["quantity"] as int)));
  double get shippingCost => shippingMethod == "Standard" ? 9.99 : shippingMethod == "Express" ? 19.99 : 29.99;
  double get tax => subtotal * 0.08;
  double get total => subtotal + shippingCost + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Place Order"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              _showCartSummary();
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Customer Information
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Customer Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Full Name",
                      value: customerName,
                      validator: Validator.required,
                      onChanged: (value) {
                        customerName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Email Address",
                      value: customerEmail,
                      validator: Validator.email,
                      onChanged: (value) {
                        customerEmail = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Phone Number",
                      value: customerPhone,
                      validator: Validator.required,
                      onChanged: (value) {
                        customerPhone = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Shipping Information
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Shipping Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Street Address",
                      value: shippingAddress,
                      validator: Validator.required,
                      onChanged: (value) {
                        shippingAddress = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "City",
                            value: shippingCity,
                            validator: Validator.required,
                            onChanged: (value) {
                              shippingCity = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "State",
                            value: shippingState,
                            validator: Validator.required,
                            onChanged: (value) {
                              shippingState = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "ZIP Code",
                            value: shippingZip,
                            validator: Validator.required,
                            onChanged: (value) {
                              shippingZip = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Country",
                            items: countryOptions,
                            value: shippingCountry,
                            onChanged: (value, label) {
                              shippingCountry = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Shipping Method",
                      items: shippingOptions,
                      value: shippingMethod,
                      onChanged: (value, label) {
                        shippingMethod = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Billing Information
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Billing Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Same as shipping address",
                          "value": true,
                          "checked": sameAsShipping,
                        }
                      ],
                      value: [if (sameAsShipping) {"label": "Same as shipping address", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        sameAsShipping = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    if (!sameAsShipping) ...[
                      QTextField(
                        label: "Billing Address",
                        value: billingAddress,
                        validator: Validator.required,
                        onChanged: (value) {
                          billingAddress = value;
                          setState(() {});
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "City",
                              value: billingCity,
                              validator: Validator.required,
                              onChanged: (value) {
                                billingCity = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QTextField(
                              label: "State",
                              value: billingState,
                              validator: Validator.required,
                              onChanged: (value) {
                                billingState = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "ZIP Code",
                              value: billingZip,
                              validator: Validator.required,
                              onChanged: (value) {
                                billingZip = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QDropdownField(
                              label: "Country",
                              items: countryOptions,
                              value: billingCountry,
                              onChanged: (value, label) {
                                billingCountry = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Payment Information
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Payment Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Payment Method",
                      items: paymentOptions,
                      value: paymentMethod,
                      onChanged: (value, label) {
                        paymentMethod = value;
                        setState(() {});
                      },
                    ),
                    if (paymentMethod == "Credit Card" || paymentMethod == "Debit Card") ...[
                      QTextField(
                        label: "Cardholder Name",
                        value: cardholderName,
                        validator: Validator.required,
                        onChanged: (value) {
                          cardholderName = value;
                          setState(() {});
                        },
                      ),
                      QTextField(
                        label: "Card Number",
                        value: cardNumber,
                        validator: Validator.required,
                        onChanged: (value) {
                          cardNumber = value;
                          setState(() {});
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "Expiry Date (MM/YY)",
                              value: expiryDate,
                              validator: Validator.required,
                              onChanged: (value) {
                                expiryDate = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QTextField(
                              label: "CVV",
                              value: cvv,
                              validator: Validator.required,
                              onChanged: (value) {
                                cvv = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Order Summary
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
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
                        color: primaryColor,
                      ),
                    ),
                    
                    // Items
                    ...cartItems.map((item) {
                      return Container(
                        padding: EdgeInsets.all(spXs),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusXs),
                                image: DecorationImage(
                                  image: NetworkImage("${item["image"]}"),
                                  fit: BoxFit.cover,
                                ),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
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
                              "\$${(((item["price"] as num).toDouble()) * (item["quantity"] as int)).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    
                    Divider(color: disabledOutlineBorderColor),
                    
                    // Pricing
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Subtotal",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${subtotal.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Shipping ($shippingMethod)",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${shippingCost.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Tax",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${tax.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Divider(color: disabledOutlineBorderColor),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Total",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${total.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Place Order Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Place Order - \$${total.toStringAsFixed(2)}",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _placeOrder();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCartSummary() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledOutlineBorderColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              Text(
                "Cart Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              ...cartItems.map((item) {
                return Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusXs),
                        image: DecorationImage(
                          image: NetworkImage("${item["image"]}"),
                          fit: BoxFit.cover,
                        ),
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
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Qty: ${item["quantity"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${(((item["price"] as num).toDouble()) * (item["quantity"] as int)).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                );
              }).toList(),
              
              Divider(color: disabledOutlineBorderColor),
              
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    "\$${total.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _placeOrder() async {
    showLoading();
    
    // Simulate order processing
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    ss("Order placed successfully! Order ID: ORD-${DateTime.now().millisecondsSinceEpoch}");
    
    // Navigate to order confirmation or back to home
    //offAll(OrderConfirmationView());
  }
}
