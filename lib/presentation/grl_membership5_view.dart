import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMembership5View extends StatefulWidget {
  @override
  State<GrlMembership5View> createState() => _GrlMembership5ViewState();
}

class _GrlMembership5ViewState extends State<GrlMembership5View> {
  String paymentMethod = "credit_card";
  String selectedCard = "visa_1234";
  bool savePayment = true;
  bool agreeTerms = false;

  Map<String, dynamic> selectedPlan = {
    "name": "Pro",
    "price": 29.99,
    "originalPrice": 39.99,
    "billingCycle": "Monthly",
    "features": [
      "Unlimited projects",
      "Priority support",
      "Advanced analytics",
      "Premium templates",
      "Custom branding",
    ],
    "discount": 25,
  };

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "credit_card",
      "name": "Credit/Debit Card",
      "icon": Icons.credit_card,
      "description": "Visa, Mastercard, American Express",
    },
    {
      "id": "paypal",
      "name": "PayPal",
      "icon": Icons.payment,
      "description": "Pay with your PayPal account",
    },
    {
      "id": "google_pay",
      "name": "Google Pay",
      "icon": Icons.g_mobiledata,
      "description": "Quick and secure payments",
    },
    {
      "id": "apple_pay",
      "name": "Apple Pay",
      "icon": Icons.apple,
      "description": "Touch ID or Face ID required",
    },
  ];

  List<Map<String, dynamic>> savedCards = [
    {
      "id": "visa_1234",
      "type": "Visa",
      "last4": "1234",
      "expiry": "12/26",
      "isDefault": true,
    },
    {
      "id": "master_5678",
      "type": "Mastercard",
      "last4": "5678",
      "expiry": "08/25",
      "isDefault": false,
    },
  ];

  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Details"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
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
                  
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.star,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${selectedPlan["name"]} Plan",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${selectedPlan["billingCycle"]} billing",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if ((selectedPlan["discount"] as int) > 0)
                            Text(
                              "\$${(selectedPlan["originalPrice"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Text(
                            "\$${(selectedPlan["price"] as double).toStringAsFixed(2)}",
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
                  
                  if ((selectedPlan["discount"] as int) > 0) ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.local_offer,
                            color: successColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${selectedPlan["discount"]}% discount applied",
                            style: TextStyle(
                              color: successColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  SizedBox(height: spMd),
                  
                  // Features
                  ...List.generate((selectedPlan["features"] as List).length, (index) {
                    final feature = (selectedPlan["features"] as List)[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 14,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "$feature",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Payment method selection
            Text(
              "Payment Method",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...List.generate(paymentMethods.length, (index) {
              final method = paymentMethods[index];
              final isSelected = paymentMethod == method["id"];
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: isSelected 
                      ? Border.all(color: primaryColor, width: 2)
                      : Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledBoldColor,
                          width: 2,
                        ),
                        color: isSelected ? primaryColor : Colors.transparent,
                      ),
                      child: isSelected
                          ? Icon(Icons.check, color: Colors.white, size: 12)
                          : null,
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      method["icon"] as IconData,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${method["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
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
                  ],
                ),
              );
            }),
            
            SizedBox(height: spMd),
            
            // Card details (if credit card selected)
            if (paymentMethod == "credit_card") ...[
              Text(
                "Card Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              // Saved cards
              if (savedCards.isNotEmpty) ...[
                Text(
                  "Saved Cards",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                ...List.generate(savedCards.length, (index) {
                  final card = savedCards[index];
                  final isSelected = selectedCard == card["id"];
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: isSelected 
                          ? Border.all(color: primaryColor, width: 2)
                          : Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledBoldColor,
                              width: 2,
                            ),
                            color: isSelected ? primaryColor : Colors.transparent,
                          ),
                          child: isSelected
                              ? Icon(Icons.check, color: Colors.white, size: 10)
                              : null,
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.credit_card,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${card["type"]} ending in ${card["last4"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "Expires ${card["expiry"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (card["isDefault"] as bool)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Default",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
                
                SizedBox(height: spSm),
                
                Text(
                  "Or add new card",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
              ],
              
              // New card form
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    QTextField(
                      label: "Card Number",
                      value: cardNumber,
                      hint: "1234 5678 9012 3456",
                      onChanged: (value) {
                        cardNumber = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Cardholder Name",
                      value: cardholderName,
                      hint: "John Doe",
                      onChanged: (value) {
                        cardholderName = value;
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
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Save this card for future payments",
                                "value": true,
                                "checked": savePayment,
                              }
                            ],
                            value: [if (savePayment) {"label": "Save this card for future payments", "value": true, "checked": true}],
                            onChanged: (values, ids) {
                              savePayment = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            
            SizedBox(height: spMd),
            
            // Terms and conditions
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "I agree to the Terms of Service and Privacy Policy",
                        "value": true,
                        "checked": agreeTerms,
                      }
                    ],
                    value: [if (agreeTerms) {"label": "I agree to the Terms of Service and Privacy Policy", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      agreeTerms = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Security info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Secure Payment",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Your payment information is encrypted and secure. We never store your full card details.",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Complete payment button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Complete Payment \$${(selectedPlan["price"] as double).toStringAsFixed(2)}",
                size: bs.md,
                onPressed: agreeTerms ? () {
                  // Process payment
                } : null,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Center(
              child: Text(
                "Cancel anytime. No hidden fees.",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
