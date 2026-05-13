import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCheckout7View extends StatefulWidget {
  const GrlCheckout7View({Key? key}) : super(key: key);

  @override
  State<GrlCheckout7View> createState() => _GrlCheckout7ViewState();
}

class _GrlCheckout7ViewState extends State<GrlCheckout7View> {
  String selectedPlan = "premium";
  String billingCycle = "yearly";
  String paymentMethod = "card";
  String promoCode = "";
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardHolderName = "";
  bool autoRenew = true;
  
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> subscriptionPlans = [
    {
      "id": "basic",
      "name": "Basic Plan",
      "description": "Perfect for individuals getting started",
      "monthlyPrice": 9.99,
      "yearlyPrice": 99.99,
      "features": [
        "Up to 5 projects",
        "10GB storage",
        "Basic support",
        "Mobile app access",
      ],
      "popular": false,
    },
    {
      "id": "premium",
      "name": "Premium Plan",
      "description": "Best for growing teams and businesses",
      "monthlyPrice": 24.99,
      "yearlyPrice": 249.99,
      "features": [
        "Unlimited projects",
        "100GB storage",
        "Priority support",
        "Advanced analytics",
        "Team collaboration",
        "API access",
      ],
      "popular": true,
    },
    {
      "id": "enterprise",
      "name": "Enterprise Plan",
      "description": "For large organizations with custom needs",
      "monthlyPrice": 99.99,
      "yearlyPrice": 999.99,
      "features": [
        "Everything in Premium",
        "Unlimited storage",
        "24/7 dedicated support",
        "Custom integrations",
        "Advanced security",
        "SLA guarantee",
      ],
      "popular": false,
    },
  ];

  List<Map<String, dynamic>> billingCycles = [
    {
      "id": "monthly",
      "name": "Monthly",
      "description": "Billed monthly",
      "discount": 0,
    },
    {
      "id": "yearly",
      "name": "Yearly",
      "description": "Billed annually",
      "discount": 20,
    },
  ];

  Map<String, dynamic> get selectedPlanData => subscriptionPlans.firstWhere((plan) => plan["id"] == selectedPlan);
  double get basePrice => billingCycle == "yearly" ? selectedPlanData["yearlyPrice"] as double : selectedPlanData["monthlyPrice"] as double;
  double get discount => billingCycle == "yearly" ? (selectedPlanData["monthlyPrice"] as double) * 12 - (selectedPlanData["yearlyPrice"] as double) : 0;
  double get tax => basePrice * 0.08;
  double get total => basePrice + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscribe Now"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spLg,
            children: [
              _buildPlanSelection(),
              _buildBillingCycleSelection(),
              _buildPricingBreakdown(),
              _buildPromoCode(),
              _buildPaymentMethod(),
              _buildAutoRenewal(),
              _buildSubscriptionTerms(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildSubscribeButton(),
    );
  }

  Widget _buildPlanSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Your Plan",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: subscriptionPlans.map((plan) {
              bool isSelected = selectedPlan == plan["id"];
              bool isPopular = plan["popular"];
              
              return GestureDetector(
                onTap: () {
                  selectedPlan = plan["id"];
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(25) : Colors.grey.shade50,
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${plan["name"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? primaryColor : Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${plan["description"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (billingCycle == "yearly") ...[
                                      Text(
                                        "\$${(plan["monthlyPrice"] as double).toStringAsFixed(2)}/mo",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                      Text(
                                        "\$${((plan["yearlyPrice"] as double) / 12).toStringAsFixed(2)}/mo",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ] else ...[
                                      Text(
                                        "\$${(plan["monthlyPrice"] as double).toStringAsFixed(2)}/mo",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: (plan["features"] as List<String>).map((feature) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: spXs),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 32),
                                      Icon(
                                        Icons.check_circle,
                                        color: successColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          feature,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      if (isPopular)
                        Positioned(
                          top: -8,
                          right: 16,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "Most Popular",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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

  Widget _buildBillingCycleSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Billing Frequency",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: billingCycles.map((cycle) {
              bool isSelected = billingCycle == cycle["id"];
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    billingCycle = cycle["id"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: cycle["id"] == "monthly" ? spSm : 0),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(25) : Colors.grey.shade50,
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${cycle["name"]}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? primaryColor : Colors.black,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${cycle["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (cycle["discount"] > 0) ...[
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Save ${cycle["discount"]}%",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingBreakdown() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pricing Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          _buildPriceRow(
            "${selectedPlanData["name"]} - ${billingCycle == "yearly" ? "Annual" : "Monthly"}",
            basePrice,
          ),
          if (discount > 0)
            _buildPriceRow(
              "Annual Discount",
              -discount,
              isDiscount: true,
            ),
          _buildPriceRow("Tax", tax),
          Divider(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total ${billingCycle == "yearly" ? "(Annual)" : "(Monthly)"}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          if (billingCycle == "yearly") ...[
            SizedBox(height: spXs),
            Text(
              "Equivalent to \$${(total / 12).toStringAsFixed(2)}/month",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPromoCode() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Promo Code",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Enter promo code",
                  value: promoCode,
                  hint: "SAVE20, WELCOME50, etc.",
                  onChanged: (value) {
                    promoCode = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Apply",
                size: bs.sm,
                onPressed: promoCode.isNotEmpty ? _applyPromoCode : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
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
          SizedBox(height: spSm),
          QTextField(
            label: "Cardholder Name",
            value: cardHolderName,
            hint: "John Doe",
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

  Widget _buildAutoRenewal() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subscription Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Auto-renew subscription",
                      "value": true,
                      "checked": autoRenew,
                    }
                  ],
                  value: [
                    if (autoRenew)
                      {
                        "label": "Auto-renew subscription",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    autoRenew = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: Colors.blue,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    autoRenew
                        ? "Your subscription will automatically renew at the end of each billing period. You can cancel anytime."
                        : "Your subscription will expire at the end of the current billing period. You'll need to manually renew.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade600,
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

  Widget _buildSubscriptionTerms() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subscription Terms",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "• Subscription starts immediately after payment confirmation",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "• Cancel anytime through your account settings",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "• 30-day money-back guarantee for annual plans",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "• Unused subscription time is non-refundable",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "By subscribing, you agree to our ",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Terms of Service",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Text(
                " and ",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Privacy Policy",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowLg],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${selectedPlanData["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    billingCycle == "yearly" ? "Billed annually" : "Billed monthly",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Start Subscription",
              size: bs.md,
              onPressed: _startSubscription,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.security, color: successColor, size: 14),
              SizedBox(width: spXs),
              Text(
                "Secure payment with 256-bit SSL encryption",
                style: TextStyle(
                  fontSize: 11,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isDiscount = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDiscount ? successColor : disabledBoldColor,
            ),
          ),
          Text(
            "${isDiscount ? "-" : ""}\$${amount.abs().toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDiscount ? successColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _applyPromoCode() {
    if (promoCode.isNotEmpty) {
      ss("Promo code applied successfully! 10% discount added.");
    }
  }

  void _startSubscription() {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      Future.delayed(Duration(seconds: 3), () {
        hideLoading();
        ss("Subscription activated successfully! Welcome to ${selectedPlanData["name"]}!");
        // Navigate to dashboard or success page
      });
    }
  }
}
