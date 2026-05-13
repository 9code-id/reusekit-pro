import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSummary4View extends StatefulWidget {
  @override
  State<GrlSummary4View> createState() => _GrlSummary4ViewState();
}

class _GrlSummary4ViewState extends State<GrlSummary4View> {
  List<Map<String, dynamic>> salesData = [
    {
      "month": "January",
      "revenue": 125000.0,
      "target": 150000.0,
      "growth": 12.5,
      "orders": 542,
      "customers": 387,
    },
    {
      "month": "February",
      "revenue": 142000.0,
      "target": 150000.0,
      "growth": 15.8,
      "orders": 598,
      "customers": 421,
    },
    {
      "month": "March",
      "revenue": 168000.0,
      "target": 150000.0,
      "growth": 22.3,
      "orders": 672,
      "customers": 489,
    },
    {
      "month": "April",
      "revenue": 156000.0,
      "target": 150000.0,
      "growth": 18.7,
      "orders": 634,
      "customers": 445,
    },
    {
      "month": "May",
      "revenue": 189000.0,
      "target": 150000.0,
      "growth": 26.4,
      "orders": 712,
      "customers": 523,
    },
    {
      "month": "June",
      "revenue": 203000.0,
      "target": 150000.0,
      "growth": 31.2,
      "orders": 789,
      "customers": 567,
    },
  ];

  List<Map<String, dynamic>> topProducts = [
    {
      "name": "Premium Headphones",
      "revenue": 45000.0,
      "units": 234,
      "percentage": 18.5,
    },
    {
      "name": "Wireless Speakers",
      "revenue": 38000.0,
      "units": 189,
      "percentage": 15.2,
    },
    {
      "name": "Smart Watch",
      "revenue": 32000.0,
      "units": 156,
      "percentage": 12.8,
    },
    {
      "name": "Gaming Mouse",
      "revenue": 28000.0,
      "units": 142,
      "percentage": 11.3,
    },
    {
      "name": "Bluetooth Keyboard",
      "revenue": 24000.0,
      "units": 128,
      "percentage": 9.6,
    },
  ];

  String selectedPeriod = "last_6_months";

  @override
  Widget build(BuildContext context) {
    final totalRevenue = salesData.fold(0.0, (sum, item) => sum + (item["revenue"] as double));
    final totalOrders = salesData.fold(0, (sum, item) => sum + (item["orders"] as int));
    final totalCustomers = salesData.fold(0, (sum, item) => sum + (item["customers"] as int));
    final avgGrowth = salesData.fold(0.0, (sum, item) => sum + (item["growth"] as double)) / salesData.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Performance Summary"),
        actions: [
          Icon(Icons.download, color: primaryColor),
          SizedBox(width: spSm),
          Icon(Icons.share, color: primaryColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: [
                      {"label": "Last 3 Months", "value": "last_3_months"},
                      {"label": "Last 6 Months", "value": "last_6_months"},
                      {"label": "Last 12 Months", "value": "last_12_months"},
                      {"label": "Year to Date", "value": "ytd"},
                    ],
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Revenue",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "\$${totalRevenue.currency}",
                    style: TextStyle(
                      fontSize: fsH2,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.trending_up, color: successColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${avgGrowth.toStringAsFixed(1)}% vs last period",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(179),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: _buildKpiCard(
                    "Total Orders",
                    totalOrders.toString(),
                    Icons.shopping_cart,
                    successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildKpiCard(
                    "Customers",
                    totalCustomers.toString(),
                    Icons.people,
                    infoColor,
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
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
                  Column(
                    spacing: spSm,
                    children: salesData.map((data) {
                      final progressPercent = ((data["revenue"] as double) / (data["target"] as double)).clamp(0.0, 1.0);
                      final isTarget = (data["revenue"] as double) >= (data["target"] as double);
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${data["month"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      isTarget ? Icons.check_circle : Icons.radio_button_unchecked,
                                      color: isTarget ? successColor : warningColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "\$${(data["revenue"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: progressPercent,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isTarget ? successColor : warningColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(progressPercent * 100).toStringAsFixed(0)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Target: \$${(data["target"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "+${(data["growth"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
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
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Performing Products",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Icon(Icons.trending_up, color: successColor, size: 20),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: topProducts.map((product) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.inventory,
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
                                    "${product["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
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
                                  "\$${(product["revenue"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${(product["percentage"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
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
                ],
              ),
            ),

            Container(
              width: double.infinity,
              child: QButton(
                label: "Generate Detailed Report",
                icon: Icons.description,
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
