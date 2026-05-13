import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSubscription8View extends StatefulWidget {
  @override
  State<GrlSubscription8View> createState() => _GrlSubscription8ViewState();
}

class _GrlSubscription8ViewState extends State<GrlSubscription8View> {
  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "card_1",
      "type": "credit_card",
      "brand": "Visa",
      "last4": "4567",
      "expiryMonth": 12,
      "expiryYear": 2026,
      "isDefault": true,
      "holderName": "John Doe",
    },
    {
      "id": "card_2",
      "type": "credit_card",
      "brand": "Mastercard",
      "last4": "8901",
      "expiryMonth": 8,
      "expiryYear": 2027,
      "isDefault": false,
      "holderName": "John Doe",
    },
    {
      "id": "paypal_1",
      "type": "paypal",
      "email": "john.doe@example.com",
      "isDefault": false,
    },
  ];

  bool showAddPaymentForm = false;

  // Add payment form fields
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";
  String selectedCardType = "credit_card";
  String paypalEmail = "";

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Methods"),
        actions: [
          if (!showAddPaymentForm)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showAddPaymentForm = true;
                setState(() {});
              },
            ),
        ],
      ),
      body: showAddPaymentForm
          ? _buildAddPaymentForm()
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildSecurityInfo(),
                  _buildPaymentMethodsList(),
                  _buildBillingInfo(),
                ],
              ),
            ),
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
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
                "Secure Payment Processing",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Text(
            "Your payment information is encrypted and stored securely. We never store your full card details.",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              Icon(Icons.verified_user, color: successColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "SSL Encrypted",
                style: TextStyle(
                  color: successColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.shield, color: successColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "PCI Compliant",
                style: TextStyle(
                  color: successColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsList() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Payment Methods",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showAddPaymentForm = true;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                        size: 14,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Add New",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: paymentMethods.map((method) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: method["isDefault"] as bool ? primaryColor.withAlpha(10) : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: method["isDefault"] as bool ? primaryColor : disabledOutlineBorderColor,
                    width: method["isDefault"] as bool ? 2 : 1,
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getPaymentMethodColor(method["type"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            _getPaymentMethodIcon(method["type"]),
                            color: _getPaymentMethodColor(method["type"]),
                            size: 20,
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
                                    method["type"] == "paypal" 
                                        ? "PayPal"
                                        : "${method["brand"]} •••• ${method["last4"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (method["isDefault"] as bool)
                                    Container(
                                      margin: EdgeInsets.only(left: spSm),
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "DEFAULT",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Text(
                                method["type"] == "paypal" 
                                    ? "${method["email"]}"
                                    : "Expires ${method["expiryMonth"]}/${method["expiryYear"]} • ${method["holderName"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_vert,
                            color: disabledBoldColor,
                            size: 20,
                          ),
                          onSelected: (value) => _handlePaymentMethodAction(value, method),
                          itemBuilder: (context) => [
                            if (!(method["isDefault"] as bool))
                              PopupMenuItem(
                                value: "set_default",
                                child: Row(
                                  children: [
                                    Icon(Icons.star, size: 16, color: warningColor),
                                    SizedBox(width: spSm),
                                    Text("Set as Default"),
                                  ],
                                ),
                              ),
                            PopupMenuItem(
                              value: "edit",
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 16, color: primaryColor),
                                  SizedBox(width: spSm),
                                  Text("Edit"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: "delete",
                              child: Row(
                                children: [
                                  Icon(Icons.delete, size: 16, color: dangerColor),
                                  SizedBox(width: spSm),
                                  Text("Delete"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (method["type"] == "credit_card" && _isCardExpiringSoon(method))
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: warningColor,
                              size: 14,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "This card expires soon. Please update it to avoid payment issues.",
                                style: TextStyle(
                                  color: warningColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                si("Edit payment method");
                              },
                              child: Text(
                                "Update",
                                style: TextStyle(
                                  color: warningColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
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

  Widget _buildBillingInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Billing Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Text(
                    "Next billing date:",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "July 22, 2025",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Billing amount:",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "\$32.39",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Payment method:",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Visa •••• 4567",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  child: QButton(
                    label: "View History",
                    size: bs.sm,
                    onPressed: () {
                      si("Opening billing history");
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: QButton(
                    label: "Update Billing",
                    size: bs.sm,
                    onPressed: () {
                      si("Update billing information");
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddPaymentForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showAddPaymentForm = false;
                          setState(() {});
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "Add Payment Method",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Payment Type",
                    items: [
                      {"label": "Credit/Debit Card", "value": "credit_card"},
                      {"label": "PayPal", "value": "paypal"},
                    ],
                    value: selectedCardType,
                    onChanged: (value, label) {
                      selectedCardType = value;
                      setState(() {});
                    },
                  ),
                  if (selectedCardType == "credit_card") ...[
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
                    QTextField(
                      label: "Cardholder Name",
                      value: cardholderName,
                      hint: "John Doe",
                      validator: Validator.required,
                      onChanged: (value) {
                        cardholderName = value;
                        setState(() {});
                      },
                    ),
                  ] else if (selectedCardType == "paypal") ...[
                    QTextField(
                      label: "PayPal Email",
                      value: paypalEmail,
                      hint: "your@email.com",
                      validator: Validator.email,
                      onChanged: (value) {
                        paypalEmail = value;
                        setState(() {});
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: infoColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "PayPal Setup",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "You'll be redirected to PayPal to complete the setup process securely.",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: Container(
                          child: QButton(
                            label: "Cancel",
                            size: bs.md,
                            onPressed: () {
                              showAddPaymentForm = false;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: QButton(
                            label: selectedCardType == "paypal" ? "Connect PayPal" : "Add Card",
                            size: bs.md,
                            onPressed: _addPaymentMethod,
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
    );
  }

  void _addPaymentMethod() {
    if (!formKey.currentState!.validate()) {
      se("Please fill in all required fields");
      return;
    }

    // Simulate adding payment method
    if (selectedCardType == "credit_card") {
      paymentMethods.add({
        "id": "card_${paymentMethods.length + 1}",
        "type": "credit_card",
        "brand": "Visa", // This would be detected from card number
        "last4": cardNumber.substring(cardNumber.length - 4),
        "expiryMonth": int.parse(expiryDate.split('/')[0]),
        "expiryYear": 2000 + int.parse(expiryDate.split('/')[1]),
        "isDefault": paymentMethods.isEmpty,
        "holderName": cardholderName,
      });
    } else {
      paymentMethods.add({
        "id": "paypal_${paymentMethods.length + 1}",
        "type": "paypal",
        "email": paypalEmail,
        "isDefault": paymentMethods.isEmpty,
      });
    }

    // Reset form
    cardNumber = "";
    expiryDate = "";
    cvv = "";
    cardholderName = "";
    paypalEmail = "";
    showAddPaymentForm = false;
    setState(() {});

    ss("Payment method added successfully!");
  }

  void _handlePaymentMethodAction(String action, Map<String, dynamic> method) async {
    switch (action) {
      case "set_default":
        // Set all methods to non-default
        for (var m in paymentMethods) {
          m["isDefault"] = false;
        }
        // Set selected method as default
        method["isDefault"] = true;
        setState(() {});
        ss("Default payment method updated");
        break;

      case "edit":
        si("Edit payment method");
        break;

      case "delete":
        bool isConfirmed = await confirm("Delete this payment method?");
        if (isConfirmed) {
          // If deleting default method, set another as default
          if (method["isDefault"] as bool && paymentMethods.length > 1) {
            paymentMethods.first["isDefault"] = true;
          }
          paymentMethods.remove(method);
          setState(() {});
          ss("Payment method deleted");
        }
        break;
    }
  }

  IconData _getPaymentMethodIcon(String type) {
    switch (type) {
      case "credit_card":
        return Icons.credit_card;
      case "paypal":
        return Icons.account_balance_wallet;
      default:
        return Icons.payment;
    }
  }

  Color _getPaymentMethodColor(String type) {
    switch (type) {
      case "credit_card":
        return primaryColor;
      case "paypal":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  bool _isCardExpiringSoon(Map<String, dynamic> method) {
    if (method["type"] != "credit_card") return false;
    
    final now = DateTime.now();
    final expiryDate = DateTime(method["expiryYear"], method["expiryMonth"]);
    final monthsUntilExpiry = ((expiryDate.year - now.year) * 12) + (expiryDate.month - now.month);
    
    return monthsUntilExpiry <= 3 && monthsUntilExpiry > 0;
  }
}
