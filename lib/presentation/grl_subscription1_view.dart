import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSubscription1View extends StatefulWidget {
  @override
  State<GrlSubscription1View> createState() => _GrlSubscription1ViewState();
}

class _GrlSubscription1ViewState extends State<GrlSubscription1View> {
  List<Map<String, dynamic>> subscriptionPlans = [
    {
      "name": "Basic",
      "price": 9.99,
      "period": "month",
      "features": [
        "10 GB Storage",
        "Email Support",
        "Basic Analytics",
        "Standard Security"
      ],
      "isPopular": false,
      "color": successColor,
    },
    {
      "name": "Pro",
      "price": 19.99,
      "period": "month",
      "features": [
        "100 GB Storage",
        "Priority Support",
        "Advanced Analytics",
        "Enhanced Security",
        "API Access",
        "Custom Branding"
      ],
      "isPopular": true,
      "color": primaryColor,
    },
    {
      "name": "Enterprise",
      "price": 49.99,
      "period": "month",
      "features": [
        "Unlimited Storage",
        "24/7 Phone Support",
        "Premium Analytics",
        "Enterprise Security",
        "Full API Access",
        "White Label",
        "Dedicated Manager",
        "Custom Integration"
      ],
      "isPopular": false,
      "color": warningColor,
    },
  ];

  int selectedPlanIndex = 1;
  bool isAnnualBilling = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Plan"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildBillingToggle(),
            _buildPlanCards(),
            _buildComparisonTable(),
            _buildSubscribeButton(),
            _buildFooterInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(20), secondaryColor.withAlpha(20)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Unlock Premium Features",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Choose the perfect plan for your needs and start growing your business today",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingToggle() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                isAnnualBilling = false;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: !isAnnualBilling ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: !isAnnualBilling ? [shadowSm] : null,
                ),
                child: Text(
                  "Monthly",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: !isAnnualBilling ? FontWeight.bold : FontWeight.normal,
                    color: !isAnnualBilling ? primaryColor : disabledBoldColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                isAnnualBilling = true;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: isAnnualBilling ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: isAnnualBilling ? [shadowSm] : null,
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Text(
                      "Annual",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: isAnnualBilling ? FontWeight.bold : FontWeight.normal,
                        color: isAnnualBilling ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Save 20%",
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCards() {
    return Column(
      spacing: spSm,
      children: List.generate(subscriptionPlans.length, (index) {
        final plan = subscriptionPlans[index];
        final isSelected = selectedPlanIndex == index;
        final displayPrice = isAnnualBilling ? ((plan["price"] as double) * 12 * 0.8) : (plan["price"] as double);
        
        return GestureDetector(
          onTap: () {
            selectedPlanIndex = index;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: isSelected ? (plan["color"] as Color) : disabledOutlineBorderColor,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: isSelected ? [shadowMd] : [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: plan["color"] as Color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${plan["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    if (plan["isPopular"] as bool)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXl),
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
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${displayPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: plan["color"] as Color,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "/${isAnnualBilling ? 'year' : 'month'}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spXs,
                  children: (plan["features"] as List<String>).map((feature) {
                    return Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: successColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
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
      }),
    );
  }

  Widget _buildComparisonTable() {
    List<String> allFeatures = [
      "Storage",
      "Support",
      "Analytics",
      "Security",
      "API Access",
      "Branding",
      "Manager",
      "Integration",
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
            ),
            child: Text(
              "Feature Comparison",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...allFeatures.map((feature) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      feature,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  ...subscriptionPlans.map((plan) {
                    bool hasFeature = (plan["features"] as List<String>)
                        .any((f) => f.toLowerCase().contains(feature.toLowerCase()));
                    return Expanded(
                      child: Icon(
                        hasFeature ? Icons.check : Icons.close,
                        color: hasFeature ? successColor : dangerColor,
                        size: 18,
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton() {
    final selectedPlan = subscriptionPlans[selectedPlanIndex];
    final displayPrice = isAnnualBilling 
        ? ((selectedPlan["price"] as double) * 12 * 0.8) 
        : (selectedPlan["price"] as double);
    
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Subscribe to ${selectedPlan["name"]} - \$${displayPrice.toStringAsFixed(2)}/${isAnnualBilling ? 'year' : 'month'}",
        size: bs.md,
        onPressed: () {
          ss("Subscription activated successfully!");
        },
      ),
    );
  }

  Widget _buildFooterInfo() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.security,
              size: 16,
              color: successColor,
            ),
            SizedBox(width: spXs),
            Text(
              "30-day money-back guarantee",
              style: TextStyle(
                color: successColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          "Cancel anytime • No hidden fees • Secure payment",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Text(
                "Terms of Service",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text(
              " • ",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Privacy Policy",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
