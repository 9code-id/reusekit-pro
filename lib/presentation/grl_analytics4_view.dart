import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAnalytics4View extends StatefulWidget {
  @override
  State<GrlAnalytics4View> createState() => _GrlAnalytics4ViewState();
}

class _GrlAnalytics4ViewState extends State<GrlAnalytics4View> {
  String selectedPeriod = "month";
  String selectedCurrency = "USD";

  List<Map<String, dynamic>> periods = [
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "3months"},
    {"label": "Last 6 Months", "value": "6months"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> currencies = [
    {"label": "USD", "value": "USD"},
    {"label": "EUR", "value": "EUR"},
    {"label": "GBP", "value": "GBP"},
    {"label": "JPY", "value": "JPY"},
  ];

  List<Map<String, dynamic>> financialMetrics = [
    {
      "title": "Total Revenue",
      "current": 542300.00,
      "previous": 485200.00,
      "icon": Icons.trending_up,
      "color": Colors.green
    },
    {
      "title": "Total Expenses",
      "current": 321800.00,
      "previous": 298500.00,
      "icon": Icons.trending_down,
      "color": Colors.red
    },
    {
      "title": "Net Profit",
      "current": 220500.00,
      "previous": 186700.00,
      "icon": Icons.account_balance,
      "color": Colors.blue
    },
    {
      "title": "Profit Margin",
      "current": 40.7,
      "previous": 38.5,
      "icon": Icons.percent,
      "color": Colors.purple
    },
  ];

  List<Map<String, dynamic>> expenseCategories = [
    {
      "category": "Operational Costs",
      "amount": 145600.00,
      "percentage": 45.2,
      "color": Colors.blue,
      "items": ["Salaries", "Utilities", "Office Rent"]
    },
    {
      "category": "Marketing",
      "amount": 89200.00,
      "percentage": 27.7,
      "color": Colors.green,
      "items": ["Digital Ads", "Content Creation", "Events"]
    },
    {
      "category": "Technology",
      "amount": 52300.00,
      "percentage": 16.3,
      "color": Colors.orange,
      "items": ["Software Licenses", "Hardware", "Cloud Services"]
    },
    {
      "category": "Other",
      "amount": 34700.00,
      "percentage": 10.8,
      "color": Colors.purple,
      "items": ["Travel", "Legal", "Insurance"]
    },
  ];

  List<Map<String, dynamic>> revenueStreams = [
    {
      "stream": "Product Sales",
      "amount": 324800.00,
      "percentage": 59.9,
      "growth": 15.2,
      "color": Colors.blue
    },
    {
      "stream": "Subscriptions",
      "amount": 156200.00,
      "percentage": 28.8,
      "growth": 22.5,
      "color": Colors.green
    },
    {
      "stream": "Services",
      "amount": 45100.00,
      "percentage": 8.3,
      "growth": -5.8,
      "color": Colors.orange
    },
    {
      "stream": "Licensing",
      "amount": 16200.00,
      "percentage": 3.0,
      "growth": 8.9,
      "color": Colors.purple
    },
  ];

  List<Map<String, dynamic>> monthlyData = [
    {"month": "Jan", "revenue": 42500, "expenses": 28300, "profit": 14200},
    {"month": "Feb", "revenue": 38900, "expenses": 26800, "profit": 12100},
    {"month": "Mar", "revenue": 45600, "expenses": 29500, "profit": 16100},
    {"month": "Apr", "revenue": 48200, "expenses": 31200, "profit": 17000},
    {"month": "May", "revenue": 52100, "expenses": 33800, "profit": 18300},
    {"month": "Jun", "revenue": 49800, "expenses": 32100, "profit": 17700},
  ];

  double _calculatePercentageChange(double current, double previous) {
    return ((current - previous) / previous) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Analytics"),
        actions: [
          Icon(Icons.file_download),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
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
                    label: "Currency",
                    items: currencies,
                    value: selectedCurrency,
                    onChanged: (value, label) {
                      selectedCurrency = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: financialMetrics.map((metric) {
                double change = metric["title"] == "Profit Margin"
                    ? (metric["current"] as double) - (metric["previous"] as double)
                    : _calculatePercentageChange(
                        metric["current"] as double,
                        metric["previous"] as double
                      );
                
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
                              color: change >= 0
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}${metric["title"] == "Profit Margin" ? 'pp' : '%'}",
                              style: TextStyle(
                                color: change >= 0 ? successColor : dangerColor,
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
                        metric["title"] == "Profit Margin"
                            ? "${(metric["current"] as double).toStringAsFixed(1)}%"
                            : "\$${(metric["current"] as double).currency}",
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

            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
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
                          "Revenue Streams",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...revenueStreams.map((stream) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: stream["color"] as Color,
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "${stream["stream"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (stream["growth"] as double) >= 0
                                            ? successColor.withAlpha(20)
                                            : dangerColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${(stream["growth"] as double) >= 0 ? '+' : ''}${(stream["growth"] as double).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          color: (stream["growth"] as double) >= 0
                                              ? successColor
                                              : dangerColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    SizedBox(width: 16),
                                    Text(
                                      "\$${(stream["amount"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: stream["color"] as Color,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${(stream["percentage"] as double).toStringAsFixed(1)}%",
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
                  ),
                ),
                Expanded(
                  child: Container(
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
                          "Expense Categories",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...expenseCategories.map((category) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: category["color"] as Color,
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "${category["category"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
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
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    SizedBox(width: 16),
                                    Text(
                                      "\$${(category["amount"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: category["color"] as Color,
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
                ),
              ],
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
                    "Monthly Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...monthlyData.map((data) {
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
                            width: 40,
                            child: Text(
                              "${data["month"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Revenue:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "\$${((data["revenue"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "Expenses:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "\$${((data["expenses"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "Profit:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "\$${((data["profit"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
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
      ),
    );
  }
}
