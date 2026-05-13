import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWelcome4View extends StatefulWidget {
  @override
  State<GrlWelcome4View> createState() => _GrlWelcome4ViewState();
}

class _GrlWelcome4ViewState extends State<GrlWelcome4View> {
  String selectedPlan = "starter";
  
  final List<Map<String, dynamic>> plans = [
    {
      "id": "starter",
      "name": "Starter",
      "price": "Free",
      "period": "Forever",
      "description": "Perfect for getting started",
      "features": [
        "5 Projects",
        "10GB Storage",
        "Email Support",
        "Basic Templates",
      ],
      "color": successColor,
      "popular": false,
    },
    {
      "id": "pro",
      "name": "Professional",
      "price": "\$9",
      "period": "per month",
      "description": "For professional use",
      "features": [
        "Unlimited Projects",
        "100GB Storage",
        "Priority Support",
        "Premium Templates",
        "Advanced Analytics",
        "Team Collaboration",
      ],
      "color": primaryColor,
      "popular": true,
    },
    {
      "id": "enterprise",
      "name": "Enterprise",
      "price": "\$29",
      "period": "per month",
      "description": "For large organizations",
      "features": [
        "Everything in Pro",
        "1TB Storage",
        "24/7 Phone Support",
        "Custom Integrations",
        "Advanced Security",
        "Dedicated Manager",
      ],
      "color": warningColor,
      "popular": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            SizedBox(height: sp2xl),
            
            // Header
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, successColor],
                ),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.workspace_premium,
                size: 50,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Text(
              "Choose Your Plan",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fsH1,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "Select the perfect plan for your needs.\nUpgrade or downgrade anytime.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Plans
            Column(
              children: plans.map((plan) {
                final isSelected = selectedPlan == plan["id"];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: GestureDetector(
                    onTap: () {
                      selectedPlan = plan["id"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: isSelected ? plan["color"] : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected ? [shadowMd] : [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header with Popular Badge
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${plan["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH5,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${plan["description"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (plan["popular"])
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: plan["color"],
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Text(
                                    "POPULAR",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Price
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${plan["price"]}",
                                style: TextStyle(
                                  fontSize: fsH2,
                                  fontWeight: FontWeight.bold,
                                  color: plan["color"],
                                ),
                              ),
                              if (plan["period"] != "Forever")
                                Text(
                                  " ${plan["period"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Features
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: (plan["features"] as List).map<Widget>((feature) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: plan["color"],
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "$feature",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Select Button
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: isSelected ? "Selected" : "Select Plan",
                              size: bs.md,
                              onPressed: () {
                                selectedPlan = plan["id"];
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spXl),
            
            // Testimonial
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [infoColor.withAlpha(20), primaryColor.withAlpha(20)],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        color: warningColor,
                        size: 20,
                      );
                    }),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "\"This platform has transformed how we work. The features are incredible and the support team is amazing!\"",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: primaryColor,
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sarah Johnson",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Product Manager",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Continue Button
            QButton(
              label: "Continue with ${plans.firstWhere((p) => p["id"] == selectedPlan)["name"]}",
              size: bs.md,
              onPressed: () {
                // navigateTo('');
              },
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "No credit card required • Cancel anytime",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
