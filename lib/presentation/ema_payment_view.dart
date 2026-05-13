import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaPaymentView extends StatefulWidget {
  const EmaPaymentView({super.key});

  @override
  State<EmaPaymentView> createState() => _EmaPaymentViewState();
}

class _EmaPaymentViewState extends State<EmaPaymentView> {
  final formKey = GlobalKey<FormState>();
  String selectedPaymentMethod = "credit_card";
  bool savePaymentInfo = false;
  bool agreeToTerms = false;
  
  // Credit Card Details
  String cardNumber = "";
  String cardHolderName = "";
  String expiryDate = "";
  String cvv = "";
  
  // Billing Address
  String billingAddress = "";
  String billingCity = "";
  String billingState = "";
  String billingZip = "";
  String billingCountry = "US";
  
  // Digital Wallet
  String selectedWallet = "";
  
  Map<String, dynamic> orderSummary = {
    "eventName": "Grand Concert 2025",
    "venue": "Madison Square Garden",
    "date": "2025-07-15",
    "time": "19:30",
    "ticketType": "VIP Experience Package",
    "quantity": 2,
    "seats": ["A-R5-S12", "A-R5-S13"],
    "addOns": ["VIP Parking", "Official T-Shirt"],
    "subtotal": 1000.0,
    "processingFee": 50.0,
    "serviceFee": 20.0,
    "taxes": 86.0,
    "discount": 100.0,
    "total": 1056.0,
    "promoCode": "EARLY2025",
  };

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "credit_card",
      "name": "Credit Card",
      "icon": Icons.credit_card,
      "description": "Visa, MasterCard, American Express",
      "fees": 0.0,
      "processingTime": "Instant",
    },
    {
      "id": "debit_card",
      "name": "Debit Card",
      "icon": Icons.payment,
      "description": "Bank debit cards",
      "fees": 0.0,
      "processingTime": "Instant",
    },
    {
      "id": "paypal",
      "name": "PayPal",
      "icon": Icons.account_balance_wallet,
      "description": "Pay with your PayPal account",
      "fees": 0.0,
      "processingTime": "Instant",
    },
    {
      "id": "apple_pay",
      "name": "Apple Pay",
      "icon": Icons.phone_iphone,
      "description": "Touch ID or Face ID",
      "fees": 0.0,
      "processingTime": "Instant",
    },
    {
      "id": "google_pay",
      "name": "Google Pay",
      "icon": Icons.android,
      "description": "Pay with Google",
      "fees": 0.0,
      "processingTime": "Instant",
    },
    {
      "id": "bank_transfer",
      "name": "Bank Transfer",
      "icon": Icons.account_balance,
      "description": "Direct bank transfer",
      "fees": 5.0,
      "processingTime": "1-3 business days",
    },
  ];

  List<Map<String, dynamic>> savedCards = [
    {
      "id": "card_1",
      "last4": "4567",
      "brand": "Visa",
      "expiryMonth": "12",
      "expiryYear": "2027",
      "holderName": "John Doe",
      "isDefault": true,
    },
    {
      "id": "card_2",
      "last4": "8901",
      "brand": "MasterCard", 
      "expiryMonth": "08",
      "expiryYear": "2026",
      "holderName": "John Doe",
      "isDefault": false,
    },
  ];

  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "US"},
    {"label": "Canada", "value": "CA"},
    {"label": "United Kingdom", "value": "UK"},
    {"label": "Australia", "value": "AU"},
  ];

  double getTotalWithFees() {
    double baseFee = paymentMethods.firstWhere((method) => method["id"] == selectedPaymentMethod)["fees"] as double;
    return (orderSummary["total"] as double) + baseFee;
  }

  bool isFormValid() {
    if (!agreeToTerms) return false;
    
    if (selectedPaymentMethod == "credit_card" || selectedPaymentMethod == "debit_card") {
      return cardNumber.isNotEmpty && 
             cardHolderName.isNotEmpty && 
             expiryDate.isNotEmpty && 
             cvv.isNotEmpty &&
             billingAddress.isNotEmpty &&
             billingCity.isNotEmpty &&
             billingState.isNotEmpty &&
             billingZip.isNotEmpty;
    }
    
    return true;
  }

  void processPayment() async {
    if (!isFormValid()) {
      se("Please fill in all required fields");
      return;
    }

    showLoading();
    
    // Simulate payment processing
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    //navigateTo('EmaTicketPurchaseView')
    ss("Payment processed successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        actions: [
          QButton(
            icon: Icons.security,
            size: bs.sm,
            onPressed: () {
              //navigateTo('SecurityInfoView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  spacing: spSm,
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
                    Text(
                      "${orderSummary["eventName"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${DateTime.parse("${orderSummary["date"]}").dMMMy} at ${orderSummary["time"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "${orderSummary["quantity"]} x ${orderSummary["ticketType"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Divider(color: primaryColor.withAlpha(50)),
                    Row(
                      children: [
                        Text(
                          "Total Amount:",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${getTotalWithFees().currency}",
                          style: TextStyle(
                            fontSize: fsH5,
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
              Text(
                "Select Payment Method",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: paymentMethods.map((method) {
                  bool isSelected = method["id"] == selectedPaymentMethod;
                  double fee = method["fees"] as double;
                  
                  return GestureDetector(
                    onTap: () {
                      selectedPaymentMethod = method["id"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor : disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  method["icon"],
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${method["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? primaryColor : Colors.black87,
                                  ),
                                ),
                              ),
                              if (isSelected) ...[
                                Icon(
                                  Icons.check_circle,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ],
                            ],
                          ),
                          Text(
                            "${method["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                fee > 0 ? "Fee: \$${fee.currency}" : "No fees",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: fee > 0 ? warningColor : successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${method["processingTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Payment Details
              if (selectedPaymentMethod == "credit_card" || selectedPaymentMethod == "debit_card") ...[
                Text(
                  "Card Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Saved Cards
                if (savedCards.isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Saved Cards",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        ...savedCards.map((card) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: disabledOutlineBorderColor),
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
                                        "${card["brand"]} •••• ${card["last4"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
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
                                QButton(
                                  label: "Use This Card",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Auto-fill card details
                                    cardNumber = "**** **** **** ${card["last4"]}";
                                    cardHolderName = card["holderName"];
                                    expiryDate = "${card["expiryMonth"]}/${card["expiryYear"]}";
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                        Divider(),
                        Text(
                          "Or enter new card details below:",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                QTextField(
                  label: "Card Number *",
                  value: cardNumber,
                  hint: "1234 5678 9012 3456",
                  validator: Validator.required,
                  onChanged: (value) {
                    cardNumber = value;
                    setState(() {});
                  },
                ),

                QTextField(
                  label: "Cardholder Name *",
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
                        label: "Expiry Date *",
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
                        label: "CVV *",
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

                // Billing Address
                Text(
                  "Billing Address",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                QTextField(
                  label: "Address *",
                  value: billingAddress,
                  hint: "123 Main Street",
                  validator: Validator.required,
                  onChanged: (value) {
                    billingAddress = value;
                    setState(() {});
                  },
                ),

                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "City *",
                        value: billingCity,
                        hint: "New York",
                        validator: Validator.required,
                        onChanged: (value) {
                          billingCity = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QTextField(
                        label: "State *",
                        value: billingState,
                        hint: "NY",
                        validator: Validator.required,
                        onChanged: (value) {
                          billingState = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "ZIP Code *",
                        value: billingZip,
                        hint: "10001",
                        validator: Validator.required,
                        onChanged: (value) {
                          billingZip = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QDropdownField(
                        label: "Country *",
                        items: countries,
                        value: billingCountry,
                        onChanged: (value, label) {
                          billingCountry = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],

              // Digital Wallet Details
              if (selectedPaymentMethod == "paypal" || 
                  selectedPaymentMethod == "apple_pay" || 
                  selectedPaymentMethod == "google_pay") ...[
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: infoColor.withAlpha(50)),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Icon(
                        paymentMethods.firstWhere((m) => m["id"] == selectedPaymentMethod)["icon"],
                        color: infoColor,
                        size: 40,
                      ),
                      Text(
                        "You will be redirected to ${paymentMethods.firstWhere((m) => m["id"] == selectedPaymentMethod)["name"]} to complete your payment",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: infoColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Bank Transfer Details
              if (selectedPaymentMethod == "bank_transfer") ...[
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: warningColor.withAlpha(50)),
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Bank Transfer Information",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "• Processing time: 1-3 business days",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "• Additional fee: \$5.00",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "• Bank details will be provided after order confirmation",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Options
              QSwitch(
                items: [
                  {
                    "label": "Save payment information for future use",
                    "value": true,
                    "checked": savePaymentInfo,
                  }
                ],
                value: savePaymentInfo ? [{"label": "Save payment information for future use", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  savePaymentInfo = values.isNotEmpty;
                  setState(() {});
                },
              ),

              QSwitch(
                items: [
                  {
                    "label": "I agree to the terms and conditions and privacy policy *",
                    "value": true,
                    "checked": agreeToTerms,
                  }
                ],
                value: agreeToTerms ? [{"label": "I agree to the terms and conditions and privacy policy *", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  agreeToTerms = values.isNotEmpty;
                  setState(() {});
                },
              ),

              // Security Notice
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.security, color: successColor, size: 24),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Secure Payment",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Your payment information is encrypted and secure. We never store your card details.",
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

              // Pay Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Pay \$${getTotalWithFees().currency}",
                  size: bs.md,
                  onPressed: isFormValid() ? processPayment : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
