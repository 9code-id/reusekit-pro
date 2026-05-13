import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaSubscriptionView extends StatefulWidget {
  const PpaSubscriptionView({super.key});

  @override
  State<PpaSubscriptionView> createState() => _PpaSubscriptionViewState();
}

class _PpaSubscriptionViewState extends State<PpaSubscriptionView> {
  String selectedPlan = "annual";
  bool isLoading = false;

  List<Map<String, dynamic>> subscriptionPlans = [
    {
      "id": "free",
      "name": "Free",
      "price": 0,
      "period": "Forever",
      "description": "Perfect for casual photographers",
      "color": Color(0xFF95A5A6),
      "popular": false,
      "features": [
        "5 photos per day",
        "Basic filters",
        "1GB cloud storage",
        "Standard support",
        "Watermarked exports"
      ],
      "limitations": [
        "Limited editing tools",
        "No batch processing",
        "No RAW support"
      ]
    },
    {
      "id": "monthly",
      "name": "Pro Monthly",
      "price": 9.99,
      "period": "per month",
      "description": "For serious photographers",
      "color": Color(0xFF3498DB),
      "popular": false,
      "features": [
        "Unlimited photos",
        "All professional filters",
        "50GB cloud storage",
        "Priority support",
        "No watermarks",
        "Advanced editing tools",
        "Batch processing",
        "RAW file support"
      ],
      "limitations": []
    },
    {
      "id": "annual",
      "name": "Pro Annual",
      "price": 79.99,
      "period": "per year",
      "originalPrice": 119.88,
      "description": "Best value for professionals",
      "color": Color(0xFF2ECC71),
      "popular": true,
      "savings": "Save 33%",
      "features": [
        "Everything in Pro Monthly",
        "200GB cloud storage",
        "AI-powered suggestions",
        "Advanced analytics",
        "Custom presets",
        "Collaboration tools",
        "Priority processing",
        "Beta feature access"
      ],
      "limitations": []
    },
    {
      "id": "lifetime",
      "name": "Lifetime Pro",
      "price": 299.99,
      "period": "one-time payment",
      "description": "Never pay again",
      "color": Color(0xFF9B59B6),
      "popular": false,
      "specialOffer": "Limited Time",
      "features": [
        "Everything in Pro Annual",
        "Unlimited cloud storage",
        "Exclusive filters",
        "Personal account manager",
        "Commercial license",
        "Future updates included",
        "Premium community access"
      ],
      "limitations": []
    }
  ];

  Map<String, dynamic> get selectedPlanData {
    return subscriptionPlans.firstWhere((plan) => plan["id"] == selectedPlan);
  }

  void selectPlan(String planId) {
    selectedPlan = planId;
    setState(() {});
  }

  void subscribeToPlan() async {
    isLoading = true;
    setState(() {});

    // Simulate payment processing
    await Future.delayed(Duration(seconds: 2));

    isLoading = false;
    setState(() {});

    if (selectedPlan == "free") {
      ss("Welcome to PhotoPro! Enjoy your free features.");
    } else {
      ss("Subscription activated successfully! Welcome to PhotoPro ${selectedPlanData["name"]}.");
    }

    //navigateTo('PpaHomeView')
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Plan"),
        actions: [
          TextButton(
            onPressed: () {
              //navigateTo('PpaHomeView')
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Unlock Your Photography Potential",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Choose the perfect plan to elevate your photography with professional tools, unlimited storage, and AI-powered features.",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Subscription Plans
            Column(
              spacing: spSm,
              children: subscriptionPlans.map((plan) {
                final isSelected = selectedPlan == plan["id"];
                final planColor = plan["color"] as Color;

                return GestureDetector(
                  onTap: () => selectPlan(plan["id"]),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: isSelected
                          ? Border.all(color: planColor, width: 2)
                          : Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      children: [
                        // Plan Header
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? planColor.withAlpha(20) : Colors.grey[50],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Selection Circle
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: isSelected ? planColor : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? planColor : disabledColor,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),

                              SizedBox(width: spSm),

                              // Plan Info
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
                                            color: planColor,
                                          ),
                                        ),
                                        if (plan["popular"] == true) ...[
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: warningColor,
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
                                        if (plan["specialOffer"] != null) ...[
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
                                              "${plan["specialOffer"]}",
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
                                      "${plan["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Price
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (plan["originalPrice"] != null)
                                    Text(
                                      "\$${(plan["originalPrice"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        plan["price"] == 0 
                                            ? "Free"
                                            : "\$${(plan["price"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: fsH5,
                                          fontWeight: FontWeight.bold,
                                          color: planColor,
                                        ),
                                      ),
                                      if (plan["price"] != 0)
                                        Text(
                                          " ${plan["period"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                  if (plan["savings"] != null)
                                    Text(
                                      "${plan["savings"]}",
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
                        ),

                        // Plan Features
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              // Features
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
                                            fontSize: 13,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),

                              // Limitations
                              if ((plan["limitations"] as List).isNotEmpty) ...[
                                SizedBox(height: spXs),
                                Column(
                                  spacing: spXs,
                                  children: (plan["limitations"] as List<String>).map((limitation) {
                                    return Row(
                                      children: [
                                        Icon(
                                          Icons.cancel,
                                          size: 16,
                                          color: disabledColor,
                                        ),
                                        SizedBox(width: spSm),
                                        Expanded(
                                          child: Text(
                                            limitation,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: disabledColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Subscription Benefits
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Why Choose PhotoPro?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: [
                      "30-day money-back guarantee",
                      "Cancel anytime, no questions asked",
                      "Secure payment processing",
                      "Regular feature updates",
                      "24/7 customer support"
                    ].map((benefit) {
                      return Row(
                        children: [
                          Icon(
                            Icons.verified,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              benefit,
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
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

            // Subscribe Button
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : subscribeToPlan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedPlanData["color"] as Color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text("Processing..."),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            selectedPlan == "free" ? Icons.play_arrow : Icons.credit_card,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            selectedPlan == "free"
                                ? "Start with Free Plan"
                                : "Subscribe to ${selectedPlanData["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            // Terms and Privacy
            Container(
              padding: EdgeInsets.all(spSm),
              child: Text(
                "By subscribing, you agree to our Terms of Service and Privacy Policy. Subscriptions auto-renew unless cancelled 24 hours before the end of the current period.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
