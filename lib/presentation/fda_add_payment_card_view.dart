import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaAddPaymentCardView extends StatefulWidget {
  const FdaAddPaymentCardView({Key? key}) : super(key: key);

  @override
  State<FdaAddPaymentCardView> createState() => _FdaAddPaymentCardViewState();
}

class _FdaAddPaymentCardViewState extends State<FdaAddPaymentCardView> {
  final formKey = GlobalKey<FormState>();
  
  String cardNumber = "";
  String cardHolderName = "";
  String expiryDate = "";
  String cvv = "";
  String selectedCardType = "credit";
  bool saveCard = true;
  bool setAsDefault = false;
  bool isProcessing = false;
  
  String detectedCardBrand = "";
  Color cardColor = Colors.blue;

  List<Map<String, dynamic>> cardTypes = [
    {"label": "Credit Card", "value": "credit"},
    {"label": "Debit Card", "value": "debit"},
    {"label": "Prepaid Card", "value": "prepaid"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Payment Card"),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => _scanCard(),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardPreview(),
              SizedBox(height: spMd),
              _buildCardTypeSelection(),
              SizedBox(height: spMd),
              _buildCardForm(),
              SizedBox(height: spMd),
              _buildCardOptions(),
              SizedBox(height: spMd),
              _buildSecurityInfo(),
              SizedBox(height: spMd),
              _buildSupportedCards(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildCardPreview() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cardColor, cardColor.withAlpha(200)],
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(20),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getCardIcon(),
                      color: Colors.white,
                      size: 32,
                    ),
                    Spacer(),
                    if (detectedCardBrand.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          detectedCardBrand.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                Spacer(),
                Text(
                  cardNumber.isEmpty ? "**** **** **** ****" : _formatCardNumber(cardNumber),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CARD HOLDER",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          cardHolderName.isEmpty ? "YOUR NAME" : cardHolderName.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spLg),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "EXPIRES",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          expiryDate.isEmpty ? "MM/YY" : expiryDate,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => _changeCardColor(),
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.color_lens,
                          color: Colors.white,
                          size: 16,
                        ),
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

  Widget _buildCardTypeSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Card Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Select Card Type",
            items: cardTypes,
            value: selectedCardType,
            onChanged: (value, label) {
              selectedCardType = value;
              setState(() {});
            },
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
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Card Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _scanCard(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: primaryColor,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Scan Card",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QNumberField(
            label: "Card Number",
            value: cardNumber,
            hint: "1234 5678 9012 3456",
            validator: Validator.required,
            onChanged: (value) {
              cardNumber = value;
              _detectCardBrand(value);
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Cardholder Name",
            value: cardHolderName,
            hint: "Enter name as shown on card",
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
        ],
      ),
    );
  }

  Widget _buildCardOptions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Card Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QSwitch(
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
          SizedBox(height: spSm),
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
              setAsDefault = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                "Security Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildSecurityItem(
            "256-bit SSL Encryption",
            "Your card details are encrypted and secure",
            Icons.lock,
          ),
          _buildSecurityItem(
            "PCI DSS Compliant",
            "Industry standard security compliance",
            Icons.verified_user,
          ),
          _buildSecurityItem(
            "Zero Fraud Liability",
            "Protected against unauthorized transactions",
            Icons.shield,
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "We never store your complete card information. Your data is tokenized and encrypted.",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityItem(String title, String description, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            color: successColor,
            size: 16,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
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
  }

  Widget _buildSupportedCards() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Supported Cards",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildCardBrandIcon("Visa", Icons.credit_card, Colors.blue),
              SizedBox(width: spMd),
              _buildCardBrandIcon("Mastercard", Icons.payment, Colors.red),
              SizedBox(width: spMd),
              _buildCardBrandIcon("AmEx", Icons.account_balance_wallet, Colors.green),
              SizedBox(width: spMd),
              _buildCardBrandIcon("Discover", Icons.credit_score, Colors.orange),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "We accept all major credit and debit cards. Your payment is processed securely.",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBrandIcon(String brand, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            SizedBox(height: spXs),
            Text(
              brand,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.lock,
                color: successColor,
                size: 16,
              ),
              SizedBox(width: spSm),
              Text(
                "Your payment information is secure and encrypted",
                style: TextStyle(
                  color: successColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: isProcessing ? "Processing..." : "Add Payment Card",
              size: bs.md,
              onPressed: isProcessing ? null : () => _addCard(),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCardNumber(String cardNumber) {
    String digitsOnly = cardNumber.replaceAll(RegExp(r'\D'), '');
    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += digitsOnly[i];
    }
    return formatted;
  }

  IconData _getCardIcon() {
    switch (detectedCardBrand.toLowerCase()) {
      case 'visa':
        return Icons.credit_card;
      case 'mastercard':
        return Icons.payment;
      case 'amex':
        return Icons.account_balance_wallet;
      case 'discover':
        return Icons.credit_score;
      default:
        return Icons.credit_card;
    }
  }

  void _detectCardBrand(String cardNumber) {
    String digitsOnly = cardNumber.replaceAll(RegExp(r'\D'), '');
    
    if (digitsOnly.isEmpty) {
      detectedCardBrand = "";
      cardColor = Colors.blue;
      return;
    }

    if (digitsOnly.startsWith('4')) {
      detectedCardBrand = "Visa";
      cardColor = Colors.blue;
    } else if (digitsOnly.startsWith(RegExp(r'5[1-5]')) || 
               digitsOnly.startsWith(RegExp(r'2[2-7]'))) {
      detectedCardBrand = "Mastercard";
      cardColor = Colors.red;
    } else if (digitsOnly.startsWith(RegExp(r'3[47]'))) {
      detectedCardBrand = "AmEx";
      cardColor = Colors.green;
    } else if (digitsOnly.startsWith('6')) {
      detectedCardBrand = "Discover";
      cardColor = Colors.orange;
    } else {
      detectedCardBrand = "";
      cardColor = Colors.grey;
    }
  }

  void _changeCardColor() {
    List<Color> colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.indigo,
    ];
    
    int currentIndex = colors.indexOf(cardColor);
    int nextIndex = (currentIndex + 1) % colors.length;
    cardColor = colors[nextIndex];
    setState(() {});
  }

  void _scanCard() {
    ss("Card scanning feature opened");
    // Implement card scanning functionality
    // This would typically open camera to scan card details
  }

  void _addCard() async {
    if (!formKey.currentState!.validate()) {
      se("Please fill in all required fields");
      return;
    }

    if (cardNumber.replaceAll(RegExp(r'\D'), '').length < 13) {
      se("Please enter a valid card number");
      return;
    }

    if (cvv.length < 3) {
      se("Please enter a valid CVV");
      return;
    }

    isProcessing = true;
    setState(() {});

    showLoading();

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    hideLoading();
    isProcessing = false;
    setState(() {});

    ss("Payment card added successfully");
    back();
  }
}
