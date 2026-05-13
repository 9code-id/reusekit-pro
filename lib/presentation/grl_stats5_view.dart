import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStats5View extends StatefulWidget {
  @override
  State<GrlStats5View> createState() => _GrlStats5ViewState();
}

class _GrlStats5ViewState extends State<GrlStats5View> {
  String selectedTimeframe = "Last 30 Days";
  String selectedMetric = "Revenue";

  List<Map<String, dynamic>> kpiCards = [
    {
      "title": "Total Revenue",
      "value": 245680.0,
      "change": 12.5,
      "icon": Icons.attach_money,
      "color": Colors.green,
      "format": "currency",
    },
    {
      "title": "Active Users",
      "value": 45230.0,
      "change": 8.2,
      "icon": Icons.people,
      "color": Colors.blue,
      "format": "number",
    },
    {
      "title": "Conversion Rate",
      "value": 3.4,
      "change": -0.5,
      "icon": Icons.trending_up,
      "color": Colors.orange,
      "format": "percentage",
    },
    {
      "title": "Avg Order Value",
      "value": 127.50,
      "change": 15.2,
      "icon": Icons.shopping_cart,
      "color": Colors.purple,
      "format": "currency",
    },
  ];

  List<Map<String, dynamic>> salesData = [
    {
      "date": "Week 1",
      "sales": 58420.0,
      "orders": 234,
      "customers": 189,
    },
    {
      "date": "Week 2",
      "sales": 62150.0,
      "orders": 267,
      "customers": 201,
    },
    {
      "date": "Week 3",
      "sales": 59880.0,
      "orders": 245,
      "customers": 198,
    },
    {
      "date": "Week 4",
      "sales": 65230.0,
      "orders": 289,
      "customers": 215,
    },
  ];

  List<Map<String, dynamic>> topProducts = [
    {
      "name": "Premium Wireless Headphones",
      "sales": 45680.0,
      "units": 234,
      "growth": 15.2,
    },
    {
      "name": "Smart Fitness Tracker",
      "sales": 38420.0,  
      "units": 189,
      "growth": 8.7,
    },
    {
      "name": "Gaming Keyboard Pro",
      "sales": 32150.0,
      "units": 156,
      "growth": -2.1,
    },
    {
      "name": "USB-C Hub Adapter",
      "sales": 28940.0,
      "units": 298,
      "growth": 22.4,
    },
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "Last Year", "value": "Last Year"},
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "Revenue", "value": "Revenue"},
    {"label": "Orders", "value": "Orders"},
    {"label": "Customers", "value": "Customers"},
    {"label": "Conversion", "value": "Conversion"},
  ];

  String _formatValue(double value, String format) {
    switch (format) {
      case "currency":
        return "\$${value.currency}";
      case "percentage":
        return "${value.toStringAsFixed(1)}%";
      case "number":
        return value >= 1000 ? "${(value / 1000).toStringAsFixed(1)}K" : value.toStringAsFixed(0);
      default:
        return value.toStringAsFixed(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframeOptions,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Metric",
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

            // KPI Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: kpiCards.map((kpi) {
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
                              color: (kpi["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              kpi["icon"] as IconData,
                              color: kpi["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (kpi["change"] as double) >= 0 ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  (kpi["change"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                                  color: (kpi["change"] as double) >= 0 ? successColor : dangerColor,
                                  size: 12,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${(kpi["change"] as double).abs().toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: (kpi["change"] as double) >= 0 ? successColor : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${kpi["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        _formatValue(kpi["value"] as double, kpi["format"] as String),
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Weekly Sales Trend
            Container(
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
                    "Weekly Sales Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: salesData.map((week) {
                      double maxSales = salesData.map((e) => e["sales"] as double).reduce((a, b) => a > b ? a : b);
                      double percentage = (week["sales"] as double) / maxSales;
                      
                      return Container(
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
                                  "${week["date"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "\$${(week["sales"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${week["orders"]} orders",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.people,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${week["customers"]} customers",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: percentage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
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
            ),

            // Top Products
            Container(
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
                        "Top Performing Products",
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: topProducts.map((product) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${product["units"]} units sold",
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
                                  "\$${(product["sales"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: (product["growth"] as double) >= 0 ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${(product["growth"] as double) >= 0 ? '+' : ''}${(product["growth"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: (product["growth"] as double) >= 0 ? successColor : dangerColor,
                                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
