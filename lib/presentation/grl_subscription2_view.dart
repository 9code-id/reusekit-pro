import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSubscription2View extends StatefulWidget {
  @override
  State<GrlSubscription2View> createState() => _GrlSubscription2ViewState();
}

class _GrlSubscription2ViewState extends State<GrlSubscription2View> {
  Map<String, dynamic> currentSubscription = {
    "plan": "Pro",
    "price": 29.99,
    "period": "month",
    "nextBilling": "2025-07-22",
    "status": "active",
    "startDate": "2024-12-22",
    "autoRenew": true,
  };

  List<Map<String, dynamic>> billingHistory = [
    {
      "date": "2025-06-22",
      "amount": 29.99,
      "status": "paid",
      "invoice": "INV-2025-06-001",
      "plan": "Pro Monthly",
    },
    {
      "date": "2025-05-22",
      "amount": 29.99,
      "status": "paid",
      "invoice": "INV-2025-05-001",
      "plan": "Pro Monthly",
    },
    {
      "date": "2025-04-22",
      "amount": 29.99,
      "status": "paid",
      "invoice": "INV-2025-04-001",
      "plan": "Pro Monthly",
    },
    {
      "date": "2025-03-22",
      "amount": 19.99,
      "status": "paid",
      "invoice": "INV-2025-03-001",
      "plan": "Basic Monthly",
    },
  ];

  List<Map<String, dynamic>> availableAddons = [
    {
      "name": "Extra Storage",
      "description": "Additional 100GB cloud storage",
      "price": 9.99,
      "period": "month",
      "enabled": false,
    },
    {
      "name": "Priority Support",
      "description": "24/7 phone and chat support",
      "price": 14.99,
      "period": "month",
      "enabled": true,
    },
    {
      "name": "Advanced Analytics",
      "description": "Detailed reports and insights",
      "price": 19.99,
      "period": "month",
      "enabled": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscription Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.receipt),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCurrentPlan(),
            _buildQuickActions(),
            _buildAddons(),
            _buildBillingHistory(),
            _buildUsageStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPlan() {
    final nextBillingDate = DateTime.parse(currentSubscription["nextBilling"]);
    final daysUntilBilling = nextBillingDate.difference(DateTime.now()).inDays;
    
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.workspace_premium,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${currentSubscription["plan"]} Plan",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Active since ${DateTime.parse(currentSubscription["startDate"]).dMMMy}",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${(currentSubscription["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "per ${currentSubscription["period"]}",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Next billing in",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "$daysUntilBilling days",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                currentSubscription["autoRenew"] as bool ? Icons.autorenew : Icons.pause_circle,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                currentSubscription["autoRenew"] as bool ? "Auto-renewal enabled" : "Auto-renewal disabled",
                style: TextStyle(
                  color: Colors.white.withAlpha(200),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: Container(
            child: QButton(
              label: "Change Plan",
              size: bs.sm,
              onPressed: () {
                si("Redirecting to plan selection");
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: QButton(
              label: "Billing Details",
              size: bs.sm,
              onPressed: () {
                si("Opening billing information");
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddons() {
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
          Text(
            "Add-ons & Extensions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: availableAddons.map((addon) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (addon["enabled"] as bool) ? primaryColor.withAlpha(10) : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: (addon["enabled"] as bool) ? primaryColor : disabledOutlineBorderColor,
                    width: (addon["enabled"] as bool) ? 2 : 1,
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${addon["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: (addon["enabled"] as bool) ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${addon["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${(addon["price"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: (addon["enabled"] as bool) ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            Text(
                              "/${addon["period"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (addon["enabled"] as bool)
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
                        Spacer(),
                        QButton(
                          label: (addon["enabled"] as bool) ? "Remove" : "Add",
                          size: bs.sm,
                          onPressed: () {
                            addon["enabled"] = !(addon["enabled"] as bool);
                            setState(() {});
                            if (addon["enabled"] as bool) {
                              ss("${addon["name"]} added successfully");
                            } else {
                              si("${addon["name"]} removed");
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingHistory() {
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
                "Billing History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: billingHistory.take(3).map((bill) {
              final billDate = DateTime.parse(bill["date"]);
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.receipt_long,
                        color: successColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${bill["plan"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${billDate.dMMMy} • ${bill["invoice"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${(bill["amount"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "PAID",
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.download,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageStats() {
    List<Map<String, dynamic>> usageData = [
      {
        "title": "Storage Used",
        "value": "45.2 GB",
        "total": "100 GB",
        "percentage": 45.2,
        "color": primaryColor,
      },
      {
        "title": "API Calls",
        "value": "8,347",
        "total": "50,000",
        "percentage": 16.7,
        "color": successColor,
      },
      {
        "title": "Team Members",
        "value": "12",
        "total": "25",
        "percentage": 48.0,
        "color": warningColor,
      },
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
          Text(
            "Usage Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spMd,
            children: usageData.map((usage) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Text(
                        "${usage["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${usage["value"]} / ${usage["total"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (usage["percentage"] as double) / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: usage["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
