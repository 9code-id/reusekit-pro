import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaPremiumView extends StatefulWidget {
  const GeaPremiumView({super.key});

  @override
  State<GeaPremiumView> createState() => _GeaPremiumViewState();
}

class _GeaPremiumViewState extends State<GeaPremiumView> {
  bool isPremiumUser = false;
  String selectedPlan = "monthly";

  List<Map<String, dynamic>> premiumFeatures = [
    {
      "icon": Icons.stars,
      "title": "Unlimited Access",
      "description": "Access to all premium games and content",
    },
    {
      "icon": Icons.speed,
      "title": "No Ads",
      "description": "Enjoy uninterrupted gaming experience",
    },
    {
      "icon": Icons.cloud_sync,
      "title": "Cloud Save",
      "description": "Sync your progress across all devices",
    },
    {
      "icon": Icons.priority_high,
      "title": "Priority Support",
      "description": "Get faster customer support response",
    },
    {
      "icon": Icons.auto_awesome,
      "title": "Exclusive Content",
      "description": "Access to premium-only games and features",
    },
    {
      "icon": Icons.group_add,
      "title": "Multi-Device",
      "description": "Use premium on up to 5 devices",
    },
  ];

  List<Map<String, dynamic>> subscriptionPlans = [
    {
      "id": "monthly",
      "name": "Monthly Plan",
      "price": 9.99,
      "currency": "USD",
      "duration": "month",
      "popular": false,
      "savings": 0,
      "description": "Perfect for trying out premium features",
    },
    {
      "id": "quarterly",
      "name": "Quarterly Plan",
      "price": 24.99,
      "currency": "USD",
      "duration": "3 months",
      "popular": true,
      "savings": 25,
      "description": "Best value for regular gamers",
    },
    {
      "id": "yearly",
      "name": "Yearly Plan",
      "price": 79.99,
      "currency": "USD",
      "duration": "year",
      "popular": false,
      "savings": 33,
      "description": "Maximum savings for dedicated players",
    },
  ];

  Map<String, dynamic> currentSubscription = {
    "plan": "Monthly Plan",
    "startDate": "2024-06-01",
    "endDate": "2024-07-01",
    "autoRenew": true,
    "status": "Active",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Premium Subscription"),
        actions: [
          if (isPremiumUser)
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                //navigateTo('SubscriptionSettingsView')
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Premium Status Banner
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isPremiumUser 
                      ? [warningColor, warningColor.withAlpha(150)]
                      : [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    isPremiumUser ? Icons.stars : Icons.diamond,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isPremiumUser ? "Premium Active" : "Go Premium",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          isPremiumUser 
                              ? "Enjoy all premium features"
                              : "Unlock exclusive features and content",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                        if (isPremiumUser) ...[
                          SizedBox(height: spXs),
                          Text(
                            "Expires: ${currentSubscription["endDate"]}",
                            style: TextStyle(
                              color: Colors.white.withAlpha(180),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Premium Features
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Premium Features",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...premiumFeatures.map((feature) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              feature["icon"],
                              color: primaryColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${feature["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${feature["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isPremiumUser)
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            if (!isPremiumUser) ...[
              // Subscription Plans
              Text(
                "Choose Your Plan",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              ...subscriptionPlans.map((plan) {
                final isSelected = selectedPlan == plan["id"];
                return GestureDetector(
                  onTap: () {
                    selectedPlan = plan["id"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      children: [
                        if (plan["popular"] == true)
                          Positioned(
                            top: -spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
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
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Radio<String>(
                                  value: plan["id"],
                                  groupValue: selectedPlan,
                                  onChanged: (value) {
                                    selectedPlan = value!;
                                    setState(() {});
                                  },
                                  activeColor: primaryColor,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${plan["name"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${(plan["price"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                    Text(
                                      "/${plan["duration"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if ((plan["savings"] as int) > 0) ...[
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Save ${plan["savings"]}% compared to monthly",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),

              // Subscribe Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Subscribe Now",
                  size: bs.md,
                  onPressed: () {
                    //navigateTo('PaymentView', arguments: selectedPlan)
                  },
                ),
              ),

              // Terms and Conditions
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Text(
                      "By subscribing, you agree to our Terms of Service and Privacy Policy. Subscription automatically renews unless cancelled 24 hours before the end of the current period.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            //navigateTo('TermsOfServiceView')
                          },
                          child: Text(
                            "Terms of Service",
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          " • ",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //navigateTo('PrivacyPolicyView')
                          },
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Current Subscription Details
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Subscription",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Plan",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${currentSubscription["plan"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${currentSubscription["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Start Date",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${currentSubscription["startDate"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Next Billing",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${currentSubscription["endDate"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          currentSubscription["autoRenew"] ? Icons.autorenew : Icons.pause,
                          color: currentSubscription["autoRenew"] ? successColor : warningColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          currentSubscription["autoRenew"] ? "Auto-renewal enabled" : "Auto-renewal disabled",
                          style: TextStyle(
                            fontSize: 12,
                            color: currentSubscription["autoRenew"] ? successColor : warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Management Actions
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Manage Subscription",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('SubscriptionManageView')
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Cancel Subscription",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('SubscriptionCancelView')
                      },
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
