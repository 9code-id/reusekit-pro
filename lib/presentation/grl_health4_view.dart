import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHealth4View extends StatefulWidget {
  @override
  State<GrlHealth4View> createState() => _GrlHealth4ViewState();
}

class _GrlHealth4ViewState extends State<GrlHealth4View> {
  String selectedPackage = "basic";
  List<Map<String, dynamic>> packages = [
    {
      "id": "basic",
      "name": "Basic Plan",
      "price": 99.99,
      "features": [
        "Monthly health checkup",
        "Blood pressure monitoring",
        "Basic lab tests",
        "Nutrition consultation",
        "Emergency support"
      ],
      "color": Colors.blue,
      "popular": false
    },
    {
      "id": "premium",
      "name": "Premium Plan",
      "price": 199.99,
      "features": [
        "Weekly health monitoring",
        "Comprehensive lab tests",
        "Specialist consultations",
        "Personalized diet plan",
        "24/7 telehealth support",
        "Mental health sessions",
        "Fitness tracking"
      ],
      "color": Colors.green,
      "popular": true
    },
    {
      "id": "family",
      "name": "Family Plan",
      "price": 299.99,
      "features": [
        "Coverage for 4 members",
        "Pediatric consultations",
        "Elderly care support",
        "Family health history",
        "Vaccination reminders",
        "Emergency coordination",
        "Health insurance support"
      ],
      "color": Colors.orange,
      "popular": false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Insurance Plans"),
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
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Choose Your Health Plan",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Comprehensive healthcare coverage for you and your family",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            // Benefits Overview
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
                    "Why Choose Our Health Plans?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.verified, color: successColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Trusted by 50,000+ families",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.local_hospital, color: successColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Network of 500+ hospitals",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.support_agent, color: successColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "24/7 customer support",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Plans Section
            Text(
              "Available Plans",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            // Plan Cards
            ...packages.map((package) {
              bool isSelected = selectedPackage == package["id"];
              bool isPopular = package["popular"] as bool;
              
              return GestureDetector(
                onTap: () {
                  selectedPackage = package["id"];
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
                    boxShadow: isSelected ? [shadowMd] : [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Plan Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${package["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (isPopular) ...[
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: successColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "POPULAR",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "\$${(package["price"] as double).toStringAsFixed(2)}/month",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: package["color"] as Color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                        ],
                      ),

                      // Features List
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Included Features:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            ...(package["features"] as List<String>).map((feature) {
                              return Row(
                                children: [
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
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            // Coverage Details
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
                    "Coverage Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.shield, color: Colors.blue, size: 32),
                              SizedBox(height: spXs),
                              Text(
                                "Coverage",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                "Up to \$100K",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.access_time, color: Colors.green, size: 32),
                              SizedBox(height: spXs),
                              Text(
                                "Waiting Period",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                "0 Days",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Buttons
            Container(
              width: double.infinity,
              child: QButton(
                label: "Subscribe to ${packages.firstWhere((p) => p["id"] == selectedPackage)["name"]}",
                size: bs.md,
                onPressed: () {
                  ss("Subscription initiated for ${packages.firstWhere((p) => p["id"] == selectedPackage)["name"]}");
                },
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Compare Plans",
                    size: bs.sm,
                    onPressed: () {
                      si("Plan comparison feature coming soon");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Contact Agent",
                    size: bs.sm,
                    onPressed: () {
                      si("Connecting with health insurance agent...");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
