import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmPricingTiersView extends StatefulWidget {
  const EcmPricingTiersView({super.key});

  @override
  State<EcmPricingTiersView> createState() => _EcmPricingTiersViewState();
}

class _EcmPricingTiersViewState extends State<EcmPricingTiersView> {
  bool isLoading = false;
  String selectedTier = "standard";

  List<Map<String, dynamic>> pricingTiers = [
    {
      "id": 1,
      "name": "Basic Package",
      "description": "Essential features for small events",
      "price": 299.0,
      "billing_cycle": "monthly",
      "max_attendees": 100,
      "max_events": 5,
      "features": [
        "Event registration",
        "Basic ticketing",
        "Email notifications",
        "Attendee management",
        "Basic reporting"
      ],
      "status": "active",
      "popularity": 25,
      "color": "#4CAF50",
      "recommended": false
    },
    {
      "id": 2,
      "name": "Professional Package",
      "description": "Advanced features for growing businesses",
      "price": 599.0,
      "billing_cycle": "monthly",
      "max_attendees": 500,
      "max_events": 20,
      "features": [
        "Everything in Basic",
        "Advanced ticketing",
        "Payment processing",
        "Custom branding",
        "Analytics dashboard",
        "API access",
        "Priority support"
      ],
      "status": "active",
      "popularity": 45,
      "color": "#2196F3",
      "recommended": true
    },
    {
      "id": 3,
      "name": "Enterprise Package",
      "description": "Complete solution for large organizations",
      "price": 1299.0,
      "billing_cycle": "monthly",
      "max_attendees": 2000,
      "max_events": 100,
      "features": [
        "Everything in Professional",
        "White-label solution",
        "Advanced integrations",
        "Dedicated account manager",
        "24/7 phone support",
        "Custom development",
        "SLA guarantee"
      ],
      "status": "active",
      "popularity": 20,
      "color": "#FF9800",
      "recommended": false
    },
    {
      "id": 4,
      "name": "Starter Package",
      "description": "Perfect for testing and small events",
      "price": 99.0,
      "billing_cycle": "monthly",
      "max_attendees": 50,
      "max_events": 2,
      "features": [
        "Basic event creation",
        "Simple registration",
        "Email reminders",
        "Basic support"
      ],
      "status": "active",
      "popularity": 10,
      "color": "#9C27B0",
      "recommended": false
    }
  ];

  List<Map<String, dynamic>> tierComparison = [
    {
      "feature": "Max Attendees",
      "starter": "50",
      "basic": "100",
      "professional": "500",
      "enterprise": "2,000"
    },
    {
      "feature": "Max Events",
      "starter": "2",
      "basic": "5",
      "professional": "20",
      "enterprise": "100"
    },
    {
      "feature": "Payment Processing",
      "starter": "No",
      "basic": "No",
      "professional": "Yes",
      "enterprise": "Yes"
    },
    {
      "feature": "Custom Branding",
      "starter": "No",
      "basic": "No",
      "professional": "Yes",
      "enterprise": "Yes"
    },
    {
      "feature": "API Access",
      "starter": "No",
      "basic": "No",
      "professional": "Yes",
      "enterprise": "Yes"
    },
    {
      "feature": "Phone Support",
      "starter": "No",
      "basic": "No",
      "professional": "No",
      "enterprise": "24/7"
    }
  ];

  Widget _buildPricingCard(Map<String, dynamic> tier) {
    Color tierColor = Color(int.parse(tier["color"].toString().replaceAll("#", "0xFF")));
    bool isRecommended = tier["recommended"] ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isRecommended 
            ? Border.all(color: tierColor, width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRecommended)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: spXs),
              decoration: BoxDecoration(
                color: tierColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
              ),
              child: Text(
                "MOST POPULAR",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: tierColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        _getTierIcon(tier["name"]),
                        color: tierColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${tier["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${tier["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${tier["popularity"]}% users",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${((tier["price"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: tierColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "/${tier["billing_cycle"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people, color: primaryColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "${tier["max_attendees"]} attendees",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event, color: infoColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "${tier["max_events"]} events",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Features included:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(tier["features"] as List).map<Widget>((feature) {
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
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: isRecommended ? "Choose Plan" : "Select Plan",
                        size: bs.sm,
                        onPressed: () => _selectPlan(tier),
                      ),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.info,
                      size: bs.sm,
                      onPressed: () => _viewPlanDetails(tier),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(26),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            ),
            child: Row(
              children: [
                Icon(Icons.compare_arrows, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Feature Comparison",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    "Feature",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Starter",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Basic",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Professional",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Enterprise",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
              rows: tierComparison.map<DataRow>((comparison) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        "${comparison["feature"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    DataCell(
                      _buildComparisonCell(comparison["starter"]),
                    ),
                    DataCell(
                      _buildComparisonCell(comparison["basic"]),
                    ),
                    DataCell(
                      _buildComparisonCell(comparison["professional"]),
                    ),
                    DataCell(
                      _buildComparisonCell(comparison["enterprise"]),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCell(String value) {
    bool isYes = value.toLowerCase() == "yes" || value.contains("24/7");
    bool isNo = value.toLowerCase() == "no";
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
      decoration: BoxDecoration(
        color: isYes 
            ? successColor.withAlpha(26)
            : isNo 
                ? dangerColor.withAlpha(26)
                : primaryColor.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isYes 
              ? successColor
              : isNo 
                  ? dangerColor
                  : primaryColor,
        ),
      ),
    );
  }

  Widget _buildPricingCalculator() {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Icon(Icons.calculate, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Pricing Calculator",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Estimate your monthly costs based on your event requirements",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Number of Events",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Up to 20 events",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Expected Attendees",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "500 total attendees",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.recommend, color: successColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recommended Plan: Professional Package",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Perfect fit for your requirements",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTierIcon(String tierName) {
    if (tierName.contains("Starter")) return Icons.rocket_launch;
    if (tierName.contains("Basic")) return Icons.business;
    if (tierName.contains("Professional")) return Icons.star;
    if (tierName.contains("Enterprise")) return Icons.corporate_fare;
    return Icons.local_activity;
  }

  void _selectPlan(Map<String, dynamic> tier) {
    // Navigate to plan selection/payment
  }

  void _viewPlanDetails(Map<String, dynamic> tier) {
    // Show detailed plan information
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pricing Tiers"),
        actions: [
          QButton(
            icon: Icons.help,
            size: bs.sm,
            onPressed: () {
              // Show pricing help
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose the perfect plan for your events",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Scale your event management with flexible pricing options",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            _buildPricingCalculator(),
            SizedBox(height: spSm),
            Text(
              "Available Plans",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else
              ...pricingTiers.map((tier) => _buildPricingCard(tier)).toList(),
            SizedBox(height: spSm),
            _buildComparisonTable(),
          ],
        ),
      ),
    );
  }
}
