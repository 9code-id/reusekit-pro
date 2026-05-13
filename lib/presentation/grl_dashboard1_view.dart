import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDashboard1View extends StatefulWidget {
  @override
  State<GrlDashboard1View> createState() => _GrlDashboard1ViewState();
}

class _GrlDashboard1ViewState extends State<GrlDashboard1View> {
  bool loading = false;
  String selectedPeriod = "This Month";
  List<Map<String, dynamic>> revenueData = [
    {"month": "Jan", "revenue": 45000.0, "growth": 12.5},
    {"month": "Feb", "revenue": 52000.0, "growth": 15.6},
    {"month": "Mar", "revenue": 48000.0, "growth": -7.7},
    {"month": "Apr", "revenue": 58000.0, "growth": 20.8},
    {"month": "May", "revenue": 62000.0, "growth": 6.9},
    {"month": "Jun", "revenue": 67000.0, "growth": 8.1},
  ];

  List<Map<String, dynamic>> topProducts = [
    {"name": "Premium Package", "sales": 1250, "revenue": 125000.0, "trend": "up"},
    {"name": "Standard Package", "sales": 890, "revenue": 89000.0, "trend": "up"},
    {"name": "Basic Package", "sales": 650, "revenue": 32500.0, "trend": "down"},
    {"name": "Enterprise Package", "sales": 340, "revenue": 170000.0, "trend": "up"},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Dashboard"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            child: QButton(
              icon: Icons.refresh,
              size: bs.sm,
              onPressed: () {
                loading = true;
                setState(() {});
                Future.delayed(Duration(seconds: 2), () {
                  loading = false;
                  setState(() {});
                });
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Filter
            Row(
              children: [
                Text(
                  "Period:",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Select Period",
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

            // Key Metrics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildMetricCard(
                  "Total Revenue",
                  "\$${((revenueData.map((d) => d["revenue"] as double).reduce((a, b) => a + b))).currency}",
                  Icons.attach_money,
                  successColor,
                  "+18.2%",
                ),
                _buildMetricCard(
                  "Total Orders",
                  "3,130",
                  Icons.shopping_cart,
                  infoColor,
                  "+22.5%",
                ),
                _buildMetricCard(
                  "Conversion Rate",
                  "12.8%",
                  Icons.trending_up,
                  warningColor,
                  "-2.1%",
                ),
                _buildMetricCard(
                  "Avg Order Value",
                  "\$${(125.50).currency}",
                  Icons.receipt,
                  primaryColor,
                  "+8.7%",
                ),
              ],
            ),

            // Revenue Chart Section
            Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Revenue Trend",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.show_chart,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),
                  Container(
                    height: 200,
                    child: Column(
                      spacing: spXs,
                      children: revenueData.map((data) {
                        return Row(
                          children: [
                            Container(
                              width: 30,
                              child: Text(
                                "${data["month"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Container(
                                height: 25,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: ((data["revenue"] as double) / 70000.0),
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              width: 80,
                              child: Text(
                                "\$${((data["revenue"] as double) / 1000).toStringAsFixed(0)}K",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              width: 50,
                              child: Text(
                                "${(data["growth"] as double) >= 0 ? '+' : ''}${(data["growth"] as double).toStringAsFixed(1)}%",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: (data["growth"] as double) >= 0 ? successColor : dangerColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
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
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Selling Products",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Navigating to full product analytics");
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: topProducts.map((product) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
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
                                    "${product["sales"]} sales",
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
                                  "\$${((product["revenue"] as double) / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      product["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                                      size: 14,
                                      color: product["trend"] == "up" ? successColor : dangerColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      product["trend"] == "up" ? "High" : "Low",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: product["trend"] == "up" ? successColor : dangerColor,
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
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.download,
                    size: bs.md,
                    onPressed: () {
                      ss("Report exported successfully");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Analytics",
                    icon: Icons.analytics,
                    size: bs.md,
                    onPressed: () {
                      si("Opening detailed analytics");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String change) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: change.startsWith('+') ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: change.startsWith('+') ? successColor : dangerColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
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
        ],
      ),
    );
  }
}
