import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaGuestCheckoutView extends StatefulWidget {
  const SpaGuestCheckoutView({super.key});

  @override
  State<SpaGuestCheckoutView> createState() => _SpaGuestCheckoutViewState();
}

class _SpaGuestCheckoutViewState extends State<SpaGuestCheckoutView> {
  final formKey = GlobalKey<FormState>();
  
  // Contact Information
  String email = "";
  String firstName = "";
  String lastName = "";
  String phone = "";
  
  // Shipping Address
  String shippingAddress = "";
  String shippingCity = "";
  String shippingState = "";
  String shippingZip = "";
  String shippingCountry = "United States";
  
  // Billing Address
  bool sameAsShipping = true;
  String billingAddress = "";
  String billingCity = "";
  String billingState = "";
  String billingZip = "";
  String billingCountry = "United States";
  
  // Payment
  String paymentMethod = "credit_card";
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";
  
  // Order Summary
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "iPhone 15 Pro Max",
      "price": 1199.00,
      "quantity": 1,
      "image": "https://picsum.photos/100/100?random=1&keyword=phone"
    },
    {
      "id": 2,
      "name": "AirPods Pro",
      "price": 249.00,
      "quantity": 2,
      "image": "https://picsum.photos/100/100?random=2&keyword=headphones"
    }
  ];
  
  double get subtotal => cartItems.fold(0.0, (sum, item) => sum + ((item["price"] as double) * (item["quantity"] as int)));
  double get tax => subtotal * 0.08;
  double get shipping => 15.99;
  double get total => subtotal + tax + shipping;

  List<Map<String, dynamic>> paymentMethods = [
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "PayPal", "value": "paypal"},
    {"label": "Apple Pay", "value": "apple_pay"},
    {"label": "Google Pay", "value": "google_pay"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Checkout"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildOrderSummary(),
              _buildContactInformation(),
              _buildShippingAddress(),
              _buildBillingAddress(),
              _buildPaymentMethod(),
              _buildOrderTotal(),
              _buildCheckoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
          ...cartItems.map((item) => _buildCartItem(item)),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    return Row(
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
          "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInformation() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Email Address",
            value: email,
            validator: Validator.email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "First Name",
                  value: firstName,
                  validator: Validator.required,
                  onChanged: (value) {
                    firstName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Last Name",
                  value: lastName,
                  validator: Validator.required,
                  onChanged: (value) {
                    lastName = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Phone Number",
            value: phone,
            validator: Validator.required,
            onChanged: (value) {
              phone = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShippingAddress() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Shipping Address",
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
                flex: 2,
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
              SizedBox(width: spSm),
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
            ],
          ),
          QTextField(
            label: "Country",
            value: shippingCountry,
            onChanged: (value) {
              shippingCountry = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBillingAddress() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Billing Address",
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
            value: [
              if (sameAsShipping)
                {"label": "Same as shipping address", "value": true, "checked": true}
            ],
            onChanged: (values, ids) {
              sameAsShipping = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (!sameAsShipping) ...[
            QTextField(
              label: "Street Address",
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
                  flex: 2,
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
                SizedBox(width: spSm),
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
              ],
            ),
            QTextField(
              label: "Country",
              value: billingCountry,
              onChanged: (value) {
                billingCountry = value;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Select Payment Method",
            items: paymentMethods,
            value: paymentMethod,
            onChanged: (value, label) {
              paymentMethod = value;
              setState(() {});
            },
          ),
          if (paymentMethod == "credit_card") ...[
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
                    label: "MM/YY",
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
          if (paymentMethod == "paypal") ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "You will be redirected to PayPal to complete your payment",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
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

  Widget _buildOrderTotal() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Order Total",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildTotalRow("Subtotal", subtotal),
          _buildTotalRow("Tax", tax),
          _buildTotalRow("Shipping", shipping),
          Container(
            height: 1,
            color: disabledColor,
            margin: EdgeInsets.symmetric(vertical: spXs),
          ),
          _buildTotalRow("Total", total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Complete Order - \$${total.toStringAsFixed(2)}",
            size: bs.md,
            onPressed: _processOrder,
          ),
        ),
        Text(
          "By placing your order, you agree to our Terms of Service and Privacy Policy",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  void _processOrder() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Confirm Order"),
          content: Text("Are you sure you want to place this order for \$${total.toStringAsFixed(2)}?"),
          actions: [
            QButton(
              label: "Cancel",
              size: bs.sm,
              onPressed: () => back(),
            ),
            QButton(
              label: "Confirm",
              size: bs.sm,
              onPressed: () {
                back();
                _completeOrder();
              },
            ),
          ],
        ),
      );
    }
  }

  void _completeOrder() async {
    showLoading();
    
    // Simulate processing
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Order placed successfully! You will receive a confirmation email shortly.");
    
    // Reset form
    setState(() {
      email = "";
      firstName = "";
      lastName = "";
      phone = "";
      shippingAddress = "";
      shippingCity = "";
      shippingState = "";
      shippingZip = "";
      cardNumber = "";
      expiryDate = "";
      cvv = "";
      cardholderName = "";
    });
  }
}
