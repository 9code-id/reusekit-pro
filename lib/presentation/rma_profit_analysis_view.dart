import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaProfitAnalysisView extends StatefulWidget {
  const RmaProfitAnalysisView({super.key});

  @override
  State<RmaProfitAnalysisView> createState() => _RmaProfitAnalysisViewState();
}

class _RmaProfitAnalysisViewState extends State<RmaProfitAnalysisView> {
  int selectedTab = 0;
  String selectedPeriod = "This Month";
  String selectedProduct = "All Products";
  String selectedRegion = "All Regions";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "current_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "This Quarter", "value": "current_quarter"},
    {"label": "Last Quarter", "value": "last_quarter"},
    {"label": "This Year", "value": "current_year"},
    {"label": "Last Year", "value": "last_year"},
  ];

  List<Map<String, dynamic>> productOptions = [
    {"label": "All Products", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Home & Garden", "value": "home_garden"},
    {"label": "Sports", "value": "sports"},
    {"label": "Books", "value": "books"},
  ];

  List<Map<String, dynamic>> regionOptions = [
    {"label": "All Regions", "value": "all"},
    {"label": "North America", "value": "north_america"},
    {"label": "Europe", "value": "europe"},
    {"label": "Asia Pacific", "value": "asia_pacific"},
    {"label": "Latin America", "value": "latin_america"},
  ];

  List<Map<String, dynamic>> profitMetrics = [
    {
      "title": "Gross Profit",
      "amount": 125680.50,
      "change": 15.3,
      "icon": Icons.trending_up,
      "color": successColor,
      "subtitle": "Total revenue minus COGS",
    },
    {
      "title": "Net Profit",
      "amount": 89240.25,
      "change": 12.8,
      "icon": Icons.account_balance,
      "color": primaryColor,
      "subtitle": "After all expenses",
    },
    {
      "title": "Profit Margin",
      "amount": 28.5,
      "change": 2.1,
      "icon": Icons.percent,
      "color": infoColor,
      "subtitle": "Net profit percentage",
      "isPercentage": true,
    },
    {
      "title": "EBITDA",
      "amount": 98750.75,
      "change": 18.7,
      "icon": Icons.analytics,
      "color": warningColor,
      "subtitle": "Earnings before deductions",
    },
  ];

  List<Map<String, dynamic>> profitByProduct = [
    {
      "product": "Premium Laptops",
      "revenue": 45680.00,
      "cogs": 32476.00,
      "profit": 13204.00,
      "margin": 28.9,
      "units": 156,
      "growth": 15.2,
    },
    {
      "product": "Wireless Headphones",
      "revenue": 28950.00,
      "cogs": 17370.00,
      "profit": 11580.00,
      "margin": 40.0,
      "units": 578,
      "growth": 22.8,
    },
    {
      "product": "Smart Watches",
      "revenue": 34200.00,
      "cogs": 23940.00,
      "profit": 10260.00,
      "margin": 30.0,
      "units": 228,
      "growth": -5.3,
    },
    {
      "product": "Gaming Accessories",
      "revenue": 19800.00,
      "cogs": 11880.00,
      "profit": 7920.00,
      "margin": 40.0,
      "units": 396,
      "growth": 31.5,
    },
    {
      "product": "Phone Cases",
      "revenue": 15750.00,
      "cogs": 8505.00,
      "profit": 7245.00,
      "margin": 46.0,
      "units": 1050,
      "growth": 8.7,
    },
  ];

  List<Map<String, dynamic>> profitByRegion = [
    {
      "region": "North America",
      "revenue": 89450.00,
      "profit": 25447.50,
      "margin": 28.4,
      "growth": 12.3,
      "customers": 2840,
    },
    {
      "region": "Europe",
      "revenue": 67890.00,
      "profit": 20367.00,
      "margin": 30.0,
      "growth": 18.7,
      "customers": 1960,
    },
    {
      "region": "Asia Pacific",
      "revenue": 54230.00,
      "profit": 14654.10,
      "margin": 27.0,
      "growth": 25.1,
      "customers": 3250,
    },
    {
      "region": "Latin America",
      "revenue": 23180.00,
      "profit": 6257.60,
      "margin": 27.0,
      "growth": 8.9,
      "customers": 890,
    },
  ];

  List<Map<String, dynamic>> monthlyProfitData = [
    {"month": "Jan", "revenue": 180000, "profit": 45000, "margin": 25.0},
    {"month": "Feb", "revenue": 195000, "profit": 52650, "margin": 27.0},
    {"month": "Mar", "revenue": 210000, "profit": 58800, "margin": 28.0},
    {"month": "Apr", "revenue": 225000, "profit": 65250, "margin": 29.0},
    {"month": "May", "revenue": 240000, "profit": 72000, "margin": 30.0},
    {"month": "Jun", "revenue": 255000, "profit": 79050, "margin": 31.0},
  ];

  void _showProfitDetails(String type, Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("$type Profit Analysis"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (type == "Product") ...[
                Text(
                  "${data["product"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                _buildDetailRow("Revenue", "\$${((data["revenue"] as num).toDouble()).currency}"),
                _buildDetailRow("COGS", "\$${((data["cogs"] as num).toDouble()).currency}"),
                _buildDetailRow("Gross Profit", "\$${((data["profit"] as num).toDouble()).currency}"),
                _buildDetailRow("Profit Margin", "${(data["margin"] as num).toStringAsFixed(1)}%"),
                _buildDetailRow("Units Sold", "${data["units"]}"),
                _buildDetailRow("Growth Rate", "${(data["growth"] as num) >= 0 ? '+' : ''}${(data["growth"] as num).toStringAsFixed(1)}%"),
              ] else if (type == "Region") ...[
                Text(
                  "${data["region"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                _buildDetailRow("Revenue", "\$${((data["revenue"] as num).toDouble()).currency}"),
                _buildDetailRow("Profit", "\$${((data["profit"] as num).toDouble()).currency}"),
                _buildDetailRow("Profit Margin", "${(data["margin"] as num).toStringAsFixed(1)}%"),
                _buildDetailRow("Growth Rate", "${(data["growth"] as num) >= 0 ? '+' : ''}${(data["growth"] as num).toStringAsFixed(1)}%"),
                _buildDetailRow("Active Customers", "${data["customers"]}"),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "View Details",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              si("Detailed $type analysis would open here");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  ss("Data refreshed");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: profitMetrics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
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
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            metric["icon"],
                            color: metric["color"],
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (metric["change"] as num) >= 0 
                                ? successColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                (metric["change"] as num) >= 0 
                                    ? Icons.trending_up 
                                    : Icons.trending_down,
                                color: (metric["change"] as num) >= 0 
                                    ? successColor 
                                    : dangerColor,
                                size: 12,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${(metric["change"] as num) >= 0 ? '+' : ''}${(metric["change"] as num).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: (metric["change"] as num) >= 0 
                                      ? successColor 
                                      : dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${metric["title"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      metric["isPercentage"] == true 
                          ? "${(metric["amount"] as num).toStringAsFixed(1)}%"
                          : "\$${((metric["amount"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${metric["subtitle"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spLg),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Monthly Profit Trend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  height: 200,
                  child: Center(
                    child: Text(
                      "Monthly profit trend chart would be displayed here",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
    var sortedProducts = List<Map<String, dynamic>>.from(profitByProduct);
    sortedProducts.sort((a, b) => (b["profit"] as num).compareTo(a["profit"] as num));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Product Category",
                  items: productOptions,
                  value: selectedProduct,
                  onChanged: (value, label) {
                    selectedProduct = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {
                  ss("Product profit report exported");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Product Profitability",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...sortedProducts.map((product) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: (product["growth"] as num) >= 0 ? successColor : dangerColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product["product"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
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
                            "\$${((product["profit"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (product["growth"] as num) >= 0 
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(product["growth"] as num) >= 0 ? '+' : ''}${(product["growth"] as num).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: (product["growth"] as num) >= 0 ? successColor : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Revenue",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "\$${((product["revenue"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
                              "COGS",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "\$${((product["cogs"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
                              "Margin",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(product["margin"] as num).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showProfitDetails("Product", product),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: disabledBoldColor,
                          size: 14,
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
    );
  }

  Widget _buildRegionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Region",
                  items: regionOptions,
                  value: selectedRegion,
                  onChanged: (value, label) {
                    selectedRegion = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.map,
                size: bs.sm,
                onPressed: () {
                  si("Regional profit map would open here");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Regional Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...profitByRegion.map((region) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${region["region"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${region["customers"]} active customers",
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
                            "\$${((region["profit"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "+${(region["growth"] as num).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Revenue",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "\$${((region["revenue"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
                              "Margin",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(region["margin"] as num).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showProfitDetails("Region", region),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: disabledBoldColor,
                          size: 14,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Profit Analysis",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Products", icon: Icon(Icons.inventory)),
        Tab(text: "Regions", icon: Icon(Icons.public)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildProductsTab(),
        _buildRegionsTab(),
      ],
    );
  }
}
