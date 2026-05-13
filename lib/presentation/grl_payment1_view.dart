import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPayment1View extends StatefulWidget {
  @override
  State<GrlPayment1View> createState() => _GrlPayment1ViewState();
}

class _GrlPayment1ViewState extends State<GrlPayment1View> {
  String selectedPaymentMethod = "credit_card";
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";
  bool saveCard = false;
  
  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "credit_card",
      "title": "Credit Card",
      "icon": Icons.credit_card,
      "description": "Visa, Mastercard, American Express"
    },
    {
      "id": "paypal",
      "title": "PayPal",
      "icon": Icons.account_balance_wallet,
      "description": "Pay with your PayPal account"
    },
    {
      "id": "apple_pay",
      "title": "Apple Pay",
      "icon": Icons.phone_iphone,
      "description": "Touch ID or Face ID required"
    },
    {
      "id": "google_pay",
      "title": "Google Pay",
      "icon": Icons.contactless,
      "description": "Pay with Google Pay"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Methods"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildOrderSummary(),
            _buildPaymentMethods(),
            if (selectedPaymentMethod == "credit_card") _buildCreditCardForm(),
            _buildSecurityInfo(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: QButton(
          label: "Complete Payment - \$299.99",
          onPressed: () {
            _processPayment();
          },
        ),
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
        spacing: spSm,
        children: [
          Text(
            "Order Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal"),
              Text("\$259.99"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Shipping"),
              Text("\$25.00"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tax"),
              Text("\$15.00"),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "\$299.99",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Payment Method",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...paymentMethods.map((method) {
          return GestureDetector(
            onTap: () {
              selectedPaymentMethod = "${method["id"]}";
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: selectedPaymentMethod == method["id"]
                      ? primaryColor
                      : disabledOutlineBorderColor,
                  width: selectedPaymentMethod == method["id"] ? 2 : 1,
                ),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(
                    method["icon"] as IconData,
                    color: selectedPaymentMethod == method["id"]
                        ? primaryColor
                        : disabledBoldColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${method["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: selectedPaymentMethod == method["id"]
                                ? primaryColor
                                : Colors.black,
                          ),
                        ),
                        Text(
                          "${method["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (selectedPaymentMethod == method["id"])
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
      ],
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
            ),
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
          QTextField(
            label: "Cardholder Name",
            value: cardholderName,
            hint: "John Doe",
            onChanged: (value) {
              cardholderName = value;
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
          QSwitch(
            items: [
              {
                "label": "Save card for future purchases",
                "value": true,
                "checked": saveCard,
              }
            ],
            value: [
              if (saveCard)
                {
                  "label": "Save card for future purchases",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              saveCard = values.isNotEmpty;
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
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: infoColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.security,
            color: infoColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "Your payment information is encrypted and secure. We don't store your card details.",
              style: TextStyle(
                fontSize: 12,
                color: infoColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _processPayment() {
    showLoading();
    
    // Simulate payment processing
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Payment processed successfully!");
    });
  }
}
