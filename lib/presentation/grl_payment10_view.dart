import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPayment10View extends StatefulWidget {
  @override
  State<GrlPayment10View> createState() => _GrlPayment10ViewState();
}

class _GrlPayment10ViewState extends State<GrlPayment10View> {
  String selectedPaymentMethod = "card";
  String selectedInstallment = "1";
  String selectedAccount = "checking";
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";
  String billingAddress = "";
  String billingCity = "";
  String billingZip = "";
  String accountNumber = "";
  String routingNumber = "";
  String accountName = "";
  bool savePaymentMethod = false;
  bool agreeToTerms = false;
  bool enableAutoPay = false;
  bool showPaymentForm = false;

  final List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "card",
      "name": "Credit/Debit Card",
      "icon": Icons.credit_card,
      "description": "Visa, Mastercard, American Express"
    },
    {
      "id": "bank",
      "name": "Bank Transfer",
      "icon": Icons.account_balance,
      "description": "Direct bank account transfer"
    },
    {
      "id": "paypal",
      "name": "PayPal",
      "icon": Icons.payment,
      "description": "Pay with your PayPal account"
    },
    {
      "id": "apple_pay",
      "name": "Apple Pay",
      "icon": Icons.phone_iphone,
      "description": "Touch ID or Face ID payment"
    },
    {
      "id": "google_pay",
      "name": "Google Pay",
      "icon": Icons.android,
      "description": "Pay with Google Pay wallet"
    },
  ];

  final List<Map<String, dynamic>> installmentOptions = [
    {"value": "1", "label": "Pay in full", "fee": "No fee"},
    {"value": "3", "label": "3 months", "fee": "2.9% fee"},
    {"value": "6", "label": "6 months", "fee": "5.9% fee"},
    {"value": "12", "label": "12 months", "fee": "9.9% fee"},
  ];

  final List<Map<String, dynamic>> accountTypes = [
    {"value": "checking", "label": "Checking Account"},
    {"value": "savings", "label": "Savings Account"},
  ];

  final List<Map<String, dynamic>> savedPaymentMethods = [
    {
      "id": "card_1",
      "type": "card",
      "name": "Visa ending in 4242",
      "expiry": "12/25",
      "isDefault": true
    },
    {
      "id": "card_2",
      "type": "card",
      "name": "Mastercard ending in 8888",
      "expiry": "03/26",
      "isDefault": false
    },
    {
      "id": "bank_1",
      "type": "bank",
      "name": "Chase Bank ****1234",
      "expiry": "",
      "isDefault": false
    },
  ];

  void _processPayment() async {
    if (!agreeToTerms) {
      se("Please agree to the terms and conditions");
      return;
    }

    if (selectedPaymentMethod == "card") {
      if (cardNumber.isEmpty || expiryDate.isEmpty || cvv.isEmpty || cardholderName.isEmpty) {
        se("Please fill in all card details");
        return;
      }
    } else if (selectedPaymentMethod == "bank") {
      if (accountNumber.isEmpty || routingNumber.isEmpty || accountName.isEmpty) {
        se("Please fill in all bank account details");
        return;
      }
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Payment processed successfully!");
    
    // Reset form
    setState(() {
      cardNumber = "";
      expiryDate = "";
      cvv = "";
      cardholderName = "";
      billingAddress = "";
      billingCity = "";
      billingZip = "";
      accountNumber = "";
      routingNumber = "";
      accountName = "";
      agreeToTerms = false;
      showPaymentForm = false;
    });
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> method) {
    final isSelected = selectedPaymentMethod == method["id"];
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method["id"];
          showPaymentForm = true;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                method["icon"],
                color: Colors.white,
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
                      fontWeight: FontWeight.bold,
                      color: isSelected ? primaryColor : Colors.black,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${method["description"]}",
                    style: TextStyle(
                      fontSize: 14,
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
  }

  Widget _buildSavedPaymentMethodCard(Map<String, dynamic> method) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(
            method["type"] == "card" ? Icons.credit_card : Icons.account_balance,
            color: primaryColor,
            size: 24,
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
                  ),
                ),
                if (method["expiry"].isNotEmpty) ...[
                  SizedBox(height: spXs),
                  Text(
                    "Expires ${method["expiry"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
                if (method["isDefault"]) ...[
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Default",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              QButton(
                label: "Use",
                size: bs.sm,
                onPressed: () {
                  setState(() {
                    showPaymentForm = true;
                  });
                  ss("Payment method selected");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  // Show options menu
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Card Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Card Number",
            value: cardNumber,
            hint: "1234 5678 9012 3456",
            onChanged: (value) {
              cardNumber = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
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
              SizedBox(width: spMd),
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
          SizedBox(height: spMd),
          QTextField(
            label: "Cardholder Name",
            value: cardholderName,
            hint: "John Doe",
            onChanged: (value) {
              cardholderName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Text(
            "Billing Address",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Address",
            value: billingAddress,
            hint: "123 Main Street",
            onChanged: (value) {
              billingAddress = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "City",
                  value: billingCity,
                  hint: "New York",
                  onChanged: (value) {
                    billingCity = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QTextField(
                  label: "ZIP Code",
                  value: billingZip,
                  hint: "10001",
                  onChanged: (value) {
                    billingZip = value;
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

  Widget _buildBankForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bank Account Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Account Type",
            items: accountTypes,
            value: selectedAccount,
            onChanged: (value, label) {
              selectedAccount = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Account Number",
            value: accountNumber,
            hint: "1234567890",
            onChanged: (value) {
              accountNumber = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Routing Number",
            value: routingNumber,
            hint: "021000021",
            onChanged: (value) {
              routingNumber = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Account Holder Name",
            value: accountName,
            hint: "John Doe",
            onChanged: (value) {
              accountName = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInstallmentOptions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ...installmentOptions.map((option) {
            final isSelected = selectedInstallment == option["value"];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedInstallment = option["value"];
                });
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(radiusSm),
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
                          ? Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${option["label"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? primaryColor : Colors.black,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${option["fee"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          _buildSummaryRow("Subtotal", "\$149.99"),
          _buildSummaryRow("Processing Fee", "\$2.99"),
          if (selectedInstallment != "1")
            _buildSummaryRow("Installment Fee", "\$8.99"),
          _buildSummaryRow("Tax", "\$15.00"),
          Divider(color: disabledOutlineBorderColor),
          _buildSummaryRow(
            "Total",
            "\$${selectedInstallment == "1" ? "167.98" : "176.97"}",
            isTotal: true,
          ),
          if (selectedInstallment != "1") ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "Monthly payment: \$${((double.parse(selectedInstallment) > 1 ? 176.97 : 167.98) / int.parse(selectedInstallment)).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  color: infoColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : disabledBoldColor,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? primaryColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Gateway"),
        actions: [
          QButton(
            icon: Icons.help_outline,
            size: bs.sm,
            onPressed: () {
              si("Need help? Contact our support team");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saved Payment Methods
            Text(
              "Saved Payment Methods",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ...savedPaymentMethods.map((method) => _buildSavedPaymentMethodCard(method)).toList(),
            
            SizedBox(height: spLg),
            
            // Add New Payment Method
            Text(
              "Add New Payment Method",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ...paymentMethods.map((method) => _buildPaymentMethodCard(method)).toList(),
            
            if (showPaymentForm) ...[
              SizedBox(height: spLg),
              
              // Payment Form
              if (selectedPaymentMethod == "card")
                _buildCardForm()
              else if (selectedPaymentMethod == "bank")
                _buildBankForm()
              else
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 48,
                        color: successColor,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Redirecting to ${paymentMethods.firstWhere((m) => m["id"] == selectedPaymentMethod)["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "You will be redirected to complete your payment securely",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              
              SizedBox(height: spLg),
              
              // Installment Options
              _buildInstallmentOptions(),
              
              SizedBox(height: spLg),
              
              // Payment Summary
              _buildPaymentSummary(),
              
              SizedBox(height: spLg),
              
              // Payment Options
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Save payment method for future use",
                                "value": true,
                                "checked": savePaymentMethod,
                              }
                            ],
                            value: [
                              if (savePaymentMethod)
                                {
                                  "label": "Save payment method for future use",
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
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Enable auto-pay for future invoices",
                                "value": true,
                                "checked": enableAutoPay,
                              }
                            ],
                            value: [
                              if (enableAutoPay)
                                {
                                  "label": "Enable auto-pay for future invoices",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                enableAutoPay = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "I agree to the Terms and Conditions",
                                "value": true,
                                "checked": agreeToTerms,
                              }
                            ],
                            value: [
                              if (agreeToTerms)
                                {
                                  "label": "I agree to the Terms and Conditions",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              setState(() {
                                agreeToTerms = values.isNotEmpty;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Process Payment Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Process Payment",
                  size: bs.md,
                  onPressed: _processPayment,
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Security Notice
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: successColor,
                      size: 24,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Secure Payment",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Your payment information is encrypted and secure. We never store your full card details.",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
