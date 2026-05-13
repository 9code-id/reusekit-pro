import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOverview2View extends StatefulWidget {
  @override
  State<GrlOverview2View> createState() => _GrlOverview2ViewState();
}

class _GrlOverview2ViewState extends State<GrlOverview2View> {
  List<Map<String, dynamic>> salesOverview = [
    {
      "period": "Today",
      "sales": 25680.0,
      "orders": 89,
      "customers": 67,
      "target": 30000.0,
      "change": 8.5,
    },
    {
      "period": "This Week",
      "sales": 187450.0,
      "orders": 623,
      "customers": 412,
      "target": 200000.0,
      "change": 12.3,
    },
    {
      "period": "This Month",
      "sales": 756000.0,
      "orders": 2567,
      "customers": 1834,
      "target": 800000.0,
      "change": 15.7,
    },
    {
      "period": "This Quarter",
      "sales": 2245000.0,
      "orders": 7890,
      "customers": 5234,
      "target": 2400000.0,
      "change": 18.9,
    },
  ];

  List<Map<String, dynamic>> topProducts = [
    {
      "name": "Premium Wireless Headphones",
      "sales": 145000.0,
      "units_sold": 892,
      "growth": 23.5,
      "category": "Electronics",
      "stock": 245,
    },
    {
      "name": "Smart Fitness Watch",
      "sales": 128000.0,
      "units_sold": 645,
      "growth": 18.2,
      "category": "Wearables",
      "stock": 189,
    },
    {
      "name": "Bluetooth Speaker Pro",
      "sales": 98000.0,
      "units_sold": 567,
      "growth": 15.8,
      "category": "Audio",
      "stock": 312,
    },
    {
      "name": "Gaming Mechanical Keyboard",
      "sales": 78000.0,
      "units_sold": 423,
      "growth": 12.4,
      "category": "Gaming",
      "stock": 156,
    },
    {
      "name": "4K Webcam HD",
      "sales": 65000.0,
      "units_sold": 389,
      "growth": 9.7,
      "category": "Accessories",
      "stock": 78,
    },
  ];

  List<Map<String, dynamic>> salesChannels = [
    {
      "channel": "Online Store",
      "revenue": 1450000.0,
      "percentage": 58.5,
      "orders": 3245,
      "avg_order": 447.0,
      "color": primaryColor,
    },
    {
      "channel": "Mobile App",
      "revenue": 680000.0,
      "percentage": 27.4,
      "orders": 1789,
      "avg_order": 380.0,
      "color": successColor,
    },
    {
      "channel": "Retail Stores",
      "revenue": 245000.0,
      "percentage": 9.9,
      "orders": 456,
      "avg_order": 537.0,
      "color": infoColor,
    },
    {
      "channel": "Third-party Marketplaces",
      "revenue": 105000.0,
      "percentage": 4.2,
      "orders": 234,
      "avg_order": 449.0,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> customerSegments = [
    {
      "segment": "VIP Customers",
      "count": 1245,
      "revenue": 890000.0,
      "avg_order": 715.0,
      "retention": 94.5,
      "color": primaryColor,
    },
    {
      "segment": "Premium Members",
      "count": 3890,
      "revenue": 1340000.0,
      "avg_order": 344.0,
      "retention": 87.2,
      "color": successColor,
    },
    {
      "segment": "Regular Customers",
      "count": 8765,
      "revenue": 1890000.0,
      "avg_order": 215.0,
      "retention": 72.8,
      "color": infoColor,
    },
    {
      "segment": "New Customers",
      "count": 2145,
      "revenue": 325000.0,
      "avg_order": 151.0,
      "retention": 45.3,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> regionalPerformance = [
    {
      "region": "North America",
      "revenue": 1250000.0,
      "growth": 15.8,
      "orders": 4567,
      "market_share": 42.5,
    },
    {
      "region": "Europe",
      "revenue": 890000.0,
      "growth": 18.3,
      "orders": 3234,
      "market_share": 30.2,
    },
    {
      "region": "Asia Pacific",
      "revenue": 545000.0,
      "growth": 28.7,
      "orders": 2156,
      "market_share": 18.5,
    },
    {
      "region": "Latin America",
      "revenue": 189000.0,
      "growth": 22.1,
      "orders": 892,
      "market_share": 6.4,
    },
    {
      "region": "Middle East & Africa",
      "revenue": 68000.0,
      "growth": 35.4,
      "orders": 345,
      "market_share": 2.4,
    },
  ];

  String selectedPeriod = "This Month";

  @override
  Widget build(BuildContext context) {
    final selectedData = salesOverview.firstWhere((item) => item["period"] == selectedPeriod);
    final totalRevenue = salesChannels.fold(0.0, (sum, channel) => sum + (channel["revenue"] as double));

    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Performance Overview"),
        actions: [
          Icon(Icons.trending_up, color: primaryColor),
          SizedBox(width: spSm),
          Icon(Icons.filter_alt, color: primaryColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(179)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.show_chart, color: Colors.white, size: 28),
                      SizedBox(width: spSm),
                      Text(
                        "Sales Performance Dashboard",
                        style: TextStyle(
                          fontSize: fsH5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Time Period",
                          items: salesOverview.map((item) => {
                            "label": item["period"],
                            "value": item["period"],
                          }).toList(),
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(Icons.date_range, color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: _buildSalesMetricCard(
                    "Sales Revenue",
                    "\$${(selectedData["sales"] as double).currency}",
                    Icons.monetization_on,
                    successColor,
                    "${(selectedData["change"] as double).toStringAsFixed(1)}% vs previous",
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSalesMetricCard(
                    "Total Orders",
                    "${selectedData["orders"]}",
                    Icons.shopping_cart,
                    primaryColor,
                    "${selectedData["customers"]} customers",
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: _buildSalesMetricCard(
                    "Target Progress",
                    "${(((selectedData["sales"] as double) / (selectedData["target"] as double)) * 100).toStringAsFixed(1)}%",
                    Icons.flag,
                    infoColor,
                    "Target: \$${(selectedData["target"] as double).currency}",
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSalesMetricCard(
                    "Avg Order Value",
                    "\$${((selectedData["sales"] as double) / (selectedData["orders"] as int)).toStringAsFixed(2)}",
                    Icons.receipt,
                    warningColor,
                    "Per transaction",
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
                    "Top Performing Products",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
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
                                  Row(
                                    children: [
                                      Text(
                                        "${product["category"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        " • ${product["units_sold"]} units",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        " • Stock: ${product["stock"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: (product["stock"] as int) < 100 ? dangerColor : disabledBoldColor,
                                        ),
                                      ),
                                    ],
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "+${(product["growth"] as double).toStringAsFixed(1)}%",
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
                  Text(
                    "Sales Channel Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: salesChannels.map((channel) {
                      final revenuePercent = ((channel["revenue"] as double) / totalRevenue) * 100;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: channel["color"] as Color,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${channel["channel"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${revenuePercent.toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: channel["color"] as Color,
                                  ),
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
                                      widthFactor: revenuePercent / 100,
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
                                Text(
                                  "\$${(channel["revenue"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${channel["orders"]} orders",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "AOV: \$${(channel["avg_order"] as double).toStringAsFixed(0)}",
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

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
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
                          "Customer Segments",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Column(
                          spacing: spSm,
                          children: customerSegments.map((segment) {
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: segment["color"] as Color,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Text(
                                          "${segment["segment"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${segment["count"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: segment["color"] as Color,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${(segment["revenue"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "AOV: \$${(segment["avg_order"] as double).toStringAsFixed(0)}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(segment["retention"] as double).toStringAsFixed(1)}% retention",
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
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Container(
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
                          "Regional Performance",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Column(
                          spacing: spSm,
                          children: regionalPerformance.map((region) {
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${region["region"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "+${(region["growth"] as double).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "\$${(region["revenue"] as double).currency} • ${region["orders"]} orders",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: ((region["market_share"] as double) / 100).clamp(0.0, 1.0),
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
                                      Text(
                                        "${(region["market_share"] as double).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
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
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Sales Forecast",
                    icon: Icons.trending_up,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Export Data",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesMetricCard(String title, String value, IconData icon, Color color, String subtitle) {
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
          Text(
            subtitle,
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
