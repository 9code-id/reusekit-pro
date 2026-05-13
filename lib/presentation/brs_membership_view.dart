import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsMembershipView extends StatefulWidget {
  const BrsMembershipView({super.key});

  @override
  State<BrsMembershipView> createState() => _BrsMembershipViewState();
}

class _BrsMembershipViewState extends State<BrsMembershipView> {
  String currentPlan = "Silver";
  int currentPoints = 2450;
  
  List<Map<String, dynamic>> membershipPlans = [
    {
      "id": 1,
      "name": "Bronze",
      "color": Color(0xFFCD7F32),
      "monthlyPrice": 0,
      "yearlyPrice": 0,
      "pointsRequired": 0,
      "currentLevel": false,
      "features": [
        "Basic booking system",
        "Standard customer support",
        "1 point per \$1 spent",
        "Basic profile features",
      ],
      "limitations": [
        "No priority booking",
        "Limited discounts",
      ],
    },
    {
      "id": 2,
      "name": "Silver",
      "color": Color(0xFFC0C0C0),
      "monthlyPrice": 9.99,
      "yearlyPrice": 99.99,
      "pointsRequired": 1000,
      "currentLevel": true,
      "features": [
        "Priority booking slots",
        "Enhanced customer support",
        "2 points per \$1 spent",
        "5% discount on all services",
        "Free monthly newsletter",
        "Birthday bonus points",
      ],
      "limitations": [
        "Limited premium services",
      ],
    },
    {
      "id": 3,
      "name": "Gold",
      "color": Color(0xFFFFD700),
      "monthlyPrice": 19.99,
      "yearlyPrice": 199.99,
      "pointsRequired": 5000,
      "currentLevel": false,
      "features": [
        "VIP priority booking",
        "24/7 premium support",
        "3 points per \$1 spent",
        "10% discount on all services",
        "Free monthly premium service",
        "Exclusive barbershop access",
        "Personal grooming consultation",
        "Special event invitations",
      ],
      "limitations": [],
    },
    {
      "id": 4,
      "name": "Platinum",
      "color": Color(0xFFE5E4E2),
      "monthlyPrice": 39.99,
      "yearlyPrice": 399.99,
      "pointsRequired": 10000,
      "currentLevel": false,
      "features": [
        "Unlimited priority access",
        "Dedicated account manager",
        "5 points per \$1 spent",
        "15% discount on all services",
        "2 free premium services monthly",
        "Exclusive platinum barbershops",
        "Personal stylist assignment",
        "Home service options",
        "Partner spa access",
        "Complimentary products",
      ],
      "limitations": [],
    },
  ];

  List<Map<String, dynamic>> membershipBenefits = [
    {
      "title": "Priority Booking",
      "description": "Get access to premium time slots before other customers",
      "icon": Icons.schedule,
      "available": ["Silver", "Gold", "Platinum"],
    },
    {
      "title": "Points Multiplier",
      "description": "Earn more points with every service booking",
      "icon": Icons.stars,
      "available": ["Silver", "Gold", "Platinum"],
    },
    {
      "title": "Exclusive Discounts",
      "description": "Special member-only pricing on all services",
      "icon": Icons.local_offer,
      "available": ["Silver", "Gold", "Platinum"],
    },
    {
      "title": "Free Monthly Service",
      "description": "Complimentary premium service every month",
      "icon": Icons.card_giftcard,
      "available": ["Gold", "Platinum"],
    },
    {
      "title": "Personal Consultation",
      "description": "One-on-one grooming and style consultation",
      "icon": Icons.person,
      "available": ["Gold", "Platinum"],
    },
    {
      "title": "Home Service",
      "description": "Barbershop services at your location",
      "icon": Icons.home,
      "available": ["Platinum"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Membership Plans"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showMembershipHelp();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Membership Status
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _getCurrentPlanColor(),
                    _getCurrentPlanColor().withAlpha(200),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.workspace_premium,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Plan",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "$currentPlan Member",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "$currentPoints points earned",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Progress to Next Level
                  if (currentPlan != "Platinum")
                    _buildProgressToNextLevel(),
                ],
              ),
            ),
            
            // Membership Benefits Overview
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Membership Benefits",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Unlock exclusive perks with higher membership tiers",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            // Benefits Grid
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 160,
                children: membershipBenefits.map((benefit) {
                  bool isAvailable = (benefit["available"] as List).contains(currentPlan);
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isAvailable ? primaryColor.withAlpha(50) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isAvailable ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: isAvailable ? primaryColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            benefit["icon"] as IconData,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${benefit["title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isAvailable ? primaryColor : disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${benefit["description"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        if (isAvailable)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Available",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        else
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Upgrade",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Membership Plans
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Choose Your Plan",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            
            SizedBox(height: spSm),
            
            ...membershipPlans.map((plan) {
              bool isCurrent = plan["currentLevel"] as bool;
              bool canUpgrade = _canUpgradeToPlan(plan);
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd, left: spMd, right: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isCurrent ? (plan["color"] as Color) : disabledOutlineBorderColor,
                    width: isCurrent ? 2 : 1,
                  ),
                  boxShadow: isCurrent ? [shadowMd] : [shadowSm],
                ),
                child: Column(
                  children: [
                    // Plan Header
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isCurrent ? (plan["color"] as Color).withAlpha(50) : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: plan["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.workspace_premium,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${plan["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH5,
                                        fontWeight: FontWeight.bold,
                                        color: plan["color"] as Color,
                                      ),
                                    ),
                                    if (isCurrent)
                                      Container(
                                        margin: EdgeInsets.only(left: spSm),
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: successColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Current",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],                                ),
                                if ((plan["monthlyPrice"] as num) > 0)
                                  Text(
                                    "\$${plan["monthlyPrice"]}/month or \$${plan["yearlyPrice"]}/year",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  )
                                else
                                  Text(
                                    "Free",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Plan Features
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Features Included:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spSm),
                          ...(plan["features"] as List).map((feature) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
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
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          
                          if ((plan["limitations"] as List).isNotEmpty) ...[
                            SizedBox(height: spSm),
                            Text(
                              "Limitations:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spSm),
                            ...(plan["limitations"] as List).map((limitation) {
                              return Container(
                                margin: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cancel,
                                      color: dangerColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "$limitation",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                          
                          SizedBox(height: spMd),
                          
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: isCurrent ? "Current Plan" : canUpgrade ? "Upgrade Now" : "Not Available",
                              size: bs.md,
                              onPressed: !isCurrent && canUpgrade ? () {
                                _showUpgradeDialog(plan);
                              } : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressToNextLevel() {
    Map<String, dynamic>? nextPlan = _getNextPlan();
    if (nextPlan == null) return SizedBox.shrink();
    
    int pointsNeeded = (nextPlan["pointsRequired"] as int) - currentPoints;
    double progress = currentPoints / (nextPlan["pointsRequired"] as int);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Progress to ${nextPlan["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Text(
                "$pointsNeeded points to go",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withAlpha(100),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }

  Color _getCurrentPlanColor() {
    for (var plan in membershipPlans) {
      if (plan["currentLevel"] as bool) {
        return plan["color"] as Color;
      }
    }
    return primaryColor;
  }

  Map<String, dynamic>? _getNextPlan() {
    int currentIndex = membershipPlans.indexWhere((plan) => plan["currentLevel"] as bool);
    if (currentIndex < membershipPlans.length - 1) {
      return membershipPlans[currentIndex + 1];
    }
    return null;
  }

  bool _canUpgradeToPlan(Map<String, dynamic> plan) {
    if (plan["currentLevel"] as bool) return false;
    return currentPoints >= (plan["pointsRequired"] as int);
  }

  void _showUpgradeDialog(Map<String, dynamic> plan) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          title: Text("Upgrade to ${plan["name"]}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("You're about to upgrade to ${plan["name"]} membership."),              SizedBox(height: spSm),
              if ((plan["monthlyPrice"] as num) > 0)
                Text(
                  "Price: \$${plan["monthlyPrice"]}/month",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ss("Upgrading to ${plan["name"]} membership");
              },
              child: Text("Upgrade"),
            ),
          ],
        );
      },
    );
  }

  void _showMembershipHelp() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Membership FAQ",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "How do I upgrade?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Earn points through services and activities, or purchase a plan directly.",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "Can I downgrade?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "You can cancel paid plans anytime. Your benefits continue until the billing period ends.",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Got It",
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
