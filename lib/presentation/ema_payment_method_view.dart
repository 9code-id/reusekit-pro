import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaPaymentMethodView extends StatefulWidget {
  const EmaPaymentMethodView({super.key});

  @override
  State<EmaPaymentMethodView> createState() => _EmaPaymentMethodViewState();
}

class _EmaPaymentMethodViewState extends State<EmaPaymentMethodView> {
  String selectedPaymentMethod = "";
  bool showAddCardForm = false;
  final formKey = GlobalKey<FormState>();
  
  // New Card Form
  String newCardNumber = "";
  String newCardHolderName = "";
  String newExpiryDate = "";
  String newCvv = "";
  bool setAsDefault = false;
  
  List<Map<String, dynamic>> savedPaymentMethods = [
    {
      "id": "card_1",
      "type": "credit_card",
      "brand": "Visa",
      "last4": "4567",
      "expiryMonth": "12",
      "expiryYear": "2027",
      "holderName": "John Doe",
      "isDefault": true,
      "isExpired": false,
      "billingAddress": {
        "street": "123 Main Street",
        "city": "New York",
        "state": "NY",
        "zip": "10001",
        "country": "US"
      }
    },
    {
      "id": "card_2",
      "type": "credit_card",
      "brand": "MasterCard",
      "last4": "8901",
      "expiryMonth": "08",
      "expiryYear": "2026",
      "holderName": "John Doe",
      "isDefault": false,
      "isExpired": false,
      "billingAddress": {
        "street": "456 Oak Avenue",
        "city": "Boston",
        "state": "MA",
        "zip": "02101",
        "country": "US"
      }
    },
    {
      "id": "card_3",
      "type": "credit_card",
      "brand": "American Express",
      "last4": "2345",
      "expiryMonth": "03",
      "expiryYear": "2024",
      "holderName": "John Doe",
      "isDefault": false,
      "isExpired": true,
      "billingAddress": {
        "street": "789 Pine Road",
        "city": "Chicago",
        "state": "IL",
        "zip": "60601",
        "country": "US"
      }
    },
    {
      "id": "paypal_1",
      "type": "paypal",
      "email": "john.doe@example.com",
      "isDefault": false,
      "isVerified": true,
    },
    {
      "id": "apple_pay_1",
      "type": "apple_pay",
      "deviceName": "iPhone 15 Pro",
      "isDefault": false,
      "isEnabled": true,
    }
  ];

  List<Map<String, dynamic>> availablePaymentTypes = [
    {
      "id": "credit_card",
      "name": "Credit Card",
      "icon": Icons.credit_card,
      "description": "Visa, MasterCard, American Express",
      "canAdd": true,
    },
    {
      "id": "debit_card",
      "name": "Debit Card",
      "icon": Icons.payment,
      "description": "Bank debit cards",
      "canAdd": true,
    },
    {
      "id": "paypal",
      "name": "PayPal",
      "icon": Icons.account_balance_wallet,
      "description": "Link your PayPal account",
      "canAdd": true,
    },
    {
      "id": "apple_pay",
      "name": "Apple Pay",
      "icon": Icons.phone_iphone,
      "description": "Touch ID or Face ID",
      "canAdd": false,
    },
    {
      "id": "google_pay",
      "name": "Google Pay",
      "icon": Icons.android,
      "description": "Pay with Google",
      "canAdd": false,
    },
  ];

  Color getBrandColor(String brand) {
    switch (brand.toLowerCase()) {
      case "visa":
        return Color(0xFF1A1F71);
      case "mastercard":
        return Color(0xFFEB001B);
      case "american express":
        return Color(0xFF006FCF);
      default:
        return primaryColor;
    }
  }

  IconData getBrandIcon(String brand) {
    switch (brand.toLowerCase()) {
      case "visa":
      case "mastercard":
      case "american express":
        return Icons.credit_card;
      default:
        return Icons.payment;
    }
  }

  void setDefaultPaymentMethod(String methodId) async {
    // Update default status
    for (var method in savedPaymentMethods) {
      method["isDefault"] = method["id"] == methodId;
    }
    setState(() {});
    ss("Default payment method updated");
  }

  void deletePaymentMethod(String methodId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this payment method?");
    if (isConfirmed) {
      savedPaymentMethods.removeWhere((method) => method["id"] == methodId);
      setState(() {});
      ss("Payment method deleted successfully");
    }
  }

  void addNewCard() {
    if (formKey.currentState!.validate()) {
      String newId = "card_${DateTime.now().millisecondsSinceEpoch}";
      
      savedPaymentMethods.add({
        "id": newId,
        "type": "credit_card",
        "brand": "Visa", // In real app, detect from card number
        "last4": newCardNumber.substring(newCardNumber.length - 4),
        "expiryMonth": newExpiryDate.split('/')[0],
        "expiryYear": "20${newExpiryDate.split('/')[1]}",
        "holderName": newCardHolderName,
        "isDefault": setAsDefault,
        "isExpired": false,
        "billingAddress": {
          "street": "",
          "city": "",
          "state": "",
          "zip": "",
          "country": "US"
        }
      });

      // If set as default, update other cards
      if (setAsDefault) {
        for (var method in savedPaymentMethods) {
          if (method["id"] != newId) {
            method["isDefault"] = false;
          }
        }
      }

      // Reset form
      newCardNumber = "";
      newCardHolderName = "";
      newExpiryDate = "";
      newCvv = "";
      setAsDefault = false;
      showAddCardForm = false;
      
      setState(() {});
      ss("Card added successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    final creditCards = savedPaymentMethods.where((method) => 
      method["type"] == "credit_card").toList();
    final digitalWallets = savedPaymentMethods.where((method) => 
      method["type"] != "credit_card").toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Methods"),
        actions: [
          QButton(
            icon: Icons.security,
            size: bs.sm,
            onPressed: () {
              //navigateTo('PaymentSecurityView')
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
            // Security Notice
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.security, color: infoColor, size: 24),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your payment methods are secure",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "All payment information is encrypted and stored securely according to PCI DSS standards.",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Credit Cards & Debit Cards
            if (creditCards.isNotEmpty) ...[
              Text(
                "Cards",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ...creditCards.map((card) {
                bool isExpired = card["isExpired"];
                bool isDefault = card["isDefault"];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isDefault ? primaryColor : disabledOutlineBorderColor,
                      width: isDefault ? 2 : 1,
                    ),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    children: [
                      // Card Header
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isDefault 
                            ? primaryColor.withAlpha(20) 
                            : Colors.grey.shade50,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: getBrandColor(card["brand"]),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                getBrandIcon(card["brand"]),
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${card["brand"]} •••• ${card["last4"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      if (isDefault) ...[
                                        SizedBox(width: spXs),
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
                                            "DEFAULT",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                      if (isExpired) ...[
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: dangerColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "EXPIRED",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    "${card["holderName"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Card Details
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Text("Expires:"),
                                Spacer(),
                                Text(
                                  "${card["expiryMonth"]}/${card["expiryYear"]}",
                                  style: TextStyle(
                                    color: isExpired ? dangerColor : disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            if (card["billingAddress"] != null) ...[
                              Row(
                                children: [
                                  Text("Billing Address:"),
                                  Spacer(),
                                  Expanded(
                                    child: Text(
                                      "${card["billingAddress"]["city"]}, ${card["billingAddress"]["state"]}",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Card Actions
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radiusMd),
                            bottomRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Row(
                          spacing: spSm,
                          children: [
                            if (!isDefault) ...[
                              Expanded(
                                child: QButton(
                                  label: "Set as Default",
                                  size: bs.sm,
                                  onPressed: () => setDefaultPaymentMethod(card["id"]),
                                ),
                              ),
                            ],
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('EditCardView')
                              },
                            ),
                            QButton(
                              icon: Icons.delete,
                              size: bs.sm,
                              onPressed: () => deletePaymentMethod(card["id"]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],

            // Digital Wallets
            if (digitalWallets.isNotEmpty) ...[
              Text(
                "Digital Wallets",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ...digitalWallets.map((wallet) {
                bool isDefault = wallet["isDefault"];
                IconData walletIcon;
                Color walletColor;
                String subtitle = "";

                switch (wallet["type"]) {
                  case "paypal":
                    walletIcon = Icons.account_balance_wallet;
                    walletColor = Color(0xFF0070BA);
                    subtitle = wallet["email"];
                    break;
                  case "apple_pay":
                    walletIcon = Icons.phone_iphone;
                    walletColor = Color(0xFF000000);
                    subtitle = wallet["deviceName"];
                    break;
                  case "google_pay":
                    walletIcon = Icons.android;
                    walletColor = Color(0xFF4285F4);
                    subtitle = "Google Account";
                    break;
                  default:
                    walletIcon = Icons.account_balance_wallet;
                    walletColor = primaryColor;
                    subtitle = "Digital Wallet";
                }

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isDefault ? primaryColor : disabledOutlineBorderColor,
                      width: isDefault ? 2 : 1,
                    ),
                    boxShadow: [shadowMd],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: walletColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          walletIcon,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  wallet["type"] == "paypal" 
                                    ? "PayPal"
                                    : wallet["type"] == "apple_pay"
                                      ? "Apple Pay"
                                      : "Google Pay",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                if (isDefault) ...[
                                  SizedBox(width: spXs),
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
                                      "DEFAULT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              subtitle,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isDefault) ...[
                        QButton(
                          label: "Set Default",
                          size: bs.sm,
                          onPressed: () => setDefaultPaymentMethod(wallet["id"]),
                        ),
                      ],
                      QButton(
                        icon: Icons.delete,
                        size: bs.sm,
                        onPressed: () => deletePaymentMethod(wallet["id"]),
                      ),
                    ],
                  ),
                );
              }),
            ],

            // Add New Payment Method
            if (!showAddCardForm) ...[
              Text(
                "Add New Payment Method",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: availablePaymentTypes.map((type) {
                  bool canAdd = type["canAdd"];
                  
                  return GestureDetector(
                    onTap: canAdd ? () {
                      if (type["id"] == "credit_card" || type["id"] == "debit_card") {
                        showAddCardForm = true;
                        setState(() {});
                      } else {
                        // Handle other payment types
                        ss("${type["name"]} setup would be handled here");
                      }
                    } : null,
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: canAdd ? Colors.white : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: canAdd ? primaryColor : disabledOutlineBorderColor,
                          style: canAdd ? BorderStyle.solid : BorderStyle.solid,
                        ),
                        boxShadow: canAdd ? [shadowSm] : [],
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: canAdd ? primaryColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              type["icon"],
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          Text(
                            "${type["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: canAdd ? Colors.black87 : disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${type["description"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (!canAdd) ...[
                            Text(
                              "Available in app",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],

            // Add Card Form
            if (showAddCardForm) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor),
                  boxShadow: [shadowMd],
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    spacing: spMd,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Add New Card",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            icon: Icons.close,
                            size: bs.sm,
                            onPressed: () {
                              showAddCardForm = false;
                              setState(() {});
                            },
                          ),
                        ],
                      ),

                      QTextField(
                        label: "Card Number *",
                        value: newCardNumber,
                        hint: "1234 5678 9012 3456",
                        validator: Validator.required,
                        onChanged: (value) {
                          newCardNumber = value;
                          setState(() {});
                        },
                      ),

                      QTextField(
                        label: "Cardholder Name *",
                        value: newCardHolderName,
                        hint: "John Doe",
                        validator: Validator.required,
                        onChanged: (value) {
                          newCardHolderName = value;
                          setState(() {});
                        },
                      ),

                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "Expiry Date *",
                              value: newExpiryDate,
                              hint: "MM/YY",
                              validator: Validator.required,
                              onChanged: (value) {
                                newExpiryDate = value;
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: QTextField(
                              label: "CVV *",
                              value: newCvv,
                              hint: "123",
                              validator: Validator.required,
                              onChanged: (value) {
                                newCvv = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),

                      QSwitch(
                        items: [
                          {
                            "label": "Set as default payment method",
                            "value": true,
                            "checked": setAsDefault,
                          }
                        ],
                        value: setAsDefault ? [{"label": "Set as default payment method", "value": true, "checked": true}] : [],
                        onChanged: (values, ids) {
                          setAsDefault = values.isNotEmpty;
                          setState(() {});
                        },
                      ),

                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Cancel",
                              size: bs.sm,
                              onPressed: () {
                                showAddCardForm = false;
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Add Card",
                              size: bs.sm,
                              onPressed: addNewCard,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
