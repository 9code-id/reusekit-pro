import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsCheckoutView extends StatefulWidget {
  const EcsCheckoutView({super.key});

  @override
  State<EcsCheckoutView> createState() => _EcsCheckoutViewState();
}

class _EcsCheckoutViewState extends State<EcsCheckoutView> {
  int currentStep = 0;
  bool loading = false;
  
  // Delivery Information
  String selectedAddress = "home";
  String deliveryInstructions = "";
  String selectedDeliveryMethod = "standard";
  
  // Payment Information  
  String selectedPaymentMethod = "credit_card";
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardHolderName = "";
  bool savePaymentInfo = false;
  
  // Order Summary
  List<Map<String, dynamic>> orderItems = [
    {
      "id": 1,
      "name": "Apple iPhone 15 Pro Max 256GB",
      "price": 1199.99,
      "quantity": 1,
      "image": "https://picsum.photos/300/300?random=1&keyword=iphone",
    },
    {
      "id": 2,
      "name": "Sony WH-1000XM5 Headphones",
      "price": 329.99,
      "quantity": 2,
      "image": "https://picsum.photos/300/300?random=4&keyword=headphones",
    },
  ];
  
  List<Map<String, dynamic>> addresses = [
    {
      "id": "home",
      "label": "Home",
      "name": "John Doe",
      "address": "123 Main Street, Apt 4B",
      "city": "New York",
      "zipcode": "10001",
      "phone": "+1 (555) 123-4567",
      "is_default": true,
    },
    {
      "id": "office",
      "label": "Office",
      "name": "John Doe",
      "address": "456 Business Ave, Suite 100",
      "city": "New York", 
      "zipcode": "10002",
      "phone": "+1 (555) 987-6543",
      "is_default": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Center(
              child: Text(
                "Step ${currentStep + 1} of 3",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : Column(
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
                _buildStepIndicator(0, "Delivery", Icons.local_shipping),
                Expanded(
                  child: Container(
                    height: 2,
                    color: currentStep > 0 ? primaryColor : disabledColor,
                  ),
                ),
                _buildStepIndicator(1, "Payment", Icons.payment),
                Expanded(
                  child: Container(
                    height: 2,
                    color: currentStep > 1 ? primaryColor : disabledColor,
                  ),
                ),
                _buildStepIndicator(2, "Review", Icons.receipt),
              ],
            ),
          ),

          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  if (currentStep == 0) _buildDeliveryStep(),
                  if (currentStep == 1) _buildPaymentStep(),
                  if (currentStep == 2) _buildReviewStep(),
                ],
              ),
            ),
          ),

          // Bottom Navigation
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
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
                if (currentStep > 0) SizedBox(width: spSm),
                Expanded(
                  flex: currentStep == 0 ? 1 : 2,
                  child: QButton(
                    label: currentStep == 2 ? "Place Order" : "Continue",
                    icon: currentStep == 2 ? Icons.check : Icons.arrow_forward,
                    size: bs.md,
                    onPressed: () => _handleContinue(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String title, IconData icon) {
    final isActive = currentStep >= step;
    final isCompleted = currentStep > step;
    
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : disabledColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check : icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? primaryColor : disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivery Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spMd),

        // Delivery Address
        Text(
          "Delivery Address",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),

        Column(
          children: addresses.map((address) {
            final isSelected = selectedAddress == address["id"];
            
            return GestureDetector(
              onTap: () {
                selectedAddress = "${address["id"]}";
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                          : null,
                    ),
                    SizedBox(width: spMd),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${address["label"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (address["is_default"] as bool) ...[
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Default",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${address["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${address["address"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${address["city"]}, ${address["zipcode"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${address["phone"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Icon(
                      Icons.edit,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        // Add New Address Button
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(color: primaryColor, style: BorderStyle.solid),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "Add New Address",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: spMd),

        // Delivery Method
        Text(
          "Delivery Method",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),

        Column(
          children: [
            {
              "id": "standard",
              "title": "Standard Delivery",
              "subtitle": "5-7 business days",
              "price": "FREE",
              "icon": Icons.local_shipping,
            },
            {
              "id": "express",
              "title": "Express Delivery",
              "subtitle": "2-3 business days",
              "price": "\$9.99",
              "icon": Icons.speed,
            },
            {
              "id": "overnight",
              "title": "Overnight Delivery",
              "subtitle": "Next business day",
              "price": "\$19.99",
              "icon": Icons.flash_on,
            },
          ].map((method) {
            final isSelected = selectedDeliveryMethod == method["id"];
            
            return GestureDetector(
              onTap: () {
                selectedDeliveryMethod = "${method["id"]}";
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                          : null,
                    ),
                    SizedBox(width: spMd),
                    
                    Icon(
                      method["icon"] as IconData,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spMd),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${method["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
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
                    
                    Text(
                      "${method["price"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: method["price"] == "FREE" ? successColor : primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        SizedBox(height: spMd),

        // Delivery Instructions
        Text(
          "Delivery Instructions (Optional)",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),

        QTextField(
          label: "Special instructions for delivery",
          value: deliveryInstructions,
          hint: "e.g., Leave at front door, Ring doorbell, etc.",
          onChanged: (value) {
            deliveryInstructions = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildPaymentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spMd),

        // Payment Methods
        Text(
          "Payment Method",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),

        Column(
          children: [
            {
              "id": "credit_card",
              "title": "Credit/Debit Card",
              "subtitle": "Visa, Mastercard, Amex",
              "icon": Icons.credit_card,
            },
            {
              "id": "paypal",
              "title": "PayPal",
              "subtitle": "Pay with your PayPal account",
              "icon": Icons.account_balance_wallet,
            },
            {
              "id": "apple_pay",
              "title": "Apple Pay",
              "subtitle": "Touch ID or Face ID",
              "icon": Icons.phone_iphone,
            },
            {
              "id": "google_pay",
              "title": "Google Pay",
              "subtitle": "Pay with Google",
              "icon": Icons.g_mobiledata,
            },
          ].map((method) {
            final isSelected = selectedPaymentMethod == method["id"];
            
            return GestureDetector(
              onTap: () {
                selectedPaymentMethod = "${method["id"]}";
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                          : null,
                    ),
                    SizedBox(width: spMd),
                    
                    Icon(
                      method["icon"] as IconData,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spMd),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${method["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
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
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        // Credit Card Form
        if (selectedPaymentMethod == "credit_card") ...[
          SizedBox(height: spMd),
          
          Text(
            "Card Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),

          Column(
            spacing: spSm,
            children: [
              QTextField(
                label: "Card Holder Name",
                value: cardHolderName,
                hint: "Full name on card",
                onChanged: (value) {
                  cardHolderName = value;
                  setState(() {});
                },
              ),
              
              QTextField(
                label: "Card Number",
                value: cardNumber,
                hint: "1234 5678 9012 3456",
                onChanged: (value) {
                  cardNumber = value;
                  setState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Expiry Date",
                      value: expiryDate,
                      hint: "MM/YY",
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
                      hint: "123",
                      onChanged: (value) {
                        cvv = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: spSm),

          Row(
            children: [
              Checkbox(
                value: savePaymentInfo,
                activeColor: primaryColor,
                onChanged: (value) {
                  savePaymentInfo = value ?? false;
                  setState(() {});
                },
              ),
              Expanded(
                child: Text(
                  "Save this card for future purchases",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildReviewStep() {
    final subtotal = orderItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
    final shipping = selectedDeliveryMethod == "standard" ? 0.0 : 
                    selectedDeliveryMethod == "express" ? 9.99 : 19.99;
    final total = subtotal + shipping;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Review",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spMd),

        // Order Items
        Text(
          "Order Items",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),

        Column(
          children: orderItems.map((item) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
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
                  SizedBox(width: spMd),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item["name"]}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
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
        ),

        SizedBox(height: spMd),

        // Delivery Summary
        Text(
          "Delivery Details",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),

        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery Address:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(_getSelectedAddressText()),
              
              SizedBox(height: spSm),
              
              Text(
                "Delivery Method:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(_getSelectedDeliveryText()),
              
              if (deliveryInstructions.isNotEmpty) ...[
                SizedBox(height: spSm),
                Text(
                  "Instructions:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(deliveryInstructions),
              ],
            ],
          ),
        ),

        SizedBox(height: spMd),

        // Payment Summary
        Text(
          "Payment Method",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),

        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Text(_getSelectedPaymentText()),
        ),

        SizedBox(height: spMd),

        // Order Total
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal:"),
                  Text("\$${subtotal.toStringAsFixed(2)}"),
                ],
              ),
              SizedBox(height: spXs),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping:"),
                  Text(
                    shipping == 0 ? "FREE" : "\$${shipping.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: shipping == 0 ? successColor : Colors.black,
                      fontWeight: shipping == 0 ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tax:"),
                  Text("\$${(total * 0.08).toStringAsFixed(2)}"),
                ],
              ),
              
              Divider(height: spMd * 2),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${(total * 1.08).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: fsH6,
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
    );
  }

  String _getSelectedAddressText() {
    final address = addresses.firstWhere(
      (addr) => addr["id"] == selectedAddress,
      orElse: () => addresses.first,
    );
    return "${address["name"]}\n${address["address"]}\n${address["city"]}, ${address["zipcode"]}";
  }

  String _getSelectedDeliveryText() {
    switch (selectedDeliveryMethod) {
      case "express":
        return "Express Delivery (2-3 business days) - \$9.99";
      case "overnight":
        return "Overnight Delivery (Next business day) - \$19.99";
      default:
        return "Standard Delivery (5-7 business days) - FREE";
    }
  }

  String _getSelectedPaymentText() {
    switch (selectedPaymentMethod) {
      case "paypal":
        return "PayPal";
      case "apple_pay":
        return "Apple Pay";
      case "google_pay":
        return "Google Pay";
      default:
        return cardNumber.isNotEmpty 
          ? "Credit Card ending in ${cardNumber.substring(cardNumber.length - 4)}"
          : "Credit/Debit Card";
    }
  }

  void _handleContinue() {
    if (currentStep < 2) {
      currentStep++;
      setState(() {});
    } else {
      _placeOrder();
    }
  }

  void _placeOrder() {
    loading = true;
    setState(() {});
    
    // Simulate order placement
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Order placed successfully!");
      // Navigate to order confirmation
    });
  }
}
