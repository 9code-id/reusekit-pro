import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaSubscriptionView extends StatefulWidget {
  const GeaSubscriptionView({super.key});

  @override
  State<GeaSubscriptionView> createState() => _GeaSubscriptionViewState();
}

class _GeaSubscriptionViewState extends State<GeaSubscriptionView> {
  String selectedTab = "Plans";
  bool hasActiveSubscription = true;

  List<Map<String, dynamic>> subscriptionPlans = [
    {
      "id": "basic",
      "name": "Basic Plan",
      "price": 4.99,
      "currency": "USD",
      "duration": "month",
      "popular": false,
      "features": [
        "Access to 50+ games",
        "Basic cloud save",
        "Standard support",
        "2 device limit",
      ],
      "color": infoColor,
    },
    {
      "id": "premium",
      "name": "Premium Plan",
      "price": 9.99,
      "currency": "USD",
      "duration": "month",
      "popular": true,
      "features": [
        "Access to 200+ games",
        "Advanced cloud save",
        "Priority support",
        "5 device limit",
        "No advertisements",
        "Exclusive content",
      ],
      "color": primaryColor,
    },
    {
      "id": "ultimate",
      "name": "Ultimate Plan",
      "price": 19.99,
      "currency": "USD",
      "duration": "month",
      "popular": false,
      "features": [
        "Access to all games",
        "Premium cloud save",
        "24/7 VIP support",
        "Unlimited devices",
        "No advertisements",
        "Exclusive content",
        "Early access",
        "Beta testing",
      ],
      "color": warningColor,
    },
  ];

  Map<String, dynamic> currentSubscription = {
    "plan": "Premium Plan",
    "planId": "premium",
    "startDate": "2024-05-15",
    "endDate": "2024-06-15",
    "nextBilling": "2024-06-15",
    "price": 9.99,
    "currency": "USD",
    "autoRenew": true,
    "status": "Active",
    "daysLeft": 15,
  };

  List<Map<String, dynamic>> subscriptionHistory = [
    {
      "id": 1,
      "plan": "Premium Plan",
      "startDate": "2024-05-15",
      "endDate": "2024-06-15",
      "amount": 9.99,
      "currency": "USD",
      "status": "Active",
      "transactionId": "SUB_001234567890",
    },
    {
      "id": 2,
      "plan": "Basic Plan",
      "startDate": "2024-04-15",
      "endDate": "2024-05-15",
      "amount": 4.99,
      "currency": "USD",
      "status": "Completed",
      "transactionId": "SUB_001234567891",
    },
    {
      "id": 3,
      "plan": "Premium Plan",
      "startDate": "2024-03-15",
      "endDate": "2024-04-15",
      "amount": 9.99,
      "currency": "USD",
      "status": "Completed",
      "transactionId": "SUB_001234567892",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Completed":
        return primaryColor;
      case "Cancelled":
        return dangerColor;
      case "Expired":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscription Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.receipt_long),
            onPressed: () {
              //navigateTo('BillingHistoryView')
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "Plans";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == "Plans" ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Available Plans",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "Plans" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "Current";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == "Current" ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Current Plan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "Current" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "History";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == "History" ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "History",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "History" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: selectedTab == "Plans" 
                ? _buildPlansView()
                : selectedTab == "Current"
                    ? _buildCurrentView()
                    : _buildHistoryView(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlansView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Comparison Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.compare_arrows,
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Choose Your Plan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Upgrade or downgrade anytime",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Plans Grid
          ...subscriptionPlans.map((plan) {
            final isCurrentPlan = hasActiveSubscription && 
                plan["id"] == currentSubscription["planId"];
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: plan["popular"] == true ? warningColor : 
                         isCurrentPlan ? successColor : Colors.transparent,
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
                          "MOST POPULAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (isCurrentPlan)
                    Positioned(
                      top: -spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "CURRENT PLAN",
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
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (plan["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.star,
                              color: plan["color"] as Color,
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
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Best for ${plan["id"]} users",
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: plan["color"] as Color,
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
                      SizedBox(height: spSm),

                      // Features List
                      Text(
                        "Features included:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...(plan["features"] as List<String>).map((feature) {
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
                              Expanded(
                                child: Text(
                                  feature,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      SizedBox(height: spSm),

                      // Action Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: isCurrentPlan ? "Current Plan" : "Select Plan",
                          size: bs.sm,
                          onPressed: isCurrentPlan ? null : () {
                            //navigateTo('SubscriptionCheckoutView', arguments: plan)
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCurrentView() {
    if (!hasActiveSubscription) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 64,
              color: disabledBoldColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No Active Subscription",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Choose a plan to get started",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Browse Plans",
              size: bs.sm,
              onPressed: () {
                selectedTab = "Plans";
                setState(() {});
              },
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Current Plan Overview
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${currentSubscription["plan"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Active subscription",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(40),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${currentSubscription["daysLeft"]} days left",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Subscription Details
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
                  "Subscription Details",
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
                            "End Date",
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
                            "${currentSubscription["nextBilling"]}",
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
                            "Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(currentSubscription["price"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
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
                  "Manage Subscription",
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
                      child: QButton(
                        label: "Change Plan",
                        size: bs.sm,
                        onPressed: () {
                          selectedTab = "Plans";
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Cancel Plan",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('CancelSubscriptionView')
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: currentSubscription["autoRenew"] ? "Disable Auto-Renewal" : "Enable Auto-Renewal",
                    size: bs.sm,
                    onPressed: () {
                      currentSubscription["autoRenew"] = !currentSubscription["autoRenew"];
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
  }

  Widget _buildHistoryView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // History Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Subscriptions",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${subscriptionHistory.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Spent",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${subscriptionHistory.fold(0.0, (sum, s) => sum + (s["amount"] as double)).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // History List
          ...subscriptionHistory.map((subscription) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${subscription["plan"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(subscription["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${subscription["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: _getStatusColor(subscription["status"]),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${subscription["startDate"]} - ${subscription["endDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${(subscription["amount"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.receipt,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "ID: ${subscription["transactionId"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
