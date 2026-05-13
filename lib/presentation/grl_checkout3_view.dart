import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCheckout3View extends StatefulWidget {
  const GrlCheckout3View({Key? key}) : super(key: key);

  @override
  State<GrlCheckout3View> createState() => _GrlCheckout3ViewState();
}

class _GrlCheckout3ViewState extends State<GrlCheckout3View> {
  String selectedPaymentMethod = "card";
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardHolderName = "";
  bool saveCard = false;
  String billingAddress = "";
  String billingCity = "";
  String billingZip = "";
  
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> orderItems = [
    {
      "id": 1,
      "name": "Wireless Bluetooth Earbuds",
      "image": "https://picsum.photos/60/60?random=1&keyword=earbuds",
      "price": 129.99,
      "quantity": 1,
    },
    {
      "id": 2,
      "name": "Phone Case - Clear",
      "image": "https://picsum.photos/60/60?random=2&keyword=phone-case",
      "price": 24.99,
      "quantity": 2,
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "card",
      "name": "Credit/Debit Card",
      "icon": Icons.credit_card,
      "description": "Visa, Mastercard, Amex",
    },
    {
      "id": "paypal",
      "name": "PayPal",
      "icon": Icons.account_balance_wallet,
      "description": "Pay with your PayPal account",
    },
    {
      "id": "apple",
      "name": "Apple Pay",
      "icon": Icons.phone_iphone,
      "description": "Touch ID or Face ID",
    },
    {
      "id": "google",
      "name": "Google Pay",
      "icon": Icons.account_balance,
      "description": "Quick and secure payment",
    },
  ];

  List<Map<String, dynamic>> savedCards = [
    {
      "id": "card1",
      "last4": "4242",
      "brand": "Visa",
      "expiry": "12/26",
      "isDefault": true,
    },
    {
      "id": "card2",
      "last4": "8888",
      "brand": "Mastercard",
      "expiry": "09/25",
      "isDefault": false,
    },
  ];

  double get subtotal => orderItems.fold(0.0, (sum, item) => sum + ((item["price"] as double) * (item["quantity"] as int)));
  double get shipping => 12.99;
  double get tax => subtotal * 0.087;
  double get total => subtotal + shipping + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        actions: [
          IconButton(
            icon: Icon(Icons.security),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spLg,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderSummary(),
              _buildPaymentMethods(),
              if (selectedPaymentMethod == "card") ...[
                _buildSavedCards(),
                _buildCardForm(),
                _buildBillingAddress(),
              ],
              _buildPricingDetails(),
              _buildSecurityNotice(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildPaymentButton(),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${orderItems.length} items",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: orderItems.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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

  Widget _buildPaymentMethods() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: paymentMethods.map((method) {
              bool isSelected = selectedPaymentMethod == method["id"];
              return GestureDetector(
                onTap: () {
                  selectedPaymentMethod = method["id"];
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(25) : Colors.grey.shade50,
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          method["icon"] as IconData,
                          color: isSelected ? Colors.white : disabledBoldColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${method["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? primaryColor : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${method["description"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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

  Widget _buildSavedCards() {
    if (savedCards.isEmpty) return SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Saved Cards",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: savedCards.map((card) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.credit_card,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "**** **** **** ${card["last4"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${card["brand"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                " • Expires ${card["expiry"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (card["isDefault"])
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "Default",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Use",
                      size: bs.sm,
                      onPressed: () {
                        _useExistingCard(card);
                      },
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

  Widget _buildCardForm() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add New Card",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
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
          SizedBox(height: spSm),
          QTextField(
            label: "Cardholder Name",
            value: cardHolderName,
            hint: "John Doe",
            validator: Validator.required,
            onChanged: (value) {
              cardHolderName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
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
              SizedBox(width: spSm),
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
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Save this card for future purchases",
                      "value": true,
                      "checked": saveCard,
                    }
                  ],
                  value: [
                    if (saveCard)
                      {
                        "label": "Save this card for future purchases",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    saveCard = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
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
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Billing Address",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
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
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "City",
                  value: billingCity,
                  hint: "New York",
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
                  label: "ZIP Code",
                  value: billingZip,
                  hint: "10001",
                  validator: Validator.required,
                  onChanged: (value) {
                    billingZip = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingDetails() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          _buildPriceRow("Subtotal", subtotal),
          _buildPriceRow("Shipping", shipping),
          _buildPriceRow("Tax", tax),
          Divider(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }

  Widget _buildSecurityNotice() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.security,
            color: Colors.green,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Secure Payment",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Your payment information is encrypted and secure. We never store your card details.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowLg],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: \$${total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.security, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "SSL Secured",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: selectedPaymentMethod == "card" 
                  ? "Pay \$${total.toStringAsFixed(2)}"
                  : "Continue with ${paymentMethods.firstWhere((p) => p["id"] == selectedPaymentMethod)["name"]}",
              size: bs.md,
              onPressed: _processPayment,
            ),
          ),
        ],
      ),
    );
  }

  void _useExistingCard(Map<String, dynamic> card) {
    cardNumber = "**** **** **** ${card["last4"]}";
    expiryDate = "${card["expiry"]}";
    cardHolderName = "John Doe";
    setState(() {});
    ss("Card selected successfully!");
  }

  void _processPayment() {
    if (selectedPaymentMethod == "card") {
      if (formKey.currentState!.validate()) {
        _completePayment();
      }
    } else {
      _completePayment();
    }
  }

  void _completePayment() {
    showLoading();
    
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Payment processed successfully!");
      // Navigate to order confirmation
    });
  }
}
