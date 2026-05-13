import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsPaymentView extends StatefulWidget {
  const EcsPaymentView({super.key});

  @override
  State<EcsPaymentView> createState() => _EcsPaymentViewState();
}

class _EcsPaymentViewState extends State<EcsPaymentView> {
  final formKey = GlobalKey<FormState>();
  String selectedPaymentMethod = "card";
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardHolderName = "";
  bool saveCard = false;
  String billingAddress = "";
  String billingCity = "";
  String billingZip = "";
  
  Map<String, dynamic> orderSummary = {
    "subtotal": 89.97,
    "shipping": 9.99,
    "tax": 8.10,
    "discount": 10.00,
    "total": 98.06,
    "items": [
      {
        "name": "Wireless Bluetooth Headphones",
        "price": 59.99,
        "quantity": 1,
        "image": "https://picsum.photos/60/60?random=1&keyword=headphones"
      },
      {
        "name": "Phone Case - Clear",
        "price": 19.99,
        "quantity": 1,
        "image": "https://picsum.photos/60/60?random=2&keyword=phone"
      },
      {
        "name": "USB-C Cable",
        "price": 9.99,
        "quantity": 1,
        "image": "https://picsum.photos/60/60?random=3&keyword=cable"
      }
    ]
  };

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "card",
      "title": "Credit/Debit Card",
      "icon": Icons.credit_card,
      "description": "Visa, Mastercard, American Express"
    },
    {
      "id": "paypal",
      "title": "PayPal",
      "icon": Icons.payment,
      "description": "Pay with your PayPal account"
    },
    {
      "id": "applepay",
      "title": "Apple Pay",
      "icon": Icons.phone_iphone,
      "description": "Pay with Touch ID or Face ID"
    },
    {
      "id": "googlepay",
      "title": "Google Pay",
      "icon": Icons.account_balance_wallet,
      "description": "Pay with your Google account"
    }
  ];

  List<Map<String, dynamic>> savedCards = [
    {
      "id": "card_001",
      "type": "Visa",
      "lastFour": "4242",
      "expiry": "12/25",
      "isDefault": true
    },
    {
      "id": "card_002", 
      "type": "Mastercard",
      "lastFour": "8888",
      "expiry": "08/26",
      "isDefault": false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        actions: [
          IconButton(
            icon: Icon(Icons.security),
            onPressed: () {
              _showSecurityInfo();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
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
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          ...(orderSummary["items"] as List).map((item) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spMd),
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
                                    "\$${(item["price"] as double).currency}",
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
                          Divider(),
                          _buildSummaryRow("Subtotal", orderSummary["subtotal"] as double),
                          _buildSummaryRow("Shipping", orderSummary["shipping"] as double),
                          _buildSummaryRow("Tax", orderSummary["tax"] as double),
                          _buildSummaryRow("Discount", -(orderSummary["discount"] as double), color: successColor),
                          Divider(),
                          _buildSummaryRow("Total", orderSummary["total"] as double, isTotal: true),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    ...paymentMethods.map((method) {
                      bool isSelected = selectedPaymentMethod == method["id"];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(spMd),
                          leading: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              method["icon"] as IconData,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              size: 24,
                            ),
                          ),
                          title: Text(
                            "${method["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          subtitle: Text(
                            "${method["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          trailing: Radio<String>(
                            value: method["id"] as String,
                            groupValue: selectedPaymentMethod,
                            onChanged: (value) {
                              selectedPaymentMethod = value!;
                              setState(() {});
                            },
                            activeColor: primaryColor,
                          ),
                          onTap: () {
                            selectedPaymentMethod = method["id"] as String;
                            setState(() {});
                          },
                        ),
                      );
                    }).toList(),
                    
                    if (selectedPaymentMethod == "card") ...[
                      SizedBox(height: spLg),
                      if (savedCards.isNotEmpty) ...[
                        Text(
                          "Saved Cards",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        ...savedCards.map((card) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              ),
                              boxShadow: [shadowSm],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.credit_card,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${card["type"]} •••• ${card["lastFour"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          if (card["isDefault"] as bool) ...[
                                            SizedBox(width: spSm),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "Default",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        "Expires ${card["expiry"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  label: "Use This Card",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        
                        SizedBox(height: spMd),
                        Text(
                          "Or Add New Card",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                      ],
                      
                      QTextField(
                        label: "Card Number",
                        value: cardNumber,
                        validator: Validator.required,
                        onChanged: (value) {
                          cardNumber = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
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
                          SizedBox(width: spMd),
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
                      SizedBox(height: spMd),
                      QTextField(
                        label: "Cardholder Name",
                        value: cardHolderName,
                        validator: Validator.required,
                        onChanged: (value) {
                          cardHolderName = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Checkbox(
                            value: saveCard,
                            onChanged: (value) {
                              saveCard = value ?? false;
                              setState(() {});
                            },
                            activeColor: primaryColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Save this card for future purchases",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spLg),
                      Text(
                        "Billing Address",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      QTextField(
                        label: "Address",
                        value: billingAddress,
                        validator: Validator.required,
                        onChanged: (value) {
                          billingAddress = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spMd),
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
                          SizedBox(width: spMd),
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
                    ],
                  ],
                ),
              ),
            ),
          ),
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
                      "Total Amount",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${(orderSummary["total"] as double).currency}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                QButton(
                  label: "Complete Payment",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _processPayment();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {Color? color, bool isTotal = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
          Text(
            "${amount < 0 ? '-' : ''}\$${amount.abs().currency}",
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color ?? (isTotal ? primaryColor : null),
            ),
          ),
        ],
      ),
    );
  }

  void _showSecurityInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.security, color: successColor),
            SizedBox(width: spSm),
            Text("Secure Payment"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your payment information is protected by:"),
            SizedBox(height: spMd),
            Row(
              children: [
                Icon(Icons.lock, color: successColor, size: 16),
                SizedBox(width: spSm),
                Text("256-bit SSL encryption"),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.verified, color: successColor, size: 16),
                SizedBox(width: spSm),
                Text("PCI DSS compliance"),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.shield, color: successColor, size: 16),
                SizedBox(width: spSm),
                Text("Fraud detection"),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _processPayment() async {
    showLoading();
    
    // Simulate payment processing
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    ss("Payment successful! Your order has been placed.");
    
    // Navigate to order confirmation
    //navigateTo('order_confirmation')
  }
}
