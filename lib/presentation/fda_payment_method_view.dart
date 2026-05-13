import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaPaymentMethodView extends StatefulWidget {
  const FdaPaymentMethodView({super.key});

  @override
  State<FdaPaymentMethodView> createState() => _FdaPaymentMethodViewState();
}

class _FdaPaymentMethodViewState extends State<FdaPaymentMethodView> {
  int selectedPaymentIndex = 0;
  String newCardNumber = "";
  String newCardHolderName = "";
  String newCardExpiry = "";
  String newCardCvv = "";
  bool saveCard = true;

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "1",
      "type": "Credit Card",
      "name": "Visa ending in 4567",
      "icon": Icons.credit_card,
      "isDefault": true,
      "cardNumber": "**** **** **** 4567",
      "expiryDate": "12/25",
      "holderName": "John Doe",
    },
    {
      "id": "2",
      "type": "Credit Card",
      "name": "Mastercard ending in 8901",
      "icon": Icons.credit_card,
      "isDefault": false,
      "cardNumber": "**** **** **** 8901",
      "expiryDate": "06/26",
      "holderName": "John Doe",
    },
    {
      "id": "3",
      "type": "Digital Wallet",
      "name": "PayPal",
      "icon": Icons.account_balance_wallet,
      "isDefault": false,
      "email": "john.doe@email.com",
    },
    {
      "id": "4",
      "type": "Digital Wallet", 
      "name": "Apple Pay",
      "icon": Icons.phone_iphone,
      "isDefault": false,
      "deviceName": "iPhone 14 Pro",
    },
    {
      "id": "5",
      "type": "Bank Transfer",
      "name": "Direct Bank Transfer",
      "icon": Icons.account_balance,
      "isDefault": false,
      "bankName": "Chase Bank",
      "accountNumber": "**** 5678",
    },
    {
      "id": "6",
      "type": "Cash",
      "name": "Cash on Delivery",
      "icon": Icons.payments,
      "isDefault": false,
      "description": "Pay when your order arrives",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Methods"),
        actions: [
          QButton(
            icon: Icons.help_outline,
            size: bs.sm,
            onPressed: () {
              _showPaymentHelp();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Methods List
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Payment Method",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...paymentMethods.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> method = entry.value;
                    bool isSelected = selectedPaymentIndex == index;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPaymentIndex = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(top: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.transparent,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: isSelected
                                  ? Icon(Icons.check, color: Colors.white, size: 14)
                                  : null,
                            ),
                            SizedBox(width: spSm),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                method["icon"] as IconData,
                                color: primaryColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${method["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? primaryColor : Colors.black,
                                          ),
                                        ),
                                      ),
                                      if (method["isDefault"] as bool)
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: successColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
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
                                  Text(
                                    "${method["type"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  _buildPaymentDetails(method),
                                ],
                              ),
                            ),
                            if (method["type"] != "Cash")
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  _showPaymentOptions(method);
                                },
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Add New Payment Method
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add New Payment Method",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QButton(
                    label: "Add Credit/Debit Card",
                    size: bs.md,
                    icon: Icons.credit_card,
                    onPressed: () {
                      _showAddCardDialog();
                    },
                  ),
                  QButton(
                    label: "Link PayPal Account",
                    size: bs.md,
                    icon: Icons.account_balance_wallet,
                    onPressed: () {
                      ss("PayPal integration coming soon");
                    },
                  ),
                  QButton(
                    label: "Add Bank Account",
                    size: bs.md,
                    icon: Icons.account_balance,
                    onPressed: () {
                      ss("Bank account integration coming soon");
                    },
                  ),
                ],
              ),
            ),

            // Payment Security
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Security",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.security, color: successColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Your payment information is encrypted and secure",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.verified_user, color: successColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "PCI DSS compliant payment processing",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.lock, color: successColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "256-bit SSL encryption for all transactions",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Payment Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Payment Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            border: Border.all(color: disabledOutlineBorderColor),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.phone_iphone, color: primaryColor, size: 32),
                              SizedBox(height: spSm),
                              Text(
                                "Apple Pay",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            border: Border.all(color: disabledOutlineBorderColor),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.android, color: primaryColor, size: 32),
                              SizedBox(height: spSm),
                              Text(
                                "Google Pay",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            border: Border.all(color: disabledOutlineBorderColor),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.account_balance_wallet, color: primaryColor, size: 32),
                              SizedBox(height: spSm),
                              Text(
                                "PayPal",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: QButton(
          label: "Confirm Payment Method",
          size: bs.md,
          icon: Icons.check,
          onPressed: () {
            ss("Payment method confirmed");
            back();
          },
        ),
      ),
    );
  }

  Widget _buildPaymentDetails(Map<String, dynamic> method) {
    switch (method["type"]) {
      case "Credit Card":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${method["cardNumber"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledColor,
                fontFamily: 'monospace',
              ),
            ),
            Text(
              "Expires ${method["expiryDate"]} • ${method["holderName"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledColor,
              ),
            ),
          ],
        );
      case "Digital Wallet":
        if (method["email"] != null) {
          return Text(
            "${method["email"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          );
        } else if (method["deviceName"] != null) {
          return Text(
            "${method["deviceName"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          );
        }
        break;
      case "Bank Transfer":
        return Text(
          "${method["bankName"]} ${method["accountNumber"]}",
          style: TextStyle(
            fontSize: 12,
            color: disabledColor,
          ),
        );
      case "Cash":
        return Text(
          "${method["description"]}",
          style: TextStyle(
            fontSize: 12,
            color: disabledColor,
          ),
        );
    }
    return SizedBox();
  }

  void _showAddCardDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Card"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "Card Number",
              value: newCardNumber,
              hint: "1234 5678 9012 3456",
              onChanged: (value) {
                newCardNumber = value;
              },
            ),
            QTextField(
              label: "Cardholder Name",
              value: newCardHolderName,
              hint: "John Doe",
              onChanged: (value) {
                newCardHolderName = value;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Expiry Date",
                    value: newCardExpiry,
                    hint: "MM/YY",
                    onChanged: (value) {
                      newCardExpiry = value;
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "CVV",
                    value: newCardCvv,
                    hint: "123",
                    onChanged: (value) {
                      newCardCvv = value;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: saveCard,
                  onChanged: (value) {
                    setState(() {
                      saveCard = value ?? true;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    "Save this card for future purchases",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Card",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Card added successfully");
              setState(() {
                paymentMethods.insert(0, {
                  "id": "${paymentMethods.length + 1}",
                  "type": "Credit Card",
                  "name": "Card ending in ${newCardNumber.substring(newCardNumber.length - 4)}",
                  "icon": Icons.credit_card,
                  "isDefault": false,
                  "cardNumber": "**** **** **** ${newCardNumber.substring(newCardNumber.length - 4)}",
                  "expiryDate": newCardExpiry,
                  "holderName": newCardHolderName,
                });
                newCardNumber = "";
                newCardHolderName = "";
                newCardExpiry = "";
                newCardCvv = "";
              });
            },
          ),
        ],
      ),
    );
  }

  void _showPaymentOptions(Map<String, dynamic> method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QButton(
              label: "Set as Default",
              size: bs.md,
              icon: Icons.star,
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  for (var m in paymentMethods) {
                    m["isDefault"] = false;
                  }
                  method["isDefault"] = true;
                });
                ss("Set as default payment method");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Edit Details",
              size: bs.md,
              icon: Icons.edit,
              onPressed: () {
                Navigator.pop(context);
                ss("Edit feature coming soon");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Remove",
              size: bs.md,
              icon: Icons.delete,
              color: dangerColor,
              onPressed: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Remove this payment method?");
                if (isConfirmed) {
                  setState(() {
                    paymentMethods.removeWhere((m) => m["id"] == method["id"]);
                  });
                  ss("Payment method removed");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Help"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Accepted Payment Methods:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: spSm),
            Text("• Visa, Mastercard, American Express"),
            Text("• PayPal and other digital wallets"),
            Text("• Apple Pay and Google Pay"),
            Text("• Direct bank transfer"),
            Text("• Cash on delivery"),
            SizedBox(height: spMd),
            Text(
              "Security:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: spSm),
            Text("• All payments are encrypted with 256-bit SSL"),
            Text("• We never store your full card details"),
            Text("• PCI DSS compliant payment processing"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
