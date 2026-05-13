import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaFinancialInsightsView extends StatefulWidget {
  const BfaFinancialInsightsView({super.key});

  @override
  State<BfaFinancialInsightsView> createState() => _BfaFinancialInsightsViewState();
}

class _BfaFinancialInsightsViewState extends State<BfaFinancialInsightsView> {
  String selectedPeriod = "This Month";
  
  List<Map<String, dynamic>> timeframes = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> insights = [
    {
      "id": 1,
      "type": "spending_alert",
      "title": "Dining Out Spending Increased",
      "description": "You've spent 23% more on dining out this month compared to last month.",
      "amount": 485.50,
      "change": 23.5,
      "category": "Food & Dining",
      "icon": Icons.restaurant,
      "color": warningColor,
      "priority": "Medium",
      "actionable": true,
      "action": "Review dining budget",
    },
    {
      "id": 2,
      "type": "savings_opportunity",
      "title": "Subscription Optimization",
      "description": "You have 3 unused subscriptions that could save you \$45/month.",
      "amount": 45.0,
      "change": 0.0,
      "category": "Entertainment",
      "icon": Icons.subscriptions,
      "color": successColor,
      "priority": "High",
      "actionable": true,
      "action": "Manage subscriptions",
    },
    {
      "id": 3,
      "type": "positive_trend",
      "title": "Savings Goal Progress",
      "description": "You're 15% ahead of your emergency fund savings target this month.",
      "amount": 750.0,
      "change": 15.0,
      "category": "Savings",
      "icon": Icons.trending_up,
      "color": successColor,
      "priority": "Low",
      "actionable": false,
      "action": "",
    },
    {
      "id": 4,
      "type": "budget_alert",
      "title": "Transportation Budget Exceeded",
      "description": "You've exceeded your transportation budget by \$125 this month.",
      "amount": 125.0,
      "change": -12.5,
      "category": "Transportation",
      "icon": Icons.directions_car,
      "color": dangerColor,
      "priority": "High",
      "actionable": true,
      "action": "Adjust transportation budget",
    },
    {
      "id": 5,
      "type": "income_insight",
      "title": "Steady Income Growth",
      "description": "Your income has grown by 8% compared to the same period last year.",
      "amount": 1200.0,
      "change": 8.0,
      "category": "Income",
      "icon": Icons.trending_up,
      "color": primaryColor,
      "priority": "Low",
      "actionable": false,
      "action": "",
    },
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "id": 1,
      "title": "Increase Emergency Fund",
      "description": "Consider boosting your emergency fund contribution by \$200/month to reach your 6-month goal faster.",
      "impact": "High",
      "effort": "Medium",
      "savings": 200.0,
      "timeframe": "6 months",
      "icon": Icons.security,
      "color": primaryColor,
    },
    {
      "id": 2,
      "title": "Switch to High-Yield Savings",
      "description": "Moving your savings to a high-yield account could earn you an extra \$150/year in interest.",
      "impact": "Medium",
      "effort": "Low",
      "savings": 150.0,
      "timeframe": "1 year",
      "icon": Icons.savings,
      "color": successColor,
    },
    {
      "id": 3,
      "title": "Optimize Credit Card Usage",
      "description": "Using your cashback card for recurring expenses could earn you \$75 more per month.",
      "impact": "Medium",
      "effort": "Low",
      "savings": 75.0,
      "timeframe": "1 month",
      "icon": Icons.credit_card,
      "color": infoColor,
    },
  ];

  Map<String, dynamic> monthlyTrends = {
    "income": 5250.0,
    "expenses": 3875.0,
    "savings": 1375.0,
    "income_change": 5.2,
    "expenses_change": -2.8,
    "savings_change": 12.4,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Insights"),
        actions: [
          IconButton(
            onPressed: () {
              // Refresh insights
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            QDropdownField(
              label: "Time Period",
              items: timeframes,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),

            // Key Metrics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Monthly Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          "Income",
                          "\$${(monthlyTrends["income"] as double).currency}",
                          monthlyTrends["income_change"] as double,
                          successColor,
                          Icons.trending_up,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildMetricCard(
                          "Expenses",
                          "\$${(monthlyTrends["expenses"] as double).currency}",
                          monthlyTrends["expenses_change"] as double,
                          dangerColor,
                          Icons.trending_down,
                        ),
                      ),
                    ],
                  ),
                  _buildMetricCard(
                    "Net Savings",
                    "\$${(monthlyTrends["savings"] as double).currency}",
                    monthlyTrends["savings_change"] as double,
                    primaryColor,
                    Icons.savings,
                  ),
                ],
              ),
            ),

            // Insights Section
            Text(
              "Key Insights",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              spacing: spSm,
              children: insights.map((insight) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: insight["color"] as Color,
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (insight["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              insight["icon"] as IconData,
                              color: insight["color"] as Color,
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
                                    Expanded(
                                      child: Text(
                                        "${insight["title"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getPriorityColor(insight["priority"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${insight["priority"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: _getPriorityColor(insight["priority"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${insight["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if ((insight["change"] as double) != 0.0) ...[
                            Text(
                              "${(insight["change"] as double) >= 0 ? '+' : ''}${(insight["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: (insight["change"] as double) >= 0 ? successColor : dangerColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                      
                      Text(
                        "${insight["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      if (insight["actionable"] as bool) ...[
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "${insight["action"]}",
                            icon: Icons.arrow_forward,
                            size: bs.sm,
                            onPressed: () {
                              // Handle action
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recommendations Section
            Text(
              "Recommendations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              spacing: spSm,
              children: recommendations.map((rec) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (rec["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              rec["icon"] as IconData,
                              color: rec["color"] as Color,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${rec["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "\$${(rec["savings"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "${rec["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  "Impact: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${rec["impact"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getImpactColor(rec["impact"]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Effort: ",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${rec["effort"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getEffortColor(rec["effort"]),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${rec["timeframe"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Apply Recommendation",
                          icon: Icons.check_circle,
                          size: bs.sm,
                          onPressed: () {
                            // Apply recommendation
                          },
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
    );
  }

  Widget _buildMetricCard(String title, String amount, double change, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Row(
            children: [
              Icon(
                change >= 0 ? Icons.trending_up : Icons.trending_down,
                size: 12,
                color: change >= 0 ? successColor : dangerColor,
              ),
              SizedBox(width: spXxs),
              Text(
                "${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: change >= 0 ? successColor : dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case "High":
        return successColor;
      case "Medium":
        return warningColor;
      case "Low":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getEffortColor(String effort) {
    switch (effort) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "High":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
