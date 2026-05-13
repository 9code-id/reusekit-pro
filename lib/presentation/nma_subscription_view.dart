import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaSubscriptionView extends StatefulWidget {
  const NmaSubscriptionView({Key? key}) : super(key: key);

  @override
  State<NmaSubscriptionView> createState() => _NmaSubscriptionViewState();
}

class _NmaSubscriptionViewState extends State<NmaSubscriptionView> {
  String selectedPlan = "monthly";
  bool isYearly = false;
  
  List<Map<String, dynamic>> subscriptionPlans = [
    {
      "id": "free",
      "name": "Free",
      "price": 0,
      "yearlyPrice": 0,
      "description": "Basic news access with limited features",
      "features": [
        "Read latest news articles",
        "Browse 5 categories",
        "Basic search functionality",
        "Standard ad-supported experience"
      ],
      "limitations": [
        "Limited article views per day",
        "No offline reading",
        "No personalization",
        "Ads in content"
      ],
      "color": disabledBoldColor,
      "popular": false
    },
    {
      "id": "monthly", 
      "name": "News Pro",
      "price": 9.99,
      "yearlyPrice": 99.99,
      "description": "Full access to all news features and content",
      "features": [
        "Unlimited article access",
        "Ad-free reading experience", 
        "Offline reading & downloads",
        "Personalized news feed",
        "Breaking news notifications",
        "Multiple news sources",
        "Premium article summaries",
        "Dark mode support"
      ],
      "limitations": [],
      "color": primaryColor,
      "popular": true
    },
    {
      "id": "premium",
      "name": "News Premium",
      "price": 19.99,
      "yearlyPrice": 199.99,
      "description": "Ultimate news experience with exclusive content",
      "features": [
        "Everything in News Pro",
        "Exclusive premium articles",
        "AI-powered news insights",
        "Early access to breaking news",
        "Live news updates",
        "Expert analysis & opinions",
        "Custom news alerts",
        "Priority customer support",
        "Advanced search filters",
        "News archive access"
      ],
      "limitations": [],
      "color": warningColor,
      "popular": false
    }
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "name": "Credit Card",
      "icon": Icons.credit_card,
      "description": "Visa, Mastercard, American Express"
    },
    {
      "name": "PayPal",
      "icon": Icons.payment,
      "description": "Secure PayPal payment"
    },
    {
      "name": "Apple Pay",
      "icon": Icons.apple,
      "description": "Quick and secure payment"
    },
    {
      "name": "Google Pay",
      "icon": Icons.g_mobiledata,
      "description": "Pay with Google account"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Plan"),
        actions: [
          QButton(
            icon: Icons.help_outline,
            size: bs.sm,
            onPressed: () {
              _showSubscriptionHelp();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSubscriptionHeader(),
            _buildBillingToggle(),
            _buildSubscriptionPlans(),
            _buildSelectedPlanSummary(),
            _buildPaymentMethods(),
            _buildSubscribeButton(),
            _buildSubscriptionInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionHeader() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withAlpha(30),
            primaryColor.withAlpha(10),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Icon(
            Icons.workspace_premium,
            size: 60,
            color: primaryColor,
          ),
          
          Text(
            "Unlock Premium News",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "Get unlimited access to breaking news, exclusive content, and personalized features",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBenefit("Ad-Free", Icons.block),
              SizedBox(width: spLg),
              _buildBenefit("Offline", Icons.offline_pin),
              SizedBox(width: spLg),
              _buildBenefit("Unlimited", Icons.all_inclusive),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefit(String label, IconData icon) {
    return Column(
      spacing: spXs,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBillingToggle() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => isYearly = false);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spMd),
                decoration: BoxDecoration(
                  color: !isYearly ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Monthly",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: !isYearly ? Colors.white : disabledBoldColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => isYearly = true);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spMd),
                decoration: BoxDecoration(
                  color: isYearly ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Text(
                      "Yearly",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isYearly ? Colors.white : disabledBoldColor,
                      ),
                    ),
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
                        "Save 20%",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
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

  Widget _buildSubscriptionPlans() {
    return Column(
      spacing: spMd,
      children: subscriptionPlans.map((plan) {
        final isSelected = selectedPlan == plan["id"];
        final isPopular = plan["popular"] as bool;
        final planColor = plan["color"] as Color;
        final price = isYearly ? plan["yearlyPrice"] : plan["price"];
        final features = plan["features"] as List;
        
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedPlan = plan["id"];
            });
          },
          child: Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: isSelected ? planColor : disabledColor,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected ? [shadowMd] : [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                // Plan Header
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${plan["name"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: planColor,
                                ),
                              ),
                              if (isPopular) ...[
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
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
                            ],
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: spXs,
                      children: [
                        if (price == 0) ...[
                          Text(
                            "Free",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: planColor,
                            ),
                          ),
                        ] else ...[
                          Text(
                            "\$${price.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: planColor,
                            ),
                          ),
                          Text(
                            isYearly ? "/year" : "/month",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                
                // Features List
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: features.map((feature) {
                    return Row(
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
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                
                // Selection Indicator
                if (isSelected)
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: planColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: planColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Selected Plan",
                          style: TextStyle(
                            fontSize: 14,
                            color: planColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSelectedPlanSummary() {
    final selectedPlanData = subscriptionPlans.firstWhere(
      (plan) => plan["id"] == selectedPlan,
    );
    
    final price = isYearly 
        ? selectedPlanData["yearlyPrice"] 
        : selectedPlanData["price"];
    
    if (price == 0) return Container();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Order Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${selectedPlanData["name"]} (${isYearly ? "Yearly" : "Monthly"})",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${price.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          if (isYearly) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "You save",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "\$${((selectedPlanData["price"] * 12) - selectedPlanData["yearlyPrice"]).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    final selectedPlanData = subscriptionPlans.firstWhere(
      (plan) => plan["id"] == selectedPlan,
    );
    
    final price = isYearly 
        ? selectedPlanData["yearlyPrice"] 
        : selectedPlanData["price"];
    
    if (price == 0) return Container();
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Payment Method",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...paymentMethods.asMap().entries.map((entry) {
            final index = entry.key;
            final method = entry.value;
            final isLast = index == paymentMethods.length - 1;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: isLast ? null : Border(
                  bottom: BorderSide(
                    color: disabledColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      method["icon"] as IconData,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${method["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${method["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: disabledBoldColor,
                    size: 16,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton() {
    final selectedPlanData = subscriptionPlans.firstWhere(
      (plan) => plan["id"] == selectedPlan,
    );
    
    final price = isYearly 
        ? selectedPlanData["yearlyPrice"] 
        : selectedPlanData["price"];
    
    return Container(
      width: double.infinity,
      child: QButton(
        label: price == 0 
            ? "Continue with Free Plan" 
            : "Subscribe Now - \$${price.toStringAsFixed(2)}",
        size: bs.md,
        onPressed: _handleSubscription,
      ),
    );
  }

  Widget _buildSubscriptionInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Subscription Information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          
          Text(
            "• Cancel anytime with no penalties\n• Automatic renewal unless cancelled\n• Full refund within 7 days of purchase\n• Access to all premium features immediately\n• Free trial for first-time subscribers",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    si("Opening Terms of Service");
                  },
                  child: Text(
                    "Terms of Service",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              Text(
                " | ",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    si("Opening Privacy Policy");
                  },
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleSubscription() {
    final selectedPlanData = subscriptionPlans.firstWhere(
      (plan) => plan["id"] == selectedPlan,
    );
    
    final price = isYearly 
        ? selectedPlanData["yearlyPrice"] 
        : selectedPlanData["price"];
    
    if (price == 0) {
      ss("Welcome! You're using the free plan");
      // ss('Next page'));
    } else {
      si("Processing subscription to ${selectedPlanData["name"]}...");
      
      Future.delayed(Duration(seconds: 2), () {
        ss("Subscription successful! Welcome to ${selectedPlanData["name"]}");
        // ss('Next page'));
      });
    }
  }

  void _showSubscriptionHelp() {
    si("For subscription help, contact support@newsmax.com");
  }
}
