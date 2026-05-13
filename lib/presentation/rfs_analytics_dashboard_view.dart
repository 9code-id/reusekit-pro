import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsAnalyticsDashboardView extends StatefulWidget {
  const RfsAnalyticsDashboardView({super.key});

  @override
  State<RfsAnalyticsDashboardView> createState() => _RfsAnalyticsDashboardViewState();
}

class _RfsAnalyticsDashboardViewState extends State<RfsAnalyticsDashboardView> {
  int selectedTab = 0;
  String selectedPeriod = "today";
  String selectedMetric = "revenue";

  List<Map<String, dynamic>> periodItems = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> metricItems = [
    {"label": "Revenue", "value": "revenue"},
    {"label": "Orders", "value": "orders"},
    {"label": "Customers", "value": "customers"},
    {"label": "Items Sold", "value": "items"},
  ];

  Map<String, dynamic> overviewData = {
    "today": {
      "revenue": 4850.75,
      "orders": 156,
      "customers": 134,
      "items": 289,
      "averageOrder": 31.09,
      "conversionRate": 3.2,
    },
    "week": {
      "revenue": 28450.25,
      "orders": 890,
      "customers": 756,
      "items": 1654,
      "averageOrder": 31.97,
      "conversionRate": 3.8,
    },
    "month": {
      "revenue": 125680.50,
      "orders": 3890,
      "customers": 2456,
      "items": 7234,
      "averageOrder": 32.31,
      "conversionRate": 4.1,
    },
    "year": {
      "revenue": 1456780.25,
      "orders": 45680,
      "customers": 12890,
      "items": 89456,
      "averageOrder": 31.89,
      "conversionRate": 3.9,
    },
  };

  List<Map<String, dynamic>> revenueChart = [
    {"period": "Jan", "value": 125680.50},
    {"period": "Feb", "value": 134250.75},
    {"period": "Mar", "value": 98450.25},
    {"period": "Apr", "value": 156780.50},
    {"period": "May", "value": 178950.25},
    {"period": "Jun", "value": 165430.75},
    {"period": "Jul", "value": 189250.50},
    {"period": "Aug", "value": 203780.25},
    {"period": "Sep", "value": 195640.75},
    {"period": "Oct", "value": 218950.50},
    {"period": "Nov", "value": 234670.25},
    {"period": "Dec", "value": 256890.75},
  ];

  List<Map<String, dynamic>> topMenuItems = [
    {
      "name": "Pizza Margherita",
      "category": "Pizza",
      "orders": 89,
      "revenue": 2136.00,
      "percentage": 15.2,
      "trend": "up",
    },
    {
      "name": "Burger Combo",
      "category": "Burgers",
      "orders": 76,
      "revenue": 1824.00,
      "percentage": 12.8,
      "trend": "up",
    },
    {
      "name": "Pasta Carbonara",
      "category": "Pasta",
      "orders": 65,
      "revenue": 1560.00,
      "percentage": 10.9,
      "trend": "down",
    },
    {
      "name": "Sushi Platter",
      "category": "Sushi",
      "orders": 45,
      "revenue": 2025.00,
      "percentage": 9.5,
      "trend": "up",
    },
    {
      "name": "Caesar Salad",
      "category": "Salads",
      "orders": 54,
      "revenue": 972.00,
      "percentage": 8.1,
      "trend": "stable",
    },
  ];

  List<Map<String, dynamic>> customerSegments = [
    {
      "segment": "New Customers",
      "count": 45,
      "percentage": 33.6,
      "revenue": 1395.75,
      "averageOrder": 31.02,
      "color": successColor,
    },
    {
      "segment": "Returning Customers",
      "count": 67,
      "percentage": 50.0,
      "revenue": 2578.50,
      "averageOrder": 38.49,
      "color": primaryColor,
    },
    {
      "segment": "VIP Customers",
      "count": 22,
      "percentage": 16.4,
      "revenue": 876.50,
      "averageOrder": 39.84,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> orderChannels = [
    {
      "channel": "Mobile App",
      "orders": 89,
      "percentage": 57.1,
      "revenue": 2769.50,
      "color": primaryColor,
    },
    {
      "channel": "Website",
      "orders": 34,
      "percentage": 21.8,
      "revenue": 1058.25,
      "color": infoColor,
    },
    {
      "channel": "Phone Orders",
      "orders": 23,
      "percentage": 14.7,
      "revenue": 714.75,
      "color": warningColor,
    },
    {
      "channel": "Walk-in",
      "orders": 10,
      "percentage": 6.4,
      "revenue": 308.25,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> deliveryAnalytics = [
    {
      "metric": "Average Delivery Time",
      "value": "28 min",
      "trend": "down",
      "change": "-5%",
      "target": "30 min",
      "icon": Icons.timer,
    },
    {
      "metric": "On-Time Delivery Rate",
      "value": "94.2%",
      "trend": "up",
      "change": "+2.1%",
      "target": "95%",
      "icon": Icons.schedule,
    },
    {
      "metric": "Customer Satisfaction",
      "value": "4.7/5",
      "trend": "up",
      "change": "+0.3",
      "target": "4.5/5",
      "icon": Icons.star,
    },
    {
      "metric": "Delivery Success Rate",
      "value": "98.5%",
      "trend": "stable",
      "change": "0%",
      "target": "98%",
      "icon": Icons.check_circle,
    },
  ];

  List<Map<String, dynamic>> hourlyData = [
    {"hour": "6 AM", "orders": 2, "revenue": 45.50},
    {"hour": "7 AM", "orders": 8, "revenue": 234.75},
    {"hour": "8 AM", "orders": 15, "revenue": 456.25},
    {"hour": "9 AM", "orders": 12, "revenue": 378.50},
    {"hour": "10 AM", "orders": 18, "revenue": 567.75},
    {"hour": "11 AM", "orders": 25, "revenue": 789.25},
    {"hour": "12 PM", "orders": 34, "revenue": 1024.50},
    {"hour": "1 PM", "orders": 42, "revenue": 1345.75},
    {"hour": "2 PM", "orders": 28, "revenue": 892.25},
    {"hour": "3 PM", "orders": 22, "revenue": 678.50},
    {"hour": "4 PM", "orders": 19, "revenue": 598.75},
    {"hour": "5 PM", "orders": 31, "revenue": 956.25},
    {"hour": "6 PM", "orders": 45, "revenue": 1398.50},
    {"hour": "7 PM", "orders": 52, "revenue": 1678.75},
    {"hour": "8 PM", "orders": 38, "revenue": 1189.25},
    {"hour": "9 PM", "orders": 29, "revenue": 892.50},
    {"hour": "10 PM", "orders": 18, "revenue": 567.25},
    {"hour": "11 PM", "orders": 8, "revenue": 234.75},
  ];

  Map<String, dynamic> get currentData => overviewData[selectedPeriod] ?? overviewData["today"];

  Widget _buildOverviewCard(String title, String value, String subtitle, Color color, IconData icon) {
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                size: 16,
                color: successColor,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: successColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard() {
    double maxValue = revenueChart
        .map((item) => item["value"] as double)
        .reduce((a, b) => a > b ? a : b);

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
          Text(
            "Revenue Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: revenueChart.map((item) {
                double height = ((item["value"] as double) / maxValue) * 180;
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
                          "${item["period"]}",
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
    );
  }

  Widget _buildTopItemsCard() {
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
          Text(
            "Top Menu Items",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...topMenuItems.map((item) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledOutlineBorderColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${item["category"]}",
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
                      "${item["orders"]} orders",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "\$${((item["revenue"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: spSm),
                Icon(
                  item["trend"] == "up" ? Icons.trending_up :
                  item["trend"] == "down" ? Icons.trending_down : Icons.trending_flat,
                  size: 16,
                  color: item["trend"] == "up" ? successColor :
                         item["trend"] == "down" ? dangerColor : disabledBoldColor,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildCustomerSegmentCard() {
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
          Text(
            "Customer Segments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...customerSegments.map((segment) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: segment["color"],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${segment["segment"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${segment["count"]} customers (${(segment["percentage"] as double).toStringAsFixed(1)}%)",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$${((segment["revenue"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildOrderChannelCard() {
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
          Text(
            "Order Channels",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...orderChannels.map((channel) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${channel["channel"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "${channel["orders"]} orders",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (channel["percentage"] as double) / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: channel["color"],
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${(channel["percentage"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildDeliveryMetricCard(Map<String, dynamic> metric) {
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
              Icon(
                metric["icon"],
                size: 20,
                color: primaryColor,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${metric["metric"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Icon(
                metric["trend"] == "up" ? Icons.trending_up :
                metric["trend"] == "down" ? Icons.trending_down : Icons.trending_flat,
                size: 16,
                color: metric["trend"] == "up" ? successColor :
                       metric["trend"] == "down" ? dangerColor : disabledBoldColor,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${metric["value"]}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "${metric["change"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: metric["trend"] == "up" ? successColor :
                         metric["trend"] == "down" ? dangerColor : disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Target: ${metric["target"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyAnalysisCard() {
    double maxOrders = hourlyData
        .map((item) => (item["orders"] as int).toDouble())
        .reduce((a, b) => a > b ? a : b);

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
          Text(
            "Hourly Order Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: hourlyData.map((item) {
                  double height = ((item["orders"] as int).toDouble() / maxOrders) * 180;
                  return Container(
                    width: 30,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height,
                          decoration: BoxDecoration(
                            color: infoColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${item["hour"]}".replaceAll(" ", "\n"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Analytics Dashboard",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Sales", icon: Icon(Icons.trending_up)),
        Tab(text: "Customers", icon: Icon(Icons.people)),
        Tab(text: "Performance", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Period",
                      items: periodItems,
                      value: selectedPeriod,
                      onChanged: (value, label) {
                        selectedPeriod = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: [
                  _buildOverviewCard(
                    "Total Revenue",
                    "\$${(currentData["revenue"] as double).currency}",
                    "+12.5% from last period",
                    primaryColor,
                    Icons.attach_money,
                  ),
                  _buildOverviewCard(
                    "Total Orders",
                    "${currentData["orders"]}",
                    "+8.3% from last period",
                    successColor,
                    Icons.shopping_cart,
                  ),
                  _buildOverviewCard(
                    "New Customers",
                    "${currentData["customers"]}",
                    "+15.2% from last period",
                    infoColor,
                    Icons.people,
                  ),
                  _buildOverviewCard(
                    "Items Sold",
                    "${currentData["items"]}",
                    "+6.7% from last period",
                    warningColor,
                    Icons.inventory,
                  ),
                ].map((card) => StaggeredGridTile.fit(
                  crossAxisCellCount: 1,
                  child: card,
                )).toList(),
              ),
              SizedBox(height: spMd),
              _buildChartCard(),
              SizedBox(height: spMd),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTopItemsCard()),
                  SizedBox(width: spSm),
                  Expanded(child: _buildOrderChannelCard()),
                ],
              ),
            ],
          ),
        ),
        
        // Sales Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sales Analytics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              _buildChartCard(),
              SizedBox(height: spMd),
              _buildTopItemsCard(),
              SizedBox(height: spMd),
              _buildHourlyAnalysisCard(),
            ],
          ),
        ),
        
        // Customers Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer Analytics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              _buildCustomerSegmentCard(),
              SizedBox(height: spMd),
              _buildOrderChannelCard(),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
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
                      "Customer Insights",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
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
                                "Average Order Value",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(currentData["averageOrder"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
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
                                "Conversion Rate",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${(currentData["conversionRate"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Performance Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Performance Metrics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: deliveryAnalytics.map((metric) => 
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 1,
                    child: _buildDeliveryMetricCard(metric),
                  ),
                ).toList(),
              ),
              SizedBox(height: spMd),
              _buildHourlyAnalysisCard(),
            ],
          ),
        ),
      ],
    );
  }
}
