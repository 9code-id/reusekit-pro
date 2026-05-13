import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAnalytics10View extends StatefulWidget {
  @override
  State<GrlAnalytics10View> createState() => _GrlAnalytics10ViewState();
}

class _GrlAnalytics10ViewState extends State<GrlAnalytics10View> {
  int currentTab = 0;
  String selectedRegion = "all";

  List<Map<String, dynamic>> regions = [
    {"label": "All Regions", "value": "all"},
    {"label": "North America", "value": "na"},
    {"label": "Europe", "value": "eu"},
    {"label": "Asia Pacific", "value": "ap"},
    {"label": "Latin America", "value": "la"},
  ];

  List<Map<String, dynamic>> customerMetrics = [
    {
      "title": "Total Customers",
      "value": 15680,
      "change": 22.8,
      "icon": Icons.people,
      "color": Colors.blue
    },
    {
      "title": "Customer Lifetime Value",
      "value": 2450.0,
      "change": 18.5,
      "icon": Icons.account_balance_wallet,
      "color": Colors.green
    },
    {
      "title": "Churn Rate",
      "value": 5.2,
      "change": -12.3,
      "icon": Icons.trending_down,
      "color": Colors.red
    },
    {
      "title": "Net Promoter Score",
      "value": 72.0,
      "change": 8.9,
      "icon": Icons.star,
      "color": Colors.purple
    },
  ];

  List<Map<String, dynamic>> customerSegments = [
    {
      "segment": "VIP Customers",
      "count": 1250,
      "percentage": 8.0,
      "avg_order": 485.60,
      "ltv": 5200.0,
      "frequency": 8.5,
      "color": Colors.purple
    },
    {
      "segment": "Loyal Customers",
      "count": 3800,
      "percentage": 24.2,
      "avg_order": 285.40,
      "ltv": 2850.0,
      "frequency": 6.2,
      "color": Colors.blue
    },
    {
      "segment": "Regular Customers",
      "count": 6240,
      "percentage": 39.8,
      "avg_order": 165.80,
      "ltv": 1680.0,
      "frequency": 4.1,
      "color": Colors.green
    },
    {
      "segment": "New Customers",
      "count": 4390,
      "percentage": 28.0,
      "avg_order": 89.20,
      "ltv": 425.0,
      "frequency": 1.8,
      "color": Colors.orange
    },
  ];

  List<Map<String, dynamic>> topCustomers = [
    {
      "name": "James Rodriguez",
      "email": "james.r@example.com",
      "total_spent": 15680.50,
      "orders": 45,
      "last_order": "2 days ago",
      "tier": "VIP",
      "image": "https://picsum.photos/50/50?random=1&keyword=man"
    },
    {
      "name": "Sarah Mitchell",
      "email": "sarah.m@example.com",
      "total_spent": 12340.80,
      "orders": 38,
      "last_order": "1 week ago",
      "tier": "VIP",
      "image": "https://picsum.photos/50/50?random=2&keyword=woman"
    },
    {
      "name": "Michael Chen",
      "email": "michael.c@example.com",
      "total_spent": 9850.60,
      "orders": 32,
      "last_order": "3 days ago",
      "tier": "Loyal",
      "image": "https://picsum.photos/50/50?random=3&keyword=man"
    },
    {
      "name": "Emily Johnson",
      "email": "emily.j@example.com",
      "total_spent": 8920.40,
      "orders": 28,
      "last_order": "5 days ago",
      "tier": "Loyal",
      "image": "https://picsum.photos/50/50?random=4&keyword=woman"
    },
    {
      "name": "David Wilson",
      "email": "david.w@example.com",
      "total_spent": 7650.30,
      "orders": 25,
      "last_order": "1 day ago",
      "tier": "Loyal",
      "image": "https://picsum.photos/50/50?random=5&keyword=man"
    },
  ];

  List<Map<String, dynamic>> satisfactionData = [
    {
      "rating": "5 Stars",
      "count": 8920,
      "percentage": 56.9,
      "color": Colors.green
    },
    {
      "rating": "4 Stars",
      "count": 4680,
      "percentage": 29.9,
      "color": Colors.lightGreen
    },
    {
      "rating": "3 Stars",
      "count": 1560,
      "percentage": 9.9,
      "color": Colors.orange
    },
    {
      "rating": "2 Stars",
      "count": 390,
      "percentage": 2.5,
      "color": Colors.deepOrange
    },
    {
      "rating": "1 Star",
      "count": 130,
      "percentage": 0.8,
      "color": Colors.red
    },
  ];

  List<Map<String, dynamic>> behaviorInsights = [
    {
      "behavior": "Purchase Frequency",
      "metric": "4.2 orders/month",
      "trend": "up",
      "change": 8.5,
      "icon": Icons.shopping_cart
    },
    {
      "behavior": "Average Session Duration",
      "metric": "12.5 minutes",
      "trend": "up",
      "change": 15.2,
      "icon": Icons.schedule
    },
    {
      "behavior": "Cart Abandonment Rate",
      "metric": "28.3%",
      "trend": "down",
      "change": -5.8,
      "icon": Icons.remove_shopping_cart
    },
    {
      "behavior": "Email Open Rate",
      "metric": "42.8%",
      "trend": "up",
      "change": 12.1,
      "icon": Icons.email
    },
    {
      "behavior": "Support Tickets",
      "metric": "2.1 per 100 orders",
      "trend": "down",
      "change": -18.5,
      "icon": Icons.support
    },
  ];

  List<Map<String, dynamic>> retentionData = [
    {
      "period": "Month 1",
      "retention": 100.0,
      "customers": 2450
    },
    {
      "period": "Month 2",
      "retention": 78.5,
      "customers": 1923
    },
    {
      "period": "Month 3",
      "retention": 65.2,
      "customers": 1597
    },
    {
      "period": "Month 6",
      "retention": 52.8,
      "customers": 1294
    },
    {
      "period": "Month 12",
      "retention": 41.6,
      "customers": 1019
    },
  ];

  Color _getTierColor(String tier) {
    switch (tier) {
      case "VIP":
        return Colors.purple;
      case "Loyal":
        return Colors.blue;
      case "Regular":
        return Colors.green;
      case "New":
        return Colors.orange;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Analytics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Segments", icon: Icon(Icons.group)),
        Tab(text: "Behavior", icon: Icon(Icons.insights)),
        Tab(text: "Retention", icon: Icon(Icons.loyalty)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSegmentsTab(),
        _buildBehaviorTab(),
        _buildRetentionTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          QDropdownField(
            label: "Region",
            items: regions,
            value: selectedRegion,
            onChanged: (value, label) {
              selectedRegion = value;
              setState(() {});
            },
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: customerMetrics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spSm),
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
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (metric["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"] as IconData,
                            color: metric["color"] as Color,
                            size: 20,
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
                              color: (metric["change"] as double) >= 0
                                  ? successColor
                                  : dangerColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${metric["title"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      metric["title"] == "Customer Lifetime Value"
                          ? "\$${(metric["value"] as double).currency}"
                          : metric["title"] == "Churn Rate"
                          ? "${(metric["value"] as double).toStringAsFixed(1)}%"
                          : metric["title"] == "Net Promoter Score"
                          ? "${(metric["value"] as double).toStringAsFixed(0)}"
                          : "${(metric["value"] as int)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Customers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...topCustomers.map((customer) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${customer["image"]}",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${customer["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${customer["email"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${(customer["orders"] as int)} orders • ${customer["last_order"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getTierColor(customer["tier"] as String).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${customer["tier"]}",
                                style: TextStyle(
                                  color: _getTierColor(customer["tier"] as String),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$${(customer["total_spent"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Customer Segments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...customerSegments.map((segment) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (segment["color"] as Color).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: segment["color"] as Color,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${segment["segment"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "${(segment["percentage"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: segment["color"] as Color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Customers",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${(segment["count"] as int)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Avg Order",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(segment["avg_order"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "LTV",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(segment["ltv"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: segment["color"] as Color,
                                    ),
                                  ),
                                ],
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
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Customer Satisfaction",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...satisfactionData.map((rating) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${rating["rating"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(rating["count"] as int)} reviews",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${(rating["percentage"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: rating["color"] as Color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 
                                    (rating["percentage"] as double) / 100 * 0.7,
                                decoration: BoxDecoration(
                                  color: rating["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusXs),
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
          ),
        ],
      ),
    );
  }

  Widget _buildBehaviorTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Behavior Insights",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...behaviorInsights.map((behavior) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            behavior["icon"] as IconData,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${behavior["behavior"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${behavior["metric"]}",
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
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: behavior["trend"] == "up"
                                ? successColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                behavior["trend"] == "up" 
                                    ? Icons.trending_up 
                                    : Icons.trending_down,
                                color: behavior["trend"] == "up" 
                                    ? successColor 
                                    : dangerColor,
                                size: 12,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${(behavior["change"] as double).abs().toStringAsFixed(1)}%",
                                style: TextStyle(
                                  color: behavior["trend"] == "up" 
                                      ? successColor 
                                      : dangerColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
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
          ),
        ],
      ),
    );
  }

  Widget _buildRetentionTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Customer Retention",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...retentionData.map((retention) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${retention["period"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(retention["customers"] as int)} customers",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${(retention["retention"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: (retention["retention"] as double) >= 50 
                                    ? successColor 
                                    : warningColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 
                                    (retention["retention"] as double) / 100 * 0.7,
                                decoration: BoxDecoration(
                                  color: (retention["retention"] as double) >= 50 
                                      ? successColor 
                                      : warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
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
          ),
        ],
      ),
    );
  }
}
