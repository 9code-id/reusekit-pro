import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CshTrendAnalysisView extends StatefulWidget {
  const CshTrendAnalysisView({super.key});

  @override
  State<CshTrendAnalysisView> createState() => _CshTrendAnalysisViewState();
}

class _CshTrendAnalysisViewState extends State<CshTrendAnalysisView> {
  String selectedMetric = "Ticket Volume";
  String selectedPeriod = "Last 30 Days";
  String selectedComparison = "Previous Period";
  
  List<Map<String, dynamic>> metrics = [
    {"label": "Ticket Volume", "value": "Ticket Volume"},
    {"label": "Response Time", "value": "Response Time"},
    {"label": "Resolution Rate", "value": "Resolution Rate"},
    {"label": "Customer Satisfaction", "value": "Customer Satisfaction"},
    {"label": "Agent Performance", "value": "Agent Performance"},
    {"label": "Channel Usage", "value": "Channel Usage"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "Last Year", "value": "Last Year"},
  ];

  List<Map<String, dynamic>> comparisons = [
    {"label": "Previous Period", "value": "Previous Period"},
    {"label": "Same Period Last Year", "value": "Same Period Last Year"},
    {"label": "Industry Average", "value": "Industry Average"},
    {"label": "Target Goals", "value": "Target Goals"},
  ];

  List<Map<String, dynamic>> trendMetrics = [
    {
      "title": "Ticket Volume Trend",
      "current": 1247,
      "previous": 1156,
      "percentage": 7.9,
      "icon": Icons.trending_up,
      "color": primaryColor,
      "description": "Total support tickets received"
    },
    {
      "title": "Average Response Time",
      "current": 145.5,
      "previous": 168.2,
      "percentage": -13.5,
      "icon": Icons.timer,
      "color": successColor,
      "description": "Minutes to first response",
      "unit": "min"
    },
    {
      "title": "Resolution Rate",
      "current": 94.2,
      "previous": 91.8,
      "percentage": 2.6,
      "icon": Icons.check_circle,
      "color": successColor,
      "description": "Percentage of resolved tickets",
      "unit": "%"
    },
    {
      "title": "Customer Satisfaction",
      "current": 4.6,
      "previous": 4.4,
      "percentage": 4.5,
      "icon": Icons.star,
      "color": warningColor,
      "description": "Average satisfaction rating",
      "unit": "/5"
    },
  ];

  List<Map<String, dynamic>> weeklyTrends = [
    {"day": "Mon", "tickets": 178, "satisfaction": 4.5, "responseTime": 142},
    {"day": "Tue", "tickets": 165, "satisfaction": 4.7, "responseTime": 138},
    {"day": "Wed", "tickets": 192, "satisfaction": 4.6, "responseTime": 156},
    {"day": "Thu", "tickets": 158, "satisfaction": 4.8, "responseTime": 134},
    {"day": "Fri", "tickets": 201, "satisfaction": 4.4, "responseTime": 167},
    {"day": "Sat", "tickets": 87, "satisfaction": 4.9, "responseTime": 89},
    {"day": "Sun", "tickets": 76, "satisfaction": 4.8, "responseTime": 92},
  ];

  List<Map<String, dynamic>> categoryTrends = [
    {
      "category": "Technical Issues",
      "current": 456,
      "previous": 423,
      "trend": "increasing",
      "percentage": 7.8,
      "priority": "High"
    },
    {
      "category": "Billing Questions",
      "current": 287,
      "previous": 312,
      "trend": "decreasing",
      "percentage": -8.0,
      "priority": "Medium"
    },
    {
      "category": "Feature Requests",
      "current": 198,
      "previous": 165,
      "trend": "increasing",
      "percentage": 20.0,
      "priority": "Low"
    },
    {
      "category": "Account Management",
      "current": 156,
      "previous": 178,
      "trend": "decreasing",
      "percentage": -12.4,
      "priority": "Medium"
    },
    {
      "category": "Product Information",
      "current": 150,
      "previous": 78,
      "trend": "increasing",
      "percentage": 92.3,
      "priority": "High"
    },
  ];

  List<Map<String, dynamic>> predictions = [
    {
      "metric": "Ticket Volume",
      "prediction": "Expect 15% increase",
      "confidence": 87.5,
      "timeframe": "Next 30 days",
      "reason": "Seasonal pattern + new product launch"
    },
    {
      "metric": "Response Time",
      "prediction": "Slight improvement",
      "confidence": 72.3,
      "timeframe": "Next 2 weeks",
      "reason": "Recent agent training completion"
    },
    {
      "metric": "Customer Satisfaction",
      "prediction": "Maintain current level",
      "confidence": 91.2,
      "timeframe": "Next month",
      "reason": "Stable service quality indicators"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trend Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_graph),
            onPressed: () {
              ss("Advanced analytics opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Trend report exported");
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
            // Analysis Configuration
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
                    "Analysis Configuration",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Metric to Analyze",
                    items: metrics,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Time Period",
                          items: periods,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Compare To",
                          items: comparisons,
                          value: selectedComparison,
                          onChanged: (value, label) {
                            selectedComparison = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Trend Metrics Overview
            Text(
              "Trend Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: trendMetrics.map((metric) {
                bool isPositive = (metric["percentage"] as double) >= 0;
                bool isImprovement = 
                    (metric["title"] == "Average Response Time" && !isPositive) ||
                    (metric["title"] != "Average Response Time" && isPositive);

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
                              color: isImprovement
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              spacing: 4,
                              children: [
                                Icon(
                                  isImprovement ? Icons.trending_up : Icons.trending_down,
                                  size: 12,
                                  color: isImprovement ? successColor : dangerColor,
                                ),
                                Text(
                                  "${(metric["percentage"] as double).abs().toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isImprovement ? successColor : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${metric["current"]}${metric["unit"] ?? ""}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${metric["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Previous: ${metric["previous"]}${metric["unit"] ?? ""}",
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
            ),

            // Weekly Trend Chart
            Text(
              "Weekly Performance Trend",
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
                children: [
                  Row(
                    children: [
                      Text(
                        "Daily Ticket Volume",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "This Week",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: weeklyTrends.map((day) {
                        double maxTickets = weeklyTrends
                            .map((d) => d["tickets"] as int)
                            .reduce((a, b) => a > b ? a : b)
                            .toDouble();
                        double height = ((day["tickets"] as int) / maxTickets) * 160;

                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: height,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${day["day"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${day["tickets"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Category Trends
            Text(
              "Category Trends",
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
                children: categoryTrends.map((category) {
                  int index = categoryTrends.indexOf(category);
                  bool isIncreasing = category["trend"] == "increasing";
                  Color priorityColor = category["priority"] == "High"
                      ? dangerColor
                      : category["priority"] == "Medium"
                          ? warningColor
                          : successColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: index < categoryTrends.length - 1
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
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${category["category"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: priorityColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${category["priority"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: priorityColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Current: ${category["current"]} | Previous: ${category["previous"]}",
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
                            Row(
                              spacing: 4,
                              children: [
                                Icon(
                                  isIncreasing ? Icons.trending_up : Icons.trending_down,
                                  size: 16,
                                  color: isIncreasing ? dangerColor : successColor,
                                ),
                                Text(
                                  "${(category["percentage"] as double).abs().toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isIncreasing ? dangerColor : successColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${category["trend"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: isIncreasing ? dangerColor : successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Predictions & Forecasts
            Text(
              "Predictions & Forecasts",
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
                children: predictions.map((prediction) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.psychology,
                              size: 20,
                              color: infoColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${prediction["metric"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
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
                                "${(prediction["confidence"] as double).toStringAsFixed(1)}% confidence",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${prediction["prediction"]} (${prediction["timeframe"]})",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Reason: ${prediction["reason"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Advanced Analytics",
                    icon: Icons.analytics,
                    size: bs.md,
                    onPressed: () {
                      ss("Advanced analytics opened");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Export Trends",
                    icon: Icons.download,
                    size: bs.md,
                    onPressed: () {
                      ss("Trend analysis exported");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
