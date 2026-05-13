import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsPaymentMethodView extends StatefulWidget {
  const EcsPaymentMethodView({super.key});

  @override
  State<EcsPaymentMethodView> createState() => _EcsPaymentMethodViewState();
}

class _EcsPaymentMethodViewState extends State<EcsPaymentMethodView> {
  String selectedPaymentMethod = "credit_card";
  bool savePaymentMethod = false;
  bool loading = false;

  // Credit Card Details
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardHolderName = "";

  // Bank Transfer Details
  String selectedBank = "";

  // Digital Wallet Details
  String selectedWallet = "";

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "credit_card",
      "name": "Credit/Debit Card",
      "icon": Icons.credit_card,
      "description": "Visa, Mastercard, American Express",
      "isAvailable": true,
    },
    {
      "id": "paypal",
      "name": "PayPal",
      "icon": Icons.account_balance_wallet,
      "description": "Pay with your PayPal account",
      "isAvailable": true,
    },
    {
      "id": "apple_pay",
      "name": "Apple Pay",
      "icon": Icons.phone_iphone,
      "description": "Touch ID or Face ID",
      "isAvailable": true,
    },
    {
      "id": "google_pay",
      "name": "Google Pay",
      "icon": Icons.android,
      "description": "Quick and secure payment",
      "isAvailable": true,
    },
    {
      "id": "bank_transfer",
      "name": "Bank Transfer",
      "icon": Icons.account_balance,
      "description": "Direct bank account transfer",
      "isAvailable": true,
    },
    {
      "id": "digital_wallet",
      "name": "Digital Wallet",
      "icon": Icons.wallet,
      "description": "GrabPay, OVO, DANA",
      "isAvailable": true,
    },
    {
      "id": "installment",
      "name": "Installment",
      "icon": Icons.schedule,
      "description": "0% interest for 3-12 months",
      "isAvailable": true,
    },
    {
      "id": "cod",
      "name": "Cash on Delivery",
      "icon": Icons.delivery_dining,
      "description": "Pay when your order arrives",
      "isAvailable": false,
    },
  ];

  List<Map<String, dynamic>> savedCards = [
    {
      "id": "card1",
      "lastFour": "4532",
      "brand": "Visa",
      "expiryMonth": "12",
      "expiryYear": "25",
      "isDefault": true,
    },
    {
      "id": "card2",
      "lastFour": "8901",
      "brand": "Mastercard",
      "expiryMonth": "08",
      "expiryYear": "26",
      "isDefault": false,
    },
  ];

  List<Map<String, dynamic>> banks = [
    {"name": "Bank Central Asia (BCA)", "code": "bca"},
    {"name": "Bank Mandiri", "code": "mandiri"},
    {"name": "Bank Negara Indonesia (BNI)", "code": "bni"},
    {"name": "Bank Rakyat Indonesia (BRI)", "code": "bri"},
    {"name": "CIMB Niaga", "code": "cimb"},
  ];

  List<Map<String, dynamic>> digitalWallets = [
    {"name": "GrabPay", "code": "grabpay"},
    {"name": "OVO", "code": "ovo"},
    {"name": "DANA", "code": "dana"},
    {"name": "LinkAja", "code": "linkaja"},
    {"name": "ShopeePay", "code": "shopeepay"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Order Summary
            Container(
              width: double.infinity,
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
                    "Order Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Subtotal:",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$89.99",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Shipping:",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$5.99",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Tax:",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$7.20",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$103.18",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Payment Methods
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Select Payment Method",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...paymentMethods.map((method) {
                    final isSelected = selectedPaymentMethod == method["id"];
                    final isAvailable = method["isAvailable"] as bool;
                    
                    return GestureDetector(
                      onTap: isAvailable ? () {
                        selectedPaymentMethod = method["id"];
                        setState(() {});
                      } : null,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isAvailable ? Colors.white : Colors.grey.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isAvailable 
                                    ? primaryColor.withAlpha(30)
                                    : disabledColor.withAlpha(30),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                method["icon"],
                                color: isAvailable ? primaryColor : disabledColor,
                                size: 24,
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
                                      fontWeight: FontWeight.w600,
                                      color: isAvailable ? primaryColor : disabledColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${method["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isAvailable ? disabledBoldColor : disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.radio_button_checked,
                                color: primaryColor,
                                size: 20,
                              )
                            else
                              Icon(
                                Icons.radio_button_unchecked,
                                color: disabledColor,
                                size: 20,
                              ),
                            if (!isAvailable)
                              Container(
                                margin: EdgeInsets.only(left: spSm),
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Not Available",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Payment Details
            if (selectedPaymentMethod == "credit_card") ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Credit Card Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    if (savedCards.isNotEmpty) ...[
                      Text(
                        "Saved Cards",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      ...savedCards.map((card) {
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            border: Border.all(color: disabledColor),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
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
                                      "${card["brand"]} ending in ${card["lastFour"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
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
                              if (card["isDefault"])
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
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                      
                      Text(
                        "Or add a new card",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                    
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
                    
                    QTextField(
                      label: "Cardholder Name",
                      value: cardHolderName,
                      hint: "Name on card",
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
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Save this card for future purchases",
                          "value": true,
                          "checked": savePaymentMethod,
                        }
                      ],
                      value: [
                        if (savePaymentMethod)
                          {
                            "label": "Save this card for future purchases",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          savePaymentMethod = values.isNotEmpty;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],

            if (selectedPaymentMethod == "bank_transfer") ...[
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Select Bank",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Bank",
                      items: banks.map((bank) => {
                        "label": bank["name"],
                        "value": bank["code"],
                      }).toList(),
                      value: selectedBank,
                      onChanged: (value, label) {
                        selectedBank = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],

            if (selectedPaymentMethod == "digital_wallet") ...[
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Select Digital Wallet",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Digital Wallet",
                      items: digitalWallets.map((wallet) => {
                        "label": wallet["name"],
                        "value": wallet["code"],
                      }).toList(),
                      value: selectedWallet,
                      onChanged: (value, label) {
                        selectedWallet = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],

            // Security Notice
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
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
                      "Your payment information is encrypted and secure. We never store your payment details.",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Row(
              children: [
                Text(
                  "Total: \$103.18",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                if (loading)
                  CircularProgressIndicator(
                    color: primaryColor,
                    strokeWidth: 2,
                  ),
              ],
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Proceed to Payment",
                size: bs.md,
                onPressed: loading ? null : () async {
                  loading = true;
                  setState(() {});
                  
                  await Future.delayed(Duration(seconds: 2));
                  
                  loading = false;
                  setState(() {});
                  
                  ss("Payment processed successfully!");
                  // Navigate to payment confirmation
                  // ss('Next page'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
