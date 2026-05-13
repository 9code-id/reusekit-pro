import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAnalytics1View extends StatefulWidget {
  @override
  State<GrlAnalytics1View> createState() => _GrlAnalytics1ViewState();
}

class _GrlAnalytics1ViewState extends State<GrlAnalytics1View> {
  String selectedPeriod = "7";
  String selectedMetric = "revenue";
  
  List<Map<String, dynamic>> periods = [
    {"label": "Last 7 Days", "value": "7"},
    {"label": "Last 30 Days", "value": "30"},
    {"label": "Last 90 Days", "value": "90"},
    {"label": "Last Year", "value": "365"},
  ];

  List<Map<String, dynamic>> metrics = [
    {"label": "Revenue", "value": "revenue"},
    {"label": "Orders", "value": "orders"},
    {"label": "Customers", "value": "customers"},
    {"label": "Products", "value": "products"},
  ];

  List<Map<String, dynamic>> revenueData = [
    {
      "title": "Total Revenue",
      "value": 285600.00,
      "change": 12.5,
      "icon": Icons.attach_money,
      "color": Colors.green
    },
    {
      "title": "Average Order",
      "value": 158.30,
      "change": -2.8,
      "icon": Icons.shopping_cart,
      "color": Colors.blue
    },
    {
      "title": "Conversion Rate",
      "value": 3.42,
      "change": 8.1,
      "icon": Icons.trending_up,
      "color": Colors.orange
    },
    {
      "title": "Customer LTV",
      "value": 892.50,
      "change": 15.3,
      "icon": Icons.person,
      "color": Colors.purple
    },
  ];

  List<Map<String, dynamic>> topProducts = [
    {
      "name": "Premium Wireless Headphones",
      "sales": 1250,
      "revenue": 156250.00,
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones"
    },
    {
      "name": "Smart Fitness Watch",
      "sales": 980,
      "revenue": 127400.00,
      "image": "https://picsum.photos/80/80?random=2&keyword=smartwatch"
    },
    {
      "name": "Bluetooth Speaker",
      "sales": 750,
      "revenue": 82500.00,
      "image": "https://picsum.photos/80/80?random=3&keyword=speaker"
    },
    {
      "name": "Gaming Mouse",
      "sales": 620,
      "revenue": 43400.00,
      "image": "https://picsum.photos/80/80?random=4&keyword=mouse"
    },
    {
      "name": "USB-C Hub",
      "sales": 450,
      "revenue": 31500.00,
      "image": "https://picsum.photos/80/80?random=5&keyword=usb"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Analytics"),
        actions: [
          Icon(Icons.more_vert),
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
                    label: "Metric",
                    items: metrics,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: revenueData.map((data) {
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
                              color: (data["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              data["icon"] as IconData,
                              color: data["color"] as Color,
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
                              color: (data["change"] as double) >= 0
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(data["change"] as double) >= 0 ? '+' : ''}${(data["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                color: (data["change"] as double) >= 0
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
                        "${data["title"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        data["title"] == "Conversion Rate"
                            ? "${(data["value"] as double).toStringAsFixed(2)}%"
                            : "\$${(data["value"] as double).currency}",
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
                    "Top Selling Products",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...topProducts.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> product = entry.value;
                    
                    return Container(
                      margin: EdgeInsets.only(
                        bottom: index < topProducts.length - 1 ? spSm : 0,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${product["image"]}",
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
                                  "${product["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${(product["sales"] as int)} sold",
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
                                "\$${(product["revenue"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
      ),
    );
  }
}
