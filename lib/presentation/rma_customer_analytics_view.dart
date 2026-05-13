import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaCustomerAnalyticsView extends StatefulWidget {
  const RmaCustomerAnalyticsView({super.key});

  @override
  State<RmaCustomerAnalyticsView> createState() => _RmaCustomerAnalyticsViewState();
}

class _RmaCustomerAnalyticsViewState extends State<RmaCustomerAnalyticsView> {
  int selectedPeriod = 0;
  String selectedMetric = "all";
  bool loading = false;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "7 Days", "value": 7},
    {"label": "30 Days", "value": 30},
    {"label": "90 Days", "value": 90},
    {"label": "1 Year", "value": 365},
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "All Metrics", "value": "all"},
    {"label": "Acquisition", "value": "acquisition"},
    {"label": "Retention", "value": "retention"},
    {"label": "Revenue", "value": "revenue"},
  ];

  List<Map<String, dynamic>> customerSegments = [
    {
      "name": "Premium Customers",
      "count": 1248,
      "percentage": 12.3,
      "revenue": 245000.0,
      "growth": 8.4,
      "color": Colors.amber,
    },
    {
      "name": "Regular Customers",
      "count": 5624,
      "percentage": 55.7,
      "revenue": 189000.0,
      "growth": 4.2,
      "color": Colors.blue,
    },
    {
      "name": "New Customers",
      "count": 2847,
      "percentage": 28.2,
      "revenue": 98000.0,
      "growth": 15.8,
      "color": Colors.green,
    },
    {
      "name": "At-Risk Customers",
      "count": 389,
      "percentage": 3.8,
      "revenue": 23000.0,
      "growth": -2.1,
      "color": Colors.red,
    },
  ];

  List<Map<String, dynamic>> analyticsData = [
    {
      "title": "Total Customers",
      "value": "10,108",
      "change": "+12.4%",
      "positive": true,
      "icon": Icons.people,
    },
    {
      "title": "Customer Lifetime Value",
      "value": "\$4,250",
      "change": "+8.7%",
      "positive": true,
      "icon": Icons.trending_up,
    },
    {
      "title": "Churn Rate",
      "value": "2.8%",
      "change": "-0.5%",
      "positive": true,
      "icon": Icons.trending_down,
    },
    {
      "title": "Acquisition Cost",
      "value": "\$124",
      "change": "-3.2%",
      "positive": true,
      "icon": Icons.campaign,
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "customer": "Sarah Wilson",
      "action": "Upgraded to Premium",
      "value": "\$299",
      "time": "2 hours ago",
      "type": "upgrade",
    },
    {
      "customer": "Michael Chen",
      "action": "New Purchase",
      "value": "\$89",
      "time": "4 hours ago",
      "type": "purchase",
    },
    {
      "customer": "Emma Davis",
      "action": "Support Ticket Created",
      "value": "Priority: High",
      "time": "6 hours ago",
      "type": "support",
    },
    {
      "customer": "John Martinez",
      "action": "Account Cancellation",
      "value": "Reason: Price",
      "time": "8 hours ago",
      "type": "cancellation",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                loading = true;
              });
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                  loading = false;
                });
                ss("Analytics data refreshed");
              });
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilters(),
                  _buildAnalyticsCards(),
                  _buildCustomerSegments(),
                  _buildRecentActivities(),
                ],
              ),
            ),
    );
  }

  Widget _buildFilters() {
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
              Icon(Icons.filter_list, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Analytics Filters",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: periodOptions,
                  value: (periodOptions[selectedPeriod]["value"] as int),
                  onChanged: (value, label) {
                    selectedPeriod = periodOptions.indexWhere((item) => item["value"] == value);
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Metric Focus",
                  items: metricOptions,
                  value: selectedMetric,
                  onChanged: (value, label) {
                    selectedMetric = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: analyticsData.map((data) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
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
                      color: primaryColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      data["icon"] as IconData,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: (data["positive"] as bool) ? successColor.withAlpha(51) : dangerColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${data["change"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: (data["positive"] as bool) ? successColor : dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "${data["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${data["value"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCustomerSegments() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pie_chart, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Customer Segments",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.fullscreen,
                size: bs.sm,
                onPressed: () {
                  si("Opening detailed segment analysis");
                },
              ),
            ],
          ),
          ...customerSegments.map((segment) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: (segment["color"] as Color).withAlpha(26),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: segment["color"] as Color,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${segment["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(segment["count"] as int)} customers",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
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
                          "${((segment["revenue"] as double).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (segment["growth"] as double) > 0 ? successColor.withAlpha(51) : dangerColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(segment["growth"] as double) > 0 ? '+' : ''}${(segment["growth"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (segment["growth"] as double) > 0 ? successColor : dangerColor,
                            ),
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
    );
  }

  Widget _buildRecentActivities() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Recent Customer Activities",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.view_list,
                size: bs.sm,
                onPressed: () {
                  si("Opening full activity log");
                },
              ),
            ],
          ),
          ...recentActivities.map((activity) {
            IconData activityIcon;
            Color activityColor;
            
            switch (activity["type"]) {
              case "upgrade":
                activityIcon = Icons.upgrade;
                activityColor = successColor;
                break;
              case "purchase":
                activityIcon = Icons.shopping_cart;
                activityColor = primaryColor;
                break;
              case "support":
                activityIcon = Icons.support_agent;
                activityColor = warningColor;
                break;
              case "cancellation":
                activityIcon = Icons.cancel;
                activityColor = dangerColor;
                break;
              default:
                activityIcon = Icons.info;
                activityColor = infoColor;
            }

            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: activityColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: activityColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      activityIcon,
                      color: activityColor,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${activity["customer"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${activity["action"]}",
                          style: TextStyle(
                            fontSize: 13,
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
                        "${activity["value"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: activityColor,
                        ),
                      ),
                      Text(
                        "${activity["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
