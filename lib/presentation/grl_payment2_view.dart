import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPayment2View extends StatefulWidget {
  @override
  State<GrlPayment2View> createState() => _GrlPayment2ViewState();
}

class _GrlPayment2ViewState extends State<GrlPayment2View> {
  int currentStep = 0;
  String selectedPlan = "premium";
  String billingCycle = "monthly";
  String paymentMethod = "";
  String promoCode = "";
  double discount = 0.0;
  
  List<Map<String, dynamic>> subscriptionPlans = [
    {
      "id": "basic",
      "name": "Basic Plan",
      "monthly": 9.99,
      "yearly": 99.99,
      "features": ["10 Projects", "5GB Storage", "Email Support"],
      "color": Colors.blue,
    },
    {
      "id": "premium",
      "name": "Premium Plan",
      "monthly": 19.99,
      "yearly": 199.99,
      "features": ["Unlimited Projects", "50GB Storage", "Priority Support", "Advanced Analytics"],
      "color": primaryColor,
      "popular": true,
    },
    {
      "id": "enterprise",
      "name": "Enterprise Plan",
      "monthly": 49.99,
      "yearly": 499.99,
      "features": ["Everything in Premium", "Custom Integration", "Dedicated Manager", "24/7 Phone Support"],
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> paymentOptions = [
    {"id": "card", "title": "Credit/Debit Card", "icon": Icons.credit_card},
    {"id": "paypal", "title": "PayPal", "icon": Icons.account_balance_wallet},
    {"id": "bank", "title": "Bank Transfer", "icon": Icons.account_balance},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscribe to Premium"),
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildCurrentStep(),
            ),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildStepItem(0, "Plan", Icons.grid_view),
          Expanded(child: _buildStepConnector(0)),
          _buildStepItem(1, "Payment", Icons.payment),
          Expanded(child: _buildStepConnector(1)),
          _buildStepItem(2, "Confirm", Icons.check_circle),
        ],
      ),
    );
  }

  Widget _buildStepItem(int step, String title, IconData icon) {
    bool isActive = currentStep >= step;
    bool isCurrent = currentStep == step;
    
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : disabledColor,
            shape: BoxShape.circle,
            border: isCurrent ? Border.all(color: primaryColor, width: 3) : null,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            color: isActive ? primaryColor : disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector(int step) {
    bool isCompleted = currentStep > step;
    
    return Container(
      height: 2,
      margin: EdgeInsets.only(bottom: 20),
      color: isCompleted ? primaryColor : disabledColor,
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildPlanSelection();
      case 1:
        return _buildPaymentMethod();
      case 2:
        return _buildConfirmation();
      default:
        return Container();
    }
  }

  Widget _buildPlanSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Choose Your Plan",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildBillingCycleToggle(),
        ...subscriptionPlans.map((plan) {
          return _buildPlanCard(plan);
        }).toList(),
        _buildPromoCodeSection(),
      ],
    );
  }

  Widget _buildBillingCycleToggle() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                billingCycle = "monthly";
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: billingCycle == "monthly" ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "Monthly",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: billingCycle == "monthly" ? Colors.white : disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                billingCycle = "yearly";
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: billingCycle == "yearly" ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  children: [
                    Text(
                      "Yearly",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: billingCycle == "yearly" ? Colors.white : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Save 20%",
                      style: TextStyle(
                        fontSize: 10,
                        color: billingCycle == "yearly" ? Colors.white : successColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    bool isSelected = selectedPlan == plan["id"];
    bool isPopular = plan["popular"] == true;
    double price = billingCycle == "monthly" 
        ? (plan["monthly"] as double) 
        : (plan["yearly"] as double);
    
    return GestureDetector(
      onTap: () {
        selectedPlan = "${plan["id"]}";
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${plan["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isPopular) ...[
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "POPULAR",
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
                      Text(
                        "\$${price.toStringAsFixed(2)}/${billingCycle == "monthly" ? "month" : "year"}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
            ...(plan["features"] as List<String>).map((feature) {
              return Row(
                children: [
                  Icon(
                    Icons.check,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    feature,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Promo Code",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Enter promo code",
                  value: promoCode,
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
                onPressed: promoCode.isNotEmpty ? () {
                  _applyPromoCode();
                } : null,
              ),
            ],
          ),
          if (discount > 0)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_offer,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Discount applied: -\$${discount.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Payment Method",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...paymentOptions.map((option) {
          return GestureDetector(
            onTap: () {
              paymentMethod = "${option["id"]}";
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: paymentMethod == option["id"]
                      ? primaryColor
                      : disabledOutlineBorderColor,
                  width: paymentMethod == option["id"] ? 2 : 1,
                ),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(
                    option["icon"] as IconData,
                    color: paymentMethod == option["id"]
                        ? primaryColor
                        : disabledBoldColor,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Text(
                      "${option["title"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: paymentMethod == option["id"]
                            ? primaryColor
                            : Colors.black,
                      ),
                    ),
                  ),
                  if (paymentMethod == option["id"])
                    Icon(
                      Icons.check_circle,
                      color: primaryColor,
                      size: 20,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildConfirmation() {
    Map<String, dynamic> selectedPlanData = subscriptionPlans.firstWhere(
      (plan) => plan["id"] == selectedPlan,
    );
    
    double basePrice = billingCycle == "monthly" 
        ? (selectedPlanData["monthly"] as double)
        : (selectedPlanData["yearly"] as double);
    double finalPrice = basePrice - discount;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Confirm Subscription",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Subscription Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Plan"),
                  Text("${selectedPlanData["name"]}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Billing Cycle"),
                  Text("${billingCycle.substring(0, 1).toUpperCase()}${billingCycle.substring(1)}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Base Price"),
                  Text("\$${basePrice.toStringAsFixed(2)}"),
                ],
              ),
              if (discount > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discount"),
                    Text(
                      "-\$${discount.toStringAsFixed(2)}",
                      style: TextStyle(color: successColor),
                    ),
                  ],
                ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${finalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: fsH6,
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
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: infoColor.withAlpha(100)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "You will be charged \$${finalPrice.toStringAsFixed(2)} ${billingCycle == "monthly" ? "monthly" : "yearly"}. You can cancel anytime from your account settings.",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          if (currentStep > 0) ...[
            Expanded(
              child: QButton(
                label: "Back",
                color: disabledBoldColor,
                onPressed: () {
                  currentStep--;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
          ],
          Expanded(
            flex: 2,
            child: QButton(
              label: currentStep == 2 ? "Subscribe Now" : "Continue",
              onPressed: _canProceed() ? () {
                if (currentStep == 2) {
                  _processSubscription();
                } else {
                  currentStep++;
                  setState(() {});
                }
              } : null,
            ),
          ),
        ],
      ),
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return selectedPlan.isNotEmpty;
      case 1:
        return paymentMethod.isNotEmpty;
      case 2:
        return true;
      default:
        return false;
    }
  }

  void _applyPromoCode() {
    if (promoCode.toLowerCase() == "save20") {
      discount = 20.0;
      ss("Promo code applied successfully!");
    } else {
      se("Invalid promo code");
    }
    setState(() {});
  }

  void _processSubscription() {
    showLoading();
    
    // Simulate subscription processing
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Subscription activated successfully!");
    });
  }
}
