import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsAddPaymentCardView extends StatefulWidget {
  const EcsAddPaymentCardView({super.key});

  @override
  State<EcsAddPaymentCardView> createState() => _EcsAddPaymentCardViewState();
}

class _EcsAddPaymentCardViewState extends State<EcsAddPaymentCardView> {
  final formKey = GlobalKey<FormState>();
  String cardNumber = "";
  String cardHolderName = "";
  String expiryDate = "";
  String cvv = "";
  bool saveCard = true;
  bool setAsDefault = false;
  bool loading = false;
  String selectedCardType = "";

  List<Map<String, dynamic>> cardTypes = [
    {
      "name": "Visa",
      "value": "visa",
      "color": 0xFF1976D2,
      "pattern": r'^4[0-9]{12}(?:[0-9]{3})?$',
    },
    {
      "name": "Mastercard",
      "value": "mastercard",
      "color": 0xFFE53935,
      "pattern": r'^5[1-5][0-9]{14}$',
    },
    {
      "name": "American Express",
      "value": "amex",
      "color": 0xFF00ACC1,
      "pattern": r'^3[47][0-9]{13}$',
    },
  ];

  void _detectCardType(String number) {
    String cleanNumber = number.replaceAll(' ', '');
    
    for (var cardType in cardTypes) {
      RegExp pattern = RegExp(cardType["pattern"] as String);
      if (pattern.hasMatch(cleanNumber)) {
        selectedCardType = cardType["value"] as String;
        setState(() {});
        return;
      }
    }
    
    selectedCardType = "";
    setState(() {});
  }

  String _formatCardNumber(String value) {
    value = value.replaceAll(' ', '');
    String formatted = '';
    
    for (int i = 0; i < value.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += value[i];
    }
    
    return formatted;
  }

  String _formatExpiryDate(String value) {
    value = value.replaceAll('/', '');
    if (value.length >= 2) {
      return value.substring(0, 2) + '/' + value.substring(2);
    }
    return value;
  }

  void _addCard() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Payment card added successfully");
    back();
  }

  Color _getCardColor() {
    if (selectedCardType.isEmpty) return primaryColor;
    
    var cardType = cardTypes.firstWhere(
      (type) => type["value"] == selectedCardType,
      orElse: () => {"color": primaryColor.value},
    );
    
    return Color(cardType["color"] as int);
  }

  Widget _buildCardPreview() {
    return Container(
      height: 200,
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getCardColor(),
            _getCardColor().withAlpha(180),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowMd],
      ),
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "💳",
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  selectedCardType.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            Spacer(),
            
            Text(
              cardNumber.isEmpty ? "**** **** **** ****" : cardNumber,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Card Holder",
                      style: TextStyle(
                        color: Colors.white.withAlpha(180),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      cardHolderName.isEmpty ? "YOUR NAME" : cardHolderName.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Expires",
                      style: TextStyle(
                        color: Colors.white.withAlpha(180),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      expiryDate.isEmpty ? "MM/YY" : expiryDate,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Add Payment Card"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: spMd),
              Text(
                "Adding your card...",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Payment Card"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card Preview
              _buildCardPreview(),

              // Security Notice
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: successColor.withAlpha(100)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Your payment information is encrypted and secure",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Card Information Form
              Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      // Format and detect card type
                      String formatted = _formatCardNumber(value);
                      cardNumber = formatted;
                      _detectCardType(value);
                      setState(() {});
                    },
                  ),

                  QTextField(
                    label: "Card Holder Name",
                    value: cardHolderName,
                    hint: "John Doe",
                    validator: Validator.required,
                    onChanged: (value) {
                      cardHolderName = value;
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
                            expiryDate = _formatExpiryDate(value);
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

                  // Card Options
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.settings,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Card Options",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
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
                            setState(() {
                              saveCard = values.isNotEmpty;
                            });
                          },
                        ),

                        QSwitch(
                          items: [
                            {
                              "label": "Set as default payment method",
                              "value": true,
                              "checked": setAsDefault,
                            }
                          ],
                          value: [
                            if (setAsDefault)
                              {
                                "label": "Set as default payment method",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            setState(() {
                              setAsDefault = values.isNotEmpty;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Add Card Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Add Payment Card",
                      size: bs.md,
                      onPressed: _addCard,
                    ),
                  ),

                  // Help Text
                  SizedBox(height: spSm),
                  
                  Text(
                    "By adding a payment card, you agree to our Terms of Service and Privacy Policy. Your card information is encrypted and stored securely.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
