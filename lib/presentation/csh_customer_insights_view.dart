import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CshCustomerInsightsView extends StatefulWidget {
  const CshCustomerInsightsView({super.key});

  @override
  State<CshCustomerInsightsView> createState() => _CshCustomerInsightsViewState();
}

class _CshCustomerInsightsViewState extends State<CshCustomerInsightsView> {
  String selectedSegment = "All Customers";
  String selectedTimeframe = "Last 30 Days";
  
  List<Map<String, dynamic>> customerSegments = [
    {"label": "All Customers", "value": "All Customers"},
    {"label": "Premium Customers", "value": "Premium Customers"},
    {"label": "Regular Customers", "value": "Regular Customers"},
    {"label": "New Customers", "value": "New Customers"},
    {"label": "At-Risk Customers", "value": "At-Risk Customers"},
    {"label": "Churned Customers", "value": "Churned Customers"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "Last Year", "value": "Last Year"},
  ];

  List<Map<String, dynamic>> insightMetrics = [
    {
      "title": "Total Customers",
      "value": "12,847",
      "change": 8.2,
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "title": "Active Customers",
      "value": "9,654",
      "change": 5.7,
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "Customer Satisfaction",
      "value": "4.6/5.0",
      "change": 0.3,
      "icon": Icons.sentiment_very_satisfied,
      "color": warningColor,
    },
    {
      "title": "Retention Rate",
      "value": "87.3%",
      "change": -2.1,
      "icon": Icons.repeat,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> customerBehavior = [
    {
      "behavior": "Frequent Support Requests",
      "percentage": 32.5,
      "count": 4187,
      "trend": "increasing",
      "color": dangerColor,
    },
    {
      "behavior": "High Engagement",
      "percentage": 28.7,
      "count": 3687,
      "trend": "stable",
      "color": successColor,
    },
    {
      "behavior": "Price Sensitive",
      "percentage": 24.3,
      "count": 3122,
      "trend": "decreasing",
      "color": warningColor,
    },
    {
      "behavior": "Feature Adoption",
      "percentage": 19.8,
      "count": 2544,
      "trend": "increasing",
      "color": infoColor,
    },
    {
      "behavior": "Low Activity",
      "percentage": 15.2,
      "count": 1953,
      "trend": "stable",
      "color": disabledBoldColor,
    },
  ];

  List<Map<String, dynamic>> topIssues = [
    {
      "issue": "Login Problems",
      "frequency": 156,
      "impact": "High",
      "resolution": 94.2,
      "avgTime": "4h 23m",
    },
    {
      "issue": "Payment Processing",
      "frequency": 142,
      "impact": "Critical",
      "resolution": 98.6,
      "avgTime": "2h 15m",
    },
    {
      "issue": "Feature Request",
      "frequency": 98,
      "impact": "Medium",
      "resolution": 76.5,
      "avgTime": "1d 6h",
    },
    {
      "issue": "Account Settings",
      "frequency": 87,
      "impact": "Low",
      "resolution": 89.7,
      "avgTime": "3h 45m",
    },
    {
      "issue": "Performance Issues",
      "frequency": 73,
      "impact": "High",
      "resolution": 92.4,
      "avgTime": "5h 12m",
    },
  ];

  List<Map<String, dynamic>> customerJourney = [
    {
      "stage": "Discovery",
      "customers": 2847,
      "conversionRate": 45.2,
      "avgTime": "2.3 days",
    },
    {
      "stage": "Trial",
      "customers": 1287,
      "conversionRate": 68.9,
      "avgTime": "14 days",
    },
    {
      "stage": "Purchase",
      "customers": 887,
      "conversionRate": 89.2,
      "avgTime": "3.1 days",
    },
    {
      "stage": "Onboarding",
      "customers": 791,
      "conversionRate": 78.4,
      "avgTime": "7 days",
    },
    {
      "stage": "Active Use",
      "customers": 620,
      "conversionRate": 94.1,
      "avgTime": "30 days",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Insights"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Insights refreshed");
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Insights exported");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Analysis Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Customer Segment",
                          items: customerSegments,
                          value: selectedSegment,
                          onChanged: (value, label) {
                            selectedSegment = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Timeframe",
                          items: timeframes,
                          value: selectedTimeframe,
                          onChanged: (value, label) {
                            selectedTimeframe = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Key Metrics
            Text(
              "Key Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: insightMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              size: 20,
                              color: metric["color"] as Color,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (metric["change"] as double) >= 0
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (metric["change"] as double) >= 0
                                    ? successColor
                                    : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Customer Behavior Analysis
            Text(
              "Customer Behavior Patterns",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: customerBehavior.map((behavior) {
                  return Column(
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
                                      "${behavior["behavior"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      behavior["trend"] == "increasing"
                                          ? Icons.trending_up
                                          : behavior["trend"] == "decreasing"
                                              ? Icons.trending_down
                                              : Icons.trending_flat,
                                      size: 16,
                                      color: behavior["trend"] == "increasing"
                                          ? successColor
                                          : behavior["trend"] == "decreasing"
                                              ? dangerColor
                                              : disabledBoldColor,
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${(behavior["percentage"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: behavior["color"] as Color,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "(${behavior["count"]} customers)",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: (behavior["percentage"] as double) / 100,
                        backgroundColor: disabledOutlineBorderColor,
                        valueColor: AlwaysStoppedAnimation(
                          behavior["color"] as Color,
                        ),
                      ),
                      if (customerBehavior.indexOf(behavior) <
                          customerBehavior.length - 1)
                        SizedBox(height: spSm),
                    ],
                  );
                }).toList(),
              ),
            ),

            // Top Customer Issues
            Text(
              "Top Customer Issues",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusSm),
                        topRight: Radius.circular(radiusSm),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Issue",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Frequency",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Impact",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Resolution",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...topIssues.map((issue) {
                    int index = topIssues.indexOf(issue);
                    Color impactColor = issue["impact"] == "Critical"
                        ? dangerColor
                        : issue["impact"] == "High"
                            ? warningColor
                            : issue["impact"] == "Medium"
                                ? infoColor
                                : successColor;

                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: index < topIssues.length - 1
                              ? BorderSide(
                                  color: disabledOutlineBorderColor,
                                  width: 1,
                                )
                              : BorderSide.none,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${issue["issue"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Avg: ${issue["avgTime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${issue["frequency"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: impactColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${issue["impact"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: impactColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${(issue["resolution"] as double).toStringAsFixed(1)}%",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: (issue["resolution"] as double) >= 90
                                    ? successColor
                                    : (issue["resolution"] as double) >= 75
                                        ? warningColor
                                        : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Customer Journey Analysis
            Text(
              "Customer Journey Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: customerJourney.map((stage) {
                  int index = customerJourney.indexOf(stage);
                  return Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
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
                                  "${stage["stage"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${stage["customers"]} customers",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "Conversion: ${(stage["conversionRate"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Avg Time: ${stage["avgTime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            LinearProgressIndicator(
                              value: (stage["conversionRate"] as double) / 100,
                              backgroundColor: disabledOutlineBorderColor,
                              valueColor: AlwaysStoppedAnimation(successColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
