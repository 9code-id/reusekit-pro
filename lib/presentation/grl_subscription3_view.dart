import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSubscription3View extends StatefulWidget {
  @override
  State<GrlSubscription3View> createState() => _GrlSubscription3ViewState();
}

class _GrlSubscription3ViewState extends State<GrlSubscription3View> {
  String selectedPaymentMethod = "credit_card";
  String selectedPlan = "pro";
  bool isProcessing = false;
  
  Map<String, dynamic> selectedPlanData = {
    "name": "Pro",
    "price": 29.99,
    "period": "month",
    "features": [
      "100 GB Storage",
      "Priority Support",
      "Advanced Analytics",
      "API Access",
      "Custom Branding",
      "Team Collaboration"
    ],
  };

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "credit_card",
      "name": "Credit Card",
      "icon": Icons.credit_card,
      "description": "Visa, Mastercard, American Express",
    },
    {
      "id": "paypal",
      "name": "PayPal",
      "icon": Icons.account_balance_wallet,
      "description": "Pay with your PayPal account",
    },
    {
      "id": "google_pay",
      "name": "Google Pay",
      "icon": Icons.contactless,
      "description": "Quick and secure payment",
    },
    {
      "id": "apple_pay",
      "name": "Apple Pay",
      "icon": Icons.apple,
      "description": "Touch ID or Face ID",
    },
  ];

  // Form fields
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";
  String billingAddress = "";
  String city = "";
  String zipCode = "";
  String country = "United States";

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Purchase"),
        actions: [
          IconButton(
            icon: Icon(Icons.security),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              _buildOrderSummary(),
              _buildPaymentMethods(),
              if (selectedPaymentMethod == "credit_card") _buildCreditCardForm(),
              _buildBillingAddress(),
              _buildSecurityInfo(),
              _buildPurchaseButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(10), secondaryColor.withAlpha(10)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.workspace_premium,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${selectedPlanData["name"]} Plan",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Monthly subscription",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${(selectedPlanData["price"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Subtotal",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(selectedPlanData["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Tax",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${((selectedPlanData["price"] as double) * 0.08).toStringAsFixed(2)}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Divider(color: disabledOutlineBorderColor),
                Row(
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${((selectedPlanData["price"] as double) * 1.08).toStringAsFixed(2)}",
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
        spacing: spMd,
        children: [
          Text(
            "Payment Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: paymentMethods.map((method) {
              final isSelected = selectedPaymentMethod == method["id"];
              return GestureDetector(
                onTap: () {
                  selectedPaymentMethod = method["id"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(10) : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          method["icon"] as IconData,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${method["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${method["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
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
          ),
        ],
      ),
    );
  }

  Widget _buildCreditCardForm() {
    return Container(
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
            "Card Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Card Number",
            value: cardNumber,
            hint: "1234 5678 9012 3456",
            validator: Validator.required,
            onChanged: (value) {
              cardNumber = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Expiry Date",
                  value: expiryDate,
                  hint: "MM/YY",
                  validator: Validator.required,
                  onChanged: (value) {
                    expiryDate = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "CVV",
                  value: cvv,
                  hint: "123",
                  validator: Validator.required,
                  onChanged: (value) {
                    cvv = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Cardholder Name",
            value: cardholderName,
            hint: "John Doe",
            validator: Validator.required,
            onChanged: (value) {
              cardholderName = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBillingAddress() {
    return Container(
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
            "Billing Address",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Address",
            value: billingAddress,
            hint: "123 Main Street",
            validator: Validator.required,
            onChanged: (value) {
              billingAddress = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "City",
                  value: city,
                  hint: "New York",
                  validator: Validator.required,
                  onChanged: (value) {
                    city = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "ZIP Code",
                  value: zipCode,
                  hint: "10001",
                  validator: Validator.required,
                  onChanged: (value) {
                    zipCode = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Country",
            items: [
              {"label": "United States", "value": "United States"},
              {"label": "Canada", "value": "Canada"},
              {"label": "United Kingdom", "value": "United Kingdom"},
              {"label": "Australia", "value": "Australia"},
              {"label": "Germany", "value": "Germany"},
            ],
            value: country,
            onChanged: (value, label) {
              country = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.security,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Secure Payment",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Text(
            "Your payment information is encrypted and secure. We use industry-standard SSL encryption to protect your data.",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Icon(Icons.verified_user, color: successColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "256-bit SSL encryption",
                style: TextStyle(
                  color: successColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.shield, color: successColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "PCI DSS compliant",
                style: TextStyle(
                  color: successColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseButton() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: isProcessing 
                ? "Processing..." 
                : "Complete Purchase - \$${((selectedPlanData["price"] as double) * 1.08).toStringAsFixed(2)}",
            size: bs.md,
            onPressed: isProcessing ? null : _processPurchase,
          ),
        ),
        if (isProcessing)
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "Processing your payment...",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        Column(
          spacing: spXs,
          children: [
            Text(
              "By completing this purchase, you agree to our",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 12,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Terms of Service",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text(
                  " and ",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _processPurchase() async {
    if (!formKey.currentState!.validate()) {
      se("Please fill in all required fields");
      return;
    }

    isProcessing = true;
    setState(() {});

    // Simulate payment processing
    await Future.delayed(Duration(seconds: 3));

    isProcessing = false;
    setState(() {});

    ss("Payment successful! Welcome to ${selectedPlanData["name"]} plan!");
  }
}
