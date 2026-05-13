import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSubscription6View extends StatefulWidget {
  @override
  State<GrlSubscription6View> createState() => _GrlSubscription6ViewState();
}

class _GrlSubscription6ViewState extends State<GrlSubscription6View> {
  Map<String, dynamic> currentPlan = {
    "name": "Pro",
    "price": 29.99,
    "features": [
      "100 GB Storage",
      "Priority Support",
      "Advanced Analytics",
      "API Access",
      "Custom Branding"
    ],
  };

  List<Map<String, dynamic>> availablePlans = [
    {
      "id": "basic",
      "name": "Basic",
      "price": 9.99,
      "features": [
        "10 GB Storage",
        "Email Support",
        "Basic Analytics",
        "Standard Security"
      ],
      "recommended": false,
      "savings": 0,
    },
    {
      "id": "pro",
      "name": "Pro",
      "price": 29.99,
      "features": [
        "100 GB Storage",
        "Priority Support",
        "Advanced Analytics",
        "API Access",
        "Custom Branding"
      ],
      "recommended": true,
      "savings": 0,
    },
    {
      "id": "enterprise",
      "name": "Enterprise",
      "price": 99.99,
      "features": [
        "Unlimited Storage",
        "24/7 Phone Support",
        "Premium Analytics",
        "Full API Access",
        "White Label Solution",
        "Dedicated Manager",
        "Custom Integration"
      ],
      "recommended": false,
      "savings": 200,
    },
  ];

  String selectedPlan = "pro";
  bool showComparison = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Plan"),
        actions: [
          IconButton(
            icon: Icon(Icons.compare_arrows),
            onPressed: () {
              showComparison = !showComparison;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCurrentPlan(),
            if (showComparison) _buildPlanComparison(),
            _buildAvailablePlans(),
            _buildUpgradeDowngradeInfo(),
            _buildChangePlanButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPlan() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(20), secondaryColor.withAlpha(20)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(100)),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.workspace_premium,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Current Plan",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXl),
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
                    Text(
                      "${currentPlan["name"]} Plan",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${(currentPlan["price"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
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
                  "Current Features",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Wrap(
                  spacing: spSm,
                  runSpacing: spXs,
                  children: (currentPlan["features"] as List<String>).map((feature) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: successColor.withAlpha(100)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check,
                            size: 12,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            feature,
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanComparison() {
    List<String> allFeatures = [
      "Storage",
      "Support",
      "Analytics",
      "API Access",
      "Branding",
      "Manager",
      "Integration",
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Plan Comparison",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showComparison = false;
                  setState(() {});
                },
                child: Icon(
                  Icons.close,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 40,
              dataRowHeight: 35,
              columns: [
                DataColumn(
                  label: Text(
                    "Features",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                ...availablePlans.map((plan) {
                  return DataColumn(
                    label: Text(
                      "${plan["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: plan["id"] == selectedPlan ? primaryColor : disabledBoldColor,
                      ),
                    ),
                  );
                }).toList(),
              ],
              rows: allFeatures.map((feature) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        feature,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    ...availablePlans.map((plan) {
                      bool hasFeature = (plan["features"] as List<String>)
                          .any((f) => f.toLowerCase().contains(feature.toLowerCase()));
                      return DataCell(
                        Icon(
                          hasFeature ? Icons.check_circle : Icons.cancel,
                          color: hasFeature ? successColor : dangerColor,
                          size: 16,
                        ),
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailablePlans() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Available Plans",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Column(
          spacing: spSm,
          children: availablePlans.map((plan) {
            bool isSelected = selectedPlan == plan["id"];
            bool isCurrent = plan["name"] == currentPlan["name"];
            double priceDifference = (plan["price"] as double) - (currentPlan["price"] as double);
            
            return GestureDetector(
              onTap: () {
                selectedPlan = plan["id"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: isCurrent 
                      ? primaryColor.withAlpha(10)
                      : isSelected 
                          ? secondaryColor.withAlpha(10) 
                          : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isCurrent 
                        ? primaryColor
                        : isSelected 
                            ? secondaryColor 
                            : disabledOutlineBorderColor,
                    width: isCurrent || isSelected ? 2 : 1,
                  ),
                  boxShadow: isCurrent || isSelected ? [shadowMd] : [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
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
                                      color: isCurrent ? primaryColor : secondaryColor,
                                    ),
                                  ),
                                  if (plan["recommended"] as bool)
                                    Container(
                                      margin: EdgeInsets.only(left: spSm),
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: warningColor,
                                        borderRadius: BorderRadius.circular(radiusXl),
                                      ),
                                      child: Text(
                                        "RECOMMENDED",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  if (isCurrent)
                                    Container(
                                      margin: EdgeInsets.only(left: spSm),
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusXl),
                                      ),
                                      child: Text(
                                        "CURRENT",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "\$${(plan["price"] as double).toStringAsFixed(2)}/month",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: isCurrent ? primaryColor : secondaryColor,
                                    ),
                                  ),
                                  if (!isCurrent && priceDifference != 0)
                                    Container(
                                      margin: EdgeInsets.only(left: spSm),
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: priceDifference > 0 
                                            ? dangerColor.withAlpha(20) 
                                            : successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${priceDifference > 0 ? '+' : ''}\$${priceDifference.abs().toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: priceDifference > 0 ? dangerColor : successColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (!isCurrent)
                          Radio<String>(
                            value: plan["id"],
                            groupValue: selectedPlan,
                            onChanged: (value) {
                              selectedPlan = value!;
                              setState(() {});
                            },
                            activeColor: secondaryColor,
                          ),
                      ],
                    ),
                    Column(
                      spacing: spXs,
                      children: (plan["features"] as List<String>).map((feature) {
                        bool isNewFeature = !(currentPlan["features"] as List<String>).contains(feature);
                        return Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: isNewFeature ? secondaryColor : successColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                feature,
                                style: TextStyle(
                                  color: isNewFeature ? secondaryColor : disabledBoldColor,
                                  fontSize: 14,
                                  fontWeight: isNewFeature ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (isNewFeature)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: infoColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "NEW",
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                    if ((plan["savings"] as int) > 0)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: successColor.withAlpha(100)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.savings,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Save up to \$${plan["savings"]} annually with this plan",
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
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildUpgradeDowngradeInfo() {
    final selectedPlanData = availablePlans.firstWhere((plan) => plan["id"] == selectedPlan);
    final currentPlanData = availablePlans.firstWhere((plan) => plan["name"] == currentPlan["name"]);
    
    if (selectedPlan == currentPlanData["id"]) {
      return Container();
    }

    bool isUpgrade = (selectedPlanData["price"] as double) > (currentPlanData["price"] as double);
    double priceDifference = ((selectedPlanData["price"] as double) - (currentPlanData["price"] as double)).abs();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isUpgrade ? successColor.withAlpha(10) : warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: isUpgrade ? successColor.withAlpha(100) : warningColor.withAlpha(100),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                isUpgrade ? Icons.trending_up : Icons.trending_down,
                color: isUpgrade ? successColor : warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                isUpgrade ? "Plan Upgrade" : "Plan Downgrade",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isUpgrade ? successColor : warningColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: [
              Row(
                children: [
                  Text(
                    "Price change:",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${isUpgrade ? '+' : '-'}\$${priceDifference.toStringAsFixed(2)}/month",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isUpgrade ? dangerColor : successColor,
                    ),
                  ),
                ],
              ),
              if (isUpgrade)
                Text(
                  "You'll be charged the prorated amount immediately and then the full amount on your next billing cycle.",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                )
              else
                Text(
                  "The price change will take effect on your next billing cycle. You'll keep your current features until then.",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChangePlanButton() {
    final selectedPlanData = availablePlans.firstWhere((plan) => plan["id"] == selectedPlan);
    final currentPlanData = availablePlans.firstWhere((plan) => plan["name"] == currentPlan["name"]);
    
    if (selectedPlan == currentPlanData["id"]) {
      return Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Text(
              "This is your current plan",
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    bool isUpgrade = (selectedPlanData["price"] as double) > (currentPlanData["price"] as double);
    
    return Column(
      spacing: spMd,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "${isUpgrade ? 'Upgrade' : 'Downgrade'} to ${selectedPlanData["name"]}",
            size: bs.md,
            onPressed: () async {
              bool isConfirmed = await confirm(
                "${isUpgrade ? 'Upgrade' : 'Downgrade'} to ${selectedPlanData["name"]} plan?"
              );
              if (isConfirmed) {
                ss("Plan changed successfully to ${selectedPlanData["name"]}!");
                // Update current plan
                currentPlan = {
                  "name": selectedPlanData["name"],
                  "price": selectedPlanData["price"],
                  "features": selectedPlanData["features"],
                };
                setState(() {});
              }
            },
          ),
        ),
        Text(
          "You can change your plan anytime. Changes will be reflected in your next billing cycle.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
