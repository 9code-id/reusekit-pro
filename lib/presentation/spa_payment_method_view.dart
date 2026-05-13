import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaPaymentMethodView extends StatefulWidget {
  const SpaPaymentMethodView({super.key});

  @override
  State<SpaPaymentMethodView> createState() => _SpaPaymentMethodViewState();
}

class _SpaPaymentMethodViewState extends State<SpaPaymentMethodView> {
  String selectedPaymentMethod = "";
  String selectedCard = "";
  
  // Credit Card Info
  String cardNumber = "";
  String cardHolderName = "";
  String expiryDate = "";
  String cvv = "";
  bool saveCard = false;
  
  // Digital Wallet Info
  String selectedWallet = "";
  
  // Bank Transfer Info
  String bankName = "";
  String accountNumber = "";
  String routingNumber = "";
  
  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "card",
      "name": "Credit/Debit Card",
      "description": "Visa, MasterCard, American Express",
      "icon": Icons.credit_card,
      "color": primaryColor,
    },
    {
      "id": "digital_wallet",
      "name": "Digital Wallet",
      "description": "Apple Pay, Google Pay, PayPal",
      "icon": Icons.account_balance_wallet,
      "color": successColor,
    },
    {
      "id": "bank_transfer",
      "name": "Bank Transfer",
      "description": "Direct bank account transfer",
      "icon": Icons.account_balance,
      "color": infoColor,
    },
    {
      "id": "buy_now_pay_later",
      "name": "Buy Now, Pay Later",
      "description": "Split payment into installments",
      "icon": Icons.payment,
      "color": warningColor,
    },
    {
      "id": "gift_card",
      "name": "Gift Card",
      "description": "Redeem spa gift cards",
      "icon": Icons.card_giftcard,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> savedCards = [
    {
      "id": "card_1",
      "type": "Visa",
      "lastFour": "4242",
      "expiryDate": "12/25",
      "isDefault": true,
    },
    {
      "id": "card_2",
      "type": "MasterCard",
      "lastFour": "8888",
      "expiryDate": "08/26",
      "isDefault": false,
    },
  ];

  List<Map<String, dynamic>> digitalWallets = [
    {
      "id": "apple_pay",
      "name": "Apple Pay",
      "icon": Icons.phone_iphone,
      "available": true,
    },
    {
      "id": "google_pay",
      "name": "Google Pay",
      "icon": Icons.g_mobiledata,
      "available": true,
    },
    {
      "id": "paypal",
      "name": "PayPal",
      "icon": Icons.payment,
      "available": true,
    },
    {
      "id": "samsung_pay",
      "name": "Samsung Pay",
      "icon": Icons.phone_android,
      "available": false,
    },
  ];

  List<Map<String, dynamic>> bnplOptions = [
    {
      "id": "klarna",
      "name": "Klarna",
      "description": "4 interest-free payments",
      "installments": "4 x \$75.00",
    },
    {
      "id": "afterpay",
      "name": "Afterpay",
      "description": "Pay in 4 installments",
      "installments": "4 x \$75.00",
    },
    {
      "id": "sezzle",
      "name": "Sezzle",
      "description": "Split into 4 payments",
      "installments": "4 x \$75.00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Methods"),
        actions: [
          if (selectedPaymentMethod.isNotEmpty)
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                _showPaymentHelp();
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Total
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "\$300.00",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            Text(
              "Choose Payment Method",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Payment Method Options
            Column(
              children: paymentMethods.map((method) {
                final isSelected = selectedPaymentMethod == method["id"];
                
                return GestureDetector(
                  onTap: () {
                    selectedPaymentMethod = method["id"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? (method["color"] as Color) : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected ? [shadowMd] : [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (method["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Icon(
                            method["icon"] as IconData,
                            color: method["color"] as Color,
                            size: 24,
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                method["name"],
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                method["description"],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Radio<String>(
                          value: method["id"],
                          groupValue: selectedPaymentMethod,
                          onChanged: (value) {
                            selectedPaymentMethod = value!;
                            setState(() {});
                          },
                          activeColor: method["color"] as Color,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Payment Method Details
            if (selectedPaymentMethod == "card") _buildCardPayment(),
            if (selectedPaymentMethod == "digital_wallet") _buildDigitalWallet(),
            if (selectedPaymentMethod == "bank_transfer") _buildBankTransfer(),
            if (selectedPaymentMethod == "buy_now_pay_later") _buildBuyNowPayLater(),
            if (selectedPaymentMethod == "gift_card") _buildGiftCard(),
            
            SizedBox(height: spXl),
          ],
        ),
      ),
      bottomNavigationBar: selectedPaymentMethod.isNotEmpty 
          ? Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowLg],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Continue to Checkout",
                      size: bs.md,
                      onPressed: () {
                        _processPaymentMethod();
                      },
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.security, size: 16, color: successColor),
                      SizedBox(width: spXs),
                      Text(
                        "Your payment information is secure",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _buildCardPayment() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Credit/Debit Card",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Saved Cards
          if (savedCards.isNotEmpty) ...[
            Text(
              "Saved Cards",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Column(
              children: savedCards.map((card) {
                final isSelected = selectedCard == card["id"];
                
                return GestureDetector(
                  onTap: () {
                    selectedCard = card["id"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusMd),
                      color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${card["type"]} •••• ${card["lastFour"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Expires ${card["expiryDate"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (card["isDefault"] as bool)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Default",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        SizedBox(width: spSm),
                        Radio<String>(
                          value: card["id"],
                          groupValue: selectedCard,
                          onChanged: (value) {
                            selectedCard = value!;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            Divider(),
            
            SizedBox(height: spSm),
          ],
          
          // Add New Card
          Text(
            "Add New Card",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Card Holder Name",
            value: cardHolderName,
            onChanged: (value) {
              cardHolderName = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
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
          
          QSwitch(
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
        ],
      ),
    );
  }

  Widget _buildDigitalWallet() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Digital Wallet",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Column(
            children: digitalWallets.map((wallet) {
              final isSelected = selectedWallet == wallet["id"];
              final isAvailable = wallet["available"] as bool;
              
              return GestureDetector(
                onTap: isAvailable ? () {
                  selectedWallet = wallet["id"];
                  setState(() {});
                } : null,
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? successColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusMd),
                    color: isSelected 
                        ? successColor.withAlpha(10) 
                        : isAvailable 
                            ? Colors.white 
                            : disabledColor.withAlpha(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        wallet["icon"] as IconData,
                        color: isAvailable 
                            ? (isSelected ? successColor : disabledBoldColor)
                            : disabledColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          wallet["name"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isAvailable 
                                ? (isSelected ? successColor : primaryColor)
                                : disabledColor,
                          ),
                        ),
                      ),
                      if (!isAvailable)
                        Text(
                          "Not Available",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      if (isAvailable)
                        Radio<String>(
                          value: wallet["id"],
                          groupValue: selectedWallet,
                          onChanged: (value) {
                            selectedWallet = value!;
                            setState(() {});
                          },
                          activeColor: successColor,
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

  Widget _buildBankTransfer() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bank Transfer",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Bank transfers may take 1-3 business days to process",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Bank Name",
            value: bankName,
            onChanged: (value) {
              bankName = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Account Number",
            value: accountNumber,
            onChanged: (value) {
              accountNumber = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Routing Number",
            value: routingNumber,
            onChanged: (value) {
              routingNumber = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBuyNowPayLater() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Buy Now, Pay Later",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Column(
            children: bnplOptions.map((option) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          option["name"],
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        QButton(
                          label: "Select",
                          size: bs.sm,
                          onPressed: () {
                            _selectBNPL(option["id"]);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      option["description"],
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      option["installments"],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
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

  Widget _buildGiftCard() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gift Card",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Gift Card Number",
            value: "",
            hint: "Enter your gift card number",
            onChanged: (value) {
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "PIN/Security Code",
            value: "",
            hint: "Enter PIN if required",
            onChanged: (value) {
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QButton(
            label: "Check Balance",
            size: bs.sm,
            onPressed: () {
              _checkGiftCardBalance();
            },
          ),
        ],
      ),
    );
  }

  void _processPaymentMethod() {
    if (selectedPaymentMethod == "card") {
      if (selectedCard.isNotEmpty || cardNumber.isNotEmpty) {
        ss("Credit card payment method selected");
        // Navigate to checkout
      } else {
        se("Please select a card or add a new one");
      }
    } else if (selectedPaymentMethod == "digital_wallet") {
      if (selectedWallet.isNotEmpty) {
        ss("Digital wallet payment method selected");
        // Navigate to checkout
      } else {
        se("Please select a digital wallet");
      }
    } else {
      ss("Payment method selected");
      // Navigate to checkout
    }
  }

  void _selectBNPL(String optionId) {
    ss("Buy Now, Pay Later option selected");
    // Handle BNPL selection
  }

  void _checkGiftCardBalance() {
    ss("Gift card balance: \$150.00");
  }

  void _showPaymentHelp() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusXl),
              topRight: Radius.circular(radiusXl),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Text(
                  "Payment Help",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Secure Payment",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "All payment information is encrypted and secure. We never store your payment details.",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        
                        SizedBox(height: spMd),
                        
                        Text(
                          "Accepted Cards",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "We accept Visa, MasterCard, American Express, and Discover cards.",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        
                        SizedBox(height: spMd),
                        
                        Text(
                          "Refund Policy",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Refunds are processed within 5-7 business days to your original payment method.",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Got It",
                    size: bs.md,
                    onPressed: () {
                      back();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
