import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsPaymentMethodView extends StatefulWidget {
  const BrsPaymentMethodView({super.key});

  @override
  State<BrsPaymentMethodView> createState() => _BrsPaymentMethodViewState();
}

class _BrsPaymentMethodViewState extends State<BrsPaymentMethodView> {
  String selectedPaymentMethod = "";
  
  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "cash",
      "name": "Cash Payment",
      "description": "Pay in cash at the barbershop",
      "icon": Icons.money,
      "available": true,
      "processingFee": 0.0
    },
    {
      "id": "card",
      "name": "Credit/Debit Card",
      "description": "Visa, Mastercard, American Express",
      "icon": Icons.credit_card,
      "available": true,
      "processingFee": 2.50
    },
    {
      "id": "paypal",
      "name": "PayPal",
      "description": "Pay securely with PayPal",
      "icon": Icons.account_balance_wallet,
      "available": true,
      "processingFee": 1.99
    },
    {
      "id": "apple_pay",
      "name": "Apple Pay",
      "description": "Touch ID or Face ID",
      "icon": Icons.phone_iphone,
      "available": true,
      "processingFee": 0.0
    },
    {
      "id": "google_pay",
      "name": "Google Pay",
      "description": "Pay with Google account",
      "icon": Icons.android,
      "available": true,
      "processingFee": 0.0
    },
    {
      "id": "bank_transfer",
      "name": "Bank Transfer",
      "description": "Direct bank transfer",
      "icon": Icons.account_balance,
      "available": false,
      "processingFee": 0.0
    }
  ];

  List<Map<String, dynamic>> savedCards = [
    {
      "id": "card_1",
      "type": "Visa",
      "lastFour": "4532",
      "expiryMonth": "12",
      "expiryYear": "2025",
      "holderName": "John Doe",
      "isDefault": true
    },
    {
      "id": "card_2",
      "type": "Mastercard",
      "lastFour": "8901",
      "expiryMonth": "06",
      "expiryYear": "2026",
      "holderName": "John Doe",
      "isDefault": false
    }
  ];

  double bookingTotal = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Booking Total
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Booking Total",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "\$${bookingTotal.currency}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Classic Haircut + Beard Trim",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Saved Payment Cards
            if (savedCards.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Saved Payment Cards",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QButton(
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            ss("Add new payment card");
                          },
                        ),
                      ],
                    ),
                    ...savedCards.map((card) {
                      bool isSelected = selectedPaymentMethod == "saved_${card["id"]}";
                      
                      return GestureDetector(
                        onTap: () {
                          selectedPaymentMethod = "saved_${card["id"]}";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          margin: EdgeInsets.only(bottom: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
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
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.credit_card,
                                  color: primaryColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${card["type"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        if (card["isDefault"] as bool)
                                          Container(
                                            margin: EdgeInsets.only(left: spXs),
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
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
                                    ),
                                    Text(
                                      "**** **** **** ${card["lastFour"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Expires ${card["expiryMonth"]}/${card["expiryYear"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: primaryColor,
                                  size: 24,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

            // Payment Methods
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Payment Methods",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...paymentMethods.map((method) {
                    bool isSelected = selectedPaymentMethod == method["id"];
                    bool isAvailable = method["available"] as bool;
                    double processingFee = method["processingFee"] as double;
                    
                    return GestureDetector(
                      onTap: isAvailable ? () {
                        selectedPaymentMethod = "${method["id"]}";
                        setState(() {});
                      } : null,
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? primaryColor.withAlpha(20) 
                              : isAvailable 
                                  ? Colors.white 
                                  : disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected 
                                ? primaryColor 
                                : isAvailable 
                                    ? disabledOutlineBorderColor 
                                    : disabledColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: isAvailable 
                                    ? primaryColor.withAlpha(20) 
                                    : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                method["icon"] as IconData,
                                color: isAvailable ? primaryColor : disabledBoldColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${method["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: isAvailable ? primaryColor : disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                      if (processingFee > 0)
                                        Text(
                                          "+\$${processingFee.currency} fee",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: warningColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    "${method["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isAvailable ? disabledBoldColor : disabledBoldColor,
                                    ),
                                  ),
                                  if (!isAvailable)
                                    Text(
                                      "Currently unavailable",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: dangerColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Payment Security Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.security, color: infoColor, size: 24),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Secure Payment",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Your payment information is encrypted and secure. We use industry-standard SSL encryption to protect your data.",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Continue Button
            Container(
              width: double.infinity,
              child: QButton(
                label: selectedPaymentMethod.isNotEmpty 
                    ? "Continue to Payment" 
                    : "Select Payment Method",
                size: bs.md,
                onPressed: selectedPaymentMethod.isNotEmpty ? () {
                  ss("Processing payment with $selectedPaymentMethod");
                } : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
