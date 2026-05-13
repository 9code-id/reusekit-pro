import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaLifeInsuranceView extends StatefulWidget {
  const BfaLifeInsuranceView({super.key});

  @override
  State<BfaLifeInsuranceView> createState() => _BfaLifeInsuranceViewState();
}

class _BfaLifeInsuranceViewState extends State<BfaLifeInsuranceView> {
  int currentTab = 0;
  String selectedPlan = "term";
  double coverageAmount = 500000;
  int policyTerm = 20;
  int age = 30;
  bool isSmoker = false;
  String gender = "male";

  List<Map<String, dynamic>> lifePlans = [
    {
      "id": "term",
      "name": "Term Life Insurance",
      "description": "Affordable protection for a specific period",
      "icon": Icons.calendar_today,
      "color": Colors.blue,
      "features": [
        "Lower premiums",
        "Flexible terms (10-30 years)",
        "High coverage amounts",
        "No cash value"
      ],
      "bestFor": "Young families, mortgage protection",
      "monthlyPremium": 45.0
    },
    {
      "id": "whole",
      "name": "Whole Life Insurance",
      "description": "Permanent coverage with cash value",
      "icon": Icons.account_balance,
      "color": Colors.green,
      "features": [
        "Lifetime coverage",
        "Cash value growth",
        "Fixed premiums",
        "Dividend potential"
      ],
      "bestFor": "Estate planning, long-term savings",
      "monthlyPremium": 180.0
    },
    {
      "id": "universal",
      "name": "Universal Life Insurance",
      "description": "Flexible permanent life insurance",
      "icon": Icons.tune,
      "color": Colors.orange,
      "features": [
        "Flexible premiums",
        "Adjustable death benefit",
        "Cash value investment",
        "Tax advantages"
      ],
      "bestFor": "Investment-focused individuals",
      "monthlyPremium": 220.0
    },
  ];

  List<Map<String, dynamic>> benefitsData = [
    {
      "title": "Death Benefit",
      "amount": 500000,
      "description": "Tax-free payout to beneficiaries",
      "icon": Icons.security,
    },
    {
      "title": "Living Benefits",
      "amount": 100000,
      "description": "Access funds for terminal illness",
      "icon": Icons.favorite,
    },
    {
      "title": "Cash Value",
      "amount": 50000,
      "description": "Accumulated savings component",
      "icon": Icons.savings,
    },
  ];

  double calculatePremium() {
    final basePremium = lifePlans.firstWhere((plan) => plan["id"] == selectedPlan)["monthlyPremium"] as double;
    double premium = basePremium;
    
    // Age factor
    if (age > 40) premium *= 1.5;
    else if (age > 30) premium *= 1.2;
    
    // Smoking factor
    if (isSmoker) premium *= 2.0;
    
    // Gender factor
    if (gender == "male") premium *= 1.1;
    
    // Coverage amount factor
    premium *= (coverageAmount / 500000);
    
    return premium;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Life Insurance",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Plans", icon: Icon(Icons.list)),
        Tab(text: "Calculator", icon: Icon(Icons.calculate)),
        Tab(text: "Benefits", icon: Icon(Icons.star)),
      ],
      tabChildren: [
        // Plans Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Protect Your",
                            style: TextStyle(
                              fontSize: fsH5,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Loved Ones",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Secure your family's financial future with comprehensive life insurance coverage",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.family_restroom,
                      size: 60,
                      color: Colors.white.withAlpha(180),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Plan Selection
              Text(
                "Choose Your Life Insurance Plan",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...lifePlans.map((plan) {
                final isSelected = selectedPlan == plan["id"];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: GestureDetector(
                    onTap: () {
                      selectedPlan = plan["id"] as String;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? (plan["color"] as Color).withAlpha(25) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? plan["color"] as Color : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected ? [shadowSm] : [],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: plan["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  plan["icon"] as IconData,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${plan["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
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
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: plan["color"] as Color,
                                  size: 24,
                                ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          
                          Text(
                            "Starting from \$${((plan["monthlyPremium"] as double).toDouble()).currency}/month",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: plan["color"] as Color,
                            ),
                          ),
                          SizedBox(height: spSm),
                          
                          Text(
                            "Best for: ${plan["bestFor"]}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (plan["features"] as List).map((feature) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (plan["color"] as Color).withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(
                                    color: (plan["color"] as Color).withAlpha(100),
                                  ),
                                ),
                                child: Text(
                                  "$feature",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: plan["color"] as Color,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),

              SizedBox(height: spLg),

              // CTA Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(100)),
                ),
                child: Column(
                  children: [
                    Text(
                      "Ready to Get Started?",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Get a personalized quote in under 5 minutes",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Get Free Quote",
                      icon: Icons.assignment,
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Calculator Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Premium Calculator",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Calculate your estimated premium based on your profile",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),

              // Calculator Form
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Age Input
                    Text(
                      "Your Age",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Slider(
                      value: age.toDouble(),
                      min: 18,
                      max: 65,
                      divisions: 47,
                      label: "$age years",
                      activeColor: primaryColor,
                      onChanged: (value) {
                        age = value.toInt();
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Coverage Amount
                    Text(
                      "Coverage Amount",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((coverageAmount).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Slider(
                      value: coverageAmount,
                      min: 100000,
                      max: 2000000,
                      divisions: 19,
                      activeColor: primaryColor,
                      onChanged: (value) {
                        coverageAmount = value;
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Gender Selection
                    Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              gender = "male";
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: gender == "male" ? primaryColor : Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: gender == "male" ? primaryColor : disabledOutlineBorderColor,
                                ),
                              ),
                              child: Text(
                                "Male",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: gender == "male" ? Colors.white : disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              gender = "female";
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: gender == "female" ? primaryColor : Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: gender == "female" ? primaryColor : disabledOutlineBorderColor,
                                ),
                              ),
                              child: Text(
                                "Female",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: gender == "female" ? Colors.white : disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Smoking Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Do you smoke?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Switch(
                          value: isSmoker,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            isSmoker = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Premium Result
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [successColor, successColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Text(
                      "Estimated Monthly Premium",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((calculatePremium()).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Based on ${lifePlans.firstWhere((plan) => plan["id"] == selectedPlan)["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Apply Now",
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Benefits Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Life Insurance Benefits",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Comprehensive protection for you and your family",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),

              // Benefits Cards
              ...benefitsData.map((benefit) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          benefit["icon"] as IconData,
                          color: primaryColor,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${benefit["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Up to \$${((benefit["amount"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${benefit["description"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

              SizedBox(height: spLg),

              // Additional Benefits
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Additional Benefits",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    ...["Waiver of Premium", "Accidental Death Benefit", "Terminal Illness Rider", "Disability Income Rider"].map((benefit) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              benefit,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
