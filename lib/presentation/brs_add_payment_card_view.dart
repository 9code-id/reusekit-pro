import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsAddPaymentCardView extends StatefulWidget {
  const BrsAddPaymentCardView({super.key});

  @override
  State<BrsAddPaymentCardView> createState() => _BrsAddPaymentCardViewState();
}

class _BrsAddPaymentCardViewState extends State<BrsAddPaymentCardView> {
  final formKey = GlobalKey<FormState>();
  String cardNumber = "";
  String cardHolderName = "";
  String expiryDate = "";
  String cvv = "";
  String cardType = "";
  bool isDefault = false;
  bool saveCard = true;

  List<Map<String, dynamic>> cardTypes = [
    {
      "name": "Visa",
      "icon": Icons.credit_card,
      "color": Colors.blue,
      "pattern": RegExp(r'^4'),
    },
    {
      "name": "Mastercard", 
      "icon": Icons.credit_card,
      "color": Colors.red,
      "pattern": RegExp(r'^5'),
    },
    {
      "name": "American Express",
      "icon": Icons.credit_card,
      "color": Colors.green,
      "pattern": RegExp(r'^3[47]'),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Payment Card"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getCardColor(),
                      _getCardColor().withAlpha(200),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.contactless,
                          color: Colors.white,
                          size: 24,
                        ),
                        Spacer(),
                        if (cardType.isNotEmpty)
                          Text(
                            cardType.toUpperCase(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      _formatCardNumber(cardNumber),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CARD HOLDER",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white.withAlpha(200),
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: spXxs),
                            Text(
                              cardHolderName.isEmpty ? "YOUR NAME" : cardHolderName.toUpperCase(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EXPIRES",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white.withAlpha(200),
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: spXxs),
                            Text(
                              expiryDate.isEmpty ? "MM/YY" : expiryDate,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: Colors.blue.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: Colors.blue,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Your payment information is encrypted and secure. We never store your CVV.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              QTextField(
                label: "Card Number",
                value: cardNumber,
                hint: "1234 5678 9012 3456",
                validator: Validator.required,
                onChanged: (value) {
                  cardNumber = _formatCardNumberInput(value);
                  cardType = _detectCardType(cardNumber);
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
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Save this card for future payments",
                                "value": true,
                                "checked": saveCard,
                              }
                            ],
                            value: [
                              if (saveCard)
                                {
                                  "label": "Save this card for future payments",
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
                    if (saveCard)
                      Row(
                        children: [
                          Expanded(
                            child: QSwitch(
                              items: [
                                {
                                  "label": "Set as default payment method",
                                  "value": true,
                                  "checked": isDefault,
                                }
                              ],
                              value: [
                                if (isDefault)
                                  {
                                    "label": "Set as default payment method",
                                    "value": true,
                                    "checked": true
                                  }
                              ],
                              onChanged: (values, ids) {
                                isDefault = values.isNotEmpty;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Accepted Cards",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: cardTypes.map((type) => Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              type["icon"],
                              color: type["color"],
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${type["name"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: type["color"],
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spLg),
              QButton(
                label: "Add Card",
                size: bs.md,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    showLoading();
                    await Future.delayed(Duration(seconds: 2));
                    hideLoading();
                    
                    ss("Payment card added successfully");
                    back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCardNumber(String number) {
    String cleaned = number.replaceAll(' ', '');
    if (cleaned.isEmpty) return "•••• •••• •••• ••••";
    
    String formatted = "";
    for (int i = 0; i < 16; i++) {
      if (i > 0 && i % 4 == 0) formatted += " ";
      if (i < cleaned.length) {
        formatted += cleaned[i];
      } else {
        formatted += "•";
      }
    }
    return formatted;
  }

  String _formatCardNumberInput(String input) {
    String cleaned = input.replaceAll(' ', '');
    String formatted = "";
    for (int i = 0; i < cleaned.length && i < 16; i++) {
      if (i > 0 && i % 4 == 0) formatted += " ";
      formatted += cleaned[i];
    }
    return formatted;
  }

  String _formatExpiryDate(String input) {
    String cleaned = input.replaceAll('/', '');
    if (cleaned.length >= 2) {
      return cleaned.substring(0, 2) + "/" + cleaned.substring(2, cleaned.length > 4 ? 4 : cleaned.length);
    }
    return cleaned;
  }

  String _detectCardType(String number) {
    String cleaned = number.replaceAll(' ', '');
    for (var type in cardTypes) {
      if (type["pattern"].hasMatch(cleaned)) {
        return type["name"];
      }
    }
    return "";
  }

  Color _getCardColor() {
    switch (cardType) {
      case "Visa":
        return Colors.blue;
      case "Mastercard":
        return Colors.red;
      case "American Express":
        return Colors.green;
      default:
        return primaryColor;
    }
  }
}
