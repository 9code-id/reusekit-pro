import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMembership2View extends StatefulWidget {
  @override
  State<GrlMembership2View> createState() => _GrlMembership2ViewState();
}

class _GrlMembership2ViewState extends State<GrlMembership2View> {
  int selectedPlan = 1;
  bool isAnnual = false;

  List<Map<String, dynamic>> membershipPlans = [
    {
      "id": 0,
      "name": "Basic",
      "monthlyPrice": 0,
      "annualPrice": 0,
      "originalPrice": 0,
      "description": "Perfect for getting started",
      "features": [
        "Access to basic features",
        "5 projects limit",
        "Community support",
        "Basic analytics",
        "Standard templates",
      ],
      "color": disabledBoldColor,
      "isPopular": false,
      "savings": 0,
    },
    {
      "id": 1,
      "name": "Pro",
      "monthlyPrice": 19,
      "annualPrice": 190,
      "originalPrice": 228,
      "description": "Best for professionals",
      "features": [
        "All Basic features",
        "Unlimited projects",
        "Priority support",
        "Advanced analytics",
        "Premium templates",
        "Custom branding",
        "API access",
      ],
      "color": primaryColor,
      "isPopular": true,
      "savings": 38,
    },
    {
      "id": 2,
      "name": "Enterprise",
      "monthlyPrice": 49,
      "annualPrice": 490,
      "originalPrice": 588,
      "description": "For large organizations",
      "features": [
        "All Pro features",
        "Team collaboration",
        "Advanced security",
        "Dedicated support",
        "Custom integrations",
        "White-label solution",
        "SLA guarantee",
        "Training sessions",
      ],
      "color": secondaryColor,
      "isPopular": false,
      "savings": 98,
    },
  ];

  double getCurrentPrice(Map<String, dynamic> plan) {
    if (isAnnual) {
      return (plan["annualPrice"] as int).toDouble();
    }
    return (plan["monthlyPrice"] as int).toDouble();
  }

  double getOriginalPrice(Map<String, dynamic> plan) {
    if (isAnnual) {
      return (plan["originalPrice"] as int).toDouble();
    }
    return (plan["monthlyPrice"] as int).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Plan"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Center(
              child: Column(
                children: [
                  Text(
                    "Unlock Premium Features",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Choose the perfect plan for your needs and start achieving more today",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Billing toggle
            Center(
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        isAnnual = false;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: !isAnnual ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: !isAnnual ? [shadowSm] : [],
                        ),
                        child: Text(
                          "Monthly",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: !isAnnual ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        isAnnual = true;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isAnnual ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: isAnnual ? [shadowSm] : [],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Annual",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isAnnual ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            if (isAnnual) ...[
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Save 20%",
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Membership plans
            ...List.generate(membershipPlans.length, (index) {
              final plan = membershipPlans[index];
              final isSelected = selectedPlan == index;
              final planColor = plan["color"] as Color;
              final currentPrice = getCurrentPrice(plan);
              final originalPrice = getOriginalPrice(plan);
              final isPopular = plan["isPopular"] as bool;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                  border: isSelected 
                      ? Border.all(color: planColor, width: 2)
                      : Border.all(color: disabledOutlineBorderColor),
                ),
                child: Stack(
                  children: [
                    if (isPopular)
                      Positioned(
                        top: 0,
                        right: spMd,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(radiusSm),
                              bottomRight: Radius.circular(radiusSm),
                            ),
                          ),
                          child: Text(
                            "MOST POPULAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? planColor : disabledBoldColor,
                                    width: 2,
                                  ),
                                  color: isSelected ? planColor : Colors.transparent,
                                ),
                                child: isSelected
                                    ? Icon(Icons.check, color: Colors.white, size: 12)
                                    : null,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${plan["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH5,
                                        fontWeight: FontWeight.bold,
                                        color: planColor,
                                      ),
                                    ),
                                    Text(
                                      "${plan["description"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (currentPrice > 0) ...[
                                    if (isAnnual && originalPrice > currentPrice)
                                      Text(
                                        "\$${originalPrice.toInt()}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "\$${currentPrice.toInt()}",
                                          style: TextStyle(
                                            fontSize: fsH4,
                                            fontWeight: FontWeight.bold,
                                            color: planColor,
                                          ),
                                        ),
                                        Text(
                                          isAnnual ? "/year" : "/month",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isAnnual && (plan["savings"] as int) > 0)
                                      Text(
                                        "Save \$${plan["savings"]}",
                                        style: TextStyle(
                                          color: successColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                  ] else ...[
                                    Text(
                                      "FREE",
                                      style: TextStyle(
                                        fontSize: fsH4,
                                        fontWeight: FontWeight.bold,
                                        color: planColor,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Features list
                          ...List.generate((plan["features"] as List).length, (featureIndex) {
                            final feature = (plan["features"] as List)[featureIndex];
                            return Padding(
                              padding: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: successColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "$feature",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          
                          SizedBox(height: spMd),
                          
                          // Select button
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: isSelected ? "Selected" : "Select Plan",
                              size: bs.md,
                              color: isSelected ? successColor : planColor,
                              onPressed: () {
                                selectedPlan = index;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            
            // Bottom info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Your Plan Benefits",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Cancel anytime with no fees\n• 14-day money-back guarantee\n• Free migration assistance\n• 24/7 customer support",
                    style: TextStyle(
                      color: infoColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Continue button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Continue to Payment",
                size: bs.md,
                onPressed: () {
                  // Navigate to payment
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
