import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShop8View extends StatefulWidget {
  @override
  State<GrlShop8View> createState() => _GrlShop8ViewState();
}

class _GrlShop8ViewState extends State<GrlShop8View> {
  int currentStep = 0;
  
  // Customer Information
  String firstName = "John";
  String lastName = "Doe";
  String email = "john.doe@example.com";
  String phone = "+1 (555) 123-4567";
  
  // Shipping Address
  String shippingAddress = "123 Main Street";
  String shippingCity = "New York";
  String shippingState = "NY";
  String shippingZip = "10001";
  String shippingCountry = "United States";
  
  // Billing Address
  bool sameBillingAddress = true;
  String billingAddress = "";
  String billingCity = "";
  String billingState = "";
  String billingZip = "";
  String billingCountry = "";
  
  // Payment Method
  String paymentMethod = "card";
  String cardNumber = "";
  String cardExpiry = "";
  String cardCVC = "";
  String cardName = "";
  
  // Order Summary Data
  List<Map<String, dynamic>> orderItems = [
    {
      "id": 1,
      "name": "Wireless Headphones",
      "price": 299.99,
      "quantity": 2,
      "image": "https://picsum.photos/100/100?random=1&keyword=headphones",
    },
    {
      "id": 2,
      "name": "Smart Watch Pro",
      "price": 449.99,
      "quantity": 1,
      "image": "https://picsum.photos/100/100?random=2&keyword=smartwatch",
    },
  ];
  
  double subtotal = 1049.97;
  double discount = 104.99;
  double shipping = 0.0;
  double tax = 75.60;
  double total = 1020.58;

  List<String> paymentMethods = [
    "Credit/Debit Card",
    "PayPal",
    "Apple Pay",
    "Google Pay",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                _buildStepIndicator(0, "Shipping", isActive: currentStep >= 0),
                Expanded(child: _buildStepLine(currentStep >= 1)),
                _buildStepIndicator(1, "Payment", isActive: currentStep >= 1),
                Expanded(child: _buildStepLine(currentStep >= 2)),
                _buildStepIndicator(2, "Review", isActive: currentStep >= 2),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildStepContent(),
            ),
          ),
          
          // Bottom Navigation
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: QButton(
                      label: "Back",
                      size: bs.md,
                      onPressed: () {
                        currentStep--;
                        setState(() {});
                      },
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: spMd),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: currentStep == 2 ? "Place Order" : "Continue",
                    size: bs.md,
                    onPressed: () {
                      if (currentStep < 2) {
                        currentStep++;
                        setState(() {});
                      } else {
                        _placeOrder();
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

  Widget _buildStepIndicator(int step, String label, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : disabledColor,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Center(
            child: Text(
              "${step + 1}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: spSm),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? primaryColor : disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(bool isActive) {
    return Container(
      height: 2,
      color: isActive ? primaryColor : disabledColor,
      margin: EdgeInsets.only(bottom: 24),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildShippingStep();
      case 1:
        return _buildPaymentStep();
      case 2:
        return _buildReviewStep();
      default:
        return Container();
    }
  }

  Widget _buildShippingStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Shipping Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Customer Info
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Customer Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "First Name",
                      value: firstName,
                      onChanged: (value) {
                        firstName = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QTextField(
                      label: "Last Name",
                      value: lastName,
                      onChanged: (value) {
                        lastName = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              QTextField(
                label: "Email Address",
                value: email,
                onChanged: (value) {
                  email = value;
                  setState(() {});
                },
              ),
              
              QTextField(
                label: "Phone Number",
                value: phone,
                onChanged: (value) {
                  phone = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Shipping Address
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Shipping Address",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              QTextField(
                label: "Street Address",
                value: shippingAddress,
                onChanged: (value) {
                  shippingAddress = value;
                  setState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: QTextField(
                      label: "City",
                      value: shippingCity,
                      onChanged: (value) {
                        shippingCity = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QTextField(
                      label: "State",
                      value: shippingState,
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
                      onChanged: (value) {
                        shippingZip = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    flex: 2,
                    child: QTextField(
                      label: "Country",
                      value: shippingCountry,
                      onChanged: (value) {
                        shippingCountry = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Billing Address Toggle
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
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Same as shipping address",
                          "value": true,
                          "checked": sameBillingAddress,
                        }
                      ],
                      value: [
                        if (sameBillingAddress)
                          {
                            "label": "Same as shipping address",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        if (sameBillingAddress) {
                          sameBillingAddress = values.isNotEmpty;
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              if (!sameBillingAddress) ...[
                SizedBox(height: spMd),
                Text(
                  "Billing Address",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                
                QTextField(
                  label: "Street Address",
                  value: billingAddress,
                  onChanged: (value) {
                    billingAddress = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: QTextField(
                        label: "City",
                        value: billingCity,
                        onChanged: (value) {
                          billingCity = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QTextField(
                        label: "State",
                        value: billingState,
                        onChanged: (value) {
                          billingState = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "ZIP Code",
                        value: billingZip,
                        onChanged: (value) {
                          billingZip = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      flex: 2,
                      child: QTextField(
                        label: "Country",
                        value: billingCountry,
                        onChanged: (value) {
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
      ],
    );
  }

  Widget _buildPaymentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Payment Methods
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
                "Select Payment Method",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: spMd),
              
              ...paymentMethods.map((method) => GestureDetector(
                onTap: () {
                  paymentMethod = method.toLowerCase().replaceAll(" ", "").replaceAll("/", "");
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: paymentMethod == method.toLowerCase().replaceAll(" ", "").replaceAll("/", "") 
                        ? primaryColor.withAlpha(20) 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: paymentMethod == method.toLowerCase().replaceAll(" ", "").replaceAll("/", "") 
                          ? primaryColor 
                          : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getPaymentIcon(method),
                        color: paymentMethod == method.toLowerCase().replaceAll(" ", "").replaceAll("/", "") 
                            ? primaryColor 
                            : disabledBoldColor,
                      ),
                      SizedBox(width: spMd),
                      Text(
                        method,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: paymentMethod == method.toLowerCase().replaceAll(" ", "").replaceAll("/", "") 
                              ? primaryColor 
                              : Colors.black,
                        ),
                      ),
                      Spacer(),
                      if (paymentMethod == method.toLowerCase().replaceAll(" ", "").replaceAll("/", ""))
                        Icon(
                          Icons.check_circle,
                          color: primaryColor,
                        ),
                    ],
                  ),
                ),
              )).toList(),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Card Details (if card payment selected)
        if (paymentMethod == "creditdebitcard")
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Card Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                QTextField(
                  label: "Cardholder Name",
                  value: cardName,
                  onChanged: (value) {
                    cardName = value;
                    setState(() {});
                  },
                ),
                
                QTextField(
                  label: "Card Number",
                  value: cardNumber,
                  onChanged: (value) {
                    cardNumber = value;
                    setState(() {});
                  },
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "MM/YY",
                        value: cardExpiry,
                        onChanged: (value) {
                          cardExpiry = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QTextField(
                        label: "CVC",
                        value: cardCVC,
                        onChanged: (value) {
                          cardCVC = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        
        SizedBox(height: spMd),
        
        // Order Summary
        _buildOrderSummary(),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Review",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Shipping Info Review
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
                  Text(
                    "Shipping Address",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      currentStep = 0;
                      setState(() {});
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "$firstName $lastName",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                shippingAddress,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "$shippingCity, $shippingState $shippingZip",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                shippingCountry,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Phone: $phone",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Payment Info Review
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
                  Text(
                    "Payment Method",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      currentStep = 1;
                      setState(() {});
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Icon(
                    _getPaymentIcon(_getPaymentMethodName()),
                    color: primaryColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    _getPaymentMethodName(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (paymentMethod == "creditdebitcard" && cardNumber.isNotEmpty) ...[
                SizedBox(height: spSm),
                Text(
                  "**** **** **** ${cardNumber.length > 4 ? cardNumber.substring(cardNumber.length - 4) : cardNumber}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Items Review
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
                "Order Items",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              
              ...orderItems.map((item) => Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
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
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Final Order Summary
        _buildOrderSummary(),
        
        SizedBox(height: spMd),
        
        // Terms and Conditions
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "By placing this order, you agree to our Terms & Conditions and Privacy Policy.",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "• Free returns within 30 days\n• 2-year warranty included\n• Secure payment processing",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
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
          _buildSummaryRow("Discount", "-\$${discount.toStringAsFixed(2)}", color: successColor),
          _buildSummaryRow("Shipping", shipping > 0 ? "\$${shipping.toStringAsFixed(2)}" : "FREE", 
              color: shipping > 0 ? null : successColor),
          _buildSummaryRow("Tax", "\$${tax.toStringAsFixed(2)}"),
          
          Divider(height: spMd * 2),
          
          _buildSummaryRow("Total", "\$${total.toStringAsFixed(2)}", isTotal: true),
        ],
      ),
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

  IconData _getPaymentIcon(String method) {
    switch (method.toLowerCase()) {
      case "credit/debit card":
        return Icons.credit_card;
      case "paypal":
        return Icons.account_balance_wallet;
      case "apple pay":
        return Icons.phone_android;
      case "google pay":
        return Icons.contactless;
      default:
        return Icons.payment;
    }
  }

  String _getPaymentMethodName() {
    switch (paymentMethod) {
      case "creditdebitcard":
        return "Credit/Debit Card";
      case "paypal":
        return "PayPal";
      case "applepay":
        return "Apple Pay";
      case "googlepay":
        return "Google Pay";
      default:
        return "Credit/Debit Card";
    }
  }

  void _placeOrder() {
    showLoading();
    
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Order placed successfully!");
      
      // Navigate to order confirmation
      // navigateTo(OrderConfirmationView());
    });
  }
}
