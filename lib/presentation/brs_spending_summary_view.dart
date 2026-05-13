import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsSpendingSummaryView extends StatefulWidget {
  const BrsSpendingSummaryView({super.key});

  @override
  State<BrsSpendingSummaryView> createState() => _BrsSpendingSummaryViewState();
}

class _BrsSpendingSummaryViewState extends State<BrsSpendingSummaryView> {
  String selectedPeriod = "This Year";
  String selectedCategory = "All Services";
  
  List<Map<String, dynamic>> spendingData = [
    {
      "period": "January 2024",
      "amount": 245.50,
      "services": 8,
      "average": 30.69,
      "trend": "up"
    },
    {
      "period": "February 2024", 
      "amount": 189.75,
      "services": 6,
      "average": 31.63,
      "trend": "down"
    },
    {
      "period": "March 2024",
      "amount": 312.20,
      "services": 10,
      "average": 31.22,
      "trend": "up"
    },
    {
      "period": "April 2024",
      "amount": 278.90,
      "services": 9,
      "average": 30.99,
      "trend": "down"
    },
  ];

  List<Map<String, dynamic>> categorySpending = [
    {
      "category": "Haircut",
      "amount": 890.50,
      "percentage": 45.2,
      "color": primaryColor,
      "visits": 29
    },
    {
      "category": "Beard Trim",
      "amount": 456.75,
      "percentage": 23.2,
      "color": successColor,
      "visits": 15
    },
    {
      "category": "Hair Wash",
      "amount": 234.80,
      "percentage": 11.9,
      "color": infoColor,
      "visits": 12
    },
    {
      "category": "Styling",
      "amount": 189.45,
      "percentage": 9.6,
      "color": warningColor,
      "visits": 8
    },
    {
      "category": "Others",
      "amount": 198.50,
      "percentage": 10.1,
      "color": dangerColor,
      "visits": 6
    },
  ];

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Jan", "amount": 245.50},
    {"month": "Feb", "amount": 189.75},
    {"month": "Mar", "amount": 312.20},
    {"month": "Apr", "amount": 278.90},
    {"month": "May", "amount": 356.40},
    {"month": "Jun", "amount": 298.15},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Spending Summary",
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.analytics)),
        Tab(text: "Categories", icon: Icon(Icons.pie_chart)),
        Tab(text: "Trends", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCategoriesTab(),
        _buildTrendsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Period Selector
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
                  "Period",
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
                      child: QDropdownField(
                        label: "Select Period",
                        items: [
                          {"label": "This Week", "value": "This Week"},
                          {"label": "This Month", "value": "This Month"},
                          {"label": "Last 3 Months", "value": "Last 3 Months"},
                          {"label": "This Year", "value": "This Year"},
                        ],
                        value: selectedPeriod,
                        onChanged: (value, label) {
                          selectedPeriod = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Total Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$1,970.00",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Total Spent",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
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
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.content_cut,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "70",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Total Services",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.timeline,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$28.14",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Average per Visit",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
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
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "+12.5%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "vs Last Month",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Monthly Breakdown
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
                  "Monthly Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...spendingData.map((data) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data["period"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${data["services"]} services • Avg: \$${(data["average"] as double).toStringAsFixed(2)}",
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
                              "\$${(data["amount"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  data["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                                  size: 16,
                                  color: data["trend"] == "up" ? successColor : dangerColor,
                                ),
                                Text(
                                  data["trend"] == "up" ? "+5.2%" : "-2.8%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: data["trend"] == "up" ? successColor : dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
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

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Category Breakdown Chart Placeholder
          Container(
            width: double.infinity,
            height: 200,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Spending by Category",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pie_chart,
                            size: 48,
                            color: primaryColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Pie Chart Visualization",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Category Details
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
                  "Category Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...categorySpending.map((category) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: category["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${category["category"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${category["visits"]} visits",
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
                                  "\$${(category["amount"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${(category["percentage"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
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
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (category["percentage"] as double) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: category["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: spSm),
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

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Trends Chart
          Container(
            width: double.infinity,
            height: 250,
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
                  "6-Month Spending Trend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.show_chart,
                            size: 48,
                            color: primaryColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Line Chart Visualization",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Monthly Data
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
                  "Monthly Data",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 150,
                  children: monthlyTrends.map((trend) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor.withAlpha(100),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${trend["month"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${(trend["amount"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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
          SizedBox(height: spMd),

          // Insights
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: infoColor,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Spending Insights",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "• Your highest spending month was May (\$356.40)\n• You save an average of 15% with loyalty points\n• Haircuts account for 45% of your total spending\n• You visit the barbershop 12 times per month on average",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
