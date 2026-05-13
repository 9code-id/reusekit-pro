import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCloud5View extends StatefulWidget {
  @override
  State<GrlCloud5View> createState() => _GrlCloud5ViewState();
}

class _GrlCloud5ViewState extends State<GrlCloud5View> {
  bool loading = false;
  String selectedPlan = "basic";
  
  List<Map<String, dynamic>> plans = [
    {
      "id": "basic",
      "name": "Basic",
      "price": 0,
      "storage": "5 GB",
      "features": [
        "5 GB Cloud Storage",
        "Basic File Sync",
        "Mobile Access",
        "Email Support",
      ],
      "popular": false,
      "color": infoColor,
    },
    {
      "id": "pro", 
      "name": "Professional",
      "price": 9.99,
      "storage": "100 GB",
      "features": [
        "100 GB Cloud Storage",
        "Advanced File Sync",
        "Desktop & Mobile Access",
        "Priority Support",
        "File Versioning",
        "Collaboration Tools",
      ],
      "popular": true,
      "color": primaryColor,
    },
    {
      "id": "enterprise",
      "name": "Enterprise", 
      "price": 29.99,
      "storage": "1 TB",
      "features": [
        "1 TB Cloud Storage",
        "Real-time Sync",
        "All Platform Access",
        "24/7 Premium Support",
        "Advanced Security",
        "Team Management",
        "API Access",
        "Custom Integrations",
      ],
      "popular": false,
      "color": warningColor,
    },
  ];

  Map<String, dynamic> currentUsage = {
    "used": 2.3,
    "total": 5.0,
    "percentage": 46,
    "plan": "Basic",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storage Plans"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showPlanComparison,
          ),
        ],
      ),
      body: loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCurrentUsage(),
                SizedBox(height: spLg),
                _buildPlanSelection(),
                SizedBox(height: spLg),
                _buildSelectedPlanDetails(),
                SizedBox(height: spLg),
                _buildUpgradeButton(),
              ],
            ),
          ),
    );
  }

  Widget _buildCurrentUsage() {
    double percentage = (currentUsage["percentage"] as int) / 100;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.storage,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Current Storage Usage",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${currentUsage["plan"]} Plan",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${((currentUsage["used"] as double)).toStringAsFixed(1)} GB of ${((currentUsage["total"] as double)).toStringAsFixed(0)} GB used",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getUsageColor().withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${currentUsage["percentage"]}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _getUsageColor(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: _getUsageColor(),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          SizedBox(height: spSm),
          if (percentage > 0.8)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: warningColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Storage almost full. Consider upgrading your plan.",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlanSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Your Plan",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...plans.map((plan) => _buildPlanCard(plan)).toList(),
      ],
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    bool isSelected = selectedPlan == plan["id"];
    bool isPopular = plan["popular"] as bool;
    Color planColor = plan["color"] as Color;
    
    return GestureDetector(
      onTap: () {
        selectedPlan = plan["id"] as String;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
          border: Border.all(
            color: isSelected ? planColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (isPopular)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
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
                Spacer(),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? planColor : disabledOutlineBorderColor,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                    ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: planColor,
                          ),
                        ),
                      )
                    : null,
                ),
              ],
            ),
            SizedBox(height: spSm),
            Text(
              "${plan["name"]}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: planColor,
              ),
            ),
            SizedBox(height: spXs),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  (plan["price"] as double) == 0 ? "Free" : "\$${((plan["price"] as double)).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if ((plan["price"] as double) > 0)
                  Text(
                    "/month",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
              ],
            ),
            SizedBox(height: spXs),
            Text(
              "${plan["storage"]} Storage",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            ...((plan["features"] as List).take(3)).map((feature) => Padding(
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
                    "$feature",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )).toList(),
            if ((plan["features"] as List).length > 3)
              GestureDetector(
                onTap: () => _showAllFeatures(plan),
                child: Text(
                  "+${(plan["features"] as List).length - 3} more features",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: planColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedPlanDetails() {
    Map<String, dynamic>? selectedPlanData = plans.firstWhere(
      (plan) => plan["id"] == selectedPlan,
    );

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: (selectedPlanData["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: selectedPlanData["color"] as Color,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selected Plan Features",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: selectedPlanData["color"] as Color,
            ),
          ),
          SizedBox(height: spMd),
          ...(selectedPlanData["features"] as List).map((feature) => Padding(
            padding: EdgeInsets.only(bottom: spSm),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 18,
                  color: selectedPlanData["color"] as Color,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "$feature",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildUpgradeButton() {
    Map<String, dynamic>? selectedPlanData = plans.firstWhere(
      (plan) => plan["id"] == selectedPlan,
    );
    
    bool isCurrentPlan = selectedPlan == "basic"; // Assuming current plan is basic
    
    return Container(
      width: double.infinity,
      child: QButton(
        label: isCurrentPlan ? "Current Plan" : "Upgrade to ${selectedPlanData["name"]}",
        size: bs.md,
        onPressed: isCurrentPlan ? null : _upgradePlan,
      ),
    );
  }

  Color _getUsageColor() {
    int percentage = currentUsage["percentage"] as int;
    if (percentage >= 90) return dangerColor;
    if (percentage >= 80) return warningColor; 
    if (percentage >= 60) return primaryColor;
    return successColor;
  }

  void _showAllFeatures(Map<String, dynamic> plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${plan["name"]} Features"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...(plan["features"] as List).map((feature) => Padding(
              padding: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: successColor,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "$feature",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showPlanComparison() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Plan Comparison",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: plans.map((plan) => _buildComparisonCard(plan)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonCard(Map<String, dynamic> plan) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${plan["name"]}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: plan["color"] as Color,
            ),
          ),
          Text(
            (plan["price"] as double) == 0 ? "Free" : "\$${((plan["price"] as double)).toStringAsFixed(2)}/month",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...(plan["features"] as List).map((feature) => Padding(
            padding: EdgeInsets.only(bottom: spXs),
            child: Row(
              children: [
                Icon(Icons.check, size: 16, color: successColor),
                SizedBox(width: spXs),
                Expanded(child: Text("$feature", style: TextStyle(fontSize: 12))),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  void _upgradePlan() async {
    bool isConfirmed = await confirm("Are you sure you want to upgrade your plan?");
    if (isConfirmed) {
      showLoading();
      
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Plan upgraded successfully!");
      });
    }
  }
}
