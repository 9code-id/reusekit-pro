import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReport6View extends StatefulWidget {
  @override
  State<GrlReport6View> createState() => _GrlReport6ViewState();
}

class _GrlReport6ViewState extends State<GrlReport6View> {
  int selectedTab = 0;
  String selectedTimeframe = "month";
  
  List<Map<String, dynamic>> timeframes = [
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "quarter"},
    {"label": "This Year", "value": "year"},
    {"label": "All Time", "value": "all"},
  ];

  List<Map<String, dynamic>> customerData = [
    {
      "name": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 (555) 123-4567",
      "totalOrders": 24,
      "totalSpent": 4850.0,
      "avgOrderValue": 202.08,
      "lastOrder": "2024-12-22",
      "joinDate": "2023-08-15",
      "segment": "vip",
      "status": "active",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=man",
    },
    {
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 (555) 234-5678",
      "totalOrders": 18,
      "totalSpent": 2960.0,
      "avgOrderValue": 164.44,
      "lastOrder": "2024-12-21",
      "joinDate": "2023-11-20",
      "segment": "loyal",
      "status": "active",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=woman",
    },
    {
      "name": "Mike Brown",
      "email": "mike.brown@email.com",
      "phone": "+1 (555) 345-6789",
      "totalOrders": 8,
      "totalSpent": 1240.0,
      "avgOrderValue": 155.0,
      "lastOrder": "2024-12-18",
      "joinDate": "2024-03-10",
      "segment": "regular",
      "status": "active",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=man",
    },
    {
      "name": "Emma Davis",
      "email": "emma.davis@email.com",
      "phone": "+1 (555) 456-7890",
      "totalOrders": 3,
      "totalSpent": 385.0,
      "avgOrderValue": 128.33,
      "lastOrder": "2024-12-10",
      "joinDate": "2024-11-05",
      "segment": "new",
      "status": "active",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=woman",
    },
    {
      "name": "David Wilson",
      "email": "david.wilson@email.com",
      "phone": "+1 (555) 567-8901",
      "totalOrders": 45,
      "totalSpent": 8750.0,
      "avgOrderValue": 194.44,
      "lastOrder": "2024-10-15",
      "joinDate": "2022-05-12",
      "segment": "vip",
      "status": "inactive",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=man",
    },
  ];

  List<Map<String, dynamic>> segmentData = [
    {
      "name": "VIP Customers",
      "count": 156,
      "percentage": 12.5,
      "avgSpent": 4200.0,
      "avgOrders": 28,
      "color": primaryColor,
      "growth": 8.5,
    },
    {
      "name": "Loyal Customers",
      "count": 342,
      "percentage": 27.4,
      "avgSpent": 2100.0,
      "avgOrders": 15,
      "color": successColor,
      "growth": 12.8,
    },
    {
      "name": "Regular Customers",
      "count": 489,
      "percentage": 39.2,
      "avgSpent": 890.0,
      "avgOrders": 7,
      "color": infoColor,
      "growth": 5.2,
    },
    {
      "name": "New Customers",
      "count": 261,
      "percentage": 20.9,
      "avgSpent": 245.0,
      "avgOrders": 2,
      "color": warningColor,
      "growth": 18.4,
    },
  ];

  List<Map<String, dynamic>> behaviorData = [
    {
      "metric": "Average Session Duration",
      "value": "8m 32s",
      "change": 12.5,
      "icon": Icons.access_time,
      "color": primaryColor,
    },
    {
      "metric": "Page Views per Session",
      "value": "4.8",
      "change": 8.2,
      "icon": Icons.visibility,
      "color": infoColor,
    },
    {
      "metric": "Cart Abandonment Rate",
      "value": "23.4%",
      "change": -5.8,
      "icon": Icons.shopping_cart,
      "color": warningColor,
    },
    {
      "metric": "Return Customer Rate",
      "value": "68.2%",
      "change": 15.7,
      "icon": Icons.refresh,
      "color": successColor,
    },
    {
      "metric": "Email Open Rate",
      "value": "32.1%",
      "change": 6.4,
      "icon": Icons.email,
      "color": primaryColor,
    },
    {
      "metric": "Social Media Engagement",
      "value": "4.2%",
      "change": 18.9,
      "icon": Icons.share,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> retentionData = [
    {"period": "Week 1", "retention": 85.2, "customers": 1248},
    {"period": "Week 2", "retention": 72.8, "customers": 1065},
    {"period": "Week 3", "retention": 64.5, "customers": 945},
    {"period": "Week 4", "retention": 58.9, "customers": 862},
    {"period": "Month 2", "retention": 48.7, "customers": 713},
    {"period": "Month 3", "retention": 42.1, "customers": 616},
    {"period": "Month 6", "retention": 35.8, "customers": 524},
    {"period": "Month 12", "retention": 28.4, "customers": 416},
  ];

  List<Map<String, dynamic>> satisfactionData = [
    {
      "rating": "5 Stars",
      "count": 1856,
      "percentage": 62.3,
      "color": successColor,
    },
    {
      "rating": "4 Stars",
      "count": 678,
      "percentage": 22.8,
      "color": primaryColor,
    },
    {
      "rating": "3 Stars",
      "count": 289,
      "percentage": 9.7,
      "color": warningColor,
    },
    {
      "rating": "2 Stars",
      "count": 98,
      "percentage": 3.3,
      "color": dangerColor,
    },
    {
      "rating": "1 Star",
      "count": 57,
      "percentage": 1.9,
      "color": dangerColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Analytics",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Segments", icon: Icon(Icons.group)),
        Tab(text: "Behavior", icon: Icon(Icons.analytics)),
        Tab(text: "Retention", icon: Icon(Icons.trending_up)),
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
          _buildTimeframeSelector(),
          _buildCustomerMetrics(),
          _buildTopCustomers(),
          _buildCustomerSatisfaction(),
        ],
      ),
    );
  }

  Widget _buildTimeframeSelector() {
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
          Text(
            "Analysis Period",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QCategoryPicker(
            items: timeframes,
            value: selectedTimeframe,
            onChanged: (index, label, value, item) {
              selectedTimeframe = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerMetrics() {
    int totalCustomers = customerData.length;
    int activeCustomers = customerData.where((c) => c["status"] == "active").length;
    double avgOrderValue = customerData.fold(0.0, (sum, c) => sum + (c["avgOrderValue"] as double)) / totalCustomers;
    double customerLifetimeValue = customerData.fold(0.0, (sum, c) => sum + (c["totalSpent"] as double)) / totalCustomers;

    List<Map<String, dynamic>> metrics = [
      {
        "title": "Total Customers",
        "value": "${totalCustomers}",
        "subtitle": "Registered users",
        "icon": Icons.people,
        "color": primaryColor,
        "change": 12.5,
      },
      {
        "title": "Active Customers",
        "value": "${activeCustomers}",
        "subtitle": "Recent activity",
        "icon": Icons.person,
        "color": successColor,
        "change": 8.7,
      },
      {
        "title": "Avg Order Value",
        "value": "\$${avgOrderValue.toStringAsFixed(0)}",
        "subtitle": "Per transaction",
        "icon": Icons.receipt,
        "color": infoColor,
        "change": 15.2,
      },
      {
        "title": "Customer LTV",
        "value": "\$${customerLifetimeValue.toStringAsFixed(0)}",
        "subtitle": "Lifetime value",
        "icon": Icons.star,
        "color": warningColor,
        "change": 18.9,
      },
    ];

    return ResponsiveGridView(
      minItemWidth: 200,
      children: metrics.map((metric) {
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
                      color: (metric["color"] as Color).withAlpha(51),
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
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "+${(metric["change"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${metric["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${metric["value"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${metric["subtitle"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTopCustomers() {
    List<Map<String, dynamic>> topCustomers = List.from(customerData);
    topCustomers.sort((a, b) => (b["totalSpent"] as double).compareTo(a["totalSpent"] as double));
    topCustomers = topCustomers.take(5).toList();

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
              Text(
                "Top Customers by Spending",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  // Navigate to customers
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: topCustomers.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> customer = entry.value;
              
              Color segmentColor = customer["segment"] == "vip" ? primaryColor :
                                 customer["segment"] == "loyal" ? successColor :
                                 customer["segment"] == "regular" ? infoColor : warningColor;

              return Container(
                margin: EdgeInsets.only(bottom: index < topCustomers.length - 1 ? spSm : 0),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: segmentColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: segmentColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                        image: DecorationImage(
                          image: NetworkImage("${customer["avatar"]}"),
                          fit: BoxFit.cover,
                        ),
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
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(customer["totalOrders"] as int)} orders • ${customer["segment"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Last order: ${customer["lastOrder"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${((customer["totalSpent"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "AOV: \$${((customer["avgOrderValue"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
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

  Widget _buildCustomerSatisfaction() {
    double avgRating = satisfactionData.fold(0.0, (sum, data) => sum + ((data["rating"] == "5 Stars" ? 5 :
                                                                        data["rating"] == "4 Stars" ? 4 :
                                                                        data["rating"] == "3 Stars" ? 3 :
                                                                        data["rating"] == "2 Stars" ? 2 : 1) * 
                                                                       (data["count"] as int))) / 
                      satisfactionData.fold(0, (sum, data) => sum + (data["count"] as int));

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
              Text(
                "Customer Satisfaction",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: successColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${avgRating.toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 16,
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
          Column(
            children: satisfactionData.map((data) {
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        "${data["rating"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (data["percentage"] as double) / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: data["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      width: 60,
                      child: Text(
                        "${(data["percentage"] as double).toStringAsFixed(1)}%",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
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

  Widget _buildSegmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSegmentOverview(),
          _buildSegmentDetails(),
        ],
      ),
    );
  }

  Widget _buildSegmentOverview() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: segmentData.map((segment) {
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
                      color: (segment["color"] as Color).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      segment["name"] == "VIP Customers" ? Icons.diamond :
                      segment["name"] == "Loyal Customers" ? Icons.favorite :
                      segment["name"] == "Regular Customers" ? Icons.person : Icons.person_add,
                      color: segment["color"] as Color,
                      size: 20,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "+${(segment["growth"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${segment["name"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "${(segment["count"] as int)}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: segment["color"] as Color,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${(segment["percentage"] as double).toStringAsFixed(1)}% of total",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSegmentDetails() {
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
          Text(
            "Segment Performance Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: segmentData.map((segment) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (segment["color"] as Color).withAlpha(25),
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
                            "${segment["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${(segment["count"] as int)} customers",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ResponsiveGridView(
                      minItemWidth: 120,
                      children: [
                        _buildSegmentMetric("Avg Spent", "\$${((segment["avgSpent"] as double)).currency}"),
                        _buildSegmentMetric("Avg Orders", "${(segment["avgOrders"] as int)}"),
                        _buildSegmentMetric("Growth", "+${(segment["growth"] as double).toStringAsFixed(1)}%"),
                        _buildSegmentMetric("Share", "${(segment["percentage"] as double).toStringAsFixed(1)}%"),
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

  Widget _buildSegmentMetric(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBehaviorTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildBehaviorMetrics(),
          _buildEngagementAnalysis(),
        ],
      ),
    );
  }

  Widget _buildBehaviorMetrics() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: behaviorData.map((behavior) {
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
                      color: (behavior["color"] as Color).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      behavior["icon"] as IconData,
                      color: behavior["color"] as Color,
                      size: 20,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: (behavior["change"] as double) >= 0 ? successColor.withAlpha(51) : dangerColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${(behavior["change"] as double) >= 0 ? '+' : ''}${(behavior["change"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: (behavior["change"] as double) >= 0 ? successColor : dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${behavior["metric"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${behavior["value"]}",
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

  Widget _buildEngagementAnalysis() {
    List<Map<String, dynamic>> engagementChannels = [
      {"channel": "Website", "engagement": 78.5, "color": primaryColor},
      {"channel": "Mobile App", "engagement": 85.2, "color": successColor},
      {"channel": "Email", "engagement": 32.1, "color": infoColor},
      {"channel": "Social Media", "engagement": 24.8, "color": warningColor},
      {"channel": "SMS", "engagement": 68.9, "color": dangerColor},
    ];

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
          Text(
            "Customer Engagement by Channel",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: engagementChannels.map((channel) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        "${channel["channel"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (channel["engagement"] as double) / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: channel["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      width: 60,
                      child: Text(
                        "${(channel["engagement"] as double).toStringAsFixed(1)}%",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: channel["color"] as Color,
                        ),
                      ),
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

  Widget _buildRetentionTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRetentionOverview(),
          _buildRetentionCohort(),
        ],
      ),
    );
  }

  Widget _buildRetentionOverview() {
    List<Map<String, dynamic>> retentionMetrics = [
      {
        "title": "1-Week Retention",
        "value": "85.2%",
        "subtitle": "Week 1 comeback rate",
        "icon": Icons.calendar_view_week,
        "color": primaryColor,
      },
      {
        "title": "1-Month Retention",
        "value": "58.9%",
        "subtitle": "Month 1 comeback rate",
        "icon": Icons.calendar_month,
        "color": successColor,
      },
      {
        "title": "3-Month Retention",
        "value": "42.1%",
        "subtitle": "Quarter comeback rate",
        "icon": Icons.calendar_today,
        "color": infoColor,
      },
      {
        "title": "12-Month Retention",
        "value": "28.4%",
        "subtitle": "Annual comeback rate",
        "icon": Icons.event,
        "color": warningColor,
      },
    ];

    return ResponsiveGridView(
      minItemWidth: 200,
      children: retentionMetrics.map((metric) {
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
                      color: (metric["color"] as Color).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      metric["icon"] as IconData,
                      color: metric["color"] as Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${metric["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${metric["value"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${metric["subtitle"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRetentionCohort() {
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
          Text(
            "Customer Retention Cohort Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: retentionData.map((period) {
              Color retentionColor = (period["retention"] as double) >= 70 ? successColor :
                                   (period["retention"] as double) >= 50 ? primaryColor :
                                   (period["retention"] as double) >= 30 ? warningColor : dangerColor;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: retentionColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: retentionColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        "${period["period"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (period["retention"] as double) / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: retentionColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      width: 60,
                      child: Text(
                        "${(period["retention"] as double).toStringAsFixed(1)}%",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: retentionColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      width: 80,
                      child: Text(
                        "${(period["customers"] as int)} users",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
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
}
