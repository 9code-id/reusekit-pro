import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOverview4View extends StatefulWidget {
  @override
  State<GrlOverview4View> createState() => _GrlOverview4ViewState();
}

class _GrlOverview4ViewState extends State<GrlOverview4View> {
  String selectedPeriod = "This Month";
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> kpiData = [
    {
      "title": "Total Revenue",
      "value": 125450.0,
      "percentage": 12.5,
      "icon": Icons.attach_money,
      "color": Color(0xFF4CAF50),
    },
    {
      "title": "New Customers",
      "value": 1247.0,
      "percentage": 8.3,
      "icon": Icons.people,
      "color": Color(0xFF2196F3),
    },
    {
      "title": "Orders",
      "value": 3521.0,
      "percentage": -2.1,
      "icon": Icons.shopping_cart,
      "color": Color(0xFFFF9800),
    },
    {
      "title": "Conversion Rate",
      "value": 3.2,
      "percentage": 1.8,
      "icon": Icons.trending_up,
      "color": Color(0xFF9C27B0),
    },
  ];
  List<Map<String, dynamic>> recentOrders = [
    {
      "id": "#ORD-001",
      "customer": "John Smith",
      "amount": 299.99,
      "status": "Completed",
      "date": "2024-06-22",
    },
    {
      "id": "#ORD-002",
      "customer": "Sarah Johnson",
      "amount": 159.50,
      "status": "Processing",
      "date": "2024-06-22",
    },
    {
      "id": "#ORD-003",
      "customer": "Mike Wilson",
      "amount": 89.99,
      "status": "Shipped",
      "date": "2024-06-21",
    },
    {
      "id": "#ORD-004",
      "customer": "Emily Davis",      "amount": 449.99,
      "status": "Pending",
      "date": "2024-06-21",
    },
  ];

  List<Map<String, dynamic>> topProducts = [
    {
      "name": "Wireless Headphones",
      "sales": 245,
      "revenue": 36750.0,
      "image": "https://picsum.photos/60/60?random=1&keyword=headphones",
    },
    {
      "name": "Smart Watch",
      "sales": 189,
      "revenue": 47250.0,
      "image": "https://picsum.photos/60/60?random=2&keyword=watch",
    },
    {
      "name": "Bluetooth Speaker",
      "sales": 156,
      "revenue": 15600.0,
      "image": "https://picsum.photos/60/60?random=3&keyword=speaker",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(      appBar: AppBar(
        title: Text("Business Overview"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Period Selector
            Row(
              children: [
                Text(
                  "Performance Dashboard",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  width: 150,
                  child: QDropdownField(
                    items: periodOptions,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // KPI Cards Grid
            ResponsiveGridView(
              minItemWidth: 200,
              padding: EdgeInsets.zero,
              children: kpiData.map((kpi) {
                return Container(
                  padding: EdgeInsets.all(spMd),
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
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (kpi["color"] as Color).withAlpha(30),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: (kpi["percentage"] as double) >= 0
                                  ? successColor.withAlpha(30)
                                  : dangerColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  (kpi["percentage"] as double) >= 0
                                      ? Icons.trending_up
                                      : Icons.trending_down,
                                  size: 14,
                                  color: (kpi["percentage"] as double) >= 0
                                      ? successColor
                                      : dangerColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${(kpi["percentage"] as double) >= 0 ? '+' : ''}${(kpi["percentage"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: (kpi["percentage"] as double) >= 0
                                        ? successColor
                                        : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "${kpi["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        kpi["title"] == "Conversion Rate"
                            ? "${(kpi["value"] as double).toStringAsFixed(1)}%"
                            : kpi["title"] == "Total Revenue"
                                ? "\$${((kpi["value"] as double)).currency}"
                                : "${(kpi["value"] as double).toInt()}",
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

            // Recent Orders Section
            Container(
              padding: EdgeInsets.all(spMd),
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
                        "Recent Orders",
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
                  SizedBox(height: spMd),
                  Column(
                    children: recentOrders.map((order) {
                      Color statusColor = order["status"] == "Completed"
                          ? successColor
                          : order["status"] == "Processing"
                              ? warningColor
                              : order["status"] == "Shipped"
                                  ? infoColor
                                  : disabledBoldColor;

                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: statusColor,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${order["id"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: statusColor.withAlpha(30),
                                          borderRadius:
                                              BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${order["status"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: statusColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${order["customer"]}",
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
                                  "\$${((order["amount"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${order["date"]}",
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
                  ),
                ],
              ),
            ),

            // Top Products Section
            Container(
              padding: EdgeInsets.all(spMd),
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
                  SizedBox(height: spMd),
                  Column(
                    children: topProducts.map((product) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
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
                                    "${product["sales"]} units sold",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${((product["revenue"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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
          ],
        ),
      ),
    );
  }
}
