import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaPremiumPaymentView extends StatefulWidget {
  const BfaPremiumPaymentView({super.key});

  @override
  State<BfaPremiumPaymentView> createState() => _BfaPremiumPaymentViewState();
}

class _BfaPremiumPaymentViewState extends State<BfaPremiumPaymentView> {
  String selectedPlan = "Pro";
  String selectedPaymentMethod = "Credit Card";
  String billingCycle = "monthly";
  bool autoRenewal = true;
  
  String cardNumber = "";
  String cardHolderName = "";
  String expiryDate = "";
  String cvv = "";
  String billingAddress = "";
  String city = "";
  String zipCode = "";
  String country = "United States";

  List<Map<String, dynamic>> plans = [
    {
      "name": "Basic",
      "monthlyPrice": 9.99,
      "yearlyPrice": 99.99,
      "features": [
        "Credit Score Monitoring",
        "Monthly Credit Reports",
        "Basic Credit Tips",
        "Email Alerts",
      ],
      "popular": false,
    },
    {
      "name": "Pro",
      "monthlyPrice": 19.99,
      "yearlyPrice": 199.99,
      "features": [
        "Everything in Basic",
        "Weekly Credit Updates",
        "Advanced Credit Analysis",
        "Identity Theft Protection",
        "Credit Improvement Tools",
        "Priority Customer Support",
      ],
      "popular": true,
    },
    {
      "name": "Premium",
      "monthlyPrice": 29.99,
      "yearlyPrice": 299.99,
      "features": [
        "Everything in Pro",
        "Daily Credit Monitoring",
        "Full Identity Protection Suite",
        "Dedicated Credit Advisor",
        "Unlimited Dispute Support",
        "Investment Tracking",
        "Insurance Coverage",
      ],
      "popular": false,
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {"label": "Credit Card", "value": "Credit Card", "icon": Icons.credit_card},
    {"label": "Debit Card", "value": "Debit Card", "icon": Icons.payment},
    {"label": "PayPal", "value": "PayPal", "icon": Icons.account_balance_wallet},
    {"label": "Bank Transfer", "value": "Bank Transfer", "icon": Icons.account_balance},
  ];

  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Premium Payment"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.diamond,
                    color: Colors.white,
                    size: 32,
                  ),
                  Text(
                    "Upgrade to Premium",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Get advanced credit monitoring and financial tools",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Choose Your Plan",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            QCategoryPicker(
              items: [
                {"label": "Monthly", "value": "monthly"},
                {"label": "Yearly (Save 20%)", "value": "yearly"},
              ],
              value: billingCycle,
              onChanged: (index, label, value, item) {
                billingCycle = value;
                setState(() {});
              },
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: plans.map((plan) {
                bool isSelected = selectedPlan == plan["name"];
                bool isPopular = plan["popular"] as bool;
                double price = billingCycle == "monthly" 
                    ? (plan["monthlyPrice"] as double)
                    : (plan["yearlyPrice"] as double);
                
                return GestureDetector(
                  onTap: () {
                    selectedPlan = plan["name"] as String;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isPopular)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Most Popular",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        Row(
                          children: [
                            Text(
                              "${plan["name"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 20,
                              ),
                          ],
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${price.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              billingCycle == "monthly" ? "/month" : "/year",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        if (billingCycle == "yearly")
                          Text(
                            "Save \$${(((plan["monthlyPrice"] as double) * 12) - (plan["yearlyPrice"] as double)).toStringAsFixed(2)} per year",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                        Column(
                          spacing: spXs,
                          children: (plan["features"] as List<String>).map((feature) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: successColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            Text(
              "Payment Method",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            QCategoryPicker(
              items: paymentMethods.map((method) => {
                "label": method["label"],
                "value": method["value"],
              }).toList(),
              value: selectedPaymentMethod,
              onChanged: (index, label, value, item) {
                selectedPaymentMethod = value;
                setState(() {});
              },
            ),

            if (selectedPaymentMethod == "Credit Card" || selectedPaymentMethod == "Debit Card") ...[
              Text(
                "Card Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              QTextField(
                label: "Card Number",
                value: cardNumber,
                hint: "1234 5678 9012 3456",
                onChanged: (value) {
                  cardNumber = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Cardholder Name",
                value: cardHolderName,
                hint: "John Doe",
                onChanged: (value) {
                  cardHolderName = value;
                  setState(() {});
                },
              ),

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
            ],

            Text(
              "Billing Address",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            QTextField(
              label: "Street Address",
              value: billingAddress,
              hint: "123 Main Street",
              onChanged: (value) {
                billingAddress = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "City",
                    value: city,
                    hint: "New York",
                    onChanged: (value) {
                      city = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "ZIP Code",
                    value: zipCode,
                    hint: "10001",
                    onChanged: (value) {
                      zipCode = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Country",
              items: countries,
              value: country,
              onChanged: (value, label) {
                country = value;
                setState(() {});
              },
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Billing Options",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QSwitch(
                    items: [
                      {
                        "label": "Enable Auto-Renewal",
                        "value": true,
                        "checked": autoRenewal,
                      }
                    ],
                    value: autoRenewal ? [{"label": "Enable Auto-Renewal", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      autoRenewal = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: infoColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Auto-renewal ensures uninterrupted service. Cancel anytime.",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(60)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Order Summary",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Text(
                        "$selectedPlan Plan",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${_getSelectedPlanPrice().toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  if (billingCycle == "yearly")
                    Row(
                      children: [
                        Text(
                          "Annual Discount",
                          style: TextStyle(
                            color: successColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "-\$${_getAnnualDiscount().toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),

                  Divider(),

                  Row(
                    children: [
                      Text(
                        "Total ${billingCycle == "monthly" ? "Monthly" : "Annual"}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${_getTotalPrice().toStringAsFixed(2)}",
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

            Container(
              width: double.infinity,
              child: QButton(
                label: "Complete Payment",
                icon: Icons.payment,
                size: bs.md,
                onPressed: () async {
                  showLoading();
                  await Future.delayed(Duration(seconds: 2));
                  hideLoading();
                  ss("Payment completed successfully!");
                },
              ),
            ),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Secure Payment",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Your payment information is encrypted and secure. We use industry-standard SSL encryption to protect your data.",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getSelectedPlanPrice() {
    final plan = plans.firstWhere((p) => p["name"] == selectedPlan);
    return billingCycle == "monthly" 
        ? (plan["monthlyPrice"] as double)
        : (plan["yearlyPrice"] as double);
  }

  double _getAnnualDiscount() {
    if (billingCycle == "yearly") {
      final plan = plans.firstWhere((p) => p["name"] == selectedPlan);
      return ((plan["monthlyPrice"] as double) * 12) - (plan["yearlyPrice"] as double);
    }
    return 0.0;
  }

  double _getTotalPrice() {
    return _getSelectedPlanPrice();
  }
}
