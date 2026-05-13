import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMembership4View extends StatefulWidget {
  const GrlMembership4View({Key? key}) : super(key: key);

  @override
  State<GrlMembership4View> createState() => _GrlMembership4ViewState();
}

class _GrlMembership4ViewState extends State<GrlMembership4View> {
  String currentMembership = "premium";
  int selectedUpgrade = 0;
  bool showComparison = false;

  Map<String, dynamic> currentPlan = {
    "name": "Premium",
    "price": 29.99,
    "period": "monthly",
    "nextBilling": "2024-07-15",
    "features": [
      "Unlimited projects",
      "100GB storage",
      "Priority support",
      "Premium templates",
      "Advanced analytics"
    ],
    "usage": {
      "projects": {"used": 15, "limit": "unlimited"},
      "storage": {"used": 45.2, "limit": 100},
      "supportTickets": {"used": 3, "limit": "unlimited"},
    }
  };

  List<Map<String, dynamic>> upgradeOptions = [
    {
      "name": "Enterprise",
      "price": 99.99,
      "period": "monthly",
      "savings": 0,
      "popular": false,
      "features": [
        "Everything in Premium",
        "Unlimited storage",
        "24/7 phone support",
        "Custom integrations",
        "Dedicated account manager",
        "Advanced security",
        "SLA guarantee"
      ],
      "additionalBenefits": [
        "Save 40% on add-ons",
        "Free migration assistance",
        "Priority feature requests"
      ],
      "color": warningColor,
    },
    {
      "name": "Enterprise Plus",
      "price": 199.99,
      "period": "monthly",
      "savings": 50,
      "popular": true,
      "features": [
        "Everything in Enterprise",
        "White-label solution",
        "Custom development",
        "On-premise deployment",
        "Compliance certifications",
        "Advanced reporting",
        "Multi-region support"
      ],
      "additionalBenefits": [
        "Free setup and training",
        "Quarterly business reviews",
        "Early access to new features"
      ],
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> addOns = [
    {
      "name": "Extra Storage",
      "description": "Additional 500GB storage",
      "price": 9.99,
      "period": "monthly",
      "enabled": false,
    },
    {
      "name": "Advanced Analytics",
      "description": "Custom reports and insights",
      "price": 19.99,
      "period": "monthly",
      "enabled": true,
    },
    {
      "name": "White Label",
      "description": "Remove branding, use your own",
      "price": 29.99,
      "period": "monthly",
      "enabled": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Membership"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              si("Viewing billing history");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Plan Status
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Plan: ${currentPlan["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "\$${(currentPlan["price"] as num).toStringAsFixed(2)}/${currentPlan["period"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "ACTIVE",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Next billing: ${currentPlan["nextBilling"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Usage Statistics
            Text(
              "Current Usage",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...(currentPlan["usage"] as Map<String, dynamic>).entries.map((entry) {
              final key = entry.key;
              final usage = entry.value as Map<String, dynamic>;
              final used = usage["used"];
              final limit = usage["limit"];
              final isUnlimited = limit == "unlimited";
              final percentage = isUnlimited ? 0.0 : (used / limit) * 100;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          key == "projects" ? "Projects" :
                          key == "storage" ? "Storage (GB)" : "Support Tickets",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          isUnlimited 
                              ? "$used / Unlimited"
                              : key == "storage" 
                                  ? "${(used as double).toStringAsFixed(1)}GB / ${limit}GB"
                                  : "$used / $limit",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    if (!isUnlimited) ...[
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: percentage / 100,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          percentage > 80 ? dangerColor :
                          percentage > 60 ? warningColor : successColor,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: spLg),

            // Upgrade Options
            Row(
              children: [
                Text(
                  "Upgrade Options",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    showComparison = !showComparison;
                    setState(() {});
                  },
                  child: Text(
                    showComparison ? "Hide Comparison" : "Compare Plans",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),

            ...List.generate(upgradeOptions.length, (index) {
              final plan = upgradeOptions[index];
              final isSelected = selectedUpgrade == index;
              final isPopular = plan["popular"] as bool;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (isPopular)
                      Positioned(
                        top: -8,
                        right: spLg,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: plan["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
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
                    GestureDetector(
                      onTap: () {
                        selectedUpgrade = index;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? (plan["color"] as Color).withAlpha(10)
                              : Colors.white,
                          border: Border.all(
                            color: isSelected 
                                ? (plan["color"] as Color)
                                : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: isSelected ? [shadowMd] : [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected 
                                        ? (plan["color"] as Color)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected 
                                          ? (plan["color"] as Color)
                                          : disabledOutlineBorderColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 14,
                                        )
                                      : null,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${plan["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${(plan["price"] as num).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: fsH5,
                                        fontWeight: FontWeight.bold,
                                        color: plan["color"] as Color,
                                      ),
                                    ),
                                    Text(
                                      "/${plan["period"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    if ((plan["savings"] as num) > 0)
                                      Container(
                                        margin: EdgeInsets.only(top: spXs),
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: successColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Save \$${plan["savings"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            
                            if (showComparison) ...[
                              SizedBox(height: spMd),
                              Text(
                                "Features:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(plan["features"] as List).map((feature) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: spXs),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: successColor,
                                        size: 14,
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Text(
                                          "$feature",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              
                              SizedBox(height: spSm),
                              Text(
                                "Additional Benefits:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: plan["color"] as Color,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(plan["additionalBenefits"] as List).map((benefit) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: spXs),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: plan["color"] as Color,
                                        size: 14,
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Text(
                                          "$benefit",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: plan["color"] as Color,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            // Add-ons Section
            Text(
              "Available Add-ons",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...addOns.map((addon) {
              final isEnabled = addon["enabled"] as bool;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isEnabled 
                      ? successColor.withAlpha(10)
                      : Colors.white,
                  border: Border.all(
                    color: isEnabled ? successColor : disabledOutlineBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isEnabled ? successColor : Colors.transparent,
                        border: Border.all(
                          color: isEnabled ? successColor : disabledOutlineBorderColor,
                          width: 2,
                        ),
                      ),
                      child: isEnabled
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12,
                            )
                          : null,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${addon["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${addon["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${(addon["price"] as num).toStringAsFixed(2)}/${addon["period"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isEnabled ? successColor : primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spLg),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Upgrade Now",
                    size: bs.md,
                    onPressed: () {
                      final selectedPlan = upgradeOptions[selectedUpgrade];
                      ss("Upgrading to ${selectedPlan["name"]}!");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: QButton(
                      label: "Manage Plan",
                      size: bs.md,
                      color: Colors.white,
                      onPressed: () {
                        si("Opening plan management options");
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Text(
              "Upgrades take effect immediately • Downgrades at next billing cycle",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
